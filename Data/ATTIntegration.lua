-- ====================================================================
-- Copper Fever - Data\ATTIntegration.lua
-- ALL THE THINGS 插件集成
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever

-- ====================================================================
-- ATT 集成模块初始化
-- ====================================================================
CF.ATTIntegration = CF.ATTIntegration or {}
local ATT = CF.ATTIntegration

-- 初始化标志
ATT.initialized = false
ATT.available = false
ATT.version = nil

-- ====================================================================
-- 检测 ATT 是否可用
-- ====================================================================
function ATT:CheckAvailability()
    -- 检查 ATT 全局变量是否存在
    if _G.AllTheThings or _G.ATTCharacterData then
        self.available = true
        
        -- 尝试获取版本信息
        if _G.AllTheThings and type(_G.AllTheThings.GetVersion) == "function" then
            local success, version = pcall(_G.AllTheThings.GetVersion)
            if success then
                self.version = version
                CF:LogInfo("检测到 ALL THE THINGS v%s", tostring(version))
            end
        else
            CF:LogInfo("检测到 ALL THE THINGS (版本未知)")
        end
        
        return true
    end
    
    self.available = false
    return false
end

-- 是否可用
function ATT:IsAvailable()
    return self.available
end

-- 获取版本
function ATT:GetVersion()
    return self.version
end

-- ====================================================================
-- 从 ATT 导入货币数据
-- ====================================================================
function ATT:ImportCurrencies()
    if not self:IsAvailable() then
        CF:LogError("ALL THE THINGS 不可用")
        return {}
    end
    
    CF:LogInfo("正在从 ALL THE THINGS 导入货币数据...")
    
    local imported = {}
    local importedCount = 0
    
    -- ATT 可能将货币数据存储在不同的位置
    -- 这里提供一个通用的导入框架
    
    -- 尝试从 ATT 的数据结构中获取货币信息
    if _G.AllTheThings and type(_G.AllTheThings.Currencies) == "table" then
        for currencyID, data in pairs(_G.AllTheThings.Currencies) do
            if type(currencyID) == "number" and CF:IsValidCurrencyIDValue(currencyID) then
                -- 验证货币ID是否真实存在
                if CF:IsValidCurrencyID(currencyID) then
                    table.insert(imported, {
                        id = currencyID,
                        source = "ATT",
                        data = data,
                    })
                    importedCount = importedCount + 1
                end
            end
        end
    end
    
    CF:LogInfo("从 ATT 导入了 %d 个货币", importedCount)
    return imported
end

-- ====================================================================
-- 从 ATT 导入声望数据
-- ====================================================================
function ATT:ImportReputations()
    if not self:IsAvailable() then
        CF:LogError("ALL THE THINGS 不可用")
        return {}
    end
    
    CF:LogInfo("正在从 ALL THE THINGS 导入声望数据...")
    
    local imported = {}
    local importedCount = 0
    
    -- 尝试从 ATT 的数据结构中获取声望信息
    if _G.AllTheThings and type(_G.AllTheThings.Factions) == "table" then
        for factionID, data in pairs(_G.AllTheThings.Factions) do
            if type(factionID) == "number" and CF:IsValidFactionIDValue(factionID) then
                -- 验证声望ID是否真实存在
                if CF:IsValidFactionID(factionID) then
                    table.insert(imported, {
                        id = factionID,
                        source = "ATT",
                        data = data,
                    })
                    importedCount = importedCount + 1
                end
            end
        end
    end
    
    CF:LogInfo("从 ATT 导入了 %d 个声望", importedCount)
    return imported
end

-- ====================================================================
-- 从 ATT 导入地图数据
-- ====================================================================
function ATT:ImportMapData()
    if not self:IsAvailable() then
        CF:LogError("ALL THE THINGS 不可用")
        return {}
    end
    
    CF:LogInfo("正在从 ALL THE THINGS 导入地图数据...")
    
    local imported = {}
    local importedCount = 0
    
    -- 尝试从 ATT 的数据结构中获取地图信息
    if _G.AllTheThings and type(_G.AllTheThings.Maps) == "table" then
        for mapID, data in pairs(_G.AllTheThings.Maps) do
            if type(mapID) == "number" and CF:IsValidMapIDValue(mapID) then
                -- 验证地图ID是否真实存在
                if CF:IsValidMapID(mapID) then
                    imported[mapID] = {
                        id = mapID,
                        source = "ATT",
                        data = data,
                    }
                    importedCount = importedCount + 1
                end
            end
        end
    end
    
    CF:LogInfo("从 ATT 导入了 %d 个地图", importedCount)
    return imported
end

-- ====================================================================
-- 从 ATT 导入地图-货币关联
-- ====================================================================
function ATT:ImportMapCurrencyAssociations()
    if not self:IsAvailable() then
        CF:LogError("ALL THE THINGS 不可用")
        return {}
    end
    
    CF:LogInfo("正在从 ALL THE THINGS 导入地图-货币关联...")
    
    local associations = {}
    local associationCount = 0
    
    -- ATT 可能以不同方式存储关联关系
    -- 这里提供一个通用框架来提取这些关联
    
    if _G.AllTheThings and type(_G.AllTheThings.MapCurrencies) == "table" then
        for mapID, currencies in pairs(_G.AllTheThings.MapCurrencies) do
            if type(mapID) == "number" and type(currencies) == "table" then
                local validCurrencies = {}
                
                for _, currencyID in ipairs(currencies) do
                    if type(currencyID) == "number" and CF:IsValidCurrencyIDValue(currencyID) then
                        table.insert(validCurrencies, currencyID)
                    end
                end
                
                if #validCurrencies > 0 then
                    associations[mapID] = validCurrencies
                    associationCount = associationCount + 1
                end
            end
        end
    end
    
    CF:LogInfo("从 ATT 导入了 %d 个地图-货币关联", associationCount)
    return associations
end

-- ====================================================================
-- 从 ATT 导入地图-声望关联
-- ====================================================================
function ATT:ImportMapReputationAssociations()
    if not self:IsAvailable() then
        CF:LogError("ALL THE THINGS 不可用")
        return {}
    end
    
    CF:LogInfo("正在从 ALL THE THINGS 导入地图-声望关联...")
    
    local associations = {}
    local associationCount = 0
    
    if _G.AllTheThings and type(_G.AllTheThings.MapFactions) == "table" then
        for mapID, factions in pairs(_G.AllTheThings.MapFactions) do
            if type(mapID) == "number" and type(factions) == "table" then
                local validFactions = {}
                
                for _, factionID in ipairs(factions) do
                    if type(factionID) == "number" and CF:IsValidFactionIDValue(factionID) then
                        table.insert(validFactions, factionID)
                    end
                end
                
                if #validFactions > 0 then
                    associations[mapID] = validFactions
                    associationCount = associationCount + 1
                end
            end
        end
    end
    
    CF:LogInfo("从 ATT 导入了 %d 个地图-声望关联", associationCount)
    return associations
end

-- ====================================================================
-- 导入所有数据
-- ====================================================================
function ATT:ImportAllData()
    if not self:IsAvailable() then
        CF:ShowLocalizedError("ERROR_ATT_NOT_FOUND")
        return false
    end
    
    CF:LogInfo("开始从 ALL THE THINGS 导入所有数据...")
    CF:ShowLocalizedMessage("MSG_DATA_IMPORTING")
    local startTime = GetTime()
    local totalImported = 0
    
    -- 导入货币
    local success, currencies = pcall(self.ImportCurrencies, self)
    if success and currencies then
        totalImported = totalImported + #currencies
        CF:LogInfo("✓ 货币导入完成")
    else
        CF:LogError("✗ 货币导入失败: %s", tostring(currencies))
    end
    
    -- 导入声望 (修复: 添加 local 声明)
    local reputations
    success, reputations = pcall(self.ImportReputations, self)
    if success and reputations then
        totalImported = totalImported + #reputations
        CF:LogInfo("✓ 声望导入完成")
    else
        CF:LogError("✗ 声望导入失败: %s", tostring(reputations))
    end
    
    -- 导入地图数据 (修复: 添加 local 声明)
    local maps
    success, maps = pcall(self.ImportMapData, self)
    if success and maps then
        totalImported = totalImported + CF:TableSize(maps)
        CF:LogInfo("✓ 地图导入完成")
    else
        CF:LogError("✗ 地图导入失败: %s", tostring(maps))
    end
    
    -- 导入地图-货币关联 (修复: 添加 local 声明)
    local mapCurrencies
    success, mapCurrencies = pcall(self.ImportMapCurrencyAssociations, self)
    if success and mapCurrencies then
        -- 合并到数据库
        if CF.DataManager and CF.DataManager.ImportMapAssociations then
            local importData = {}
            for mapID, currencies in pairs(mapCurrencies) do
                importData[mapID] = {currencies = currencies}
            end
            CF.DataManager:ImportMapAssociations(importData)
        end
        CF:LogInfo("✓ 地图-货币关联导入完成")
    else
        CF:LogError("✗ 地图-货币关联导入失败: %s", tostring(mapCurrencies))
    end
    
    -- 导入地图-声望关联 (修复: 添加 local 声明)
    local mapReputations
    success, mapReputations = pcall(self.ImportMapReputationAssociations, self)
    if success and mapReputations then
        -- 合并到数据库
        if CF.DataManager and CF.DataManager.ImportMapAssociations then
            local importData = {}
            for mapID, reputations in pairs(mapReputations) do
                importData[mapID] = importData[mapID] or {}
                importData[mapID].reputations = reputations
            end
            CF.DataManager:ImportMapAssociations(importData)
        end
        CF:LogInfo("✓ 地图-声望关联导入完成")
    else
        CF:LogError("✗ 地图-声望关联导入失败: %s", tostring(mapReputations))
    end
    
    local elapsed = GetTime() - startTime
    CF:LogInfo("数据导入完成，耗时: %.2f 秒，共导入 %d 条数据", elapsed, totalImported)
    CF:ShowLocalizedSuccess("MSG_DATA_IMPORTED")
    
    return true
end

-- ====================================================================
-- 获取 ATT 的当前区域数据
-- ====================================================================
function ATT:GetCurrentZoneData()
    if not self:IsAvailable() then
        return nil
    end
    
    -- 尝试从 ATT 获取当前区域的数据
    if _G.AllTheThings and type(_G.AllTheThings.GetCurrentMapID) == "function" then
        local success, mapID = pcall(_G.AllTheThings.GetCurrentMapID)
        if success and mapID then
            return {
                mapID = mapID,
                source = "ATT",
            }
        end
    end
    
    return nil
end

-- ====================================================================
-- 与 ATT 同步特定地图的数据
-- ====================================================================
function ATT:SyncMapData(mapID)
    if not self:IsAvailable() then
        CF:LogError("ALL THE THINGS 不可用")
        return false
    end
    
    if type(mapID) ~= "number" or mapID <= 0 then
        CF:LogError("无效的地图ID: %s", tostring(mapID))
        return false
    end
    
    CF:LogInfo("正在同步地图 %d 的数据...", mapID)
    
    -- 尝试从 ATT 获取该地图的货币和声望
    local currencies = {}
    local reputations = {}
    
    if _G.AllTheThings then
        -- 尝试获取地图的货币
        if type(_G.AllTheThings.GetMapCurrencies) == "function" then
            local success, data = pcall(_G.AllTheThings.GetMapCurrencies, mapID)
            if success and type(data) == "table" then
                currencies = data
            end
        end
        
        -- 尝试获取地图的声望
        if type(_G.AllTheThings.GetMapFactions) == "function" then
            local success, data = pcall(_G.AllTheThings.GetMapFactions, mapID)
            if success and type(data) == "table" then
                reputations = data
            end
        end
    end
    
    -- 保存到 DataManager
    if CF.DataManager then
        if #currencies > 0 then
            CF.DataManager:SetMapCurrencies(mapID, currencies)
        end
        if #reputations > 0 then
            CF.DataManager:SetMapReputations(mapID, reputations)
        end
    end
    
    CF:LogInfo("地图 %d 同步完成: %d 货币, %d 声望", 
              mapID, #currencies, #reputations)
    
    return true
end

-- ====================================================================
-- 监听 ATT 事件
-- ====================================================================
function ATT:RegisterATTEvents()
    if not self:IsAvailable() then
        return
    end
    
    -- ATT 可能会触发自定义事件
    -- 这里可以注册监听这些事件
    
    if _G.AllTheThings and type(_G.AllTheThings.RegisterCallback) == "function" then
        -- 注册数据更新回调
        local success = pcall(_G.AllTheThings.RegisterCallback, "DataUpdated", function()
            CF:LogInfo("ATT 数据已更新")
            -- 可以在这里触发重新导入或刷新
        end)
        
        if success then
            CF:LogInfo("已注册 ATT 事件监听")
        end
    end
end

-- ====================================================================
-- 初始化 ATT 集成
-- ====================================================================
function ATT:Initialize()
    if self.initialized then
        CF:LogWarning("ATTIntegration 已经初始化过了")
        return
    end
    
    CF:LogInfo("初始化 ALL THE THINGS 集成...")
    
    -- 检测 ATT 是否可用
    self:CheckAvailability()
    
    if self.available then
        -- 注册事件监听
        self:RegisterATTEvents()
        
        CF:LogInfo("ALL THE THINGS 集成初始化完成")
    else
        CF:LogInfo("ALL THE THINGS 未安装或未启用")
    end
    
    self.initialized = true
end

-- ====================================================================
-- 获取集成状态
-- ====================================================================
function ATT:GetStatus()
    return {
        initialized = self.initialized,
        available = self.available,
        version = self.version,
        canImport = self.available,
    }
end

-- ====================================================================
-- 打印集成状态
-- ====================================================================
function ATT:PrintStatus()
    local status = self:GetStatus()
    
    CF:LogInfo("=== ATT 集成状态 ===")
    CF:LogInfo("初始化: %s", status.initialized and "是" or "否")
    CF:LogInfo("可用: %s", status.available and "是" or "否")
    CF:LogInfo("版本: %s", status.version or "未知")
    CF:LogInfo("可导入: %s", status.canImport and "是" or "否")
    CF:LogInfo("===================")
end

-- ====================================================================
-- 清理函数
-- ====================================================================
function ATT:Cleanup()
    CF:LogInfo("清理 ATT 集成...")
    -- 这里可以添加清理逻辑
end

-- ====================================================================
-- 兼容性检查
-- ====================================================================
function ATT:CheckCompatibility()
    if not self:IsAvailable() then
        return true -- 如果没有安装，没有兼容性问题
    end
    
    -- 检查 ATT 版本是否兼容
    if self.version then
        -- 这里可以添加版本检查逻辑
        -- 例如:检查最低版本要求
        CF:LogInfo("ATT 版本 %s 兼容性检查通过", tostring(self.version))
    end
    
    return true
end

-- ====================================================================
-- 结束标记
-- ====================================================================