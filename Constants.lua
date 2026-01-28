-- ====================================================================
-- Copper Fever - Constants.lua
-- 常量定义文件
-- Author: David W Zhang
-- ====================================================================

-- 创建插件命名空间
CopperFever = CopperFever or {}
local CF = CopperFever

-- ====================================================================
-- 版本信息
-- ====================================================================
CF.VERSION = "1.0.0"
CF.BUILD = 120000

-- ====================================================================
-- 插件名称常量
-- ====================================================================
CF.ADDON_NAME = "CopperFever"
CF.ADDON_TITLE = "Copper Fever"

-- ====================================================================
-- 颜色常量
-- ====================================================================
CF.COLORS = {
    -- 品质颜色
    POOR = {r = 0.62, g = 0.62, b = 0.62},           -- 灰色（垃圾）
    COMMON = {r = 1.00, g = 1.00, b = 1.00},         -- 白色（普通）
    UNCOMMON = {r = 0.12, g = 1.00, b = 0.00},       -- 绿色（优秀）
    RARE = {r = 0.00, g = 0.44, b = 0.87},           -- 蓝色（精良）
    EPIC = {r = 0.64, g = 0.21, b = 0.93},           -- 紫色（史诗）
    LEGENDARY = {r = 1.00, g = 0.50, b = 0.00},      -- 橙色（传说）
    ARTIFACT = {r = 0.90, g = 0.80, b = 0.50},       -- 金色（神器）
    HEIRLOOM = {r = 0.00, g = 0.80, b = 1.00},       -- 青色（传家宝）
    
    -- 系统颜色
    GOLD = {r = 1.00, g = 0.82, b = 0.00},           -- 金色
    RED = {r = 1.00, g = 0.00, b = 0.00},            -- 红色
    GREEN = {r = 0.00, g = 1.00, b = 0.00},          -- 绿色
    YELLOW = {r = 1.00, g = 1.00, b = 0.00},         -- 黄色
    GRAY = {r = 0.50, g = 0.50, b = 0.50},           -- 灰色
}

-- ====================================================================
-- 默认配置常量
-- ====================================================================
CF.DEFAULTS = {
    -- 主窗口配置
    mainFrame = {
        width = 200,
        height = 300,
        point = "CENTER",
        x = 0,
        y = 0,
        locked = false,
        shown = true,
        scale = 1.0,
        alpha = 0.9,
        backgroundColor = {r = 0, g = 0, b = 0, a = 0.8},
        borderColor = {r = 1, g = 0.82, b = 0, a = 1},
    },
    
    -- 显示配置
    display = {
        layout = "vertical",        -- "vertical" 或 "horizontal"
        iconSize = 24,
        fontSize = 12,
        spacing = 5,
        showIcons = true,
        showTooltips = true,
        autoHide = false,           -- 不相关区域自动隐藏
        hideInCombat = false,       -- 战斗中隐藏
        showZoneMessages = false,   -- 显示区域切换消息
    },
    
    -- 数据配置
    data = {
        enableAutoUpdate = true,     -- 启用自动更新
        updateInterval = 5,          -- 更新间隔（秒）
        showAllCurrencies = false,   -- 显示所有货币（不仅当前地图）
    },
}

-- ====================================================================
-- 事件常量
-- ====================================================================
CF.EVENTS = {
    -- 玩家事件
    PLAYER_ENTERING_WORLD = "PLAYER_ENTERING_WORLD",
    PLAYER_LEAVING_WORLD = "PLAYER_LEAVING_WORLD",
    PLAYER_LOGIN = "PLAYER_LOGIN",
    PLAYER_LOGOUT = "PLAYER_LOGOUT",
    
    -- 货币事件
    CURRENCY_DISPLAY_UPDATE = "CURRENCY_DISPLAY_UPDATE",
    
    -- 区域事件
    ZONE_CHANGED = "ZONE_CHANGED",
    ZONE_CHANGED_NEW_AREA = "ZONE_CHANGED_NEW_AREA",
    ZONE_CHANGED_INDOORS = "ZONE_CHANGED_INDOORS",
    
    -- 声望事件
    UPDATE_FACTION = "UPDATE_FACTION",
    
    -- 战斗事件
    PLAYER_REGEN_DISABLED = "PLAYER_REGEN_DISABLED",  -- 进入战斗
    PLAYER_REGEN_ENABLED = "PLAYER_REGEN_ENABLED",    -- 离开战斗
}

-- ====================================================================
-- 货币类型常量
-- ====================================================================
CF.CURRENCY_TYPES = {
    STANDARD = 1,       -- 标准货币
    SEASONAL = 2,       -- 赛季货币
    REPUTATION = 3,     -- 声望货币
    SPECIAL = 4,        -- 特殊货币
}

-- ====================================================================
-- 阵营常量
-- ====================================================================
CF.FACTIONS = {
    ALLIANCE = 1,
    HORDE = 2,
    NEUTRAL = 3,
}

-- ====================================================================
-- 地图类型常量
-- ====================================================================
CF.MAP_TYPES = {
    COSMIC = 0,
    WORLD = 1,
    CONTINENT = 2,
    ZONE = 3,
    DUNGEON = 4,
    MICRO = 5,
    ORPHAN = 6,
}

-- ====================================================================
-- 扩展版本常量
-- ====================================================================
CF.EXPANSIONS = {
    CLASSIC = 0,                -- 经典旧世
    TBC = 1,                    -- 燃烧的远征
    WOTLK = 2,                  -- 巫妖王之怒
    CATACLYSM = 3,              -- 大地的裂变
    MOP = 4,                    -- 熊猫人之谜
    WOD = 5,                    -- 德拉诺之王
    LEGION = 6,                 -- 军团再临
    BFA = 7,                    -- 争霸艾泽拉斯
    SHADOWLANDS = 8,            -- 暗影国度
    DRAGONFLIGHT = 9,           -- 巨龙时代
    TWW = 10,                   -- 地心之战
}

-- ====================================================================
-- 错误代码常量
-- ====================================================================
CF.ERROR_CODES = {
    SUCCESS = 0,
    INVALID_PARAMETER = 1,
    DATA_NOT_FOUND = 2,
    API_ERROR = 3,
    PERMISSION_DENIED = 4,
    UNKNOWN_ERROR = 99,
}

-- ====================================================================
-- 调试级别常量
-- ====================================================================
CF.DEBUG_LEVELS = {
    NONE = 0,
    ERROR = 1,
    WARNING = 2,
    INFO = 3,
    DEBUG = 4,
    TRACE = 5,
}

-- 当前调试级别（发布版本设置为 NONE）
CF.CURRENT_DEBUG_LEVEL = CF.DEBUG_LEVELS.NONE

-- ====================================================================
-- API保护常量
-- ====================================================================
CF.PROTECTED_APIS = {
    -- 需要保护的API列表，避免"保密数据"污染
    "C_CurrencyInfo.GetCurrencyInfo",
    "C_CurrencyInfo.GetCurrencyListInfo",
    "C_Map.GetMapInfo",
    "C_Reputation.GetFactionDataByID",
}

-- ====================================================================
-- 性能优化常量
-- ====================================================================
CF.PERFORMANCE = {
    THROTTLE_DELAY = 0.5,           -- 节流延迟（秒）
    CACHE_DURATION = 300,           -- 缓存持续时间（秒）
    MAX_BATCH_SIZE = 50,            -- 最大批处理大小
    MAX_CACHE_SIZE = 1000,          -- 最大缓存条目数
}

-- ====================================================================
-- 字符串格式常量
-- ====================================================================
CF.FORMATS = {
    MONEY = "%d|cffffd700g|r %d|cffc7c7cfs|r %d|cffeda55fc|r",  -- 金 银 铜
    PERCENT = "%.1f%%",                                          -- 百分比
    NUMBER = "%d",                                               -- 整数
    NUMBER_SHORT = "%.1fk",                                      -- 简短数字（千）
}

-- ====================================================================
-- 帧层级常量
-- ====================================================================
CF.FRAME_STRATA = {
    MAIN = "MEDIUM",
    CONFIG = "HIGH",
    TOOLTIP = "TOOLTIP",
}

-- ====================================================================
-- 工具提示锚点常量
-- ====================================================================
CF.TOOLTIP_ANCHORS = {
    TOP = "TOP",
    BOTTOM = "BOTTOM",
    LEFT = "LEFT",
    RIGHT = "RIGHT",
    TOPLEFT = "TOPLEFT",
    TOPRIGHT = "TOPRIGHT",
    BOTTOMLEFT = "BOTTOMLEFT",
    BOTTOMRIGHT = "BOTTOMRIGHT",
}

-- ====================================================================
-- 辅助函数：颜色转换
-- ====================================================================

-- 验证颜色表
local function ValidateColor(color)
    if type(color) ~= "table" then return false end
    if type(color.r) ~= "number" or color.r < 0 or color.r > 1 then return false end
    if type(color.g) ~= "number" or color.g < 0 or color.g > 1 then return false end
    if type(color.b) ~= "number" or color.b < 0 or color.b > 1 then return false end
    return true
end

-- 颜色转十六进制
function CF:ColorToHex(color)
    if not ValidateColor(color) then return "FFFFFF" end
    local r = math.floor((color.r or 1) * 255)
    local g = math.floor((color.g or 1) * 255)
    local b = math.floor((color.b or 1) * 255)
    return string.format("%02X%02X%02X", r, g, b)
end

-- 十六进制转颜色
function CF:HexToColor(hex)
    if type(hex) ~= "string" or #hex ~= 6 then 
        return {r = 1, g = 1, b = 1} 
    end
    
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    
    if not r or not g or not b then
        return {r = 1, g = 1, b = 1}
    end
    
    return {
        r = r / 255,
        g = g / 255,
        b = b / 255
    }
end

-- ====================================================================
-- 辅助函数：颜色代码生成
-- ====================================================================
function CF:GetColorCode(color)
    if not ValidateColor(color) then return "|cFFFFFFFF" end
    return string.format("|cFF%s", self:ColorToHex(color))
end

-- ====================================================================
-- 辅助函数：玩家阵营检测
-- ====================================================================
function CF:GetPlayerFaction()
    local factionName = UnitFactionGroup("player")
    if factionName == "Alliance" then
        return CF.FACTIONS.ALLIANCE
    elseif factionName == "Horde" then
        return CF.FACTIONS.HORDE
    else
        return CF.FACTIONS.NEUTRAL
    end
end

-- ====================================================================
-- 输入验证辅助函数
-- ====================================================================

-- 验证货币ID
function CF:IsValidCurrencyIDValue(currencyID)
    return type(currencyID) == "number" and currencyID > 0
end

-- 验证地图ID
function CF:IsValidMapIDValue(mapID)
    return type(mapID) == "number" and mapID > 0
end

-- 验证声望ID
function CF:IsValidFactionIDValue(factionID)
    return type(factionID) == "number" and factionID > 0
end

-- 验证扩展版本ID
function CF:IsValidExpansionID(expansionID)
    return type(expansionID) == "number" and 
           expansionID >= CF.EXPANSIONS.CLASSIC and 
           expansionID <= CF.EXPANSIONS.TWW
end

-- ====================================================================
-- 结束标记
-- ====================================================================