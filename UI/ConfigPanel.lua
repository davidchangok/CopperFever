-- ====================================================================
-- Copper Fever - UI\ConfigPanel.lua
-- 配置面板界面
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever

-- ====================================================================
-- 配置面板初始化
-- ====================================================================
CF.ConfigPanel = CF.ConfigPanel or {}
local CP = CF.ConfigPanel

-- 初始化标志
CP.initialized = false
CP.frame = nil
CP.elements = {}
CP.tempSettings = {}

-- ====================================================================
-- 创建配置面板
-- ====================================================================
function CP:CreatePanel()
    if self.frame then
        CF:LogWarning("配置面板已经创建")
        return self.frame
    end
    
    -- 创建主框架
    local frame = CreateFrame("Frame", "CopperFeverConfigPanel", UIParent, "BackdropTemplate")
    frame:SetSize(600, 500)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetFrameStrata(CF.FRAME_STRATA.CONFIG)
    frame:SetFrameLevel(10)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:Hide()
    
    -- 设置背景
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    frame:SetBackdropColor(0, 0, 0, 0.9)
    frame:SetBackdropBorderColor(1, 0.82, 0, 1)
    
    -- 拖动事件
    frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)
    
    self.frame = frame
    
    -- 创建子元素
    self:CreateTitle()
    self:CreateCloseButton()
    self:CreateTabs()
    self:CreateButtons()
    
    CF:LogInfo("配置面板创建完成")
    return frame
end

-- ====================================================================
-- 创建标题
-- ====================================================================
function CP:CreateTitle()
    if not self.frame then return end
    
    local title = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", self.frame, "TOP", 0, -15)
    title:SetText(CF:L("CONFIG_TITLE"))
    title:SetTextColor(1, 0.82, 0)
    
    self.elements.title = title
end

-- ====================================================================
-- 创建关闭按钮
-- ====================================================================
function CP:CreateCloseButton()
    if not self.frame then return end
    
    local closeButton = CreateFrame("Button", nil, self.frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -5, -5)
    closeButton:SetSize(32, 32)
    
    closeButton:SetScript("OnClick", function()
        CP:Close()
    end)
    
    self.elements.closeButton = closeButton
end

-- ====================================================================
-- 创建标签页
-- ====================================================================
function CP:CreateTabs()
    if not self.frame then return end
    
    local tabs = {}
    local tabNames = {
        {name = "general", label = CF:L("CONFIG_GENERAL")},
        {name = "display", label = CF:L("CONFIG_DISPLAY")},
        {name = "data", label = CF:L("CONFIG_DATA")},
        {name = "advanced", label = CF:L("CONFIG_ADVANCED")},
    }
    
    for i, tabInfo in ipairs(tabNames) do
        local tab = CreateFrame("Button", nil, self.frame)
        tab:SetSize(130, 30)
        tab:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 20 + (i-1) * 135, -45)
        
        -- 标签背景
        tab:SetNormalTexture("Interface\\ChatFrame\\ChatFrameTab-BGLeft")
        tab:SetHighlightTexture("Interface\\ChatFrame\\ChatFrameTab-BGLeft")
        
        -- 标签文本
        tab.text = tab:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        tab.text:SetPoint("CENTER", tab, "CENTER", 0, 0)
        tab.text:SetText(tabInfo.label)
        
        -- 点击事件
        tab:SetScript("OnClick", function()
            CP:ShowTab(tabInfo.name)
        end)
        
        tab.name = tabInfo.name
        tabs[tabInfo.name] = tab
    end
    
    self.elements.tabs = tabs
    
    -- 创建标签页内容容器
    self:CreateTabContents()
    
    -- 默认显示第一个标签页
    self:ShowTab("general")
end

-- ====================================================================
-- 创建标签页内容
-- ====================================================================
function CP:CreateTabContents()
    if not self.frame then return end
    
    local contents = {}
    
    -- 通用设置标签页
    contents.general = self:CreateGeneralTab()
    
    -- 显示设置标签页
    contents.display = self:CreateDisplayTab()
    
    -- 数据设置标签页
    contents.data = self:CreateDataTab()
    
    -- 高级设置标签页
    contents.advanced = self:CreateAdvancedTab()
    
    self.elements.contents = contents
end

-- ====================================================================
-- 创建通用设置标签页
-- ====================================================================
function CP:CreateGeneralTab()
    local content = CreateFrame("Frame", nil, self.frame)
    content:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 20, -80)
    content:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -20, 50)
    content:Hide()
    
    local yOffset = 0
    
    -- 窗口设置组
    local groupHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    groupHeader:SetPoint("TOPLEFT", content, "TOPLEFT", 5, -yOffset)
    groupHeader:SetText(CF:L("CONFIG_GROUP_APPEARANCE"))
    groupHeader:SetTextColor(1, 0.82, 0)
    yOffset = yOffset + 25
    
    -- 窗口缩放
    local scaleLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    scaleLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    scaleLabel:SetText(CF:L("WINDOW_SCALE"))
    
    local scaleSlider = CreateFrame("Slider", nil, content, "OptionsSliderTemplate")
    scaleSlider:SetPoint("TOPLEFT", scaleLabel, "BOTTOMLEFT", 0, -10)
    scaleSlider:SetSize(200, 20)
    scaleSlider:SetMinMaxValues(0.5, 1.5)
    scaleSlider:SetValueStep(0.05)
    scaleSlider:SetObeyStepOnDrag(true)
    scaleSlider.Low:SetText("0.5")
    scaleSlider.High:SetText("1.5")
    scaleSlider.Text:SetText(CF:L("WINDOW_SCALE"))
    
    scaleSlider:SetScript("OnValueChanged", function(self, value)
        self.Text:SetText(string.format("%s: %.2f", CF:L("WINDOW_SCALE"), value))
        CP.tempSettings.scale = value
    end)
    
    content.scaleSlider = scaleSlider
    yOffset = yOffset + 60
    
    -- 窗口透明度
    local alphaLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    alphaLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    alphaLabel:SetText(CF:L("WINDOW_ALPHA"))
    
    local alphaSlider = CreateFrame("Slider", nil, content, "OptionsSliderTemplate")
    alphaSlider:SetPoint("TOPLEFT", alphaLabel, "BOTTOMLEFT", 0, -10)
    alphaSlider:SetSize(200, 20)
    alphaSlider:SetMinMaxValues(0.3, 1.0)
    alphaSlider:SetValueStep(0.05)
    alphaSlider:SetObeyStepOnDrag(true)
    alphaSlider.Low:SetText("0.3")
    alphaSlider.High:SetText("1.0")
    alphaSlider.Text:SetText(CF:L("WINDOW_ALPHA"))
    
    alphaSlider:SetScript("OnValueChanged", function(self, value)
        self.Text:SetText(string.format("%s: %.2f", CF:L("WINDOW_ALPHA"), value))
        CP.tempSettings.alpha = value
    end)
    
    content.alphaSlider = alphaSlider
    yOffset = yOffset + 60
    
    -- 锁定窗口复选框
    local lockCheckbox = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
    lockCheckbox:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    lockCheckbox.text = lockCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    lockCheckbox.text:SetPoint("LEFT", lockCheckbox, "RIGHT", 5, 0)
    lockCheckbox.text:SetText(CF:L("WINDOW_LOCKED"))
    
    lockCheckbox:SetScript("OnClick", function(self)
        CP.tempSettings.locked = self:GetChecked()
    end)
    
    content.lockCheckbox = lockCheckbox
    yOffset = yOffset + 30
    
    -- 重置位置按钮
    local resetButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    resetButton:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    resetButton:SetSize(150, 25)
    resetButton:SetText(CF:L("WINDOW_RESET_POSITION"))
    
    resetButton:SetScript("OnClick", function()
        if CF.MainFrame and CF.MainFrame.ResetPosition then
            CF.MainFrame:ResetPosition()
        end
    end)
    
    content.resetButton = resetButton
    yOffset = yOffset + 35
    
    return content
end

-- ====================================================================
-- 创建显示设置标签页
-- ====================================================================
function CP:CreateDisplayTab()
    local content = CreateFrame("Frame", nil, self.frame)
    content:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 20, -80)
    content:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -20, 50)
    content:Hide()
    
    local yOffset = 0
    
    -- 布局组
    local groupHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    groupHeader:SetPoint("TOPLEFT", content, "TOPLEFT", 5, -yOffset)
    groupHeader:SetText(CF:L("CONFIG_GROUP_APPEARANCE"))
    groupHeader:SetTextColor(1, 0.82, 0)
    yOffset = yOffset + 25
    
    -- 布局选择
    local layoutLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    layoutLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    layoutLabel:SetText(CF:L("DISPLAY_LAYOUT"))
    
    local layoutDropdown = CreateFrame("Frame", "CopperFeverLayoutDropdown", content, "UIDropDownMenuTemplate")
    layoutDropdown:SetPoint("TOPLEFT", layoutLabel, "BOTTOMLEFT", -15, -5)
    
    UIDropDownMenu_SetWidth(layoutDropdown, 150)
    UIDropDownMenu_Initialize(layoutDropdown, function(self, level)
        local info = UIDropDownMenu_CreateInfo()
        
        info.text = CF:L("LAYOUT_VERTICAL")
        info.value = "vertical"
        info.func = function()
            CP.tempSettings.layout = "vertical"
            UIDropDownMenu_SetText(layoutDropdown, CF:L("LAYOUT_VERTICAL"))
        end
        UIDropDownMenu_AddButton(info)
        
        info.text = CF:L("LAYOUT_HORIZONTAL")
        info.value = "horizontal"
        info.func = function()
            CP.tempSettings.layout = "horizontal"
            UIDropDownMenu_SetText(layoutDropdown, CF:L("LAYOUT_HORIZONTAL"))
        end
        UIDropDownMenu_AddButton(info)
    end)
    
    content.layoutDropdown = layoutDropdown
    yOffset = yOffset + 60
    
    -- 图标大小
    local iconSizeLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    iconSizeLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    iconSizeLabel:SetText(CF:L("DISPLAY_ICON_SIZE"))
    
    local iconSizeSlider = CreateFrame("Slider", nil, content, "OptionsSliderTemplate")
    iconSizeSlider:SetPoint("TOPLEFT", iconSizeLabel, "BOTTOMLEFT", 0, -10)
    iconSizeSlider:SetSize(200, 20)
    iconSizeSlider:SetMinMaxValues(16, 48)
    iconSizeSlider:SetValueStep(2)
    iconSizeSlider:SetObeyStepOnDrag(true)
    iconSizeSlider.Low:SetText("16")
    iconSizeSlider.High:SetText("48")
    iconSizeSlider.Text:SetText(CF:L("DISPLAY_ICON_SIZE"))
    
    iconSizeSlider:SetScript("OnValueChanged", function(self, value)
        self.Text:SetText(string.format("%s: %d", CF:L("DISPLAY_ICON_SIZE"), value))
        CP.tempSettings.iconSize = value
    end)
    
    content.iconSizeSlider = iconSizeSlider
    yOffset = yOffset + 60
    
    -- 字体大小
    local fontSizeLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fontSizeLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    fontSizeLabel:SetText(CF:L("DISPLAY_FONT_SIZE"))
    
    local fontSizeSlider = CreateFrame("Slider", nil, content, "OptionsSliderTemplate")
    fontSizeSlider:SetPoint("TOPLEFT", fontSizeLabel, "BOTTOMLEFT", 0, -10)
    fontSizeSlider:SetSize(200, 20)
    fontSizeSlider:SetMinMaxValues(8, 20)
    fontSizeSlider:SetValueStep(1)
    fontSizeSlider:SetObeyStepOnDrag(true)
    fontSizeSlider.Low:SetText("8")
    fontSizeSlider.High:SetText("20")
    fontSizeSlider.Text:SetText(CF:L("DISPLAY_FONT_SIZE"))
    
    fontSizeSlider:SetScript("OnValueChanged", function(self, value)
        self.Text:SetText(string.format("%s: %d", CF:L("DISPLAY_FONT_SIZE"), value))
        CP.tempSettings.fontSize = value
    end)
    
    content.fontSizeSlider = fontSizeSlider
    yOffset = yOffset + 60
    
    -- 显示图标复选框
    local showIconsCheckbox = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
    showIconsCheckbox:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    showIconsCheckbox.text = showIconsCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    showIconsCheckbox.text:SetPoint("LEFT", showIconsCheckbox, "RIGHT", 5, 0)
    showIconsCheckbox.text:SetText(CF:L("DISPLAY_SHOW_ICONS"))
    
    showIconsCheckbox:SetScript("OnClick", function(self)
        CP.tempSettings.showIcons = self:GetChecked()
    end)
    
    content.showIconsCheckbox = showIconsCheckbox
    yOffset = yOffset + 30
    
    -- 显示工具提示复选框
    local showTooltipsCheckbox = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
    showTooltipsCheckbox:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    showTooltipsCheckbox.text = showTooltipsCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    showTooltipsCheckbox.text:SetPoint("LEFT", showTooltipsCheckbox, "RIGHT", 5, 0)
    showTooltipsCheckbox.text:SetText(CF:L("DISPLAY_SHOW_TOOLTIPS"))
    
    showTooltipsCheckbox:SetScript("OnClick", function(self)
        CP.tempSettings.showTooltips = self:GetChecked()
    end)
    
    content.showTooltipsCheckbox = showTooltipsCheckbox
    yOffset = yOffset + 30
    
    -- 战斗中隐藏复选框
    local hideInCombatCheckbox = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
    hideInCombatCheckbox:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    hideInCombatCheckbox.text = hideInCombatCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    hideInCombatCheckbox.text:SetPoint("LEFT", hideInCombatCheckbox, "RIGHT", 5, 0)
    hideInCombatCheckbox.text:SetText(CF:L("DISPLAY_HIDE_IN_COMBAT"))
    
    hideInCombatCheckbox:SetScript("OnClick", function(self)
        CP.tempSettings.hideInCombat = self:GetChecked()
    end)
    
    content.hideInCombatCheckbox = hideInCombatCheckbox
    yOffset = yOffset + 30
    
    -- 显示区域消息复选框
    local showZoneMessagesCheckbox = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
    showZoneMessagesCheckbox:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    showZoneMessagesCheckbox.text = showZoneMessagesCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    showZoneMessagesCheckbox.text:SetPoint("LEFT", showZoneMessagesCheckbox, "RIGHT", 5, 0)
    showZoneMessagesCheckbox.text:SetText(CF:L("DISPLAY_SHOW_ZONE_MESSAGES"))
    
    showZoneMessagesCheckbox:SetScript("OnClick", function(self)
        CP.tempSettings.showZoneMessages = self:GetChecked()
    end)
    
    content.showZoneMessagesCheckbox = showZoneMessagesCheckbox
    yOffset = yOffset + 30
    
    return content
end

-- ====================================================================
-- 创建数据设置标签页
-- ====================================================================
function CP:CreateDataTab()
    local content = CreateFrame("Frame", nil, self.frame)
    content:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 20, -80)
    content:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -20, 50)
    content:Hide()
    
    local yOffset = 0
    
    -- 数据源组
    local groupHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    groupHeader:SetPoint("TOPLEFT", content, "TOPLEFT", 5, -yOffset)
    groupHeader:SetText(CF:L("CONFIG_GROUP_DATA_SOURCES"))
    groupHeader:SetTextColor(1, 0.82, 0)
    yOffset = yOffset + 25
    
    -- 启用自动更新复选框
    local autoUpdateCheckbox = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
    autoUpdateCheckbox:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    autoUpdateCheckbox.text = autoUpdateCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    autoUpdateCheckbox.text:SetPoint("LEFT", autoUpdateCheckbox, "RIGHT", 5, 0)
    autoUpdateCheckbox.text:SetText(CF:L("DATA_AUTO_UPDATE"))
    
    autoUpdateCheckbox:SetScript("OnClick", function(self)
        CP.tempSettings.enableAutoUpdate = self:GetChecked()
    end)
    
    content.autoUpdateCheckbox = autoUpdateCheckbox
    yOffset = yOffset + 30
    
    -- 更新间隔
    local updateIntervalLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    updateIntervalLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    updateIntervalLabel:SetText(CF:L("DATA_UPDATE_INTERVAL"))
    
    local updateIntervalSlider = CreateFrame("Slider", nil, content, "OptionsSliderTemplate")
    updateIntervalSlider:SetPoint("TOPLEFT", updateIntervalLabel, "BOTTOMLEFT", 0, -10)
    updateIntervalSlider:SetSize(200, 20)
    updateIntervalSlider:SetMinMaxValues(1, 30)
    updateIntervalSlider:SetValueStep(1)
    updateIntervalSlider:SetObeyStepOnDrag(true)
    updateIntervalSlider.Low:SetText("1")
    updateIntervalSlider.High:SetText("30")
    updateIntervalSlider.Text:SetText(CF:L("DATA_UPDATE_INTERVAL"))
    
    updateIntervalSlider:SetScript("OnValueChanged", function(self, value)
        self.Text:SetText(string.format("%s: %d", CF:L("DATA_UPDATE_INTERVAL"), value))
        CP.tempSettings.updateInterval = value
    end)
    
    content.updateIntervalSlider = updateIntervalSlider
    yOffset = yOffset + 60
    
    -- 刷新数据按钮
    local refreshButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    refreshButton:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    refreshButton:SetSize(150, 25)
    refreshButton:SetText(CF:L("BUTTON_REFRESH"))
    
    refreshButton:SetScript("OnClick", function()
        if CF.DataManager and CF.DataManager.RefreshData then
            CF.DataManager:RefreshData()
        end
    end)
    
    content.refreshButton = refreshButton
    yOffset = yOffset + 35
    
    -- ATT 集成组
    yOffset = yOffset + 10
    local attHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    attHeader:SetPoint("TOPLEFT", content, "TOPLEFT", 5, -yOffset)
    attHeader:SetText(CF:L("ATT_DATA_SOURCE_HEADER"))
    attHeader:SetTextColor(1, 0.82, 0)
    yOffset = yOffset + 25
    
    -- ATT 状态
    local attStatus = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    attStatus:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    
    if CF.ATTIntegration and CF.ATTIntegration:IsAvailable() then
        attStatus:SetText(CF:L("INFO_ATT_INTEGRATION"))
        attStatus:SetTextColor(0, 1, 0)
    else
        attStatus:SetText(CF:L("ERROR_ATT_NOT_FOUND"))
        attStatus:SetTextColor(1, 0, 0)
    end
    
    content.attStatus = attStatus
    yOffset = yOffset + 25
    
    -- 从 ATT 导入按钮
    local importATTButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    importATTButton:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    importATTButton:SetSize(200, 25)
    importATTButton:SetText(CF:L("DATA_IMPORT_FROM_ATT"))
    
    if not (CF.ATTIntegration and CF.ATTIntegration:IsAvailable()) then
        importATTButton:Disable()
    end
    
    importATTButton:SetScript("OnClick", function()
        if CF.ATTIntegration and CF.ATTIntegration.ImportAllData then
            CF.ATTIntegration:ImportAllData()
        end
    end)
    
    content.importATTButton = importATTButton
    yOffset = yOffset + 35
    
    return content
end

-- ====================================================================
-- 创建高级设置标签页
-- ====================================================================
function CP:CreateAdvancedTab()
    local content = CreateFrame("Frame", nil, self.frame)
    content:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 20, -80)
    content:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -20, 50)
    content:Hide()
    
    local yOffset = 0
    
    -- 高级选项组
    local groupHeader = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    groupHeader:SetPoint("TOPLEFT", content, "TOPLEFT", 5, -yOffset)
    groupHeader:SetText(CF:L("CONFIG_ADVANCED"))
    groupHeader:SetTextColor(1, 0.82, 0)
    yOffset = yOffset + 25
    
    -- 调试模式
    local debugCheckbox = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
    debugCheckbox:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    debugCheckbox.text = debugCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    debugCheckbox.text:SetPoint("LEFT", debugCheckbox, "RIGHT", 5, 0)
    debugCheckbox.text:SetText(CF:L("CMD_HELP_DEBUG"))
    
    debugCheckbox:SetChecked(CF.CURRENT_DEBUG_LEVEL > CF.DEBUG_LEVELS.NONE)
    
    debugCheckbox:SetScript("OnClick", function(self)
        if self:GetChecked() then
            CF.CURRENT_DEBUG_LEVEL = CF.DEBUG_LEVELS.INFO
            CF:ShowLocalizedMessage("CMD_DEBUG_ENABLED")
        else
            CF.CURRENT_DEBUG_LEVEL = CF.DEBUG_LEVELS.NONE
            CF:ShowLocalizedMessage("CMD_DEBUG_DISABLED")
        end
    end)
    
    content.debugCheckbox = debugCheckbox
    yOffset = yOffset + 30
    
    -- 清除缓存按钮
    local clearCacheButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    clearCacheButton:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    clearCacheButton:SetSize(150, 25)
    clearCacheButton:SetText(CF:L("DEBUG_CLEAR_CACHE"))
    
    clearCacheButton:SetScript("OnClick", function()
        if CF.ClearCache then
            CF:ClearCache()
            CF:ShowLocalizedSuccess("MSG_DATA_IMPORTED")
        end
        if CF.DataManager and CF.DataManager.ClearAllCaches then
            CF.DataManager:ClearAllCaches()
        end
    end)
    
    content.clearCacheButton = clearCacheButton
    yOffset = yOffset + 35
    
    -- 显示统计信息按钮
    local showStatsButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    showStatsButton:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    showStatsButton:SetSize(150, 25)
    showStatsButton:SetText(CF:L("DEBUG_SHOW_CACHE"))
    
    showStatsButton:SetScript("OnClick", function()
        if CF.Security and CF.Security.PrintStats then
            CF.Security:PrintStats()
        end
        if CF.StaticData and CF.StaticData.PrintStatistics then
            CF.StaticData:PrintStatistics()
        end
    end)
    
    content.showStatsButton = showStatsButton
    yOffset = yOffset + 35
    
    -- 重置所有设置按钮
    yOffset = yOffset + 20
    local resetAllButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    resetAllButton:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    resetAllButton:SetSize(200, 25)
    resetAllButton:SetText(CF:L("DATA_RESET"))
    
    resetAllButton:SetScript("OnClick", function()
        StaticPopup_Show("COPPERFEVER_RESET_CONFIRM")
    end)
    
    content.resetAllButton = resetAllButton
    yOffset = yOffset + 35
    
    -- 版本信息
    yOffset = yOffset + 20
    local versionInfo = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    versionInfo:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    versionInfo:SetText(string.format("%s: %s (%s: %d)", 
        CF:L("ADDON_VERSION"), CF.VERSION,
        CF:L("CMD_BUILD"), CF.BUILD))
    versionInfo:SetTextColor(0.7, 0.7, 0.7)
    yOffset = yOffset + 25
    
    -- 作者信息
    local authorInfo = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    authorInfo:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOffset)
    authorInfo:SetText(CF:L("ABOUT_AUTHOR_INFO"))
    authorInfo:SetTextColor(0.7, 0.7, 0.7)
    yOffset = yOffset + 25
    
    return content
end

-- ====================================================================
-- 创建底部按钮
-- ====================================================================
function CP:CreateButtons()
    if not self.frame then return end
    
    -- 保存按钮
    local saveButton = CreateFrame("Button", nil, self.frame, "UIPanelButtonTemplate")
    saveButton:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -20, 15)
    saveButton:SetSize(100, 25)
    saveButton:SetText(CF:L("BUTTON_SAVE"))
    
    saveButton:SetScript("OnClick", function()
        CP:SaveSettings()
    end)
    
    self.elements.saveButton = saveButton
    
    -- 取消按钮
    local cancelButton = CreateFrame("Button", nil, self.frame, "UIPanelButtonTemplate")
    cancelButton:SetPoint("RIGHT", saveButton, "LEFT", -10, 0)
    cancelButton:SetSize(100, 25)
    cancelButton:SetText(CF:L("BUTTON_CANCEL"))
    
    cancelButton:SetScript("OnClick", function()
        CP:Close()
    end)
    
    self.elements.cancelButton = cancelButton
end

-- ====================================================================
-- 显示标签页
-- ====================================================================
function CP:ShowTab(tabName)
    if not self.elements.tabs or not self.elements.contents then
        return
    end
    
    -- 隐藏所有标签页内容
    for name, content in pairs(self.elements.contents) do
        content:Hide()
    end
    
    -- 重置所有标签按钮
    for name, tab in pairs(self.elements.tabs) do
        tab.text:SetTextColor(1, 1, 1)
    end
    
    -- 显示选中的标签页
    if self.elements.contents[tabName] then
        self.elements.contents[tabName]:Show()
    end
    
    -- 高亮选中的标签按钮
    if self.elements.tabs[tabName] then
        self.elements.tabs[tabName].text:SetTextColor(1, 0.82, 0)
    end
    
    CF:LogInfo("切换到标签页: %s", tabName)
end

-- ====================================================================
-- 加载设置到界面
-- ====================================================================
function CP:LoadSettings()
    local db = CopperFeverDB
    if not db or not db.settings then
        CF:LogError("无法加载设置")
        return
    end
    
    -- 复制当前设置到临时设置
    self.tempSettings = CF:DeepCopy(db.settings)
    
    -- 加载到通用标签页
    if self.elements.contents.general then
        local content = self.elements.contents.general
        local mainFrame = db.settings.mainFrame
        
        if content.scaleSlider then
            content.scaleSlider:SetValue(mainFrame.scale or 1.0)
        end
        
        if content.alphaSlider then
            content.alphaSlider:SetValue(mainFrame.alpha or 0.9)
        end
        
        if content.lockCheckbox then
            content.lockCheckbox:SetChecked(mainFrame.locked or false)
        end
    end
    
    -- 加载到显示标签页
    if self.elements.contents.display then
        local content = self.elements.contents.display
        local display = db.settings.display
        
        if content.layoutDropdown then
            UIDropDownMenu_SetText(content.layoutDropdown, 
                CF:GetLayoutLocalizedName(display.layout or "vertical"))
        end
        
        if content.iconSizeSlider then
            content.iconSizeSlider:SetValue(display.iconSize or 24)
        end
        
        if content.fontSizeSlider then
            content.fontSizeSlider:SetValue(display.fontSize or 12)
        end
        
        if content.showIconsCheckbox then
            content.showIconsCheckbox:SetChecked(display.showIcons ~= false)
        end
        
        if content.showTooltipsCheckbox then
            content.showTooltipsCheckbox:SetChecked(display.showTooltips ~= false)
        end
        
        if content.hideInCombatCheckbox then
            content.hideInCombatCheckbox:SetChecked(display.hideInCombat or false)
        end
        
        if content.showZoneMessagesCheckbox then
            content.showZoneMessagesCheckbox:SetChecked(display.showZoneMessages or false)
        end
    end
    
    -- 加载到数据标签页
    if self.elements.contents.data then
        local content = self.elements.contents.data
        local data = db.settings.data
        
        if content.autoUpdateCheckbox then
            content.autoUpdateCheckbox:SetChecked(data.enableAutoUpdate ~= false)
        end
        
        if content.updateIntervalSlider then
            content.updateIntervalSlider:SetValue(data.updateInterval or 5)
        end
    end
    
    CF:LogInfo("设置已加载到配置界面")
end

-- ====================================================================
-- 保存设置
-- ====================================================================
function CP:SaveSettings()
    local db = CopperFeverDB
    if not db or not db.settings then
        CF:LogError("无法保存设置")
        return
    end
    
    -- 保存主窗口设置
    if self.tempSettings.scale then
        db.settings.mainFrame.scale = self.tempSettings.scale
        if CF.MainFrame and CF.MainFrame.frame then
            CF.MainFrame.frame:SetScale(self.tempSettings.scale)
        end
    end
    
    if self.tempSettings.alpha then
        db.settings.mainFrame.alpha = self.tempSettings.alpha
        if CF.MainFrame and CF.MainFrame.frame then
            CF.MainFrame.frame:SetAlpha(self.tempSettings.alpha)
        end
    end
    
    if self.tempSettings.locked ~= nil then
        db.settings.mainFrame.locked = self.tempSettings.locked
        if CF.MainFrame then
            CF.MainFrame:SetLocked(self.tempSettings.locked)
        end
    end
    
    -- 保存显示设置
    if self.tempSettings.layout then
        db.settings.display.layout = self.tempSettings.layout
    end
    
    if self.tempSettings.iconSize then
        db.settings.display.iconSize = self.tempSettings.iconSize
    end
    
    if self.tempSettings.fontSize then
        db.settings.display.fontSize = self.tempSettings.fontSize
    end
    
    if self.tempSettings.showIcons ~= nil then
        db.settings.display.showIcons = self.tempSettings.showIcons
    end
    
    if self.tempSettings.showTooltips ~= nil then
        db.settings.display.showTooltips = self.tempSettings.showTooltips
    end
    
    if self.tempSettings.hideInCombat ~= nil then
        db.settings.display.hideInCombat = self.tempSettings.hideInCombat
    end
    
    if self.tempSettings.showZoneMessages ~= nil then
        db.settings.display.showZoneMessages = self.tempSettings.showZoneMessages
    end
    
    -- 保存数据设置
    if self.tempSettings.enableAutoUpdate ~= nil then
        db.settings.data.enableAutoUpdate = self.tempSettings.enableAutoUpdate
        
        -- 重启自动更新
        if CF.DataManager then
            if self.tempSettings.enableAutoUpdate then
                CF.DataManager:StartAutoUpdate()
            else
                CF.DataManager:StopAutoUpdate()
            end
        end
    end
    
    if self.tempSettings.updateInterval then
        db.settings.data.updateInterval = self.tempSettings.updateInterval
        
        -- 重启自动更新以应用新间隔
        if CF.DataManager and db.settings.data.enableAutoUpdate then
            CF.DataManager:StopAutoUpdate()
            CF.DataManager:StartAutoUpdate()
        end
    end
    
    -- 刷新主窗口
    if CF.MainFrame and CF.MainFrame.Update then
        CF.MainFrame:Update()
    end
    
    CF:ShowLocalizedSuccess("MSG_SETTINGS_SAVED")
    CF:LogInfo("设置已保存")
    
    self:Close()
end

-- ====================================================================
-- 打开配置面板
-- ====================================================================
function CP:Open()
    if not self.frame then
        self:CreatePanel()
    end
    
    self:LoadSettings()
    self.frame:Show()
    
    CF:LogInfo("配置面板已打开")
end

-- ====================================================================
-- 关闭配置面板
-- ====================================================================
function CP:Close()
    if self.frame then
        self.frame:Hide()
    end
    
    -- 清空临时设置
    self.tempSettings = {}
    
    CF:LogInfo("配置面板已关闭")
end

-- ====================================================================
-- 切换配置面板
-- ====================================================================
function CP:Toggle()
    if self.frame and self.frame:IsShown() then
        self:Close()
    else
        self:Open()
    end
end

-- ====================================================================
-- 初始化配置面板
-- ====================================================================
function CP:Initialize()
    if self.initialized then
        CF:LogWarning("ConfigPanel 已经初始化过了")
        return
    end
    
    CF:LogInfo("初始化配置面板...")
    
    -- 注册重置确认对话框
    StaticPopupDialogs["COPPERFEVER_RESET_CONFIRM"] = {
        text = CF:L("WARNING_RESET_CONFIRM"),
        button1 = CF:L("BUTTON_OK"),
        button2 = CF:L("BUTTON_CANCEL"),
        OnAccept = function()
            local db = CopperFeverDB
            if db then
                db.settings = CF:DeepCopy(CF.DEFAULTS)
                CF:ShowLocalizedSuccess("MSG_SETTINGS_RESET")
                
                if CF.MainFrame then
                    CF.MainFrame:ResetPosition()
                    CF.MainFrame:Update()
                end
                
                CP:LoadSettings()
            end
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    
    self.initialized = true
    CF:LogInfo("配置面板初始化完成")
end

-- ====================================================================
-- 清理函数
-- ====================================================================
function CP:Cleanup()
    CF:LogInfo("清理配置面板...")
    
    if self.frame and self.frame:IsShown() then
        self:Close()
    end
end

-- ====================================================================
-- 结束标记
-- ====================================================================