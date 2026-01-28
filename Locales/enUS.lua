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
-- 系统消息文本
-- ====================================================================
L["MSG_SETTINGS_SAVED"] = "Settings saved successfully!"
L["MSG_SETTINGS_RESET"] = "Settings reset to default!"
L["MSG_DATA_IMPORTED"] = "Data imported successfully!"
L["MSG_DATA_EXPORTED"] = "Data exported successfully!"
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

-- ====================================================================
-- 信息消息文本
-- ====================================================================
L["INFO_FIRST_RUN"] = "Thank you for using Copper Fever! Right-click the minimap button to open settings."
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
L["TIME_WEEK"] = "w"

-- ====================================================================
-- 数字单位文本（英文使用K/M）
-- ====================================================================
L["NUMBER_THOUSAND"] = "K"
L["NUMBER_MILLION"] = "M"
L["NUMBER_BILLION"] = "B"

-- ====================================================================
-- 货币和资源通用文本
-- ====================================================================
L["GOLD"] = "Gold"
L["SILVER"] = "Silver"
L["COPPER"] = "Copper"
L["MONEY"] = "Money"

-- ====================================================================
-- 声望文本
-- ====================================================================
L["REPUTATION_LEVEL"] = "Reputation Level"
L["REPUTATION_STANDING_0"] = "Hated"
L["REPUTATION_STANDING_1"] = "Hostile"
L["REPUTATION_STANDING_2"] = "Unfriendly"
L["REPUTATION_STANDING_3"] = "Neutral"
L["REPUTATION_STANDING_4"] = "Friendly"
L["REPUTATION_STANDING_5"] = "Honored"
L["REPUTATION_STANDING_6"] = "Revered"
L["REPUTATION_STANDING_7"] = "Exalted"
L["REPUTATION_STANDING_8"] = "Paragon"

-- ====================================================================
-- 地图类型文本
-- ====================================================================
L["MAP_TYPE_COSMIC"] = "Cosmic"
L["MAP_TYPE_WORLD"] = "World"
L["MAP_TYPE_CONTINENT"] = "Continent"
L["MAP_TYPE_ZONE"] = "Zone"
L["MAP_TYPE_DUNGEON"] = "Dungeon"
L["MAP_TYPE_MICRO"] = "Micro"
L["MAP_TYPE_ORPHAN"] = "Orphan"

-- ====================================================================
-- 右键菜单文本
-- ====================================================================
L["MENU_SHOW_WINDOW"] = "Show Window"
L["MENU_HIDE_WINDOW"] = "Hide Window"
L["MENU_LOCK_WINDOW"] = "Lock Window"
L["MENU_UNLOCK_WINDOW"] = "Unlock Window"
L["MENU_SETTINGS"] = "Settings"
L["MENU_RESET_POSITION"] = "Reset Position"
L["MENU_REFRESH_DATA"] = "Refresh Data"

-- ====================================================================
-- 搜索和过滤文本
-- ====================================================================
L["SEARCH"] = "Search"
L["SEARCH_PLACEHOLDER"] = "Search..."
L["FILTER"] = "Filter"
L["FILTER_ALL"] = "All"
L["FILTER_BY_EXPANSION"] = "By Expansion"
L["FILTER_BY_TYPE"] = "By Type"
L["FILTER_BY_FACTION"] = "By Faction"
L["CLEAR_FILTER"] = "Clear Filter"

-- ====================================================================
-- 排序文本
-- ====================================================================
L["SORT_BY"] = "Sort By"
L["SORT_NAME"] = "Name"
L["SORT_AMOUNT"] = "Amount"
L["SORT_TYPE"] = "Type"
L["SORT_ASCENDING"] = "Ascending"
L["SORT_DESCENDING"] = "Descending"

-- ====================================================================
-- 帮助和关于文本
-- ====================================================================
L["HELP"] = "Help"
L["ABOUT"] = "About"
L["VERSION_INFO"] = "Version Information"
L["REPORT_BUG"] = "Report a Bug"
L["FEATURE_REQUEST"] = "Feature Request"
L["DISCORD"] = "Discord"
L["GITHUB"] = "GitHub"
L["CURSEFORGE"] = "CurseForge"

-- ====================================================================
-- 键盘绑定文本
-- ====================================================================
L["KEYBIND_TOGGLE_WINDOW"] = "Toggle Main Window"
L["KEYBIND_TOGGLE_CONFIG"] = "Toggle Settings"
L["KEYBIND_REFRESH"] = "Refresh Data"

-- ====================================================================
-- 导入导出文本
-- ====================================================================
L["IMPORT_EXPORT_TITLE"] = "Import/Export"
L["IMPORT_STRING"] = "Import String"
L["EXPORT_STRING"] = "Export String"
L["COPY_TO_CLIPBOARD"] = "Copy to Clipboard"
L["PASTE_FROM_CLIPBOARD"] = "Paste from Clipboard"
L["IMPORT_SUCCESS"] = "Import successful!"
L["IMPORT_FAILED"] = "Import failed!"
L["EXPORT_SUCCESS"] = "Export successful!"

-- ====================================================================
-- 状态文本
-- ====================================================================
L["STATUS_ENABLED"] = "Enabled"
L["STATUS_DISABLED"] = "Disabled"
L["STATUS_ACTIVE"] = "Active"
L["STATUS_INACTIVE"] = "Inactive"
L["STATUS_LOADING"] = "Loading..."
L["STATUS_READY"] = "Ready"
L["STATUS_ERROR"] = "Error"

-- ====================================================================
-- 战斗文本
-- ====================================================================
L["IN_COMBAT"] = "In Combat"
L["OUT_OF_COMBAT"] = "Out of Combat"
L["COMBAT_LOCKDOWN"] = "Cannot change settings during combat"

-- ====================================================================
-- 数据同步文本
-- ====================================================================
L["SYNC_ENABLED"] = "Data Sync Enabled"
L["SYNC_DISABLED"] = "Data Sync Disabled"
L["SYNC_IN_PROGRESS"] = "Syncing..."
L["SYNC_COMPLETE"] = "Sync Complete"
L["SYNC_FAILED"] = "Sync Failed"

-- ====================================================================
-- ALL THE THINGS 集成文本
-- ====================================================================
L["ATT_INTEGRATION"] = "ALL THE THINGS Integration"
L["ATT_NOT_INSTALLED"] = "ALL THE THINGS is not installed"
L["ATT_IMPORT_DATA"] = "Import Data from ATT"
L["ATT_IMPORT_MAPS"] = "Import Map Data"
L["ATT_IMPORT_CURRENCIES"] = "Import Currency Data"
L["ATT_IMPORT_REPUTATIONS"] = "Import Reputation Data"
L["ATT_IMPORT_ALL"] = "Import All Data"
L["ATT_IMPORT_STARTED"] = "Starting import from ALL THE THINGS..."
L["ATT_IMPORT_COMPLETE"] = "Import from ALL THE THINGS complete!"

-- ====================================================================
-- 核心和命令文本
-- ====================================================================
L["CORE_INIT_LINE1"] = "==========================================="
L["CORE_INIT_LINE2"] = "  Copper Fever v%s"
L["CORE_INIT_LINE3"] = "  Author: David W Zhang"
L["CORE_INIT_LINE4"] = "  Type /cf help for commands"
L["CORE_INIT_LINE5"] = "==========================================="
L["CMD_DEBUG_ENABLED"] = "Debug mode enabled"
L["CMD_DEBUG_DISABLED"] = "Debug mode disabled"
L["CMD_HELP_HEADER"] = "=== Copper Fever Commands ==="
L["CMD_HELP_TOGGLE"] = "/cf - Toggle main window"
L["CMD_HELP_CONFIG"] = "/cf config - Open settings"
L["CMD_HELP_REFRESH"] = "/cf refresh - Refresh data"
L["CMD_HELP_RESET"] = "/cf reset - Reset window position"
L["CMD_HELP_LOCK"] = "/cf lock/unlock - Lock/unlock window"
L["CMD_HELP_ATT"] = "/cf att - Import from ALL THE THINGS"
L["CMD_HELP_DEBUG"] = "/cf debug - Toggle debug mode"
L["CMD_HELP_VERSION"] = "/cf version - Show version info"
L["CMD_HELP_HELP"] = "/cf help - Show this help"
L["CMD_INVALID_PARAM"] = "Invalid command. Type '/cf help' for available commands."
L["CMD_BUILD"] = "Build"

-- ====================================================================
-- 注册英文本地化
-- ====================================================================
CF:RegisterLocale("enUS", L)
CF:RegisterLocale("enGB", L)  -- 英国英语使用相同文本