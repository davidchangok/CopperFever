-- ====================================================================
-- Copper Fever - Locales\zhCN.lua
-- 简体中文本地化
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever
local L = {}

-- ====================================================================
-- 通用文本
-- ====================================================================
L["ADDON_NAME"] = "铜币狂热"
L["ADDON_LOADED"] = "铜币狂热加载成功！"
L["ADDON_VERSION"] = "版本"
L["AUTHOR"] = "作者"

-- ====================================================================
-- 主界面文本
-- ====================================================================
L["MAIN_FRAME_TITLE"] = "铜币狂热"
L["NO_DATA"] = "无可用数据"
L["LOADING"] = "加载中..."
L["CURRENCY"] = "货币"
L["RESOURCE"] = "资源"
L["REPUTATION"] = "声望"
L["TOTAL"] = "总计"
L["CURRENT"] = "当前"
L["MAX"] = "最大值"
L["WEEKLY"] = "每周"
L["EARNED_THIS_WEEK"] = "本周已获得"

-- ====================================================================
-- 配置界面文本
-- ====================================================================
L["CONFIG_TITLE"] = "铜币狂热设置"
L["CONFIG_GENERAL"] = "常规设置"
L["CONFIG_DISPLAY"] = "显示设置"
L["CONFIG_DATA"] = "数据设置"
L["CONFIG_ADVANCED"] = "高级设置"

-- 显示设置
L["DISPLAY_LAYOUT"] = "布局"
L["DISPLAY_ICON_SIZE"] = "图标大小"
L["DISPLAY_FONT_SIZE"] = "字体大小"
L["DISPLAY_SPACING"] = "间距"
L["DISPLAY_SHOW_ICONS"] = "显示图标"
L["DISPLAY_SHOW_TOOLTIPS"] = "显示提示信息"
L["DISPLAY_AUTO_HIDE"] = "在无关区域自动隐藏"

-- 窗口设置
L["WINDOW_LOCKED"] = "锁定窗口"
L["WINDOW_SCALE"] = "窗口缩放"
L["WINDOW_ALPHA"] = "窗口不透明度"
L["WINDOW_BACKGROUND_COLOR"] = "背景颜色"
L["WINDOW_BORDER_COLOR"] = "边框颜色"
L["WINDOW_WIDTH"] = "窗口宽度"
L["WINDOW_HEIGHT"] = "窗口高度"
L["WINDOW_RESET_POSITION"] = "重置位置"

-- 数据设置
L["DATA_AUTO_UPDATE"] = "启用自动更新"
L["DATA_UPDATE_INTERVAL"] = "更新间隔（秒）"
L["DATA_SHOW_ALL_CURRENCIES"] = "显示所有货币"
L["DATA_IMPORT_FROM_ATT"] = "从 ALL THE THINGS 导入"
L["DATA_EXPORT"] = "导出数据"
L["DATA_IMPORT"] = "导入数据"
L["DATA_RESET"] = "重置为默认"

-- 地图和资源配置
L["CONFIG_MAP_LIST"] = "地图列表"
L["CONFIG_SELECT_MAP"] = "选择一个地图进行配置"
L["CONFIG_ASSOCIATED_CURRENCIES"] = "关联货币"
L["CONFIG_ASSOCIATED_RESOURCES"] = "关联资源"
L["CONFIG_ASSOCIATED_REPUTATIONS"] = "关联声望"
L["CONFIG_ADD_CURRENCY"] = "添加货币"
L["CONFIG_ADD_RESOURCE"] = "添加资源"
L["CONFIG_ADD_REPUTATION"] = "添加声望"
L["CONFIG_REMOVE"] = "移除"

-- ====================================================================
-- 阵营文本
-- ====================================================================
L["FACTION_ALLIANCE"] = "联盟"
L["FACTION_HORDE"] = "部落"
L["FACTION_NEUTRAL"] = "中立"

-- ====================================================================
-- 扩展版本文本
-- ====================================================================
L["EXPANSION_0"] = "经典旧世"
L["EXPANSION_1"] = "燃烧的远征"
L["EXPANSION_2"] = "巫妖王之怒"
L["EXPANSION_3"] = "大地的裂变"
L["EXPANSION_4"] = "熊猫人之谜"
L["EXPANSION_5"] = "德拉诺之王"
L["EXPANSION_6"] = "军团再临"
L["EXPANSION_7"] = "争霸艾泽拉斯"
L["EXPANSION_8"] = "暗影国度"
L["EXPANSION_9"] = "巨龙时代"
L["EXPANSION_10"] = "地心之战"

-- ====================================================================
-- 货币类型文本
-- ====================================================================
L["CURRENCY_TYPE_STANDARD"] = "标准"
L["CURRENCY_TYPE_SEASONAL"] = "赛季"
L["CURRENCY_TYPE_REPUTATION"] = "声望"
L["CURRENCY_TYPE_SPECIAL"] = "特殊"
L["CURRENCY_TYPE_UNKNOWN"] = "未知"

-- ====================================================================
-- 布局类型文本
-- ====================================================================
L["LAYOUT_VERTICAL"] = "纵向"
L["LAYOUT_HORIZONTAL"] = "横向"

-- ====================================================================
-- 调试级别文本
-- ====================================================================
L["DEBUG_LEVEL_NONE"] = "无"
L["DEBUG_LEVEL_ERROR"] = "错误"
L["DEBUG_LEVEL_WARNING"] = "警告"
L["DEBUG_LEVEL_INFO"] = "信息"
L["DEBUG_LEVEL_DEBUG"] = "调试"
L["DEBUG_LEVEL_TRACE"] = "追踪"

-- ====================================================================
-- 按钮文本
-- ====================================================================
L["BUTTON_SAVE"] = "保存"
L["BUTTON_CANCEL"] = "取消"
L["BUTTON_RESET"] = "重置"
L["BUTTON_APPLY"] = "应用"
L["BUTTON_OK"] = "确定"
L["BUTTON_CLOSE"] = "关闭"
L["BUTTON_IMPORT"] = "导入"
L["BUTTON_EXPORT"] = "导出"
L["BUTTON_REFRESH"] = "刷新"
L["BUTTON_DELETE"] = "删除"
L["BUTTON_ADD"] = "添加"
L["BUTTON_EDIT"] = "编辑"

-- ====================================================================
-- 提示文本
-- ====================================================================
L["TOOLTIP_LOCK_WINDOW"] = "锁定/解锁窗口位置"
L["TOOLTIP_SHOW_CONFIG"] = "打开设置面板"
L["TOOLTIP_HIDE_WINDOW"] = "隐藏追踪窗口"
L["TOOLTIP_RESET_POSITION"] = "将窗口重置到屏幕中央"
L["TOOLTIP_IMPORT_ATT"] = "从 ALL THE THINGS 插件导入地图和货币数据"
L["TOOLTIP_CURRENCY_CLICK"] = "点击查看货币详情"
L["TOOLTIP_REPUTATION_CLICK"] = "点击查看声望详情"

-- ====================================================================
-- 系统消息文本
-- ====================================================================
L["MSG_SETTINGS_SAVED"] = "设置保存成功！"
L["MSG_SETTINGS_RESET"] = "设置已重置为默认值！"
L["MSG_DATA_IMPORTED"] = "数据导入成功！"
L["MSG_DATA_EXPORTED"] = "数据导出成功！"
L["MSG_POSITION_RESET"] = "窗口位置已重置！"
L["MSG_CURRENCY_ADDED"] = "已添加货币：%s"
L["MSG_CURRENCY_REMOVED"] = "已移除货币：%s"
L["MSG_REPUTATION_ADDED"] = "已添加声望：%s"
L["MSG_REPUTATION_REMOVED"] = "已移除声望：%s"
L["MSG_MAP_CHANGED"] = "进入：%s"

-- ====================================================================
-- 错误消息文本
-- ====================================================================
L["ERROR_INVALID_CURRENCY"] = "无效的货币ID：%s"
L["ERROR_INVALID_MAP"] = "无效的地图ID：%s"
L["ERROR_INVALID_REPUTATION"] = "无效的声望ID：%s"
L["ERROR_DATA_LOAD_FAILED"] = "数据加载失败"
L["ERROR_DATA_SAVE_FAILED"] = "数据保存失败"
L["ERROR_API_CALL_FAILED"] = "API调用失败：%s"
L["ERROR_ATT_NOT_FOUND"] = "未找到 ALL THE THINGS 插件"
L["ERROR_NO_DATA_AVAILABLE"] = "当前区域无可用数据"

-- ====================================================================
-- 警告消息文本
-- ====================================================================
L["WARNING_PROTECTED_DATA"] = "某些数据受保护，无法访问"
L["WARNING_INCOMPLETE_DATA"] = "数据可能不完整"
L["WARNING_ATT_OUTDATED"] = "ALL THE THINGS 插件可能已过时"
L["WARNING_RESET_CONFIRM"] = "确定要重置所有设置吗？"
L["WARNING_DELETE_CONFIRM"] = "确定要删除此项目吗？"

-- ====================================================================
-- 信息消息文本
-- ====================================================================
L["INFO_FIRST_RUN"] = "感谢使用铜币狂热！右键点击小地图按钮打开设置。"
L["INFO_ZONE_NO_CURRENCIES"] = "此区域无追踪货币"
L["INFO_CONFIGURE_ZONE"] = "点击此处配置此区域"
L["INFO_ATT_INTEGRATION"] = "ALL THE THINGS 集成可用"
L["INFO_UPDATE_AVAILABLE"] = "有可用更新：%s"

-- ====================================================================
-- 时间单位文本
-- ====================================================================
L["TIME_SECOND"] = "秒"
L["TIME_MINUTE"] = "分"
L["TIME_HOUR"] = "时"
L["TIME_DAY"] = "天"
L["TIME_WEEK"] = "周"

-- ====================================================================
-- 数字单位文本（中文使用万/亿）
-- ====================================================================
L["NUMBER_WAN"] = "万"
L["NUMBER_YI"] = "亿"

-- ====================================================================
-- 货币和资源通用文本
-- ====================================================================
L["GOLD"] = "金"
L["SILVER"] = "银"
L["COPPER"] = "铜"
L["MONEY"] = "金钱"

-- ====================================================================
-- 声望文本
-- ====================================================================
L["REPUTATION_LEVEL"] = "声望等级"
L["REPUTATION_STANDING_0"] = "仇恨"
L["REPUTATION_STANDING_1"] = "敌对"
L["REPUTATION_STANDING_2"] = "冷淡"
L["REPUTATION_STANDING_3"] = "中立"
L["REPUTATION_STANDING_4"] = "友善"
L["REPUTATION_STANDING_5"] = "尊敬"
L["REPUTATION_STANDING_6"] = "崇敬"
L["REPUTATION_STANDING_7"] = "崇拜"
L["REPUTATION_STANDING_8"] = "巅峰"

-- ====================================================================
-- 地图类型文本
-- ====================================================================
L["MAP_TYPE_COSMIC"] = "宇宙"
L["MAP_TYPE_WORLD"] = "世界"
L["MAP_TYPE_CONTINENT"] = "大陆"
L["MAP_TYPE_ZONE"] = "区域"
L["MAP_TYPE_DUNGEON"] = "地下城"
L["MAP_TYPE_MICRO"] = "微型"
L["MAP_TYPE_ORPHAN"] = "孤立"

-- ====================================================================
-- 右键菜单文本
-- ====================================================================
L["MENU_SHOW_WINDOW"] = "显示窗口"
L["MENU_HIDE_WINDOW"] = "隐藏窗口"
L["MENU_LOCK_WINDOW"] = "锁定窗口"
L["MENU_UNLOCK_WINDOW"] = "解锁窗口"
L["MENU_SETTINGS"] = "设置"
L["MENU_RESET_POSITION"] = "重置位置"
L["MENU_REFRESH_DATA"] = "刷新数据"

-- ====================================================================
-- 搜索和过滤文本
-- ====================================================================
L["SEARCH"] = "搜索"
L["SEARCH_PLACEHOLDER"] = "搜索..."
L["FILTER"] = "筛选"
L["FILTER_ALL"] = "全部"
L["FILTER_BY_EXPANSION"] = "按版本"
L["FILTER_BY_TYPE"] = "按类型"
L["FILTER_BY_FACTION"] = "按阵营"
L["CLEAR_FILTER"] = "清除筛选"

-- ====================================================================
-- 排序文本
-- ====================================================================
L["SORT_BY"] = "排序方式"
L["SORT_NAME"] = "名称"
L["SORT_AMOUNT"] = "数量"
L["SORT_TYPE"] = "类型"
L["SORT_ASCENDING"] = "升序"
L["SORT_DESCENDING"] = "降序"

-- ====================================================================
-- 帮助和关于文本
-- ====================================================================
L["HELP"] = "帮助"
L["ABOUT"] = "关于"
L["VERSION_INFO"] = "版本信息"
L["REPORT_BUG"] = "报告错误"
L["FEATURE_REQUEST"] = "功能建议"
L["DISCORD"] = "Discord"
L["GITHUB"] = "GitHub"
L["CURSEFORGE"] = "CurseForge"

-- ====================================================================
-- 键盘绑定文本
-- ====================================================================
L["KEYBIND_TOGGLE_WINDOW"] = "切换主窗口"
L["KEYBIND_TOGGLE_CONFIG"] = "切换设置"
L["KEYBIND_REFRESH"] = "刷新数据"

-- ====================================================================
-- 导入导出文本
-- ====================================================================
L["IMPORT_EXPORT_TITLE"] = "导入/导出"
L["IMPORT_STRING"] = "导入字符串"
L["EXPORT_STRING"] = "导出字符串"
L["COPY_TO_CLIPBOARD"] = "复制到剪贴板"
L["PASTE_FROM_CLIPBOARD"] = "从剪贴板粘贴"
L["IMPORT_SUCCESS"] = "导入成功！"
L["IMPORT_FAILED"] = "导入失败！"
L["EXPORT_SUCCESS"] = "导出成功！"

-- ====================================================================
-- 状态文本
-- ====================================================================
L["STATUS_ENABLED"] = "已启用"
L["STATUS_DISABLED"] = "已禁用"
L["STATUS_ACTIVE"] = "活动"
L["STATUS_INACTIVE"] = "非活动"
L["STATUS_LOADING"] = "加载中..."
L["STATUS_READY"] = "就绪"
L["STATUS_ERROR"] = "错误"

-- ====================================================================
-- 战斗文本
-- ====================================================================
L["IN_COMBAT"] = "战斗中"
L["OUT_OF_COMBAT"] = "脱离战斗"
L["COMBAT_LOCKDOWN"] = "战斗中无法更改设置"

-- ====================================================================
-- 数据同步文本
-- ====================================================================
L["SYNC_ENABLED"] = "数据同步已启用"
L["SYNC_DISABLED"] = "数据同步已禁用"
L["SYNC_IN_PROGRESS"] = "同步中..."
L["SYNC_COMPLETE"] = "同步完成"
L["SYNC_FAILED"] = "同步失败"

-- ====================================================================
-- ALL THE THINGS 集成文本
-- ====================================================================
L["ATT_INTEGRATION"] = "ALL THE THINGS 集成"
L["ATT_NOT_INSTALLED"] = "未安装 ALL THE THINGS"
L["ATT_IMPORT_DATA"] = "从 ATT 导入数据"
L["ATT_IMPORT_MAPS"] = "导入地图数据"
L["ATT_IMPORT_CURRENCIES"] = "导入货币数据"
L["ATT_IMPORT_REPUTATIONS"] = "导入声望数据"
L["ATT_IMPORT_ALL"] = "导入所有数据"
L["ATT_IMPORT_STARTED"] = "开始从 ALL THE THINGS 导入..."
L["ATT_IMPORT_COMPLETE"] = "从 ALL THE THINGS 导入完成！"

-- ====================================================================
-- 注册简体中文本地化
-- ====================================================================
CF:RegisterLocale("zhCN", L)