-- ====================================================================
-- Copper Fever - Core.lua
-- 核心初始化和事件管理
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever

-- ====================================================================
-- 模块初始化状态跟踪
-- ====================================================================
CF.ModulesInitialized = false
CF.InitializedModules = {}

-- ====================================================================
-- 事件系统
-- ====================================================================
CF.EventCallbacks = CF.EventCallbacks or {}

-- 注册自定义事件回调
function CF:RegisterEvent(event, callback)
    if type(event) ~= "string" or type(callback) ~= "function" then
        return false
    end
    
    self.EventCallbacks[event] = self.EventCallbacks[event] or {}
    table.insert(self.EventCallbacks[event], callback)
    
    return true
end

-- 触发自定义事件
function CF:TriggerEvent(event, ...)
    if type(event) ~= "string" then
        return
    end
    
    local callbacks = self.EventCallbacks[event]
    if not callbacks then
        return
    end
    
    for _, callback in ipairs(callbacks) do
        self:SafeCall(callback, ...)
    end
end

-- ====================================================================
-- 事件框架
-- ====================================================================
CF.EventFrame = CF.EventFrame or CreateFrame("Frame")
local EventFrame = CF.EventFrame

-- 注册游戏事件
function CF:RegisterGameEvent(event)
    if type(event) == "string" then
        EventFrame:RegisterEvent(event)
    end
end

-- 注销游戏事件
function CF:UnregisterGameEvent(event)
    if type(event) == "string" then
        EventFrame:UnregisterEvent(event)
    end
end

-- ====================================================================
-- 事件处理函数
-- ====================================================================

-- 玩家登录
function CF:OnPlayerLogin()
    self:LogInfo("玩家登录事件触发")
    
    -- 初始化数据库
    self:InitializeDatabase()
    
    -- 初始化本地化系统
    self:InitializeLocalization()
    
    -- 初始化各个模块
    self:InitializeModules()
    
    -- 显示欢迎消息
    if not CopperFeverDB.firstRun then
        self:ShowLocalizedMessage("INFO_FIRST_RUN")
        CopperFeverDB.firstRun = true
    else
        self:ShowLocalizedMessage("ADDON_LOADED")
    end
    
    -- 检查 ATT 集成（延迟加载）
    C_Timer.After(3, function()
        if CF.ATTIntegration and CF.ATTIntegration.CheckAvailability then
            if CF.ATTIntegration:CheckAvailability() then
                self:LogInfo("检测到 ALL THE THINGS 插件")
            end
        end
    end)
end

-- 进入世界
function CF:OnPlayerEnteringWorld(isInitialLogin, isReloadingUI)
    self:LogInfo("进入世界: 初次登录=%s, 重载界面=%s", 
                 tostring(isInitialLogin), tostring(isReloadingUI))
    
    -- 更新当前区域数据（延迟1秒等待地图数据加载）
    C_Timer.After(1, function()
        self:OnZoneChanged()
    end)
    
    -- 触发自定义事件
    self:TriggerEvent("PLAYER_ENTERED_WORLD", isInitialLogin, isReloadingUI)
end

-- 区域改变
function CF:OnZoneChanged()
    -- 使用节流避免频繁更新
    self:Throttle("zone_changed", 2, function()
        -- 区域变更时清理缓存，解决内存堆积风险
        if CF.DataManager and CF.DataManager.ClearExpiredCache then
            CF.DataManager:ClearExpiredCache()
        end
        
        -- 同时清理全局缓存
        if CF.ClearExpiredCache then
            CF:ClearExpiredCache()
        end

        local mapID = nil
        if CF.DataManager and CF.DataManager.GetCurrentMapID then
            mapID = CF.DataManager:GetCurrentMapID()
        end
        
        if not mapID then
            CF:LogWarning("无法获取当前地图ID")
            return
        end
        
        local mapInfo = nil
        if CF.DataManager and CF.DataManager.GetMapInfo then
            mapInfo = CF.DataManager:GetMapInfo(mapID)
        end
        
        local mapName = mapInfo and mapInfo.name or "Unknown"
        
        CF:LogInfo("区域改变: %s (ID: %d)", mapName, mapID)
        
        -- 显示区域变更消息（可选）
        local db = CopperFeverDB
        if db and db.settings and db.settings.display and 
           db.settings.display.showZoneMessages then
            CF:ShowLocalizedMessage("MSG_MAP_CHANGED", mapName)
        end
        
        -- 更新主窗口
        if CF.MainFrame and CF.MainFrame.IsShown and CF.MainFrame:IsShown() then
            if CF.MainFrame.Update then
                CF.MainFrame:Update()
            end
        end
        
        -- 触发自定义事件
        CF:TriggerEvent("ZONE_CHANGED", mapID, mapName)
    end)
end

-- 货币更新
function CF:OnCurrencyDisplayUpdate()
    -- 使用节流避免频繁更新
    self:Throttle("currency_update", 1, function()
        CF:LogInfo("货币显示更新")
        
        -- 更新主窗口
        if CF.MainFrame and CF.MainFrame.IsShown and CF.MainFrame:IsShown() then
            if CF.MainFrame.Update then
                CF.MainFrame:Update()
            end
        end
        
        -- 触发自定义事件
        CF:TriggerEvent("CURRENCY_UPDATED")
    end)
end

-- 声望更新
function CF:OnUpdateFaction()
    -- 使用节流避免频繁更新
    self:Throttle("faction_update", 1, function()
        CF:LogInfo("声望更新")
        
        -- 更新主窗口
        if CF.MainFrame and CF.MainFrame.IsShown and CF.MainFrame:IsShown() then
            if CF.MainFrame.Update then
                CF.MainFrame:Update()
            end
        end
        
        -- 触发自定义事件
        CF:TriggerEvent("REPUTATION_UPDATED")
    end)
end

-- 进入战斗
function CF:OnPlayerRegenDisabled()
    CF:LogInfo("进入战斗")
    
    -- 触发自定义事件
    CF:TriggerEvent("COMBAT_ENTERED")
    
    -- 如果设置了战斗中隐藏，则隐藏主窗口
    local db = CopperFeverDB
    if db and db.settings and db.settings.display and 
       db.settings.display.hideInCombat then
        if CF.MainFrame and CF.MainFrame.IsShown and CF.MainFrame:IsShown() then
            if CF.MainFrame.Hide then
                CF.MainFrame:Hide()
            end
        end
    end
end

-- 离开战斗
function CF:OnPlayerRegenEnabled()
    CF:LogInfo("离开战斗")
    
    -- 触发自定义事件
    CF:TriggerEvent("COMBAT_LEFT")
    
    -- 如果战斗前显示着，则重新显示主窗口
    local db = CopperFeverDB
    if db and db.settings and db.settings.mainFrame and 
       db.settings.mainFrame.shown then
        if CF.MainFrame and CF.MainFrame.Show then
            CF.MainFrame:Show()
        end
    end
end

-- ====================================================================
-- 事件分发器
-- ====================================================================
EventFrame:SetScript("OnEvent", function(self, event, ...)
    -- 根据事件类型调用相应的处理函数
    if event == "PLAYER_LOGIN" then
        CF:OnPlayerLogin()
    elseif event == "PLAYER_ENTERING_WORLD" then
        CF:OnPlayerEnteringWorld(...)
    elseif event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" then
        CF:OnZoneChanged()
    elseif event == "CURRENCY_DISPLAY_UPDATE" then
        CF:OnCurrencyDisplayUpdate()
    elseif event == "UPDATE_FACTION" then
        CF:OnUpdateFaction()
    elseif event == "PLAYER_REGEN_DISABLED" then
        CF:OnPlayerRegenDisabled()
    elseif event == "PLAYER_REGEN_ENABLED" then
        CF:OnPlayerRegenEnabled()
    elseif event == "PLAYER_LOGOUT" then
        CF:Cleanup()
    end
end)

-- ====================================================================
-- 数据库初始化
-- ====================================================================
function CF:InitializeDatabase()
    self:LogInfo("初始化数据库...")
    
    -- 初始化全局数据库
    if not CopperFeverDB then
        CopperFeverDB = {}
    end
    
    -- 初始化设置
    if not CopperFeverDB.settings then
        CopperFeverDB.settings = self:DeepCopy(CF.DEFAULTS)
    else
        -- 合并默认设置（保留用户自定义的值）
        CopperFeverDB.settings = self:MergeTables(
            self:DeepCopy(CF.DEFAULTS),
            CopperFeverDB.settings
        )
    end
    
    -- 初始化地图关联
    if not CopperFeverDB.mapAssociations then
        CopperFeverDB.mapAssociations = {}
    end
    
    -- 初始化版本信息
    if not CopperFeverDB.version then
        CopperFeverDB.version = CF.VERSION
    else
        -- 检查版本更新
        if CF:CompareVersions(CF.VERSION, CopperFeverDB.version) > 0 then
            self:OnVersionUpdate(CopperFeverDB.version, CF.VERSION)
            CopperFeverDB.version = CF.VERSION
        end
    end
    
    self:LogInfo("数据库初始化完成")
end

-- 版本更新处理
function CF:OnVersionUpdate(oldVersion, newVersion)
    self:LogInfo("检测到版本更新: %s -> %s", oldVersion, newVersion)
    
    -- 在这里可以添加版本迁移逻辑
    -- 例如：重置某些设置、迁移数据结构等
    
    self:ShowLocalizedMessage("INFO_UPDATE_AVAILABLE", newVersion)
end

-- ====================================================================
-- 模块初始化
-- ====================================================================
function CF:InitializeModules()
    if self.ModulesInitialized then
        self:LogWarning("模块已经初始化过了")
        return
    end
    
    self:LogInfo("初始化模块...")
    
    -- 初始化安全模块
    if CF.Security and CF.Security.Initialize then
        local success = pcall(CF.Security.Initialize, CF.Security)
        if success then
            self.InitializedModules.Security = true
            self:LogInfo("✓ Security 模块初始化完成")
        else
            self:LogError("✗ Security 模块初始化失败")
        end
    end
    
    -- 初始化数据管理器
    if CF.DataManager and CF.DataManager.Initialize then
        local success = pcall(CF.DataManager.Initialize, CF.DataManager)
        if success then
            self.InitializedModules.DataManager = true
            self:LogInfo("✓ DataManager 模块初始化完成")
        else
            self:LogError("✗ DataManager 模块初始化失败")
        end
    end
    
    -- 初始化 ATT 集成
    if CF.ATTIntegration and CF.ATTIntegration.Initialize then
        local success = pcall(CF.ATTIntegration.Initialize, CF.ATTIntegration)
        if success then
            self.InitializedModules.ATTIntegration = true
            self:LogInfo("✓ ATTIntegration 模块初始化完成")
        else
            self:LogError("✗ ATTIntegration 模块初始化失败")
        end
    end
    
    -- 初始化主窗口
    if CF.MainFrame and CF.MainFrame.Initialize then
        local success = pcall(CF.MainFrame.Initialize, CF.MainFrame)
        if success then
            self.InitializedModules.MainFrame = true
            self:LogInfo("✓ MainFrame 模块初始化完成")
        else
            self:LogError("✗ MainFrame 模块初始化失败")
        end
    end
    
    -- 初始化配置面板
    if CF.ConfigPanel and CF.ConfigPanel.Initialize then
        local success = pcall(CF.ConfigPanel.Initialize, CF.ConfigPanel)
        if success then
            self.InitializedModules.ConfigPanel = true
            self:LogInfo("✓ ConfigPanel 模块初始化完成")
        else
            self:LogError("✗ ConfigPanel 模块初始化失败")
        end
    end
    
    self.ModulesInitialized = true
    self:LogInfo("所有模块初始化完成")
end

-- ====================================================================
-- 斜杠命令处理
-- ====================================================================
function CF:HandleSlashCommand(input)
    local command = self:Trim(input:lower())
    
    if command == "" or command == "show" or command == "toggle" then
        -- 切换主窗口显示
        if CF.MainFrame and CF.MainFrame.Toggle then
            CF.MainFrame:Toggle()
        end
        
    elseif command == "hide" then
        -- 隐藏主窗口
        if CF.MainFrame and CF.MainFrame.Hide then
            CF.MainFrame:Hide()
        end
        
    elseif command == "config" or command == "settings" or command == "options" then
        -- 打开配置面板
        if CF.ConfigPanel and CF.ConfigPanel.Open then
            CF.ConfigPanel:Open()
        end
        
    elseif command == "refresh" or command == "reload" then
        -- 刷新数据
        if CF.DataManager and CF.DataManager.RefreshData then
            CF.DataManager:RefreshData()
        else
            CF:ShowLocalizedError("ERROR_DATA_LOAD_FAILED")
        end
        
    elseif command == "reset" then
        -- 重置位置
        if CF.MainFrame and CF.MainFrame.ResetPosition then
            CF.MainFrame:ResetPosition()
        end
        
    elseif command == "lock" then
        -- 锁定窗口
        if CF.MainFrame and CF.MainFrame.SetLocked then
            CF.MainFrame:SetLocked(true)
            CF:ShowLocalizedMessage("MENU_LOCK_WINDOW")
        end
        
    elseif command == "unlock" then
        -- 解锁窗口
        if CF.MainFrame and CF.MainFrame.SetLocked then
            CF.MainFrame:SetLocked(false)
            CF:ShowLocalizedMessage("MENU_UNLOCK_WINDOW")
        end
        
    elseif command == "att" or command == "import" then
        -- 从 ATT 导入
        if CF.ATTIntegration and CF.ATTIntegration.IsAvailable then
            if CF.ATTIntegration:IsAvailable() then
                if CF.ATTIntegration.ImportAllData then
                    CF.ATTIntegration:ImportAllData()
                end
            else
                CF:ShowLocalizedError("ERROR_ATT_NOT_FOUND")
            end
        else
            CF:ShowLocalizedError("ERROR_ATT_NOT_FOUND")
        end
        
    elseif command == "debug" then
        -- 切换调试模式
        if CF.CURRENT_DEBUG_LEVEL == CF.DEBUG_LEVELS.NONE then
            CF.CURRENT_DEBUG_LEVEL = CF.DEBUG_LEVELS.INFO
            CF:ShowLocalizedMessage("CMD_DEBUG_ENABLED")
        else
            CF.CURRENT_DEBUG_LEVEL = CF.DEBUG_LEVELS.NONE
            CF:ShowLocalizedMessage("CMD_DEBUG_DISABLED")
        end
        
    elseif command == "stats" then
        -- 显示统计信息
        if CF.Security and CF.Security.PrintStats then
            CF.Security:PrintStats()
        end
        if CF.CacheSize then
            CF:LogInfo("当前缓存条目: %d", CF.CacheSize)
        end
        
    elseif command == "clearcache" then
        -- 清理缓存
        if CF.ClearCache then
            CF:ClearCache()
            CF:ShowLocalizedSuccess("MSG_DATA_IMPORTED")
        end
        
    elseif command == "version" or command == "ver" then
        -- 显示版本信息
        local title = CF:Colorize(CF.ADDON_NAME, CF.COLORS.GOLD)
        local version = CF:Colorize("v" .. CF.VERSION, CF.COLORS.GREEN)
        local author = CF:Colorize(CF:L("AUTHOR") .. ": David W Zhang", CF.COLORS.GRAY)
        local build = CF:Colorize(CF:L("CMD_BUILD") .. ": " .. CF.BUILD, CF.COLORS.GRAY)
        print(title .. " " .. version)
        print(author)
        print(build)
        
    elseif command == "help" or command == "?" then
        -- 显示帮助
        print(CF:Colorize(CF:L("CMD_HELP_HEADER"), CF.COLORS.GOLD))
        print(CF:Colorize(CF:L("CMD_HELP_TOGGLE"), CF.COLORS.YELLOW))
        print(CF:Colorize(CF:L("CMD_HELP_CONFIG"), CF.COLORS.YELLOW))
        print(CF:Colorize(CF:L("CMD_HELP_REFRESH"), CF.COLORS.YELLOW))
        print(CF:Colorize(CF:L("CMD_HELP_RESET"), CF.COLORS.YELLOW))
        print(CF:Colorize(CF:L("CMD_HELP_LOCK"), CF.COLORS.YELLOW))
        print(CF:Colorize(CF:L("CMD_HELP_ATT"), CF.COLORS.YELLOW))
        print(CF:Colorize(CF:L("CMD_HELP_DEBUG"), CF.COLORS.YELLOW))
        print(CF:Colorize(CF:L("CMD_HELP_VERSION"), CF.COLORS.YELLOW))
        print(CF:Colorize(CF:L("CMD_HELP_HELP"), CF.COLORS.YELLOW))
        
    else
        CF:ShowLocalizedError("ERROR_INVALID_PARAMETER")
        print(CF:Colorize(CF:L("CMD_INVALID_PARAM"), CF.COLORS.YELLOW))
    end
end

-- ====================================================================
-- 注册游戏事件
-- ====================================================================
function CF:RegisterGameEvents()
    self:LogInfo("注册游戏事件...")
    
    -- 玩家事件
    self:RegisterGameEvent("PLAYER_LOGIN")
    self:RegisterGameEvent("PLAYER_ENTERING_WORLD")
    self:RegisterGameEvent("PLAYER_LOGOUT")
    
    -- 区域事件
    self:RegisterGameEvent("ZONE_CHANGED")
    self:RegisterGameEvent("ZONE_CHANGED_NEW_AREA")
    self:RegisterGameEvent("ZONE_CHANGED_INDOORS")
    
    -- 货币事件
    self:RegisterGameEvent("CURRENCY_DISPLAY_UPDATE")
    
    -- 声望事件
    self:RegisterGameEvent("UPDATE_FACTION")
    
    -- 战斗事件
    self:RegisterGameEvent("PLAYER_REGEN_DISABLED")
    self:RegisterGameEvent("PLAYER_REGEN_ENABLED")
    
    self:LogInfo("游戏事件注册完成")
end

-- ====================================================================
-- 清理函数
-- ====================================================================
function CF:Cleanup()
    self:LogInfo("执行清理...")
    
    -- 停止自动更新
    if CF.DataManager and CF.DataManager.StopAutoUpdate then
        pcall(CF.DataManager.StopAutoUpdate, CF.DataManager)
    end
    
    -- 保存窗口位置
    if CF.MainFrame and CF.MainFrame.SavePosition then
        pcall(CF.MainFrame.SavePosition, CF.MainFrame)
    end
    
    -- 清除过期缓存（不清除全部）
    if CF.ClearExpiredCache then
        pcall(CF.ClearExpiredCache, CF)
    end
    
    -- 清理安全模块
    if CF.Security and CF.Security.Cleanup then
        pcall(CF.Security.Cleanup, CF.Security)
    end
    
    self:LogInfo("清理完成")
end

-- ====================================================================
-- 主初始化函数
-- ====================================================================
function CF:Initialize()
    -- 使用本地化字符串输出初始化信息
    print(CF:Colorize(CF:L("CORE_INIT_LINE1"), CF.COLORS.GOLD))
    print(CF:Colorize(string.format(CF:L("CORE_INIT_LINE2"), CF.VERSION), CF.COLORS.GOLD))
    print(CF:Colorize(CF:L("CORE_INIT_LINE3"), CF.COLORS.GOLD))
    print(CF:Colorize(CF:L("CORE_INIT_LINE4"), CF.COLORS.GOLD))
    print(CF:Colorize(CF:L("CORE_INIT_LINE5"), CF.COLORS.GOLD))
    
    -- 注册游戏事件
    self:RegisterGameEvents()
    
    self:LogInfo("Copper Fever 核心初始化完成")
end

-- ====================================================================
-- 启动插件
-- ====================================================================

-- 立即开始初始化核心系统
CF:Initialize()

-- 注册斜杠命令
SLASH_COPPERFEVER1 = "/copperfever"
SLASH_COPPERFEVER2 = "/cf"
SlashCmdList["COPPERFEVER"] = function(msg)
    CF:HandleSlashCommand(msg)
end

-- ====================================================================
-- 全局函数导出（用于其他插件集成）
-- ====================================================================

-- 获取当前区域的货币列表
function CopperFever_GetCurrentCurrencies()
    if not CF.DataManager or not CF.DataManager.GetCurrentZoneData then 
        return {} 
    end
    
    local success, zoneData = pcall(CF.DataManager.GetCurrentZoneData, CF.DataManager)
    if not success or not zoneData then
        return {}
    end
    
    return zoneData.currencies or {}
end

-- 获取当前区域的声望列表
function CopperFever_GetCurrentReputations()
    if not CF.DataManager or not CF.DataManager.GetCurrentZoneData then 
        return {} 
    end
    
    local success, zoneData = pcall(CF.DataManager.GetCurrentZoneData, CF.DataManager)
    if not success or not zoneData then
        return {}
    end
    
    return zoneData.reputations or {}
end

-- 获取特定货币的数量
function CopperFever_GetCurrencyAmount(currencyID)
    if not CF.DataManager or not CF.DataManager.GetCurrencyAmount then 
        return 0 
    end
    
    local success, amount = pcall(CF.DataManager.GetCurrencyAmount, CF.DataManager, currencyID)
    return success and amount or 0
end

-- 获取特定声望的信息
function CopperFever_GetReputationInfo(factionID)
    if not CF.DataManager or not CF.DataManager.GetReputationInfo then 
        return nil 
    end
    
    local success, info = pcall(CF.DataManager.GetReputationInfo, CF.DataManager, factionID)
    return success and info or nil
end

-- 刷新显示
function CopperFever_Refresh()
    if CF.MainFrame and CF.MainFrame.Refresh then
        pcall(CF.MainFrame.Refresh, CF.MainFrame)
    end
end

-- 显示/隐藏主窗口
function CopperFever_Toggle()
    if CF.MainFrame and CF.MainFrame.Toggle then
        pcall(CF.MainFrame.Toggle, CF.MainFrame)
    end
end

-- ====================================================================
-- 调试输出
-- ====================================================================

-- 如果处于调试模式，输出加载信息
if CF.CURRENT_DEBUG_LEVEL > CF.DEBUG_LEVELS.NONE then
    CF:LogInfo("=== Copper Fever Debug Info ===")
    CF:LogInfo("Version: %s", CF.VERSION)
    CF:LogInfo("Build: %d", CF.BUILD)
    CF:LogInfo("Locale: %s", CF.currentLocale)
    CF:LogInfo("Player Faction: %s", CF:GetPlayerFaction())
    CF:LogInfo("Debug Level: %d", CF.CURRENT_DEBUG_LEVEL)
    CF:LogInfo("===============================")
end

-- ====================================================================
-- 结束标记
-- ====================================================================
CF:LogInfo("Core.lua 加载完成")