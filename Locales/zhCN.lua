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
-- 核心初始化文本
-- ====================================================================
L["CORE_INIT_LINE1"] = "======================================"
L["CORE_INIT_LINE2"] = "铜币狂热 v%s"
L["CORE_INIT_LINE3"] = "追踪货币和声望"
L["CORE_INIT_LINE4"] = "作者：David W Zhang"
L["CORE_INIT_LINE5"] = "======================================"

-- ====================================================================
-- 主界面文本
-- ====================================================================
L["MAIN_FRAME_TITLE"] = "铜币狂热"
L["NO_DATA"] = "暂无数据"
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
L["DISPLAY_SHOW_TOOLTIPS"] = "显示工具提示"
L["DISPLAY_AUTO_HIDE"] = "无关区域自动隐藏"
L["DISPLAY_HIDE_IN_COMBAT"] = "战斗中隐藏"
L["DISPLAY_SHOW_ZONE_MESSAGES"] = "显示区域切换消息"

-- 窗口设置
L["WINDOW_LOCKED"] = "锁定窗口"
L["WINDOW_SCALE"] = "窗口缩放"
L["WINDOW_ALPHA"] = "窗口透明度"
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
L["ATT_DATA_SOURCE_HEADER"] = "ALL THE THINGS 数据源"
L["DATA_RESET"] = "重置为默认值"

-- 地图和资源配置
L["CONFIG_MAP_LIST"] = "地图列表"
L["CONFIG_SELECT_MAP"] = "选择要配置的地图"
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
L["LAYOUT_VERTICAL"] = "垂直"
L["LAYOUT_HORIZONTAL"] = "水平"

-- ====================================================================
-- 调试级别文本
-- ====================================================================
L["DEBUG_LEVEL_NONE"] = "无"
L["DEBUG_LEVEL_ERROR"] = "错误"
L["DEBUG_LEVEL_WARNING"] = "警告"
L["DEBUG_LEVEL_INFO"] = "信息"
L["DEBUG_LEVEL_DEBUG"] = "调试"
L["DEBUG_LEVEL_TRACE"] = "跟踪"

-- ====================================================================
-- 声望等级文本
-- ====================================================================
L["REPUTATION_STANDING_1"] = "仇恨"
L["REPUTATION_STANDING_2"] = "敌对"
L["REPUTATION_STANDING_3"] = "不友好"
L["REPUTATION_STANDING_4"] = "中立"
L["REPUTATION_STANDING_5"] = "友好"
L["REPUTATION_STANDING_6"] = "尊敬"
L["REPUTATION_STANDING_7"] = "崇敬"
L["REPUTATION_STANDING_8"] = "崇拜"

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
L["TOOLTIP_RESET_POSITION"] = "重置窗口到屏幕中央"
L["TOOLTIP_IMPORT_ATT"] = "从 ALL THE THINGS 插件导入地图和货币数据"
L["TOOLTIP_CURRENCY_CLICK"] = "点击查看货币详情"
L["TOOLTIP_REPUTATION_CLICK"] = "点击查看声望详情"

-- ====================================================================
-- 菜单文本
-- ====================================================================
L["MENU_TOGGLE_WINDOW"] = "切换窗口"
L["MENU_LOCK_WINDOW"] = "锁定窗口"
L["MENU_UNLOCK_WINDOW"] = "解锁窗口"
L["MENU_RESET_POSITION"] = "重置位置"
L["MENU_SETTINGS"] = "设置"
L["MENU_REFRESH_DATA"] = "刷新数据"
L["MENU_IMPORT_ATT"] = "从 ATT 导入"

-- ====================================================================
-- 系统消息文本
-- ====================================================================
L["MSG_SETTINGS_SAVED"] = "设置已保存！"
L["MSG_SETTINGS_RESET"] = "设置已重置为默认值！"
L["MSG_DATA_IMPORTED"] = "数据导入成功！"
L["MSG_DATA_EXPORTED"] = "数据导出成功！"
L["MSG_DATA_IMPORTING"] = "正在从 ALL THE THINGS 导入数据..."
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
L["ERROR_INVALID_PARAMETER"] = "无效的参数"
L["ERROR_DATA_LOAD_FAILED"] = "数据加载失败"
L["ERROR_DATA_SAVE_FAILED"] = "数据保存失败"
L["ERROR_API_CALL_FAILED"] = "API 调用失败：%s"
L["ERROR_ATT_NOT_FOUND"] = "未找到 ALL THE THINGS 插件"
L["ERROR_NO_DATA_AVAILABLE"] = "当前区域无可用数据"

-- ====================================================================
-- 警告消息文本
-- ====================================================================
L["WARNING_PROTECTED_DATA"] = "部分数据受保护，无法访问"
L["WARNING_INCOMPLETE_DATA"] = "数据可能不完整"
L["WARNING_ATT_OUTDATED"] = "ALL THE THINGS 插件可能已过期"
L["WARNING_RESET_CONFIRM"] = "确定要重置所有设置吗？"
L["WARNING_DELETE_CONFIRM"] = "确定要删除此项目吗？"
L["WARNING_DATA_RECOVERED"] = "检测到数据损坏并已恢复"

-- ====================================================================
-- 信息消息文本
-- ====================================================================
L["INFO_FIRST_RUN"] = "感谢使用铜币狂热！输入 /cf 或 /copperfever 查看命令。"
L["INFO_ZONE_NO_CURRENCIES"] = "此区域没有追踪的货币"
L["INFO_CONFIGURE_ZONE"] = "点击这里配置此区域"
L["INFO_ATT_INTEGRATION"] = "可使用 ALL THE THINGS 集成"
L["INFO_UPDATE_AVAILABLE"] = "有可用更新：%s"

-- ====================================================================
-- 时间单位文本
-- ====================================================================
L["TIME_SECOND"] = "秒"
L["TIME_MINUTE"] = "分"
L["TIME_HOUR"] = "时"
L["TIME_DAY"] = "天"

-- ====================================================================
-- 数字单位文本（中文）
-- ====================================================================
L["NUMBER_WAN"] = "万"
L["NUMBER_YI"] = "亿"

-- ====================================================================
-- 斜杠命令帮助文本
-- ====================================================================
L["CMD_HELP_HEADER"] = "铜币狂热命令："
L["CMD_HELP_TOGGLE"] = "/cf 或 /cf toggle - 切换主窗口"
L["CMD_HELP_CONFIG"] = "/cf config - 打开设置"
L["CMD_HELP_REFRESH"] = "/cf refresh - 刷新数据"
L["CMD_HELP_RESET"] = "/cf reset - 重置窗口位置"
L["CMD_HELP_LOCK"] = "/cf lock/unlock - 锁定/解锁窗口"
L["CMD_HELP_ATT"] = "/cf att - 从 ALL THE THINGS 导入"
L["CMD_HELP_DEBUG"] = "/cf debug - 切换调试模式"
L["CMD_HELP_VERSION"] = "/cf version - 显示版本信息"
L["CMD_HELP_HELP"] = "/cf help - 显示此帮助"
L["CMD_INVALID_PARAM"] = "输入 /cf help 查看命令列表"
L["CMD_DEBUG_ENABLED"] = "调试模式已启用"
L["CMD_DEBUG_DISABLED"] = "调试模式已禁用"
L["CMD_BUILD"] = "构建"

-- ====================================================================
-- 配置面板分组标题
-- ====================================================================
L["CONFIG_GROUP_APPEARANCE"] = "外观"
L["CONFIG_GROUP_BEHAVIOR"] = "行为"
L["CONFIG_GROUP_DATA_SOURCES"] = "数据源"
L["CONFIG_GROUP_FILTERS"] = "过滤器"

-- ====================================================================
-- 配置选项描述
-- ====================================================================
L["CONFIG_DESC_LAYOUT"] = "选择项目在追踪器中的排列方式"
L["CONFIG_DESC_ICON_SIZE"] = "货币和声望图标的大小"
L["CONFIG_DESC_FONT_SIZE"] = "追踪器中文本的大小"
L["CONFIG_DESC_AUTO_HIDE"] = "当没有找到相关货币时隐藏追踪器"
L["CONFIG_DESC_HIDE_IN_COMBAT"] = "战斗中自动隐藏追踪器"
L["CONFIG_DESC_SHOW_ZONE_MESSAGES"] = "进入新区域时显示消息"
L["CONFIG_DESC_AUTO_UPDATE"] = "自动刷新货币数据"
L["CONFIG_DESC_UPDATE_INTERVAL"] = "刷新数据的频率（秒）"

-- ====================================================================
-- 工具提示详细文本
-- ====================================================================
L["TOOLTIP_CURRENCY_AMOUNT"] = "数量：%s"
L["TOOLTIP_CURRENCY_MAX"] = "最大值：%s"
L["TOOLTIP_CURRENCY_WEEKLY"] = "每周：%s / %s"
L["TOOLTIP_CURRENCY_TYPE"] = "类型：%s"
L["TOOLTIP_REPUTATION_STANDING"] = "声望等级：%s"
L["TOOLTIP_REPUTATION_PROGRESS"] = "进度：%d / %d（%.1f%%）"
L["TOOLTIP_REPUTATION_FACTION"] = "阵营：%s"

-- ====================================================================
-- 空状态文本
-- ====================================================================
L["EMPTY_CURRENCY_LIST"] = "此区域没有追踪的货币"
L["EMPTY_REPUTATION_LIST"] = "此区域没有追踪的声望"
L["EMPTY_MAP_LIST"] = "没有配置的地图"
L["EMPTY_SEARCH_RESULTS"] = "未找到结果"
L["UNKNOWN"] = "未知"
L["UNKNOWN_EXPANSION"] = "未知资料片"

-- ====================================================================
-- 搜索和过滤文本
-- ====================================================================
L["SEARCH_PLACEHOLDER"] = "搜索..."
L["FILTER_ALL"] = "全部"
L["FILTER_CURRENCIES"] = "货币"
L["FILTER_REPUTATIONS"] = "声望"
L["FILTER_CURRENT_ZONE"] = "当前区域"
L["FILTER_ALL_ZONES"] = "所有区域"

-- ====================================================================
-- 状态文本
-- ====================================================================
L["STATUS_INITIALIZED"] = "已初始化"
L["STATUS_LOADING"] = "加载中..."
L["STATUS_READY"] = "就绪"
L["STATUS_ERROR"] = "错误"
L["STATUS_UPDATING"] = "更新中..."

-- ====================================================================
-- 确认对话框文本
-- ====================================================================
L["CONFIRM_RESET_TITLE"] = "重置设置"
L["CONFIRM_RESET_TEXT"] = "确定要将所有设置重置为默认值吗？"
L["CONFIRM_DELETE_TITLE"] = "删除项目"
L["CONFIRM_DELETE_TEXT"] = "确定要删除此项目吗？"
L["CONFIRM_IMPORT_TITLE"] = "导入数据"
L["CONFIRM_IMPORT_TEXT"] = "这将覆盖您当前的设置。是否继续？"

-- ====================================================================
-- 数据管理文本
-- ====================================================================
L["DATA_TOTAL_CURRENCIES"] = "总货币数：%d"
L["DATA_TOTAL_REPUTATIONS"] = "总声望数：%d"
L["DATA_TOTAL_MAPS"] = "总地图数：%d"
L["DATA_CACHE_SIZE"] = "缓存大小：%d 条"
L["DATA_LAST_UPDATE"] = "最后更新：%s"

-- ====================================================================
-- 成就和进度文本
-- ====================================================================
L["PROGRESS_COMPLETE"] = "已完成"
L["PROGRESS_IN_PROGRESS"] = "进行中"
L["PROGRESS_NOT_STARTED"] = "未开始"
L["PROGRESS_PERCENTAGE"] = "%d%%"

-- ====================================================================
-- 右键菜单文本
-- ====================================================================
L["CONTEXT_MENU_PIN"] = "置顶"
L["CONTEXT_MENU_UNPIN"] = "取消置顶"
L["CONTEXT_MENU_HIDE"] = "隐藏"
L["CONTEXT_MENU_REMOVE"] = "从追踪器中移除"
L["CONTEXT_MENU_COPY_ID"] = "复制ID"

-- ====================================================================
-- 导入/导出文本
-- ====================================================================
L["IMPORT_EXPORT_TITLE"] = "导入/导出设置"
L["IMPORT_SUCCESS"] = "设置导入成功"
L["IMPORT_FAILED"] = "设置导入失败"
L["EXPORT_SUCCESS"] = "设置已导出到剪贴板"
L["EXPORT_FAILED"] = "设置导出失败"
L["IMPORT_INSTRUCTIONS"] = "在下方粘贴您的设置字符串："
L["EXPORT_INSTRUCTIONS"] = "复制下方字符串以分享您的设置："

-- ====================================================================
-- 性能和调试文本
-- ====================================================================
L["PERF_FPS"] = "帧数：%d"
L["PERF_MEMORY"] = "内存：%.2f MB"
L["PERF_API_CALLS"] = "API 调用：%d"
L["DEBUG_MODE_ENABLED"] = "调试模式已启用"
L["DEBUG_SHOW_CACHE"] = "显示缓存统计"
L["DEBUG_CLEAR_CACHE"] = "清除所有缓存"
L["DEBUG_RELOAD_DATA"] = "重新加载静态数据"

-- ====================================================================
-- 通知文本
-- ====================================================================
L["NOTIFY_NEW_CURRENCY"] = "新货币可用：%s"
L["NOTIFY_REPUTATION_INCREASE"] = "%s 的声望提高了"
L["NOTIFY_MAX_CURRENCY"] = "货币 %s 已达到最大值"
L["NOTIFY_WEEKLY_CAP"] = "%s 已达到每周上限"

-- ====================================================================
-- 帮助和教程文本
-- ====================================================================
L["HELP_TITLE"] = "铜币狂热帮助"
L["HELP_GETTING_STARTED"] = "入门指南"
L["HELP_BASIC_USAGE"] = "基本使用"
L["HELP_ADVANCED_FEATURES"] = "高级功能"
L["HELP_TROUBLESHOOTING"] = "故障排除"
L["HELP_ABOUT"] = "关于"

-- ====================================================================
-- 关于文本
-- ====================================================================
L["ABOUT_DESCRIPTION"] = "铜币狂热是一个魔兽世界的货币和声望追踪插件。"
L["ABOUT_AUTHOR_INFO"] = "作者：David W Zhang"
L["ABOUT_VERSION_INFO"] = "版本 %s（构建 %d）"
L["ABOUT_SUPPORT"] = "获取支持，请访问："
L["ABOUT_LICENSE"] = "许可证：保留所有权利"

-- ====================================================================
-- 注册本地化
-- ====================================================================
CF:RegisterLocale("zhCN", L)