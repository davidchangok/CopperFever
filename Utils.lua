-- ====================================================================
-- Copper Fever - Utils.lua
-- 工具函数库
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever

-- ====================================================================
-- 调试与日志工具
-- ====================================================================

-- 调试输出函数
function CF:Debug(level, message, ...)
    if not level or not message then return end
    
    -- 检查调试级别
    if level > CF.CURRENT_DEBUG_LEVEL then return end
    
    -- 格式化消息
    local formattedMsg = string.format(message, ...)
    
    -- 添加级别前缀
    local prefix = ""
    if level == CF.DEBUG_LEVELS.ERROR then
        prefix = "|cFFFF0000[ERROR]|r"
    elseif level == CF.DEBUG_LEVELS.WARNING then
        prefix = "|cFFFFFF00[WARNING]|r"
    elseif level == CF.DEBUG_LEVELS.INFO then
        prefix = "|cFF00FF00[INFO]|r"
    elseif level == CF.DEBUG_LEVELS.DEBUG then
        prefix = "|cFF00FFFF[DEBUG]|r"
    elseif level == CF.DEBUG_LEVELS.TRACE then
        prefix = "|cFFCCCCCC[TRACE]|r"
    end
    
    -- 输出到聊天框
    print(string.format("%s %s: %s", prefix, CF.ADDON_TITLE, formattedMsg))
end

-- 错误日志
function CF:LogError(message, ...)
    self:Debug(CF.DEBUG_LEVELS.ERROR, message, ...)
end

-- 警告日志
function CF:LogWarning(message, ...)
    self:Debug(CF.DEBUG_LEVELS.WARNING, message, ...)
end

-- 信息日志
function CF:LogInfo(message, ...)
    self:Debug(CF.DEBUG_LEVELS.INFO, message, ...)
end

-- ====================================================================
-- 表操作工具
-- ====================================================================

-- 深拷贝表
function CF:DeepCopy(original)
    if type(original) ~= "table" then
        return original
    end
    
    local copy = {}
    for key, value in pairs(original) do
        if type(value) == "table" then
            copy[key] = self:DeepCopy(value)
        else
            copy[key] = value
        end
    end
    
    return copy
end

-- 合并表（将source合并到target）
function CF:MergeTables(target, source)
    if type(target) ~= "table" or type(source) ~= "table" then
        return target
    end
    
    for key, value in pairs(source) do
        if type(value) == "table" and type(target[key]) == "table" then
            target[key] = self:MergeTables(target[key], value)
        else
            target[key] = value
        end
    end
    
    return target
end

-- 检查表是否为空
function CF:IsTableEmpty(tbl)
    if type(tbl) ~= "table" then return true end
    return next(tbl) == nil
end

-- 获取表的大小
function CF:TableSize(tbl)
    if type(tbl) ~= "table" then return 0 end
    
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

-- 表中是否包含某个值
function CF:TableContains(tbl, value)
    if type(tbl) ~= "table" then return false end
    
    for _, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

-- 从表中移除值
function CF:TableRemoveValue(tbl, value)
    if type(tbl) ~= "table" then return end
    
    for k, v in pairs(tbl) do
        if v == value then
            tbl[k] = nil
            return true
        end
    end
    return false
end

-- ====================================================================
-- 字符串工具
-- ====================================================================

-- 去除字符串首尾空白
function CF:Trim(str)
    if type(str) ~= "string" then return "" end
    return str:match("^%s*(.-)%s*$")
end

-- 分割字符串
function CF:Split(str, delimiter)
    if type(str) ~= "string" then return {} end
    
    delimiter = delimiter or "%s"
    local result = {}
    
    for match in string.gmatch(str, "([^"..delimiter.."]+)") do
        table.insert(result, match)
    end
    
    return result
end

-- 首字母大写
function CF:Capitalize(str)
    if type(str) ~= "string" or #str == 0 then return "" end
    return str:sub(1, 1):upper() .. str:sub(2):lower()
end

-- 格式化货币显示
function CF:FormatMoney(amount)
    if type(amount) ~= "number" then return "0|cffeda55fc|r" end
    
    local gold = math.floor(amount / 10000)
    local silver = math.floor((amount % 10000) / 100)
    local copper = amount % 100
    
    local result = ""
    if gold > 0 then
        result = result .. gold .. "|cffffd700g|r "
    end
    if silver > 0 or gold > 0 then
        result = result .. silver .. "|cffc7c7cfs|r "
    end
    result = result .. copper .. "|cffeda55fc|r"
    
    return result
end

-- 格式化大数字
function CF:FormatNumber(number)
    if type(number) ~= "number" then return "0" end
    
    if number >= 1000000 then
        return string.format("%.1fM", number / 1000000)
    elseif number >= 1000 then
        return string.format("%.1fK", number / 1000)
    else
        return tostring(number)
    end
end

-- ====================================================================
-- 时间工具
-- ====================================================================

-- 获取当前时间戳
function CF:GetTimestamp()
    return time()
end

-- 格式化时间显示
function CF:FormatTime(seconds)
    if type(seconds) ~= "number" then return "0s" end
    
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    
    if days > 0 then
        return string.format("%dd %dh", days, hours)
    elseif hours > 0 then
        return string.format("%dh %dm", hours, minutes)
    elseif minutes > 0 then
        return string.format("%dm %ds", minutes, secs)
    else
        return string.format("%ds", secs)
    end
end

-- ====================================================================
-- 节流和防抖工具
-- ====================================================================

-- 节流函数表
CF.ThrottleTimers = CF.ThrottleTimers or {}

-- 节流函数（限制函数调用频率）
function CF:Throttle(key, delay, func, ...)
    if type(key) ~= "string" or type(func) ~= "function" then return end
    
    delay = delay or CF.PERFORMANCE.THROTTLE_DELAY
    local now = GetTime()
    
    -- 检查是否在冷却时间内
    if self.ThrottleTimers[key] and (now - self.ThrottleTimers[key]) < delay then
        return false
    end
    
    -- 执行函数并记录时间
    self.ThrottleTimers[key] = now
    func(...)
    return true
end

-- 防抖函数表
CF.DebounceTimers = CF.DebounceTimers or {}

-- 防抖函数（延迟执行，重复调用会重置计时器）
function CF:Debounce(key, delay, func, ...)
    if type(key) ~= "string" or type(func) ~= "function" then return end
    
    delay = delay or CF.PERFORMANCE.THROTTLE_DELAY
    
    -- 取消之前的计时器
    if self.DebounceTimers[key] then
        self.DebounceTimers[key]:Cancel()
    end
    
    -- 创建新计时器
    local args = {...}
    self.DebounceTimers[key] = C_Timer.NewTimer(delay, function()
        func(unpack(args))
        self.DebounceTimers[key] = nil
    end)
end

-- ====================================================================
-- 缓存工具
-- ====================================================================

-- 缓存表
CF.Cache = CF.Cache or {}

-- 设置缓存
function CF:SetCache(key, value, duration)
    if type(key) ~= "string" then return end
    
    duration = duration or CF.PERFORMANCE.CACHE_DURATION
    
    self.Cache[key] = {
        value = value,
        timestamp = GetTime(),
        duration = duration,
    }
end

-- 获取缓存
function CF:GetCache(key)
    if type(key) ~= "string" then return nil end
    
    local cached = self.Cache[key]
    if not cached then return nil end
    
    -- 检查缓存是否过期
    local now = GetTime()
    if (now - cached.timestamp) > cached.duration then
        self.Cache[key] = nil
        return nil
    end
    
    return cached.value
end

-- 清除缓存
function CF:ClearCache(key)
    if key then
        self.Cache[key] = nil
    else
        self.Cache = {}
    end
end

-- ====================================================================
-- API安全调用工具
-- ====================================================================

-- 安全调用API（带错误处理）
function CF:SafeCall(func, ...)
    if type(func) ~= "function" then
        self:LogError("SafeCall: 参数不是函数")
        return nil, CF.ERROR_CODES.INVALID_PARAMETER
    end
    
    local success, result = pcall(func, ...)
    
    if not success then
        self:LogError("API调用失败: %s", tostring(result))
        return nil, CF.ERROR_CODES.API_ERROR
    end
    
    return result, CF.ERROR_CODES.SUCCESS
end

-- 安全获取货币信息（避免保密数据）
function CF:SafeGetCurrencyInfo(currencyID)
    if type(currencyID) ~= "number" then
        return nil, CF.ERROR_CODES.INVALID_PARAMETER
    end
    
    -- 检查缓存
    local cacheKey = "currency_" .. currencyID
    local cached = self:GetCache(cacheKey)
    if cached then
        return cached, CF.ERROR_CODES.SUCCESS
    end
    
    -- 调用API
    local info = self:SafeCall(C_CurrencyInfo.GetCurrencyInfo, currencyID)
    
    if not info then
        return nil, CF.ERROR_CODES.DATA_NOT_FOUND
    end
    
    -- 过滤保密数据
    local safeInfo = {
        name = info.name,
        quantity = info.quantity,
        iconFileID = info.iconFileID,
        maxQuantity = info.maxQuantity,
        canEarnPerWeek = info.canEarnPerWeek,
        quantityEarnedThisWeek = info.quantityEarnedThisWeek,
        discovered = info.discovered,
    }
    
    -- 缓存结果
    self:SetCache(cacheKey, safeInfo, 30)
    
    return safeInfo, CF.ERROR_CODES.SUCCESS
end

-- 安全获取地图信息
function CF:SafeGetMapInfo(mapID)
    if type(mapID) ~= "number" then
        return nil, CF.ERROR_CODES.INVALID_PARAMETER
    end
    
    -- 检查缓存
    local cacheKey = "map_" .. mapID
    local cached = self:GetCache(cacheKey)
    if cached then
        return cached, CF.ERROR_CODES.SUCCESS
    end
    
    -- 调用API
    local info = self:SafeCall(C_Map.GetMapInfo, mapID)
    
    if not info then
        return nil, CF.ERROR_CODES.DATA_NOT_FOUND
    end
    
    -- 缓存结果（地图信息不变，长期缓存）
    self:SetCache(cacheKey, info, 3600)
    
    return info, CF.ERROR_CODES.SUCCESS
end

-- 安全获取声望信息
function CF:SafeGetFactionData(factionID)
    if type(factionID) ~= "number" then
        return nil, CF.ERROR_CODES.INVALID_PARAMETER
    end
    
    -- 检查缓存
    local cacheKey = "faction_" .. factionID
    local cached = self:GetCache(cacheKey)
    if cached then
        return cached, CF.ERROR_CODES.SUCCESS
    end
    
    -- 调用API
    local data = self:SafeCall(C_Reputation.GetFactionDataByID, factionID)
    
    if not data then
        return nil, CF.ERROR_CODES.DATA_NOT_FOUND
    end
    
    -- 缓存结果
    self:SetCache(cacheKey, data, 60)
    
    return data, CF.ERROR_CODES.SUCCESS
end

-- ====================================================================
-- 颜色工具
-- ====================================================================

-- 给文本添加颜色
function CF:Colorize(text, color)
    if type(text) ~= "string" then return "" end
    if not color then return text end
    
    local colorCode = self:GetColorCode(color)
    return colorCode .. text .. "|r"
end

-- 根据品质获取颜色
function CF:GetQualityColor(quality)
    if quality == 0 then return CF.COLORS.POOR
    elseif quality == 1 then return CF.COLORS.COMMON
    elseif quality == 2 then return CF.COLORS.UNCOMMON
    elseif quality == 3 then return CF.COLORS.RARE
    elseif quality == 4 then return CF.COLORS.EPIC
    elseif quality == 5 then return CF.COLORS.LEGENDARY
    elseif quality == 6 then return CF.COLORS.ARTIFACT
    elseif quality == 7 then return CF.COLORS.HEIRLOOM
    else return CF.COLORS.COMMON
    end
end

-- ====================================================================
-- 坐标工具
-- ====================================================================

-- 计算两点距离
function CF:CalculateDistance(x1, y1, x2, y2)
    if type(x1) ~= "number" or type(y1) ~= "number" or 
       type(x2) ~= "number" or type(y2) ~= "number" then
        return 0
    end
    
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

-- 获取玩家当前坐标
function CF:GetPlayerPosition()
    local mapID = C_Map.GetBestMapForUnit("player")
    if not mapID then return nil, nil, nil end
    
    local position = C_Map.GetPlayerMapPosition(mapID, "player")
    if not position then return mapID, nil, nil end
    
    local x, y = position:GetXY()
    return mapID, x, y
end

-- ====================================================================
-- 数学工具
-- ====================================================================

-- 限制数值范围
function CF:Clamp(value, min, max)
    if type(value) ~= "number" then return min end
    if value < min then return min end
    if value > max then return max end
    return value
end

-- 四舍五入
function CF:Round(value, decimals)
    if type(value) ~= "number" then return 0 end
    decimals = decimals or 0
    local mult = 10 ^ decimals
    return math.floor(value * mult + 0.5) / mult
end

-- 线性插值
function CF:Lerp(a, b, t)
    if type(a) ~= "number" or type(b) ~= "number" or type(t) ~= "number" then
        return a
    end
    return a + (b - a) * t
end

-- ====================================================================
-- 验证工具
-- ====================================================================

-- 验证货币ID
function CF:IsValidCurrencyID(currencyID)
    if type(currencyID) ~= "number" then return false end
    if currencyID <= 0 then return false end
    
    local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
    return info ~= nil
end

-- 验证地图ID
function CF:IsValidMapID(mapID)
    if type(mapID) ~= "number" then return false end
    if mapID <= 0 then return false end
    
    local info = C_Map.GetMapInfo(mapID)
    return info ~= nil
end

-- 验证声望ID
function CF:IsValidFactionID(factionID)
    if type(factionID) ~= "number" then return false end
    if factionID <= 0 then return false end
    
    local data = C_Reputation.GetFactionDataByID(factionID)
    return data ~= nil
end

-- ====================================================================
-- 版本比较工具
-- ====================================================================

-- 比较版本号（返回: 1表示v1>v2, 0表示相等, -1表示v1<v2）
function CF:CompareVersions(v1, v2)
    if type(v1) ~= "string" or type(v2) ~= "string" then return 0 end
    
    local parts1 = self:Split(v1, ".")
    local parts2 = self:Split(v2, ".")
    
    local maxLen = math.max(#parts1, #parts2)
    
    for i = 1, maxLen do
        local num1 = tonumber(parts1[i]) or 0
        local num2 = tonumber(parts2[i]) or 0
        
        if num1 > num2 then return 1 end
        if num1 < num2 then return -1 end
    end
    
    return 0
end