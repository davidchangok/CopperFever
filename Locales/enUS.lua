-- ====================================================================
-- Copper Fever - Locales\enUS.lua
-- 英文本地化
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever
local L = {}

-- ====================================================================
-- 通用文本
-- ====================================================================
L["ADDON_NAME"] = "Copper Fever"
L["ADDON_LOADED"] = "Copper Fever loaded successfully!"
L["ADDON_VERSION"] = "Version"
L["AUTHOR"] = "Author"

-- ====================================================================
-- 核心初始化文本
-- ====================================================================
L["CORE_INIT_LINE1"] = "======================================"
L["CORE_INIT_LINE2"] = "Copper Fever v%s"
L["CORE_INIT_LINE3"] = "Track currencies and reputations"
L["CORE_INIT_LINE4"] = "by David W Zhang"
L["CORE_INIT_LINE5"] = "======================================"

-- ====================================================================
-- 主界面文本
-- ====================================================================
L["MAIN_FRAME_TITLE"] = "Copper Fever"
L["NO_DATA"] = "No data available"
L["LOADING"] = "Loading..."
L["CURRENCY"] = "Currency"
L["RESOURCE"] = "Resource"
L["REPUTATION"] = "Reputation"
L["TOTAL"] = "Total"
L["CURRENT"] = "Current"
L["MAX"] = "Maximum"
L["WEEKLY"] = "Weekly"
L["EARNED_THIS_WEEK"] = "Earned This Week"

-- ====================================================================
-- 配置界面文本
-- ====================================================================
L["CONFIG_TITLE"] = "Copper Fever Settings"
L["CONFIG_GENERAL"] = "General Settings"
L["CONFIG_DISPLAY"] = "Display Settings"
L["CONFIG_DATA"] = "Data Settings"
L["CONFIG_ADVANCED"] = "Advanced Settings"

-- 显示设置
L["DISPLAY_LAYOUT"] = "Layout"
L["DISPLAY_ICON_SIZE"] = "Icon Size"
L["DISPLAY_FONT_SIZE"] = "Font Size"
L["DISPLAY_SPACING"] = "Spacing"
L["DISPLAY_SHOW_ICONS"] = "Show Icons"
L["DISPLAY_SHOW_TOOLTIPS"] = "Show Tooltips"
L["DISPLAY_AUTO_HIDE"] = "Auto Hide in Irrelevant Zones"
L["DISPLAY_HIDE_IN_COMBAT"] = "Hide in Combat"
L["DISPLAY_SHOW_ZONE_MESSAGES"] = "Show Zone Change Messages"

-- 窗口设置
L["WINDOW_LOCKED"] = "Lock Window"
L["WINDOW_SCALE"] = "Window Scale"
L["WINDOW_ALPHA"] = "Window Opacity"
L["WINDOW_BACKGROUND_COLOR"] = "Background Color"
L["WINDOW_BORDER_COLOR"] = "Border Color"
L["WINDOW_WIDTH"] = "Window Width"
L["WINDOW_HEIGHT"] = "Window Height"
L["WINDOW_RESET_POSITION"] = "Reset Position"

-- 数据设置
L["DATA_AUTO_UPDATE"] = "Enable Auto Update"
L["DATA_UPDATE_INTERVAL"] = "Update Interval (seconds)"
L["DATA_SHOW_ALL_CURRENCIES"] = "Show All Currencies"
L["DATA_IMPORT_FROM_ATT"] = "Import from ALL THE THINGS"
L["DATA_EXPORT"] = "Export Data"
L["DATA_IMPORT"] = "Import Data"
L["ATT_DATA_SOURCE_HEADER"] = "ALL THE THINGS Data Sources"
L["DATA_RESET"] = "Reset to Default"

-- 地图和资源配置
L["CONFIG_MAP_LIST"] = "Map List"
L["CONFIG_SELECT_MAP"] = "Select a map to configure"
L["CONFIG_ASSOCIATED_CURRENCIES"] = "Associated Currencies"
L["CONFIG_ASSOCIATED_RESOURCES"] = "Associated Resources"
L["CONFIG_ASSOCIATED_REPUTATIONS"] = "Associated Reputations"
L["CONFIG_ADD_CURRENCY"] = "Add Currency"
L["CONFIG_ADD_RESOURCE"] = "Add Resource"
L["CONFIG_ADD_REPUTATION"] = "Add Reputation"
L["CONFIG_REMOVE"] = "Remove"

-- ====================================================================
-- 阵营文本
-- ====================================================================
L["FACTION_ALLIANCE"] = "Alliance"
L["FACTION_HORDE"] = "Horde"
L["FACTION_NEUTRAL"] = "Neutral"

-- ====================================================================
-- 扩展版本文本
-- ====================================================================
L["EXPANSION_0"] = "Classic"
L["EXPANSION_1"] = "The Burning Crusade"
L["EXPANSION_2"] = "Wrath of the Lich King"
L["EXPANSION_3"] = "Cataclysm"
L["EXPANSION_4"] = "Mists of Pandaria"
L["EXPANSION_5"] = "Warlords of Draenor"
L["EXPANSION_6"] = "Legion"
L["EXPANSION_7"] = "Battle for Azeroth"
L["EXPANSION_8"] = "Shadowlands"
L["EXPANSION_9"] = "Dragonflight"
L["EXPANSION_10"] = "The War Within"

-- ====================================================================
-- 货币类型文本
-- ====================================================================
L["CURRENCY_TYPE_STANDARD"] = "Standard"
L["CURRENCY_TYPE_SEASONAL"] = "Seasonal"
L["CURRENCY_TYPE_REPUTATION"] = "Reputation"
L["CURRENCY_TYPE_SPECIAL"] = "Special"
L["CURRENCY_TYPE_UNKNOWN"] = "Unknown"

-- ====================================================================
-- 布局类型文本
-- ====================================================================
L["LAYOUT_VERTICAL"] = "Vertical"
L["LAYOUT_HORIZONTAL"] = "Horizontal"

-- ====================================================================
-- 调试级别文本
-- ====================================================================
L["DEBUG_LEVEL_NONE"] = "None"
L["DEBUG_LEVEL_ERROR"] = "Error"
L["DEBUG_LEVEL_WARNING"] = "Warning"
L["DEBUG_LEVEL_INFO"] = "Info"
L["DEBUG_LEVEL_DEBUG"] = "Debug"
L["DEBUG_LEVEL_TRACE"] = "Trace"

-- ====================================================================
-- 声望等级文本
-- ====================================================================
L["REPUTATION_STANDING_1"] = "Hated"
L["REPUTATION_STANDING_2"] = "Hostile"
L["REPUTATION_STANDING_3"] = "Unfriendly"
L["REPUTATION_STANDING_4"] = "Neutral"
L["REPUTATION_STANDING_5"] = "Friendly"
L["REPUTATION_STANDING_6"] = "Honored"
L["REPUTATION_STANDING_7"] = "Revered"
L["REPUTATION_STANDING_8"] = "Exalted"

-- ====================================================================
-- 按钮文本
-- ====================================================================
L["BUTTON_SAVE"] = "Save"
L["BUTTON_CANCEL"] = "Cancel"
L["BUTTON_RESET"] = "Reset"
L["BUTTON_APPLY"] = "Apply"
L["BUTTON_OK"] = "OK"
L["BUTTON_CLOSE"] = "Close"
L["BUTTON_IMPORT"] = "Import"
L["BUTTON_EXPORT"] = "Export"
L["BUTTON_REFRESH"] = "Refresh"
L["BUTTON_DELETE"] = "Delete"
L["BUTTON_ADD"] = "Add"
L["BUTTON_EDIT"] = "Edit"

-- ====================================================================
-- 提示文本
-- ====================================================================
L["TOOLTIP_LOCK_WINDOW"] = "Lock/Unlock the window position"
L["TOOLTIP_SHOW_CONFIG"] = "Open settings panel"
L["TOOLTIP_HIDE_WINDOW"] = "Hide the tracker window"
L["TOOLTIP_RESET_POSITION"] = "Reset window to center of screen"
L["TOOLTIP_IMPORT_ATT"] = "Import map and currency data from ALL THE THINGS addon"
L["TOOLTIP_CURRENCY_CLICK"] = "Click to view currency details"
L["TOOLTIP_REPUTATION_CLICK"] = "Click to view reputation details"

-- ====================================================================
-- 菜单文本
-- ====================================================================
L["MENU_TOGGLE_WINDOW"] = "Toggle Window"
L["MENU_LOCK_WINDOW"] = "Lock Window"
L["MENU_UNLOCK_WINDOW"] = "Unlock Window"
L["MENU_RESET_POSITION"] = "Reset Position"
L["MENU_SETTINGS"] = "Settings"
L["MENU_REFRESH_DATA"] = "Refresh Data"
L["MENU_IMPORT_ATT"] = "Import from ATT"

-- ====================================================================
-- 系统消息文本
-- ====================================================================
L["MSG_SETTINGS_SAVED"] = "Settings saved successfully!"
L["MSG_SETTINGS_RESET"] = "Settings reset to default!"
L["MSG_DATA_IMPORTED"] = "Data imported successfully!"
L["MSG_DATA_EXPORTED"] = "Data exported successfully!"
L["MSG_DATA_IMPORTING"] = "Importing data from ALL THE THINGS..."
L["MSG_POSITION_RESET"] = "Window position reset!"
L["MSG_CURRENCY_ADDED"] = "Currency added: %s"
L["MSG_CURRENCY_REMOVED"] = "Currency removed: %s"
L["MSG_REPUTATION_ADDED"] = "Reputation added: %s"
L["MSG_REPUTATION_REMOVED"] = "Reputation removed: %s"
L["MSG_MAP_CHANGED"] = "Entered: %s"

-- ====================================================================
-- 错误消息文本
-- ====================================================================
L["ERROR_INVALID_CURRENCY"] = "Invalid currency ID: %s"
L["ERROR_INVALID_MAP"] = "Invalid map ID: %s"
L["ERROR_INVALID_REPUTATION"] = "Invalid reputation ID: %s"
L["ERROR_INVALID_PARAMETER"] = "Invalid parameter"
L["ERROR_DATA_LOAD_FAILED"] = "Failed to load data"
L["ERROR_DATA_SAVE_FAILED"] = "Failed to save data"
L["ERROR_API_CALL_FAILED"] = "API call failed: %s"
L["ERROR_ATT_NOT_FOUND"] = "ALL THE THINGS addon not found"
L["ERROR_NO_DATA_AVAILABLE"] = "No data available for current zone"

-- ====================================================================
-- 警告消息文本
-- ====================================================================
L["WARNING_PROTECTED_DATA"] = "Some data is protected and cannot be accessed"
L["WARNING_INCOMPLETE_DATA"] = "Data may be incomplete"
L["WARNING_ATT_OUTDATED"] = "ALL THE THINGS addon may be outdated"
L["WARNING_RESET_CONFIRM"] = "Are you sure you want to reset all settings?"
L["WARNING_DELETE_CONFIRM"] = "Are you sure you want to delete this item?"
L["WARNING_DATA_RECOVERED"] = "Data corruption detected and recovered"

-- ====================================================================
-- 信息消息文本
-- ====================================================================
L["INFO_FIRST_RUN"] = "Thank you for using Copper Fever! Type /cf or /copperfever to see commands."
L["INFO_ZONE_NO_CURRENCIES"] = "No tracked currencies for this zone"
L["INFO_CONFIGURE_ZONE"] = "Click here to configure this zone"
L["INFO_ATT_INTEGRATION"] = "ALL THE THINGS integration available"
L["INFO_UPDATE_AVAILABLE"] = "Update available: %s"

-- ====================================================================
-- 时间单位文本
-- ====================================================================
L["TIME_SECOND"] = "s"
L["TIME_MINUTE"] = "m"
L["TIME_HOUR"] = "h"
L["TIME_DAY"] = "d"

-- ====================================================================
-- 数字单位文本（英文）
-- ====================================================================
L["NUMBER_K"] = "K"
L["NUMBER_M"] = "M"

-- ====================================================================
-- 斜杠命令帮助文本
-- ====================================================================
L["CMD_HELP_HEADER"] = "Copper Fever Commands:"
L["CMD_HELP_TOGGLE"] = "/cf or /cf toggle - Toggle main window"
L["CMD_HELP_CONFIG"] = "/cf config - Open settings"
L["CMD_HELP_REFRESH"] = "/cf refresh - Refresh data"
L["CMD_HELP_RESET"] = "/cf reset - Reset window position"
L["CMD_HELP_LOCK"] = "/cf lock/unlock - Lock/unlock window"
L["CMD_HELP_ATT"] = "/cf att - Import from ALL THE THINGS"
L["CMD_HELP_DEBUG"] = "/cf debug - Toggle debug mode"
L["CMD_HELP_VERSION"] = "/cf version - Show version info"
L["CMD_HELP_HELP"] = "/cf help - Show this help"
L["CMD_INVALID_PARAM"] = "Type /cf help for a list of commands"
L["CMD_DEBUG_ENABLED"] = "Debug mode enabled"
L["CMD_DEBUG_DISABLED"] = "Debug mode disabled"
L["CMD_BUILD"] = "Build"

-- ====================================================================
-- 配置面板分组标题
-- ====================================================================
L["CONFIG_GROUP_APPEARANCE"] = "Appearance"
L["CONFIG_GROUP_BEHAVIOR"] = "Behavior"
L["CONFIG_GROUP_DATA_SOURCES"] = "Data Sources"
L["CONFIG_GROUP_FILTERS"] = "Filters"

-- ====================================================================
-- 配置选项描述
-- ====================================================================
L["CONFIG_DESC_LAYOUT"] = "Choose how items are arranged in the tracker"
L["CONFIG_DESC_ICON_SIZE"] = "Size of currency and reputation icons"
L["CONFIG_DESC_FONT_SIZE"] = "Size of text in the tracker"
L["CONFIG_DESC_AUTO_HIDE"] = "Hide tracker when no relevant currencies are found"
L["CONFIG_DESC_HIDE_IN_COMBAT"] = "Automatically hide tracker during combat"
L["CONFIG_DESC_SHOW_ZONE_MESSAGES"] = "Show a message when entering a new zone"
L["CONFIG_DESC_AUTO_UPDATE"] = "Automatically refresh currency data"
L["CONFIG_DESC_UPDATE_INTERVAL"] = "How often to refresh data (in seconds)"

-- ====================================================================
-- 工具提示详细文本
-- ====================================================================
L["TOOLTIP_CURRENCY_AMOUNT"] = "Amount: %s"
L["TOOLTIP_CURRENCY_MAX"] = "Maximum: %s"
L["TOOLTIP_CURRENCY_WEEKLY"] = "Weekly: %s / %s"
L["TOOLTIP_CURRENCY_TYPE"] = "Type: %s"
L["TOOLTIP_REPUTATION_STANDING"] = "Standing: %s"
L["TOOLTIP_REPUTATION_PROGRESS"] = "Progress: %d / %d (%.1f%%)"
L["TOOLTIP_REPUTATION_FACTION"] = "Faction: %s"

-- ====================================================================
-- 空状态文本
-- ====================================================================
L["EMPTY_CURRENCY_LIST"] = "No currencies tracked for this zone"
L["EMPTY_REPUTATION_LIST"] = "No reputations tracked for this zone"
L["EMPTY_MAP_LIST"] = "No maps configured"
L["EMPTY_SEARCH_RESULTS"] = "No results found"
L["UNKNOWN"] = "Unknown"
L["UNKNOWN_EXPANSION"] = "Unknown Expansion"

-- ====================================================================
-- 搜索和过滤文本
-- ====================================================================
L["SEARCH_PLACEHOLDER"] = "Search..."
L["FILTER_ALL"] = "All"
L["FILTER_CURRENCIES"] = "Currencies"
L["FILTER_REPUTATIONS"] = "Reputations"
L["FILTER_CURRENT_ZONE"] = "Current Zone"
L["FILTER_ALL_ZONES"] = "All Zones"

-- ====================================================================
-- 状态文本
-- ====================================================================
L["STATUS_INITIALIZED"] = "Initialized"
L["STATUS_LOADING"] = "Loading..."
L["STATUS_READY"] = "Ready"
L["STATUS_ERROR"] = "Error"
L["STATUS_UPDATING"] = "Updating..."

-- ====================================================================
-- 确认对话框文本
-- ====================================================================
L["CONFIRM_RESET_TITLE"] = "Reset Settings"
L["CONFIRM_RESET_TEXT"] = "Are you sure you want to reset all settings to default?"
L["CONFIRM_DELETE_TITLE"] = "Delete Item"
L["CONFIRM_DELETE_TEXT"] = "Are you sure you want to delete this item?"
L["CONFIRM_IMPORT_TITLE"] = "Import Data"
L["CONFIRM_IMPORT_TEXT"] = "This will overwrite your current settings. Continue?"

-- ====================================================================
-- 数据管理文本
-- ====================================================================
L["DATA_TOTAL_CURRENCIES"] = "Total Currencies: %d"
L["DATA_TOTAL_REPUTATIONS"] = "Total Reputations: %d"
L["DATA_TOTAL_MAPS"] = "Total Maps: %d"
L["DATA_CACHE_SIZE"] = "Cache Size: %d entries"
L["DATA_LAST_UPDATE"] = "Last Update: %s"

-- ====================================================================
-- 成就和进度文本
-- ====================================================================
L["PROGRESS_COMPLETE"] = "Complete"
L["PROGRESS_IN_PROGRESS"] = "In Progress"
L["PROGRESS_NOT_STARTED"] = "Not Started"
L["PROGRESS_PERCENTAGE"] = "%d%%"

-- ====================================================================
-- 右键菜单文本
-- ====================================================================
L["CONTEXT_MENU_PIN"] = "Pin to Top"
L["CONTEXT_MENU_UNPIN"] = "Unpin"
L["CONTEXT_MENU_HIDE"] = "Hide"
L["CONTEXT_MENU_REMOVE"] = "Remove from Tracker"
L["CONTEXT_MENU_COPY_ID"] = "Copy ID"

-- ====================================================================
-- 导入/导出文本
-- ====================================================================
L["IMPORT_EXPORT_TITLE"] = "Import/Export Settings"
L["IMPORT_SUCCESS"] = "Settings imported successfully"
L["IMPORT_FAILED"] = "Failed to import settings"
L["EXPORT_SUCCESS"] = "Settings exported to clipboard"
L["EXPORT_FAILED"] = "Failed to export settings"
L["IMPORT_INSTRUCTIONS"] = "Paste your settings string below:"
L["EXPORT_INSTRUCTIONS"] = "Copy the string below to share your settings:"

-- ====================================================================
-- 性能和调试文本
-- ====================================================================
L["PERF_FPS"] = "FPS: %d"
L["PERF_MEMORY"] = "Memory: %.2f MB"
L["PERF_API_CALLS"] = "API Calls: %d"
L["DEBUG_MODE_ENABLED"] = "Debug mode is enabled"
L["DEBUG_SHOW_CACHE"] = "Show Cache Stats"
L["DEBUG_CLEAR_CACHE"] = "Clear All Caches"
L["DEBUG_RELOAD_DATA"] = "Reload Static Data"

-- ====================================================================
-- 通知文本
-- ====================================================================
L["NOTIFY_NEW_CURRENCY"] = "New currency available: %s"
L["NOTIFY_REPUTATION_INCREASE"] = "Reputation increased with %s"
L["NOTIFY_MAX_CURRENCY"] = "Currency %s is at maximum"
L["NOTIFY_WEEKLY_CAP"] = "Weekly cap reached for %s"

-- ====================================================================
-- 帮助和教程文本
-- ====================================================================
L["HELP_TITLE"] = "Copper Fever Help"
L["HELP_GETTING_STARTED"] = "Getting Started"
L["HELP_BASIC_USAGE"] = "Basic Usage"
L["HELP_ADVANCED_FEATURES"] = "Advanced Features"
L["HELP_TROUBLESHOOTING"] = "Troubleshooting"
L["HELP_ABOUT"] = "About"

-- ====================================================================
-- 关于文本
-- ====================================================================
L["ABOUT_DESCRIPTION"] = "Copper Fever is a currency and reputation tracker for World of Warcraft."
L["ABOUT_AUTHOR_INFO"] = "Created by David W Zhang"
L["ABOUT_VERSION_INFO"] = "Version %s (Build %d)"
L["ABOUT_SUPPORT"] = "For support, visit:"
L["ABOUT_LICENSE"] = "License: All Rights Reserved"

-- ====================================================================
-- 注册本地化
-- ====================================================================
CF:RegisterLocale("enUS", L)