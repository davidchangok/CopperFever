-- ====================================================================
-- Copper Fever - Locales\Locale.lua
-- 本地化框架
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever

-- ====================================================================
-- 本地化系统初始化
-- ====================================================================

-- 创建本地化表
CF.L = CF.L or {}

-- 本地化元表，用于处理未翻译的字符串
local L = CF.L
local mt = {
    __index = function(t, k)
        -- 如果找不到翻译，返回键本身
        rawset(t, k, k)
        return k
    end
}
setmetatable(L, mt)

-- ====================================================================
-- 本地化函数
-- ====================================================================

-- 设置当前语言环境
CF.currentLocale = GetLocale()

-- 注册本地化字符串
function CF:RegisterLocale(locale, strings)
    if type(locale) ~= "string" or type(strings) ~= "table" then
        self:LogError("RegisterLocale: 无效参数")
        return
    end
    
    -- 如果是当前语言环境，合并字符串
    if locale == self.currentLocale then
        for key, value in pairs(strings) do
            L[key] = value
        end
    end
end

-- 获取本地化字符串
function CF:GetLocalizedString(key, ...)
    if type(key) ~= "string" then return "" end
    
    local str = L[key]
    
    -- 如果有参数，进行格式化
    if ... then
        str = string.format(str, ...)
    end
    
    return str
end

-- 简化调用方式
function CF:L(key, ...)
    return self:GetLocalizedString(key, ...)
end

-- ====================================================================
-- 检测当前客户端语言
-- ====================================================================

function CF:GetClientLocale()
    return self.currentLocale
end

-- 检查是否为中文客户端
function CF:IsChineseClient()
    return self.currentLocale == "zhCN" or self.currentLocale == "zhTW"
end

-- 检查是否为英文客户端
function CF:IsEnglishClient()
    return self.currentLocale == "enUS" or self.currentLocale == "enGB"
end

-- ====================================================================
-- 本地化辅助函数
-- ====================================================================

-- 获取阵营本地化名称
function CF:GetFactionLocalizedName(faction)
    if faction == CF.FACTIONS.ALLIANCE then
        return L["FACTION_ALLIANCE"]
    elseif faction == CF.FACTIONS.HORDE then
        return L["FACTION_HORDE"]
    else
        return L["FACTION_NEUTRAL"]
    end
end

-- 获取扩展版本本地化名称
function CF:GetExpansionLocalizedName(expansion)
    local key = "EXPANSION_" .. expansion
    return L[key] or ("Unknown Expansion " .. expansion)
end

-- 获取货币类型本地化名称
function CF:GetCurrencyTypeLocalizedName(currencyType)
    if currencyType == CF.CURRENCY_TYPES.STANDARD then
        return L["CURRENCY_TYPE_STANDARD"]
    elseif currencyType == CF.CURRENCY_TYPES.SEASONAL then
        return L["CURRENCY_TYPE_SEASONAL"]
    elseif currencyType == CF.CURRENCY_TYPES.REPUTATION then
        return L["CURRENCY_TYPE_REPUTATION"]
    elseif currencyType == CF.CURRENCY_TYPES.SPECIAL then
        return L["CURRENCY_TYPE_SPECIAL"]
    else
        return L["CURRENCY_TYPE_UNKNOWN"]
    end
end

-- 获取布局类型本地化名称
function CF:GetLayoutLocalizedName(layout)
    if layout == "vertical" then
        return L["LAYOUT_VERTICAL"]
    elseif layout == "horizontal" then
        return L["LAYOUT_HORIZONTAL"]
    else
        return layout
    end
end

-- ====================================================================
-- 调试信息本地化
-- ====================================================================

-- 获取调试级别本地化名称
function CF:GetDebugLevelLocalizedName(level)
    if level == CF.DEBUG_LEVELS.NONE then
        return L["DEBUG_LEVEL_NONE"]
    elseif level == CF.DEBUG_LEVELS.ERROR then
        return L["DEBUG_LEVEL_ERROR"]
    elseif level == CF.DEBUG_LEVELS.WARNING then
        return L["DEBUG_LEVEL_WARNING"]
    elseif level == CF.DEBUG_LEVELS.INFO then
        return L["DEBUG_LEVEL_INFO"]
    elseif level == CF.DEBUG_LEVELS.DEBUG then
        return L["DEBUG_LEVEL_DEBUG"]
    elseif level == CF.DEBUG_LEVELS.TRACE then
        return L["DEBUG_LEVEL_TRACE"]
    else
        return "Unknown"
    end
end

-- ====================================================================
-- 数值格式化本地化
-- ====================================================================

-- 格式化数字（考虑本地化）
function CF:FormatLocalizedNumber(number)
    if type(number) ~= "number" then return "0" end
    
    -- 中文使用万为单位
    if self:IsChineseClient() then
        if number >= 100000000 then
            return string.format("%.2f%s", number / 100000000, L["NUMBER_YI"])
        elseif number >= 10000 then
            return string.format("%.1f%s", number / 10000, L["NUMBER_WAN"])
        else
            return tostring(number)
        end
    else
        -- 英文使用K、M为单位
        if number >= 1000000 then
            return string.format("%.1fM", number / 1000000)
        elseif number >= 1000 then
            return string.format("%.1fK", number / 1000)
        else
            return tostring(number)
        end
    end
end

-- 格式化百分比（考虑本地化）
function CF:FormatLocalizedPercent(value)
    if type(value) ~= "number" then return "0%" end
    return string.format("%.1f%%", value)
end

-- ====================================================================
-- 时间格式化本地化
-- ====================================================================

-- 格式化时间（考虑本地化）
function CF:FormatLocalizedTime(seconds)
    if type(seconds) ~= "number" then return "0" .. L["TIME_SECOND"] end
    
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    
    if days > 0 then
        return string.format("%d%s %d%s", days, L["TIME_DAY"], hours, L["TIME_HOUR"])
    elseif hours > 0 then
        return string.format("%d%s %d%s", hours, L["TIME_HOUR"], minutes, L["TIME_MINUTE"])
    elseif minutes > 0 then
        return string.format("%d%s %d%s", minutes, L["TIME_MINUTE"], secs, L["TIME_SECOND"])
    else
        return string.format("%d%s", secs, L["TIME_SECOND"])
    end
end

-- ====================================================================
-- 颜色代码本地化
-- ====================================================================

-- 给文本添加颜色（带本地化支持）
function CF:ColorizeLocalizedText(key, color, ...)
    local text = self:L(key, ...)
    return self:Colorize(text, color)
end

-- ====================================================================
-- 工具提示本地化辅助
-- ====================================================================

-- 添加本地化的工具提示行
function CF:AddLocalizedTooltipLine(tooltip, key, color, ...)
    if not tooltip or type(key) ~= "string" then return end
    
    local text = self:L(key, ...)
    
    if color then
        tooltip:AddLine(text, color.r, color.g, color.b)
    else
        tooltip:AddLine(text)
    end
end

-- 添加本地化的工具提示双列行
function CF:AddLocalizedTooltipDoubleLine(tooltip, leftKey, rightKey, leftColor, rightColor, ...)
    if not tooltip or type(leftKey) ~= "string" or type(rightKey) ~= "string" then return end
    
    local leftText = self:L(leftKey, ...)
    local rightText = self:L(rightKey, ...)
    
    if leftColor and rightColor then
        tooltip:AddDoubleLine(leftText, rightText, 
            leftColor.r, leftColor.g, leftColor.b,
            rightColor.r, rightColor.g, rightColor.b)
    else
        tooltip:AddDoubleLine(leftText, rightText)
    end
end

-- ====================================================================
-- 系统消息本地化
-- ====================================================================

-- 显示本地化的系统消息
function CF:ShowLocalizedMessage(key, ...)
    local message = self:L(key, ...)
    print(self:Colorize(CF.ADDON_TITLE, CF.COLORS.GOLD) .. ": " .. message)
end

-- 显示本地化的错误消息
function CF:ShowLocalizedError(key, ...)
    local message = self:L(key, ...)
    print(self:Colorize(CF.ADDON_TITLE, CF.COLORS.GOLD) .. ": " .. 
          self:Colorize(message, CF.COLORS.RED))
end

-- 显示本地化的警告消息
function CF:ShowLocalizedWarning(key, ...)
    local message = self:L(key, ...)
    print(self:Colorize(CF.ADDON_TITLE, CF.COLORS.GOLD) .. ": " .. 
          self:Colorize(message, CF.COLORS.YELLOW))
end

-- 显示本地化的成功消息
function CF:ShowLocalizedSuccess(key, ...)
    local message = self:L(key, ...)
    print(self:Colorize(CF.ADDON_TITLE, CF.COLORS.GOLD) .. ": " .. 
          self:Colorize(message, CF.COLORS.GREEN))
end

-- ====================================================================
-- 默认回退机制
-- ====================================================================

-- 如果没有找到翻译，使用英文作为回退
CF.fallbackLocale = "enUS"

-- 设置回退语言
function CF:SetFallbackLocale(locale)
    if type(locale) == "string" then
        self.fallbackLocale = locale
    end
end

-- 获取回退语言
function CF:GetFallbackLocale()
    return self.fallbackLocale
end

-- ====================================================================
-- 语言环境信息
-- ====================================================================

-- 获取支持的语言列表
function CF:GetSupportedLocales()
    return {
        "enUS",  -- 英语（美国）
        "zhCN",  -- 简体中文
        -- 预留其他语言
        -- "zhTW",  -- 繁体中文
        -- "deDE",  -- 德语
        -- "esES",  -- 西班牙语
        -- "esMX",  -- 西班牙语（墨西哥）
        -- "frFR",  -- 法语
        -- "itIT",  -- 意大利语
        -- "ptBR",  -- 葡萄牙语（巴西）
        -- "ruRU",  -- 俄语
        -- "koKR",  -- 韩语
    }
end

-- 检查语言是否受支持
function CF:IsLocaleSupported(locale)
    local supported = self:GetSupportedLocales()
    return self:TableContains(supported, locale)
end

-- 获取当前语言的显示名称
function CF:GetLocaleDisplayName(locale)
    locale = locale or self.currentLocale
    
    local displayNames = {
        enUS = "English (US)",
        enGB = "English (GB)",
        zhCN = "简体中文",
        zhTW = "繁體中文",
        deDE = "Deutsch",
        esES = "Español",
        esMX = "Español (AL)",
        frFR = "Français",
        itIT = "Italiano",
        ptBR = "Português",
        ruRU = "Русский",
        koKR = "한국어",
    }
    
    return displayNames[locale] or locale
end

-- ====================================================================
-- 调试和测试功能
-- ====================================================================

-- 列出所有已注册的本地化字符串
function CF:ListLocalizedStrings()
    self:LogInfo("已注册的本地化字符串:")
    local count = 0
    for key, value in pairs(L) do
        if type(value) == "string" then
            self:LogInfo("  [%s] = %s", key, value)
            count = count + 1
        end
    end
    self:LogInfo("总计: %d 条", count)
end

-- 查找缺失的本地化字符串
function CF:FindMissingLocalizations(referenceLocale)
    referenceLocale = referenceLocale or "enUS"
    
    if self.currentLocale == referenceLocale then
        self:LogWarning("当前语言环境与参考语言环境相同")
        return
    end
    
    self:LogInfo("查找缺失的本地化字符串（参考: %s）", referenceLocale)
    -- 这里可以添加实际的比对逻辑
    -- 需要加载参考语言的字符串表进行比较
end