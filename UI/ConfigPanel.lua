-- ====================================================================
-- Copper Fever - UI\ConfigPanel.lua
-- 设置界面
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever

-- ====================================================================
-- 配置面板初始化
-- ====================================================================
CF.ConfigPanel = CF.ConfigPanel or {}
local CP = CF.ConfigPanel

-- 面板引用
CP.panel = nil
CP.categoryList = nil
CP.currentCategory = nil

-- 设置类别
CP.categories = {
    "general",
    "display",
    "data",
    "maps",
}

-- ====================================================================
-- 创建配置面板
-- ====================================================================
function CP:Create()
    if self.panel then
        return self.panel
    end
    
    CF:LogInfo("创建配置面板...")
    
    -- 创建主面板
    local panel = CreateFrame("Frame", "CopperFeverConfigPanel")
    panel.name = CF.ADDON_TITLE
    self.panel = panel
    
    -- 创建标题
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(CF.L["CONFIG_TITLE"])
    
    -- 创建版本信息
    local version = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    version:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    version:SetText(CF:Colorize(CF.L["ADDON_VERSION"] .. ": " .. CF.VERSION, CF.COLORS.GRAY))
    
    -- 创建作者信息
    local author = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    author:SetPoint("TOPLEFT", version, "BOTTOMLEFT", 0, -4)
    author:SetText(CF:Colorize(CF.L["AUTHOR"] .. ": David W Zhang", CF.COLORS.GRAY))
    
    -- 创建分隔线
    local divider = panel:CreateTexture(nil, "ARTWORK")
    divider:SetHeight(1)
    divider:SetPoint("TOPLEFT", author, "BOTTOMLEFT", 0, -8)
    divider:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -16, 0)
    divider:SetColorTexture(0.5, 0.5, 0.5, 0.5)
    
    -- 创建类别列表（左侧）
    self:CreateCategoryList(panel, divider)
    
    -- 创建内容区域（右侧）
    self:CreateContentArea(panel, divider)
    
    -- 创建按钮区域
    self:CreateButtonArea(panel)
    
    -- 注册到暴雪设置界面
    if Settings and Settings.RegisterCanvasLayoutCategory then
        -- 11.0+ 新设置界面
        local category = Settings.RegisterCanvasLayoutCategory(panel, CF.ADDON_TITLE)
        Settings.RegisterAddOnCategory(category)
        self.settingsCategory = category
    elseif InterfaceOptions_AddCategory then
        -- 旧版设置界面
        InterfaceOptions_AddCategory(panel)
    end
    
    -- 设置面板脚本
    panel:SetScript("OnShow", function()
        CP:OnShow()
    end)
    
    panel:SetScript("OnHide", function()
        CP:OnHide()
    end)
    
    CF:LogInfo("配置面板创建完成")
    
    return panel
end

-- ====================================================================
-- 创建类别列表
-- ====================================================================
function CP:CreateCategoryList(parent, topAnchor)
    local listFrame = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    self.categoryList = listFrame
    
    listFrame:SetPoint("TOPLEFT", topAnchor, "BOTTOMLEFT", 0, -8)
    listFrame:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 16, 60)
    listFrame:SetWidth(150)
    
    listFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    listFrame:SetBackdropColor(0, 0, 0, 0.5)
    
    -- 创建类别按钮
    listFrame.buttons = {}
    for i, category in ipairs(self.categories) do
        local button = self:CreateCategoryButton(listFrame, category, i)
        table.insert(listFrame.buttons, button)
    end
end

-- ====================================================================
-- 创建类别按钮
-- ====================================================================
function CP:CreateCategoryButton(parent, category, index)
    local button = CreateFrame("Button", nil, parent)
    button:SetSize(parent:GetWidth() - 16, 30)
    button.category = category
    
    -- 定位
    if index == 1 then
        button:SetPoint("TOPLEFT", parent, "TOPLEFT", 8, -8)
    else
        button:SetPoint("TOPLEFT", parent.buttons[index - 1], "BOTTOMLEFT", 0, -4)
    end
    
    -- 背景
    button.bg = button:CreateTexture(nil, "BACKGROUND")
    button.bg:SetAllPoints()
    button.bg:SetColorTexture(0.2, 0.2, 0.2, 0.5)
    button.bg:Hide()
    
    -- 高亮
    button.highlight = button:CreateTexture(nil, "HIGHLIGHT")
    button.highlight:SetAllPoints()
    button.highlight:SetColorTexture(1, 1, 1, 0.1)
    
    -- 文本
    button.text = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    button.text:SetPoint("LEFT", button, "LEFT", 8, 0)
    
    -- 设置类别名称
    local categoryKey = "CONFIG_" .. category:upper()
    button.text:SetText(CF.L[categoryKey])
    
    -- 点击事件
    button:SetScript("OnClick", function(self)
        CP:SelectCategory(self.category)
    end)
    
    return button
end

-- ====================================================================
-- 创建内容区域
-- ====================================================================
function CP:CreateContentArea(parent, topAnchor)
    local contentFrame = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate")
    self.contentFrame = contentFrame
    
    contentFrame:SetPoint("TOPLEFT", self.categoryList, "TOPRIGHT", 8, 0)
    contentFrame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -32, 60)
    
    -- 创建滚动子框架
    local scrollChild = CreateFrame("Frame", nil, contentFrame)
    contentFrame:SetScrollChild(scrollChild)
    scrollChild:SetWidth(contentFrame:GetWidth() - 20)
    scrollChild:SetHeight(1)
    
    contentFrame.scrollChild = scrollChild
    
    -- 创建各个类别的内容
    self.categoryFrames = {}
    self.categoryFrames.general = self:CreateGeneralSettings(scrollChild)
    self.categoryFrames.display = self:CreateDisplaySettings(scrollChild)
    self.categoryFrames.data = self:CreateDataSettings(scrollChild)
    self.categoryFrames.maps = self:CreateMapSettings(scrollChild)
end

-- ====================================================================
-- 创建常规设置
-- ====================================================================
function CP:CreateGeneralSettings(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetAllPoints(parent)
    frame:Hide()
    
    local yOffset = -10
    
    -- 标题
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    title:SetText(CF.L["CONFIG_GENERAL"])
    yOffset = yOffset - 30
    
    -- 显示主窗口复选框
    local showWindow = CreateFrame("CheckButton", nil, frame, "InterfaceOptionsCheckButtonTemplate")
    showWindow:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    showWindow.Text:SetText(CF.L["MENU_SHOW_WINDOW"])
    showWindow:SetScript("OnClick", function(self)
        local db = CopperFeverDB
        if db and db.settings and db.settings.mainFrame then
            db.settings.mainFrame.shown = self:GetChecked()
            if self:GetChecked() then
                CF.MainFrame:Show()
            else
                CF.MainFrame:Hide()
            end
        end
    end)
    frame.showWindow = showWindow
    yOffset = yOffset - 30
    
    -- 锁定窗口复选框
    local lockWindow = CreateFrame("CheckButton", nil, frame, "InterfaceOptionsCheckButtonTemplate")
    lockWindow:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    lockWindow.Text:SetText(CF.L["WINDOW_LOCKED"])
    lockWindow:SetScript("OnClick", function(self)
        CF.MainFrame:SetLocked(self:GetChecked())
    end)
    frame.lockWindow = lockWindow
    yOffset = yOffset - 30
    
    -- 重置位置按钮
    local resetPos = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    resetPos:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    resetPos:SetSize(150, 25)
    resetPos:SetText(CF.L["WINDOW_RESET_POSITION"])
    resetPos:SetScript("OnClick", function()
        CF.MainFrame:ResetPosition()
    end)
    frame.resetPos = resetPos
    yOffset = yOffset - 35
    
    -- 窗口缩放滑块
    local scaleSlider = CreateFrame("Slider", nil, frame, "OptionsSliderTemplate")
    scaleSlider:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, yOffset)
    scaleSlider:SetMinMaxValues(0.5, 2.0)
    scaleSlider:SetValueStep(0.1)
    scaleSlider:SetObeyStepOnDrag(true)
    scaleSlider.Text:SetText(CF.L["WINDOW_SCALE"])
    scaleSlider.Low:SetText("0.5")
    scaleSlider.High:SetText("2.0")
    scaleSlider:SetScript("OnValueChanged", function(self, value)
        local db = CopperFeverDB
        if db and db.settings and db.settings.mainFrame then
            db.settings.mainFrame.scale = value
            CF.MainFrame:ApplySettings()
        end
        self.Value:SetText(string.format("%.1f", value))
    end)
    scaleSlider.Value = scaleSlider:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    scaleSlider.Value:SetPoint("TOP", scaleSlider, "BOTTOM", 0, 0)
    frame.scaleSlider = scaleSlider
    yOffset = yOffset - 50
    
    -- 窗口透明度滑块
    local alphaSlider = CreateFrame("Slider", nil, frame, "OptionsSliderTemplate")
    alphaSlider:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, yOffset)
    alphaSlider:SetMinMaxValues(0.1, 1.0)
    alphaSlider:SetValueStep(0.1)
    alphaSlider:SetObeyStepOnDrag(true)
    alphaSlider.Text:SetText(CF.L["WINDOW_ALPHA"])
    alphaSlider.Low:SetText("10%")
    alphaSlider.High:SetText("100%")
    alphaSlider:SetScript("OnValueChanged", function(self, value)
        local db = CopperFeverDB
        if db and db.settings and db.settings.mainFrame then
            db.settings.mainFrame.alpha = value
            CF.MainFrame:ApplySettings()
        end
        self.Value:SetText(string.format("%.0f%%", value * 100))
    end)
    alphaSlider.Value = alphaSlider:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    alphaSlider.Value:SetPoint("TOP", alphaSlider, "BOTTOM", 0, 0)
    frame.alphaSlider = alphaSlider
    
    return frame
end

-- ====================================================================
-- 创建显示设置
-- ====================================================================
function CP:CreateDisplaySettings(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetAllPoints(parent)
    frame:Hide()
    
    local yOffset = -10
    
    -- 标题
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    title:SetText(CF.L["CONFIG_DISPLAY"])
    yOffset = yOffset - 30
    
    -- 布局选择下拉菜单
    local layoutLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    layoutLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    layoutLabel:SetText(CF.L["DISPLAY_LAYOUT"] .. ":")
    yOffset = yOffset - 25
    
    local layoutDropdown = CreateFrame("Frame", nil, frame, "UIDropDownMenuTemplate")
    layoutDropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", -15, yOffset)
    UIDropDownMenu_SetWidth(layoutDropdown, 150)
    UIDropDownMenu_Initialize(layoutDropdown, function(self, level)
        local info = UIDropDownMenu_CreateInfo()
        
        info.text = CF.L["LAYOUT_VERTICAL"]
        info.value = "vertical"
        info.func = function()
            local db = CopperFeverDB
            if db and db.settings and db.settings.display then
                db.settings.display.layout = "vertical"
                CF.MainFrame:Update()
            end
            UIDropDownMenu_SetSelectedValue(layoutDropdown, "vertical")
        end
        UIDropDownMenu_AddButton(info, level)
        
        info.text = CF.L["LAYOUT_HORIZONTAL"]
        info.value = "horizontal"
        info.func = function()
            local db = CopperFeverDB
            if db and db.settings and db.settings.display then
                db.settings.display.layout = "horizontal"
                CF.MainFrame:Update()
            end
            UIDropDownMenu_SetSelectedValue(layoutDropdown, "horizontal")
        end
        UIDropDownMenu_AddButton(info, level)
    end)
    frame.layoutDropdown = layoutDropdown
    yOffset = yOffset - 40
    
    -- 显示图标复选框
    local showIcons = CreateFrame("CheckButton", nil, frame, "InterfaceOptionsCheckButtonTemplate")
    showIcons:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    showIcons.Text:SetText(CF.L["DISPLAY_SHOW_ICONS"])
    showIcons:SetScript("OnClick", function(self)
        local db = CopperFeverDB
        if db and db.settings and db.settings.display then
            db.settings.display.showIcons = self:GetChecked()
            CF.MainFrame:Update()
        end
    end)
    frame.showIcons = showIcons
    yOffset = yOffset - 30
    
    -- 显示提示信息复选框
    local showTooltips = CreateFrame("CheckButton", nil, frame, "InterfaceOptionsCheckButtonTemplate")
    showTooltips:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    showTooltips.Text:SetText(CF.L["DISPLAY_SHOW_TOOLTIPS"])
    showTooltips:SetScript("OnClick", function(self)
        local db = CopperFeverDB
        if db and db.settings and db.settings.display then
            db.settings.display.showTooltips = self:GetChecked()
        end
    end)
    frame.showTooltips = showTooltips
    yOffset = yOffset - 30
    
    -- 自动隐藏复选框
    local autoHide = CreateFrame("CheckButton", nil, frame, "InterfaceOptionsCheckButtonTemplate")
    autoHide:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    autoHide.Text:SetText(CF.L["DISPLAY_AUTO_HIDE"])
    autoHide:SetScript("OnClick", function(self)
        local db = CopperFeverDB
        if db and db.settings and db.settings.display then
            db.settings.display.autoHide = self:GetChecked()
            CF.MainFrame:Update()
        end
    end)
    frame.autoHide = autoHide
    yOffset = yOffset - 40
    
    -- 图标大小滑块
    local iconSizeSlider = CreateFrame("Slider", nil, frame, "OptionsSliderTemplate")
    iconSizeSlider:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, yOffset)
    iconSizeSlider:SetMinMaxValues(16, 48)
    iconSizeSlider:SetValueStep(2)
    iconSizeSlider:SetObeyStepOnDrag(true)
    iconSizeSlider.Text:SetText(CF.L["DISPLAY_ICON_SIZE"])
    iconSizeSlider.Low:SetText("16")
    iconSizeSlider.High:SetText("48")
    iconSizeSlider:SetScript("OnValueChanged", function(self, value)
        local db = CopperFeverDB
        if db and db.settings and db.settings.display then
            db.settings.display.iconSize = value
            CF.MainFrame:Update()
        end
        self.Value:SetText(tostring(value))
    end)
    iconSizeSlider.Value = iconSizeSlider:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    iconSizeSlider.Value:SetPoint("TOP", iconSizeSlider, "BOTTOM", 0, 0)
    frame.iconSizeSlider = iconSizeSlider
    yOffset = yOffset - 50
    
    -- 间距滑块
    local spacingSlider = CreateFrame("Slider", nil, frame, "OptionsSliderTemplate")
    spacingSlider:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, yOffset)
    spacingSlider:SetMinMaxValues(0, 20)
    spacingSlider:SetValueStep(1)
    spacingSlider:SetObeyStepOnDrag(true)
    spacingSlider.Text:SetText(CF.L["DISPLAY_SPACING"])
    spacingSlider.Low:SetText("0")
    spacingSlider.High:SetText("20")
    spacingSlider:SetScript("OnValueChanged", function(self, value)
        local db = CopperFeverDB
        if db and db.settings and db.settings.display then
            db.settings.display.spacing = value
            CF.MainFrame:Update()
        end
        self.Value:SetText(tostring(value))
    end)
    spacingSlider.Value = spacingSlider:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    spacingSlider.Value:SetPoint("TOP", spacingSlider, "BOTTOM", 0, 0)
    frame.spacingSlider = spacingSlider
    
    return frame
end

-- ====================================================================
-- 创建数据设置
-- ====================================================================
function CP:CreateDataSettings(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetAllPoints(parent)
    frame:Hide()
    
    local yOffset = -10
    
    -- 标题
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    title:SetText(CF.L["CONFIG_DATA"])
    yOffset = yOffset - 30
    
    -- 启用自动更新复选框
    local autoUpdate = CreateFrame("CheckButton", nil, frame, "InterfaceOptionsCheckButtonTemplate")
    autoUpdate:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    autoUpdate.Text:SetText(CF.L["DATA_AUTO_UPDATE"])
    autoUpdate:SetScript("OnClick", function(self)
        local db = CopperFeverDB
        if db and db.settings and db.settings.data then
            db.settings.data.enableAutoUpdate = self:GetChecked()
            if self:GetChecked() then
                CF.DataManager:StartAutoUpdate()
            else
                CF.DataManager:StopAutoUpdate()
            end
        end
    end)
    frame.autoUpdate = autoUpdate
    yOffset = yOffset - 40
    
    -- 更新间隔滑块
    local updateIntervalSlider = CreateFrame("Slider", nil, frame, "OptionsSliderTemplate")
    updateIntervalSlider:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, yOffset)
    updateIntervalSlider:SetMinMaxValues(1, 30)
    updateIntervalSlider:SetValueStep(1)
    updateIntervalSlider:SetObeyStepOnDrag(true)
    updateIntervalSlider.Text:SetText(CF.L["DATA_UPDATE_INTERVAL"])
    updateIntervalSlider.Low:SetText("1")
    updateIntervalSlider.High:SetText("30")
    updateIntervalSlider:SetScript("OnValueChanged", function(self, value)
        local db = CopperFeverDB
        if db and db.settings and db.settings.data then
            db.settings.data.updateInterval = value
            -- 重启自动更新以应用新间隔
            if db.settings.data.enableAutoUpdate then
                CF.DataManager:StopAutoUpdate()
                CF.DataManager:StartAutoUpdate()
            end
        end
        self.Value:SetText(tostring(value) .. "s")
    end)
    updateIntervalSlider.Value = updateIntervalSlider:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    updateIntervalSlider.Value:SetPoint("TOP", updateIntervalSlider, "BOTTOM", 0, 0)
    frame.updateIntervalSlider = updateIntervalSlider
    yOffset = yOffset - 60
    
    -- ALL THE THINGS 集成
    local attTitle = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    attTitle:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    attTitle:SetText(CF:Colorize(CF.L["ATT_INTEGRATION"], CF.COLORS.YELLOW))
    yOffset = yOffset - 25
    
    -- 从 ATT 导入按钮
    local importATT = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    importATT:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    importATT:SetSize(200, 25)
    importATT:SetText(CF.L["DATA_IMPORT_FROM_ATT"])
    importATT:SetScript("OnClick", function()
        CF.ATTIntegration:ImportAllData()
    end)
    frame.importATT = importATT
    yOffset = yOffset - 35
    
    -- 手动刷新按钮
    local refreshData = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    refreshData:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    refreshData:SetSize(150, 25)
    refreshData:SetText(CF.L["BUTTON_REFRESH"])
    refreshData:SetScript("OnClick", function()
        CF.DataManager:RefreshData()
    end)
    frame.refreshData = refreshData
    yOffset = yOffset - 35
    
    -- 重置为默认按钮
    local resetData = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    resetData:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    resetData:SetSize(150, 25)
    resetData:SetText(CF.L["DATA_RESET"])
    resetData:SetScript("OnClick", function()
        StaticPopup_Show("COPPERFEVER_RESET_CONFIRM")
    end)
    frame.resetData = resetData
    
    return frame
end

-- ====================================================================
-- 创建地图设置
-- ====================================================================
function CP:CreateMapSettings(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetAllPoints(parent)
    frame:Hide()
    
    local yOffset = -10
    
    -- 标题
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    title:SetText(CF.L["CONFIG_MAP_LIST"])
    yOffset = yOffset - 30
    
    -- 说明文本
    local desc = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    desc:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    desc:SetText(CF:Colorize(CF.L["CONFIG_SELECT_MAP"], CF.COLORS.GRAY))
    desc:SetWordWrap(true)
    desc:SetWidth(parent:GetWidth() - 20)
    yOffset = yOffset - 40
    
    -- 创建地图列表滚动框架
    local mapListScroll = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    mapListScroll:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, yOffset)
    mapListScroll:SetSize(parent:GetWidth() - 40, 400)
    
    local mapListContent = CreateFrame("Frame", nil, mapListScroll)
    mapListScroll:SetScrollChild(mapListContent)
    mapListContent:SetSize(mapListScroll:GetWidth() - 20, 800)
    
    frame.mapListScroll = mapListScroll
    frame.mapListContent = mapListContent
    
    -- 填充地图列表（这里可以添加按扩展版本分组的地图列表）
    -- 由于篇幅原因，这里仅提供框架
    local mapListText = mapListContent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    mapListText:SetPoint("TOPLEFT", mapListContent, "TOPLEFT", 5, -5)
    mapListText:SetText(CF:Colorize("地图配置功能待完善...", CF.COLORS.YELLOW))
    
    return frame
end

-- ====================================================================
-- 创建按钮区域
-- ====================================================================
function CP:CreateButtonArea(parent)
    -- 保存按钮
    local saveBtn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    saveBtn:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 16, 16)
    saveBtn:SetSize(100, 25)
    saveBtn:SetText(CF.L["BUTTON_SAVE"])
    saveBtn:SetScript("OnClick", function()
        CP:SaveSettings()
    end)
    parent.saveBtn = saveBtn
    
    -- 取消按钮
    local cancelBtn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    cancelBtn:SetPoint("LEFT", saveBtn, "RIGHT", 10, 0)
    cancelBtn:SetSize(100, 25)
    cancelBtn:SetText(CF.L["BUTTON_CANCEL"])
    cancelBtn:SetScript("OnClick", function()
        CP:CancelSettings()
    end)
    parent.cancelBtn = cancelBtn
    
    -- 默认按钮
    local defaultBtn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    defaultBtn:SetPoint("LEFT", cancelBtn, "RIGHT", 10, 0)
    defaultBtn:SetSize(100, 25)
    defaultBtn:SetText(CF.L["BUTTON_RESET"])
    defaultBtn:SetScript("OnClick", function()
        StaticPopup_Show("COPPERFEVER_RESET_CONFIRM")
    end)
    parent.defaultBtn = defaultBtn
end

-- ====================================================================
-- 选择类别
-- ====================================================================
function CP:SelectCategory(category)
    -- 更新按钮状态
    for _, button in ipairs(self.categoryList.buttons) do
        if button.category == category then
            button.bg:Show()
            button.text:SetTextColor(1, 1, 1)
        else
            button.bg:Hide()
            button.text:SetTextColor(0.7, 0.7, 0.7)
        end
    end
    
    -- 显示对应的内容框架
    for cat, frame in pairs(self.categoryFrames) do
        if cat == category then
            frame:Show()
        else
            frame:Hide()
        end
    end
    
    self.currentCategory = category
end

-- ====================================================================
-- 加载设置到界面
-- ====================================================================
function CP:LoadSettings()
    local db = CopperFeverDB
    if not db or not db.settings then return end
    
    -- 加载常规设置
    local generalFrame = self.categoryFrames.general
    if generalFrame then
        generalFrame.showWindow:SetChecked(db.settings.mainFrame.shown or false)
        generalFrame.lockWindow:SetChecked(db.settings.mainFrame.locked or false)
        generalFrame.scaleSlider:SetValue(db.settings.mainFrame.scale or CF.DEFAULTS.mainFrame.scale)
        generalFrame.alphaSlider:SetValue(db.settings.mainFrame.alpha or CF.DEFAULTS.mainFrame.alpha)
    end
    
    -- 加载显示设置
    local displayFrame = self.categoryFrames.display
    if displayFrame then
        UIDropDownMenu_SetSelectedValue(displayFrame.layoutDropdown, 
            db.settings.display.layout or CF.DEFAULTS.display.layout)
        displayFrame.showIcons:SetChecked(db.settings.display.showIcons ~= false)
        displayFrame.showTooltips:SetChecked(db.settings.display.showTooltips ~= false)
        displayFrame.autoHide:SetChecked(db.settings.display.autoHide or false)
        displayFrame.iconSizeSlider:SetValue(db.settings.display.iconSize or CF.DEFAULTS.display.iconSize)
        displayFrame.spacingSlider:SetValue(db.settings.display.spacing or CF.DEFAULTS.display.spacing)
    end
    
    -- 加载数据设置
    local dataFrame = self.categoryFrames.data
    if dataFrame then
        dataFrame.autoUpdate:SetChecked(db.settings.data.enableAutoUpdate ~= false)
        dataFrame.updateIntervalSlider:SetValue(db.settings.data.updateInterval or CF.DEFAULTS.data.updateInterval)
    end
end

-- ====================================================================
-- 保存设置
-- ====================================================================
function CP:SaveSettings()
    CF:ShowLocalizedSuccess("MSG_SETTINGS_SAVED")
    
    -- 应用设置到主窗口
    CF.MainFrame:ApplySettings()
end

-- ====================================================================
-- 取消设置
-- ====================================================================
function CP:CancelSettings()
    -- 重新加载设置
    self:LoadSettings()
end

-- ====================================================================
-- 重置设置
-- ====================================================================
function CP:ResetSettings()
    -- 重置为默认值
    CopperFeverDB.settings = CF:DeepCopy(CF.DEFAULTS)
    
    -- 重新加载界面
    self:LoadSettings()
    
    -- 应用到主窗口
    CF.MainFrame:ApplySettings()
    
    CF:ShowLocalizedSuccess("MSG_SETTINGS_RESET")
end

-- ====================================================================
-- 事件处理
-- ====================================================================
function CP:OnShow()
    -- 加载当前设置
    self:LoadSettings()
    
    -- 默认显示第一个类别
    if not self.currentCategory then
        self:SelectCategory(self.categories[1])
    end
end

function CP:OnHide()
    -- 清理
end

-- ====================================================================
-- 打开配置面板
-- ====================================================================
function CP:Open()
    if Settings and self.settingsCategory then
        -- 11.0+ 新设置界面
        Settings.OpenToCategory(self.settingsCategory:GetID())
    elseif InterfaceOptionsFrame_OpenToCategory then
        -- 旧版设置界面
        InterfaceOptionsFrame_OpenToCategory(self.panel)
        InterfaceOptionsFrame_OpenToCategory(self.panel)  -- 调用两次以确保正确显示
    end
end

-- ====================================================================
-- 初始化
-- ====================================================================
function CP:Initialize()
    CF:LogInfo("初始化配置面板...")
    
    -- 创建面板
    self:Create()
    
    -- 创建确认对话框
    StaticPopupDialogs["COPPERFEVER_RESET_CONFIRM"] = {
        text = CF.L["WARNING_RESET_CONFIRM"],
        button1 = CF.L["BUTTON_OK"],
        button2 = CF.L["BUTTON_CANCEL"],
        OnAccept = function()
            CP:ResetSettings()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    
    CF:LogInfo("配置面板初始化完成")
end