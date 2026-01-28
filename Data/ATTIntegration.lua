-- ====================================================================
-- Copper Fever - Data\ATTIntegration.lua
-- ALL THE THINGS 集成接口
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever

-- ====================================================================
-- ATT 集成初始化
-- ====================================================================
CF.ATTIntegration = CF.ATTIntegration or {}
local ATT = CF.ATTIntegration

-- ATT 可用性标记
ATT.isAvailable = false
ATT.version = nil

-- ====================================================================
-- 检查 ATT 是否可用
-- ====================================================================
function ATT:CheckAvailability()
    -- 检查 ATT 插件是否加载
    if not AllTheThings then
        self.isAvailable = false
        CF:LogInfo("ALL THE THINGS 插件未找到")
        return false
    end
    
    self.isAvailable = true
    
    -- 尝试获取版本信息
    if AllTheThings.Version then
        self.version = AllTheThings.Version
        CF:LogInfo("检测到 ALL THE THINGS 版本: %s", tostring(self.version))
    else
        CF:LogInfo("检测到 ALL THE THINGS（版本未知）")
    end
    
    return true
end

-- 获取 ATT 是否可用
function ATT:IsAvailable()
    return self.isAvailable
end

-- 获取 ATT 版本
function ATT:GetVersion()
    return self.version
end

-- ====================================================================
-- 从 ATT 导入货币数据
-- ====================================================================
function ATT:ImportCurrencyData()
    if not self:IsAvailable() then
        CF:LogError("ALL THE THINGS 不可用，无法导入货币数据")
        return false, {}
    end
    
    CF:LogInfo("开始从 ATT 导入货币数据...")
    
    local importedCurrencies = {}
    local count = 0
    
    -- ATT 的货币数据结构可能存储在不同位置
    -- 这里提供一个通用的访问方式
    -- 注意：实际的数据结构可能需要根据 ATT 的实际实现调整
    
    if AllTheThings.DB and AllTheThings.DB.Currencies then
        for currencyID, data in pairs(AllTheThings.DB.Currencies) do
            if type(currencyID) == "number" and currencyID > 0 then
                -- 验证货币ID
                if CF:IsValidCurrencyID(currencyID) then
                    importedCurrencies[currencyID] = {
                        id = currencyID,
                        name = data.name or data.text or "Unknown",
                        icon = data.icon,
                        attData = data,
                    }
                    count = count + 1
                end
            end
        end
    end
    
    CF:LogInfo("从 ATT 导入了 %d 个货币", count)
    
    return true, importedCurrencies
end

-- ====================================================================
-- 从 ATT 导入地图数据
-- ====================================================================
function ATT:ImportMapData()
    if not self:IsAvailable() then
        CF:LogError("ALL THE THINGS 不可用，无法导入地图数据")
        return false, {}
    end
    
    CF:LogInfo("开始从 ATT 导入地图数据...")
    
    local importedMaps = {}
    local count = 0
    
    -- ATT 的地图数据结构
    -- 注意：实际的数据结构可能需要根据 ATT 的实际实现调整
    
    if AllTheThings.DB and AllTheThings.DB.Maps then
        for mapID, data in pairs(AllTheThings.DB.Maps) do
            if type(mapID) == "number" and mapID > 0 then
                -- 验证地图ID
                if CF:IsValidMapID(mapID) then
                    importedMaps[mapID] = {
                        id = mapID,
                        name = data.name or data.text or "Unknown",
                        parentID = data.parent,
                        attData = data,
                    }
                    count = count + 1
                end
            end
        end
    end
    
    CF:LogInfo("从 ATT 导入了 %d 个地图", count)
    
    return true, importedMaps
end

-- ====================================================================
-- 从 ATT 导入声望数据
-- ====================================================================
function ATT:ImportReputationData()
    if not self:IsAvailable() then
        CF:LogError("ALL THE THINGS 不可用，无法导入声望数据")
        return false, {}
    end
    
    CF:LogInfo("开始从 ATT 导入声望数据...")
    
    local importedReputations = {}
    local count = 0
    
    -- ATT 的声望数据结构
    -- 注意：实际的数据结构可能需要根据 ATT 的实际实现调整
    
    if AllTheThings.DB and AllTheThings.DB.Factions then
        for factionID, data in pairs(AllTheThings.DB.Factions) do
            if type(factionID) == "number" and factionID > 0 then
                -- 验证声望ID
                if CF:IsValidFactionID(factionID) then
                    importedReputations[factionID] = {
                        id = factionID,
                        name = data.name or data.text or "Unknown",
                        description = data.description,
                        attData = data,
                    }
                    count = count + 1
                end
            end
        end
    end
    
    CF:LogInfo("从 ATT 导入了 %d 个声望", count)
    
    return true, importedReputations
end

-- ====================================================================
-- 从 ATT 导入地图与货币的关联关系
-- ====================================================================
function ATT:ImportMapCurrencyAssociations()
    if not self:IsAvailable() then
        CF:LogError("ALL THE THINGS 不可用，无法导入关联数据")
        return false, {}
    end
    
    CF:LogInfo("开始从 ATT 导入地图与货币关联...")
    
    local associations = {}
    local count = 0
    
    -- 尝试从 ATT 获取地图与货币的关联
    -- 注意：这个功能取决于 ATT 是否提供此类数据
    
    -- 方法1：直接从 ATT 数据结构获取
    if AllTheThings.DB and AllTheThings.DB.MapCurrencies then
        for mapID, currencies in pairs(AllTheThings.DB.MapCurrencies) do
            if type(mapID) == "number" and type(currencies) == "table" then
                associations[mapID] = CF.DataManager:ValidateCurrencyIDs(currencies)
                if #associations[mapID] > 0 then
                    count = count + 1
                end
            end
        end
    end
    
    -- 方法2：从地图数据中推断
    if count == 0 and AllTheThings.DB and AllTheThings.DB.Maps then
        for mapID, mapData in pairs(AllTheThings.DB.Maps) do
            if type(mapID) == "number" and mapData.currencies then
                local currencyList = {}
                
                if type(mapData.currencies) == "table" then
                    for _, currencyID in ipairs(mapData.currencies) do
                        if type(currencyID) == "number" and CF:IsValidCurrencyID(currencyID) then
                            table.insert(currencyList, currencyID)
                        end
                    end
                end
                
                if #currencyList > 0 then
                    associations[mapID] = currencyList
                    count = count + 1
                end
            end
        end
    end
    
    CF:LogInfo("从 ATT 导入了 %d 个地图的货币关联", count)
    
    return true, associations
end

-- ====================================================================
-- 从 ATT 导入地图与声望的关联关系
-- ====================================================================
function ATT:ImportMapReputationAssociations()
    if not self:IsAvailable() then
        CF:LogError("ALL THE THINGS 不可用，无法导入关联数据")
        return false, {}
    end
    
    CF:LogInfo("开始从 ATT 导入地图与声望关联...")
    
    local associations = {}
    local count = 0
    
    -- 尝试从 ATT 获取地图与声望的关联
    
    -- 方法1：直接从 ATT 数据结构获取
    if AllTheThings.DB and AllTheThings.DB.MapFactions then
        for mapID, factions in pairs(AllTheThings.DB.MapFactions) do
            if type(mapID) == "number" and type(factions) == "table" then
                associations[mapID] = CF.DataManager:ValidateReputationIDs(factions)
                if #associations[mapID] > 0 then
                    count = count + 1
                end
            end
        end
    end
    
    -- 方法2：从地图数据中推断
    if count == 0 and AllTheThings.DB and AllTheThings.DB.Maps then
        for mapID, mapData in pairs(AllTheThings.DB.Maps) do
            if type(mapID) == "number" and mapData.factions then
                local factionList = {}
                
                if type(mapData.factions) == "table" then
                    for _, factionID in ipairs(mapData.factions) do
                        if type(factionID) == "number" and CF:IsValidFactionID(factionID) then
                            table.insert(factionList, factionID)
                        end
                    end
                end
                
                if #factionList > 0 then
                    associations[mapID] = factionList
                    count = count + 1
                end
            end
        end
    end
    
    CF:LogInfo("从 ATT 导入了 %d 个地图的声望关联", count)
    
    return true, associations
end

-- ====================================================================
-- 从 ATT 导入军需官位置信息
-- ====================================================================
function ATT:ImportQuartermasterData()
    if not self:IsAvailable() then
        CF:LogError("ALL THE THINGS 不可用，无法导入军需官数据")
        return false, {}
    end
    
    CF:LogInfo("开始从 ATT 导入军需官数据...")
    
    local quartermasters = {}
    local count = 0
    
    -- ATT 可能在 NPC 数据中存储军需官信息
    -- 注意：实际的数据结构可能需要根据 ATT 的实际实现调整
    
    if AllTheThings.DB and AllTheThings.DB.NPCs then
        for npcID, data in pairs(AllTheThings.DB.NPCs) do
            if type(npcID) == "number" and data.isQuartermaster then
                quartermasters[npcID] = {
                    id = npcID,
                    name = data.name or "Unknown",
                    mapID = data.mapID,
                    x = data.coord and data.coord[1],
                    y = data.coord and data.coord[2],
                    faction = data.faction,
                    reputationID = data.reputationID,
                }
                count = count + 1
            end
        end
    end
    
    CF:LogInfo("从 ATT 导入了 %d 个军需官", count)
    
    return true, quartermasters
end

-- ====================================================================
-- 执行完整导入
-- ====================================================================
function ATT:ImportAllData()
    if not self:IsAvailable() then
        CF:ShowLocalizedError("ERROR_ATT_NOT_FOUND")
        return false
    end
    
    CF:ShowLocalizedMessage("ATT_IMPORT_STARTED")
    
    local success = true
    local results = {}
    
    -- 导入货币数据
    local currencySuccess, currencies = self:ImportCurrencyData()
    results.currencies = currencySuccess and CF:TableSize(currencies) or 0
    success = success and currencySuccess
    
    -- 导入地图数据
    local mapSuccess, maps = self:ImportMapData()
    results.maps = mapSuccess and CF:TableSize(maps) or 0
    success = success and mapSuccess
    
    -- 导入声望数据
    local repSuccess, reputations = self:ImportReputationData()
    results.reputations = repSuccess and CF:TableSize(reputations) or 0
    success = success and repSuccess
    
    -- 导入地图货币关联
    local mapCurrSuccess, mapCurrencies = self:ImportMapCurrencyAssociations()
    if mapCurrSuccess and CF:TableSize(mapCurrencies) > 0 then
        -- 合并到用户配置
        local db = CopperFeverDB
        if db then
            db.mapAssociations = db.mapAssociations or {}
            for mapID, currencyList in pairs(mapCurrencies) do
                db.mapAssociations[mapID] = db.mapAssociations[mapID] or {}
                db.mapAssociations[mapID].currencies = currencyList
            end
        end
    end
    results.mapCurrencyAssociations = mapCurrSuccess and CF:TableSize(mapCurrencies) or 0
    
    -- 导入地图声望关联
    local mapRepSuccess, mapReputations = self:ImportMapReputationAssociations()
    if mapRepSuccess and CF:TableSize(mapReputations) > 0 then
        -- 合并到用户配置
        local db = CopperFeverDB
        if db then
            db.mapAssociations = db.mapAssociations or {}
            for mapID, repList in pairs(mapReputations) do
                db.mapAssociations[mapID] = db.mapAssociations[mapID] or {}
                db.mapAssociations[mapID].reputations = repList
            end
        end
    end
    results.mapReputationAssociations = mapRepSuccess and CF:TableSize(mapReputations) or 0
    
    -- 导入军需官数据
    local qmSuccess, quartermasters = self:ImportQuartermasterData()
    if qmSuccess and CF:TableSize(quartermasters) > 0 then
        -- 保存到数据库
        local db = CopperFeverDB
        if db then
            db.quartermasters = quartermasters
        end
    end
    results.quartermasters = qmSuccess and CF:TableSize(quartermasters) or 0
    
    -- 显示结果
    if success then
        CF:ShowLocalizedSuccess("ATT_IMPORT_COMPLETE")
        CF:LogInfo("导入统计: 货币=%d, 地图=%d, 声望=%d, 地图货币关联=%d, 地图声望关联=%d, 军需官=%d",
            results.currencies, results.maps, results.reputations,
            results.mapCurrencyAssociations, results.mapReputationAssociations,
            results.quartermasters)
    else
        CF:ShowLocalizedWarning("WARNING_INCOMPLETE_DATA")
    end
    
    -- 刷新数据
    CF.DataManager:RefreshData()
    
    return success, results
end

-- ====================================================================
-- 导入特定地图的数据
-- ====================================================================
function ATT:ImportMapData_Specific(mapID)
    if not self:IsAvailable() then
        CF:ShowLocalizedError("ERROR_ATT_NOT_FOUND")
        return false
    end
    
    if type(mapID) ~= "number" then
        CF:LogError("无效的地图ID")
        return false
    end
    
    CF:LogInfo("从 ATT 导入地图 %d 的数据...", mapID)
    
    -- 导入地图货币关联
    local success1, mapCurrencies = self:ImportMapCurrencyAssociations()
    if success1 and mapCurrencies[mapID] then
        CF.DataManager:SetMapCurrencies(mapID, mapCurrencies[mapID])
    end
    
    -- 导入地图声望关联
    local success2, mapReputations = self:ImportMapReputationAssociations()
    if success2 and mapReputations[mapID] then
        CF.DataManager:SetMapReputations(mapID, mapReputations[mapID])
    end
    
    if success1 or success2 then
        CF:ShowLocalizedSuccess("MSG_DATA_IMPORTED")
        return true
    else
        CF:ShowLocalizedError("ERROR_DATA_LOAD_FAILED")
        return false
    end
end

-- ====================================================================
-- 获取 ATT 的特定货币信息
-- ====================================================================
function ATT:GetCurrencyInfoFromATT(currencyID)
    if not self:IsAvailable() then
        return nil
    end
    
    if not AllTheThings.DB or not AllTheThings.DB.Currencies then
        return nil
    end
    
    return AllTheThings.DB.Currencies[currencyID]
end

-- ====================================================================
-- 获取 ATT 的特定地图信息
-- ====================================================================
function ATT:GetMapInfoFromATT(mapID)
    if not self:IsAvailable() then
        return nil
    end
    
    if not AllTheThings.DB or not AllTheThings.DB.Maps then
        return nil
    end
    
    return AllTheThings.DB.Maps[mapID]
end

-- ====================================================================
-- 获取 ATT 的特定声望信息
-- ====================================================================
function ATT:GetReputationInfoFromATT(factionID)
    if not self:IsAvailable() then
        return nil
    end
    
    if not AllTheThings.DB or not AllTheThings.DB.Factions then
        return nil
    end
    
    return AllTheThings.DB.Factions[factionID]
end

-- ====================================================================
-- 安全调用 ATT 函数
-- ====================================================================
function ATT:SafeCallATTFunction(func, ...)
    if not self:IsAvailable() then
        return nil, "ATT not available"
    end
    
    if type(func) ~= "function" then
        return nil, "Invalid function"
    end
    
    local success, result = pcall(func, ...)
    
    if not success then
        CF:LogError("ATT 函数调用失败: %s", tostring(result))
        return nil, result
    end
    
    return result, nil
end

-- ====================================================================
-- 获取导入建议
-- ====================================================================
function ATT:GetImportRecommendation()
    if not self:IsAvailable() then
        return {
            canImport = false,
            reason = CF.L["ATT_NOT_INSTALLED"],
        }
    end
    
    -- 检查 ATT 版本是否过旧
    if self.version and self.version < "1.0.0" then
        return {
            canImport = true,
            warning = CF.L["WARNING_ATT_OUTDATED"],
        }
    end
    
    return {
        canImport = true,
        reason = CF.L["INFO_ATT_INTEGRATION"],
    }
end

-- ====================================================================
-- 初始化
-- ====================================================================
function ATT:Initialize()
    -- 延迟检查 ATT 可用性（等待所有插件加载）
    C_Timer.After(2, function()
        self:CheckAvailability()
    end)
end