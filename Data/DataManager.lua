-- ====================================================================
-- Copper Fever - Data\DataManager.lua
-- 数据管理器
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever

-- ====================================================================
-- 数据管理器初始化
-- ====================================================================
CF.DataManager = CF.DataManager or {}
local DM = CF.DataManager

-- 数据缓存
DM.currencyCache = {}
DM.reputationCache = {}
DM.mapCache = {}

-- 更新计时器
DM.updateTimer = nil
DM.lastUpdateTime = 0

-- 初始化标志
DM.initialized = false

-- ====================================================================
-- 初始化数据管理器
-- ====================================================================
function DM:Initialize()
    if self.initialized then
        CF:LogWarning("DataManager 已经初始化过了")
        return
    end
    
    CF:LogInfo("初始化数据管理器...")
    
    -- 清空缓存
    self:ClearAllCaches()
    
    -- 加载用户配置的关联关系
    self:LoadUserAssociations()
    
    -- 启动定期更新
    self:StartAutoUpdate()
    
    self.initialized = true
    CF:LogInfo("数据管理器初始化完成")
end

-- ====================================================================
-- 货币数据管理
-- ====================================================================

-- 获取货币当前数量
function DM:GetCurrencyAmount(currencyID)
    if type(currencyID) ~= "number" or currencyID <= 0 then
        return 0
    end
    
    -- 检查缓存
    local cached = CF:GetCache("currency_amount_" .. currencyID)
    if cached then
        return cached
    end
    
    -- 调用API获取货币信息
    local info, errorCode = CF:SafeGetCurrencyInfo(currencyID)
    
    if errorCode ~= CF.ERROR_CODES.SUCCESS or not info then
        CF:LogWarning("获取货币信息失败: ID=%d, 错误码=%d", currencyID, errorCode or 0)
        return 0
    end
    
    local amount = info.quantity or 0
    
    -- 缓存结果（较短时间，因为货币数量会变化）
    CF:SetCache("currency_amount_" .. currencyID, amount, 10)
    
    return amount
end

-- 获取货币详细信息
function DM:GetCurrencyInfo(currencyID)
    if type(currencyID) ~= "number" or currencyID <= 0 then
        return nil
    end
    
    -- 检查缓存
    local cacheKey = "currency_info_" .. currencyID
    local cached = CF:GetCache(cacheKey)
    if cached then
        return cached
    end
    
    -- 调用API获取货币信息
    local info, errorCode = CF:SafeGetCurrencyInfo(currencyID)
    
    if errorCode ~= CF.ERROR_CODES.SUCCESS or not info then
        CF:LogWarning("获取货币信息失败: ID=%d", currencyID)
        return nil
    end
    
    -- 合并静态数据
    if CF.StaticData and CF.StaticData.GetCurrencyData then
        local staticData = CF.StaticData:GetCurrencyData(currencyID)
        if staticData then
            info.staticName = staticData.name
            info.currencyType = staticData.type
        end
    end
    
    -- 缓存结果
    CF:SetCache(cacheKey, info, 30)
    
    return info
end

-- 获取货币列表
function DM:GetCurrencyList(currencyIDs)
    if type(currencyIDs) ~= "table" then
        return {}
    end
    
    local result = {}
    
    for _, currencyID in ipairs(currencyIDs) do
        local info = self:GetCurrencyInfo(currencyID)
        if info then
            table.insert(result, {
                id = currencyID,
                name = info.name or info.staticName or "Unknown",
                icon = info.iconFileID,
                amount = info.quantity or 0,
                maxAmount = info.maxQuantity or 0,
                weeklyAmount = info.quantityEarnedThisWeek or 0,
                weeklyMax = info.canEarnPerWeek or 0,
                discovered = info.discovered,
                type = info.currencyType or CF.CURRENCY_TYPES.STANDARD,
            })
        end
    end
    
    return result
end

-- 批量更新货币信息
function DM:UpdateCurrencies(currencyIDs)
    if type(currencyIDs) ~= "table" then
        return
    end
    
    for _, currencyID in ipairs(currencyIDs) do
        -- 清除缓存以强制刷新
        CF:ClearCache("currency_amount_" .. currencyID)
        CF:ClearCache("currency_info_" .. currencyID)
        
        -- 重新获取信息
        self:GetCurrencyInfo(currencyID)
    end
end

-- ====================================================================
-- 声望数据管理
-- ====================================================================

-- 获取声望信息
function DM:GetReputationInfo(factionID)
    if type(factionID) ~= "number" or factionID <= 0 then
        return nil
    end
    
    -- 检查缓存
    local cacheKey = "reputation_info_" .. factionID
    local cached = CF:GetCache(cacheKey)
    if cached then
        return cached
    end
    
    -- 调用API获取声望信息
    local data, errorCode = CF:SafeGetFactionData(factionID)
    
    if errorCode ~= CF.ERROR_CODES.SUCCESS or not data then
        CF:LogWarning("获取声望信息失败: ID=%d", factionID)
        return nil
    end
    
    -- 获取静态数据
    local staticData = nil
    if CF.StaticData and CF.StaticData.GetReputationData then
        staticData = CF.StaticData:GetReputationData(factionID)
    end
    
    -- 构建返回信息
    local info = {
        id = factionID,
        name = data.name or (staticData and staticData.name) or "Unknown",
        description = data.description or "",
        reaction = data.reaction or 4,  -- 默认友善
        currentStanding = data.currentStanding or 0,
        currentReactionThreshold = data.currentReactionThreshold or 0,
        nextReactionThreshold = data.nextReactionThreshold or 0,
        hasBonusRepGain = data.hasBonusRepGain or false,
        canToggleAtWar = data.canToggleAtWar or false,
        isWatched = data.isWatched or false,
        isChild = data.isChild or false,
        isHeader = data.isHeader or false,
        isHeaderWithRep = data.isHeaderWithRep or false,
        isCollapsed = data.isCollapsed or false,
        isAccountWide = data.isAccountWide or false,
        factionID = factionID,
    }
    
    -- 添加静态数据
    if staticData then
        info.staticName = staticData.name
        info.faction = staticData.faction
        info.expansion = staticData.expansion
    end
    
    -- 缓存结果
    CF:SetCache(cacheKey, info, 60)
    
    return info
end

-- 获取声望列表
function DM:GetReputationList(factionIDs)
    if type(factionIDs) ~= "table" then
        return {}
    end
    
    local result = {}
    
    for _, factionID in ipairs(factionIDs) do
        local info = self:GetReputationInfo(factionID)
        if info then
            -- 计算当前等级的进度
            local current = info.currentStanding - info.currentReactionThreshold
            local max = info.nextReactionThreshold - info.currentReactionThreshold
            local percent = max > 0 and (current / max * 100) or 0
            
            table.insert(result, {
                id = factionID,
                name = info.name,
                standing = info.reaction,
                current = current,
                max = max,
                percent = percent,
                isParagon = info.reaction >= 8,
                faction = info.faction,
            })
        end
    end
    
    return result
end

-- 批量更新声望信息
function DM:UpdateReputations(factionIDs)
    if type(factionIDs) ~= "table" then
        return
    end
    
    for _, factionID in ipairs(factionIDs) do
        -- 清除缓存以强制刷新
        CF:ClearCache("reputation_info_" .. factionID)
        
        -- 重新获取信息
        self:GetReputationInfo(factionID)
    end
end

-- 获取声望等级名称
function DM:GetReputationStandingName(standing)
    if type(standing) ~= "number" then
        return CF.L["REPUTATION_STANDING_4"] or "Neutral"
    end
    
    local key = "REPUTATION_STANDING_" .. standing
    return CF.L[key] or CF.L["REPUTATION_STANDING_4"] or "Neutral"
end

-- ====================================================================
-- 地图数据管理
-- ====================================================================

-- 获取当前地图ID
function DM:GetCurrentMapID()
    local mapID = C_Map.GetBestMapForUnit("player")
    
    if not mapID then
        CF:LogWarning("无法获取当前地图ID")
        return nil
    end
    
    return mapID
end

-- 获取地图信息
function DM:GetMapInfo(mapID)
    if type(mapID) ~= "number" or mapID <= 0 then
        return nil
    end
    
    -- 检查缓存
    local cacheKey = "map_info_" .. mapID
    local cached = CF:GetCache(cacheKey)
    if cached then
        return cached
    end
    
    -- 调用API获取地图信息
    local info, errorCode = CF:SafeGetMapInfo(mapID)
    
    if errorCode ~= CF.ERROR_CODES.SUCCESS or not info then
        CF:LogWarning("获取地图信息失败: ID=%d", mapID)
        return nil
    end
    
    -- 缓存结果（地图信息不变，长期缓存）
    CF:SetCache(cacheKey, info, 3600)
    
    return info
end

-- ====================================================================
-- 地图关联管理
-- ====================================================================

-- 获取地图关联的货币列表
function DM:GetMapCurrencies(mapID)
    if type(mapID) ~= "number" or mapID <= 0 then
        return {}
    end
    
    local db = CopperFeverDB
    
    -- 优先使用用户自定义的关联
    if db and db.mapAssociations and db.mapAssociations[mapID] then
        if db.mapAssociations[mapID].currencies then
            return db.mapAssociations[mapID].currencies
        end
    end
    
    -- 使用静态数据中的关联
    if CF.StaticData and CF.StaticData.MapCurrencyAssociations then
        return CF.StaticData.MapCurrencyAssociations[mapID] or {}
    end
    
    return {}
end

-- 获取地图关联的声望列表
function DM:GetMapReputations(mapID)
    if type(mapID) ~= "number" or mapID <= 0 then
        return {}
    end
    
    local db = CopperFeverDB
    
    -- 优先使用用户自定义的关联
    if db and db.mapAssociations and db.mapAssociations[mapID] then
        if db.mapAssociations[mapID].reputations then
            return db.mapAssociations[mapID].reputations
        end
    end
    
    -- 使用静态数据中的关联
    if CF.StaticData and CF.StaticData.MapReputationAssociations then
        return CF.StaticData.MapReputationAssociations[mapID] or {}
    end
    
    return {}
end

-- 设置地图关联的货币列表
function DM:SetMapCurrencies(mapID, currencies)
    if type(mapID) ~= "number" or type(currencies) ~= "table" then
        return false
    end
    
    local db = CopperFeverDB
    if not db then
        CF:LogError("数据库未初始化")
        return false
    end
    
    db.mapAssociations = db.mapAssociations or {}
    db.mapAssociations[mapID] = db.mapAssociations[mapID] or {}
    db.mapAssociations[mapID].currencies = currencies
    
    CF:LogInfo("已设置地图 %d 的货币关联 (%d 个)", mapID, #currencies)
    return true
end

-- 设置地图关联的声望列表
function DM:SetMapReputations(mapID, reputations)
    if type(mapID) ~= "number" or type(reputations) ~= "table" then
        return false
    end
    
    local db = CopperFeverDB
    if not db then
        CF:LogError("数据库未初始化")
        return false
    end
    
    db.mapAssociations = db.mapAssociations or {}
    db.mapAssociations[mapID] = db.mapAssociations[mapID] or {}
    db.mapAssociations[mapID].reputations = reputations
    
    CF:LogInfo("已设置地图 %d 的声望关联 (%d 个)", mapID, #reputations)
    return true
end

-- 添加货币到地图关联
function DM:AddCurrencyToMap(mapID, currencyID)
    if type(mapID) ~= "number" or type(currencyID) ~= "number" then
        return false
    end
    
    local currencies = self:GetMapCurrencies(mapID)
    
    -- 检查是否已存在
    if CF:TableContains(currencies, currencyID) then
        CF:LogWarning("货币 %d 已经关联到地图 %d", currencyID, mapID)
        return false
    end
    
    -- 添加货币
    table.insert(currencies, currencyID)
    
    -- 保存
    return self:SetMapCurrencies(mapID, currencies)
end

-- 从地图关联中移除货币
function DM:RemoveCurrencyFromMap(mapID, currencyID)
    if type(mapID) ~= "number" or type(currencyID) ~= "number" then
        return false
    end
    
    local currencies = self:GetMapCurrencies(mapID)
    
    -- 移除货币
    if not CF:TableRemoveValue(currencies, currencyID) then
        CF:LogWarning("货币 %d 不在地图 %d 的关联列表中", currencyID, mapID)
        return false
    end
    
    -- 保存
    return self:SetMapCurrencies(mapID, currencies)
end

-- 添加声望到地图关联
function DM:AddReputationToMap(mapID, factionID)
    if type(mapID) ~= "number" or type(factionID) ~= "number" then
        return false
    end
    
    local reputations = self:GetMapReputations(mapID)
    
    -- 检查是否已存在
    if CF:TableContains(reputations, factionID) then
        CF:LogWarning("声望 %d 已经关联到地图 %d", factionID, mapID)
        return false
    end
    
    -- 添加声望
    table.insert(reputations, factionID)
    
    -- 保存
    return self:SetMapReputations(mapID, reputations)
end

-- 从地图关联中移除声望
function DM:RemoveReputationFromMap(mapID, factionID)
    if type(mapID) ~= "number" or type(factionID) ~= "number" then
        return false
    end
    
    local reputations = self:GetMapReputations(mapID)
    
    -- 移除声望
    if not CF:TableRemoveValue(reputations, factionID) then
        CF:LogWarning("声望 %d 不在地图 %d 的关联列表中", factionID, mapID)
        return false
    end
    
    -- 保存
    return self:SetMapReputations(mapID, reputations)
end

-- ====================================================================
-- 当前区域数据获取
-- ====================================================================

-- 获取当前区域的所有追踪数据
function DM:GetCurrentZoneData()
    local mapID = self:GetCurrentMapID()
    
    if not mapID then
        return nil
    end
    
    local mapInfo = self:GetMapInfo(mapID)
    local currencies = self:GetMapCurrencies(mapID)
    local reputations = self:GetMapReputations(mapID)
    
    -- 获取详细信息
    local currencyList = self:GetCurrencyList(currencies)
    local reputationList = self:GetReputationList(reputations)
    
    return {
        mapID = mapID,
        mapName = mapInfo and mapInfo.name or "Unknown",
        expansion = mapInfo and mapInfo.expansion or nil,
        currencies = currencyList,
        reputations = reputationList,
        hasCurrencies = #currencyList > 0,
        hasReputations = #reputationList > 0,
    }
end

-- ====================================================================
-- 自动更新系统
-- ====================================================================

-- 启动自动更新
function DM:StartAutoUpdate()
    if self.updateTimer then
        CF:LogWarning("自动更新已经在运行")
        return
    end
    
    local db = CopperFeverDB
    if not db or not db.settings or not db.settings.data or 
       not db.settings.data.enableAutoUpdate then
        CF:LogInfo("自动更新未启用")
        return
    end
    
    local interval = db.settings.data.updateInterval or CF.DEFAULTS.data.updateInterval
    
    -- 创建定时器
    self.updateTimer = C_Timer.NewTicker(interval, function()
        local success, err = pcall(self.OnAutoUpdate, self)
        if not success then
            CF:LogError("自动更新错误: %s", tostring(err))
        end
    end)
    
    CF:LogInfo("自动更新已启动，间隔: %d 秒", interval)
end

-- 停止自动更新
function DM:StopAutoUpdate()
    if self.updateTimer then
        self.updateTimer:Cancel()
        self.updateTimer = nil
        CF:LogInfo("自动更新已停止")
    end
end

-- 自动更新回调
function DM:OnAutoUpdate()
    local now = GetTime()
    
    -- 避免频繁更新
    if now - self.lastUpdateTime < 1 then
        return
    end
    
    self.lastUpdateTime = now
    
    -- 获取当前区域数据
    local zoneData = self:GetCurrentZoneData()
    
    if not zoneData then
        return
    end
    
    -- 更新货币
    if zoneData.hasCurrencies then
        local currencyIDs = {}
        for _, currency in ipairs(zoneData.currencies) do
            table.insert(currencyIDs, currency.id)
        end
        self:UpdateCurrencies(currencyIDs)
    end
    
    -- 更新声望
    if zoneData.hasReputations then
        local factionIDs = {}
        for _, reputation in ipairs(zoneData.reputations) do
            table.insert(factionIDs, reputation.id)
        end
        self:UpdateReputations(factionIDs)
    end
    
    -- 触发更新事件
    CF:TriggerEvent("DATA_UPDATED", zoneData)
end

-- 手动刷新数据
function DM:RefreshData()
    CF:LogInfo("手动刷新数据...")
    
    -- 清除过期缓存（不清除全部）
    self:ClearExpiredCache()
    
    -- 强制更新
    self:OnAutoUpdate()
    
    CF:ShowLocalizedSuccess("MSG_DATA_IMPORTED")
end

-- ====================================================================
-- 缓存管理
-- ====================================================================

-- 清除所有缓存
function DM:ClearAllCaches()
    CF:ClearCache()
    self.currencyCache = {}
    self.reputationCache = {}
    self.mapCache = {}
    CF:LogInfo("所有数据缓存已清除")
end

-- 清除过期缓存
function DM:ClearExpiredCache()
    if CF.ClearExpiredCache then
        CF:ClearExpiredCache()
    end
end

-- ====================================================================
-- 用户配置加载
-- ====================================================================

-- 加载用户自定义的关联关系
function DM:LoadUserAssociations()
    local db = CopperFeverDB
    
    if not db or not db.mapAssociations then
        CF:LogInfo("没有用户自定义的地图关联")
        return
    end
    
    local count = 0
    for mapID, associations in pairs(db.mapAssociations) do
        if type(associations) == "table" and 
           (associations.currencies or associations.reputations) then
            count = count + 1
        end
    end
    
    CF:LogInfo("加载了 %d 个地图的用户自定义关联", count)
end

-- ====================================================================
-- 数据验证
-- ====================================================================

-- 验证货币ID列表
function DM:ValidateCurrencyIDs(currencyIDs)
    if type(currencyIDs) ~= "table" then
        return {}
    end
    
    local valid = {}
    
    for _, currencyID in ipairs(currencyIDs) do
        if CF:IsValidCurrencyID(currencyID) then
            table.insert(valid, currencyID)
        else
            CF:LogWarning("无效的货币ID: %d", currencyID)
        end
    end
    
    return valid
end

-- 验证声望ID列表
function DM:ValidateReputationIDs(factionIDs)
    if type(factionIDs) ~= "table" then
        return {}
    end
    
    local valid = {}
    
    for _, factionID in ipairs(factionIDs) do
        if CF:IsValidFactionID(factionID) then
            table.insert(valid, factionID)
        else
            CF:LogWarning("无效的声望ID: %d", factionID)
        end
    end
    
    return valid
end

-- ====================================================================
-- 数据导出和导入
-- ====================================================================

-- 导出地图关联数据
function DM:ExportMapAssociations()
    local db = CopperFeverDB
    
    if not db or not db.mapAssociations then
        CF:LogWarning("没有可导出的地图关联数据")
        return nil
    end
    
    -- 序列化数据
    local exportData = CF:DeepCopy(db.mapAssociations)
    
    CF:LogInfo("已导出 %d 个地图的关联数据", CF:TableSize(exportData))
    return exportData
end

-- 导入地图关联数据
function DM:ImportMapAssociations(importData)
    if type(importData) ~= "table" then
        CF:LogError("导入数据格式错误")
        return false
    end
    
    local db = CopperFeverDB
    if not db then
        CF:LogError("数据库未初始化")
        return false
    end
    
    -- 验证并导入数据
    db.mapAssociations = db.mapAssociations or {}
    local importedCount = 0
    
    for mapID, associations in pairs(importData) do
        if type(mapID) == "number" and type(associations) == "table" then
            db.mapAssociations[mapID] = {
                currencies = self:ValidateCurrencyIDs(associations.currencies or {}),
                reputations = self:ValidateReputationIDs(associations.reputations or {}),
            }
            importedCount = importedCount + 1
        end
    end
    
    CF:LogInfo("地图关联数据导入完成 (%d 个地图)", importedCount)
    return true
end

-- ====================================================================
-- 错误恢复机制
-- ====================================================================

-- 尝试恢复损坏的数据
function DM:RecoverCorruptedData()
    CF:LogWarning("尝试恢复损坏的数据...")
    
    local db = CopperFeverDB
    if not db then
        return false
    end
    
    local recovered = false
    
    -- 检查并修复 settings
    if not db.settings or type(db.settings) ~= "table" then
        db.settings = CF:DeepCopy(CF.DEFAULTS)
        recovered = true
        CF:LogInfo("已恢复默认设置")
    end
    
    -- 检查并修复 mapAssociations
    if not db.mapAssociations or type(db.mapAssociations) ~= "table" then
        db.mapAssociations = {}
        recovered = true
        CF:LogInfo("已重置地图关联")
    end
    
    if recovered then
        CF:ShowLocalizedWarning("WARNING_DATA_RECOVERED")
    end
    
    return recovered
end

-- ====================================================================
-- 结束标记
-- ====================================================================