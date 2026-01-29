-- ====================================================================
-- Copper Fever - UI\MainFrame.lua
-- 主窗口界面
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever

-- ====================================================================
-- 主窗口初始化
-- ====================================================================
CF.MainFrame = CF.MainFrame or {}
local MF = CF.MainFrame

-- 初始化标志
MF.initialized = false
MF.frame = nil
MF.elements = {}
MF.contentRows = {}

-- ====================================================================
-- 创建主窗口
-- ====================================================================
function MF:CreateFrame()
    if self.frame then
        CF:LogWarning("主窗口已经创建")
        return self.frame
    end
    
    local db = CopperFeverDB
    if not db or not db.settings then
        CF:LogError("数据库未初始化，无法创建主窗口")
        return nil
    end
    
    local settings = db.settings.mainFrame
    
    -- 创建主框架
    local frame = CreateFrame("Frame", "CopperFeverMainFrame", UIParent, "BackdropTemplate")
    frame:SetSize(settings.width or 200, settings.height or 300)
    frame:SetPoint(settings.point or "CENTER", UIParent, settings.point or "CENTER", 
                   settings.x or 0, settings.y or 0)
    frame:SetFrameStrata(CF.FRAME_STRATA.MAIN)
    frame:SetFrameLevel(1)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(not settings.locked)
    frame:RegisterForDrag("LeftButton")
    
    -- 设置背景
    local bgColor = settings.backgroundColor or CF.DEFAULTS.mainFrame.backgroundColor
    local borderColor = settings.borderColor or CF.DEFAULTS.mainFrame.borderColor
    
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    
    frame:SetBackdropColor(bgColor.r, bgColor.g, bgColor.b, bgColor.a or 0.8)
    frame:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a or 1)
    
    -- 设置透明度和缩放
    frame:SetAlpha(settings.alpha or 0.9)
    frame:SetScale(settings.scale or 1.0)
    
    -- 拖动事件
    frame:SetScript("OnDragStart", function(self)
        if not db.settings.mainFrame.locked then
            self:StartMoving()
        end
    end)
    
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        MF:SavePosition()
    end)
    
    -- 鼠标进入/离开事件
    frame:SetScript("OnEnter", function(self)
        -- 可以在这里添加悬停效果
    end)
    
    frame:SetScript("OnLeave", function(self)
        -- 可以在这里移除悬停效果
    end)
    
    -- 右键菜单
    frame:SetScript("OnMouseUp", function(self, button)
        if button == "RightButton" then
            MF:ShowContextMenu()
        end
    end)
    
    self.frame = frame
    
    -- 创建子元素
    self:CreateTitle()
    self:CreateCloseButton()
    self:CreateScrollFrame()
    self:CreateResizeButton()
    self:CreateStatusBar()
    
    -- 初始显示状态
    if settings.shown then
        frame:Show()
    else
        frame:Hide()
    end
    
    CF:LogInfo("主窗口创建完成")
    return frame
end

-- ====================================================================
-- 创建标题栏
-- ====================================================================
function MF:CreateTitle()
    if not self.frame then return end
    
    local title = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", self.frame, "TOP", 0, -15)
    title:SetText(CF:L("MAIN_FRAME_TITLE"))
    title:SetTextColor(1, 0.82, 0)
    
    self.elements.title = title
end

-- ====================================================================
-- 创建关闭按钮
-- ====================================================================
function MF:CreateCloseButton()
    if not self.frame then return end
    
    local closeButton = CreateFrame("Button", nil, self.frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -5, -5)
    closeButton:SetSize(24, 24)
    
    closeButton:SetScript("OnClick", function()
        MF:Hide()
    end)
    
    closeButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(CF:L("TOOLTIP_HIDE_WINDOW"))
        GameTooltip:Show()
    end)
    
    closeButton:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    
    self.elements.closeButton = closeButton
end

-- ====================================================================
-- 创建滚动框架
-- ====================================================================
function MF:CreateScrollFrame()
    if not self.frame then return end
    
    local scrollFrame = CreateFrame("ScrollFrame", nil, self.frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 20, -45)
    scrollFrame:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -30, 35)
    
    -- 创建内容容器
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(scrollFrame:GetWidth(), 1) -- 高度会动态调整
    scrollFrame:SetScrollChild(content)
    
    self.elements.scrollFrame = scrollFrame
    self.elements.content = content
end

-- ====================================================================
-- 创建调整大小按钮
-- ====================================================================
function MF:CreateResizeButton()
    if not self.frame then return end
    
    local resizeButton = CreateFrame("Button", nil, self.frame)
    resizeButton:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -5, 5)
    resizeButton:SetSize(16, 16)
    resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
    
    resizeButton:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            MF.frame:StartSizing("BOTTOMRIGHT")
        end
    end)
    
    resizeButton:SetScript("OnMouseUp", function(self, button)
        MF.frame:StopMovingOrSizing()
        MF:SavePosition()
        MF:Update() -- 调整大小后重新布局
    end)
    
    self.frame:SetResizable(true)
    self.frame:SetMinResize(150, 200)
    self.frame:SetMaxResize(400, 600)
    
    self.elements.resizeButton = resizeButton
end

-- ====================================================================
-- 创建状态栏
-- ====================================================================
function MF:CreateStatusBar()
    if not self.frame then return end
    
    local statusBar = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statusBar:SetPoint("BOTTOM", self.frame, "BOTTOM", 0, 15)
    statusBar:SetText(CF:L("STATUS_READY"))
    statusBar:SetTextColor(0.7, 0.7, 0.7)
    
    self.elements.statusBar = statusBar
end

-- ====================================================================
-- 更新状态栏
-- ====================================================================
function MF:UpdateStatusBar(text)
    if self.elements.statusBar then
        self.elements.statusBar:SetText(text or CF:L("STATUS_READY"))
    end
end

-- ====================================================================
-- 更新显示内容
-- ====================================================================
function MF:Update()
    if not self.frame or not self.frame:IsShown() then
        return
    end
    
    CF:LogInfo("更新主窗口内容")
    self:UpdateStatusBar(CF:L("STATUS_UPDATING"))
    
    -- 清除现有内容
    self:ClearContent()
    
    -- 获取当前区域数据
    local zoneData = nil
    if CF.DataManager and CF.DataManager.GetCurrentZoneData then
        local success, data = pcall(CF.DataManager.GetCurrentZoneData, CF.DataManager)
        if success then
            zoneData = data
        else
            CF:LogError("获取区域数据失败: %s", tostring(data))
            self:UpdateStatusBar(CF:L("STATUS_ERROR"))
        end
    end
    
    if not zoneData or (not zoneData.hasCurrencies and not zoneData.hasReputations) then
        self:ShowNoData()
        self:UpdateStatusBar(CF:L("INFO_ZONE_NO_CURRENCIES"))
        return
    end
    
    local yOffset = 0
    
    -- 显示区域名称
    if zoneData.mapName then
        yOffset = self:DisplayZoneName(zoneData.mapName, yOffset)
    end
    
    -- 显示货币
    if zoneData.hasCurrencies then
        yOffset = self:DisplayCurrencies(zoneData.currencies, yOffset)
    end
    
    -- 显示声望
    if zoneData.hasReputations then
        yOffset = self:DisplayReputations(zoneData.reputations, yOffset)
    end
    
    -- 调整内容高度
    if self.elements.content then
        self.elements.content:SetHeight(math.max(yOffset, 1))
    end
    
    -- 更新状态栏
    local statusText = string.format("%d %s, %d %s", 
        #(zoneData.currencies or {}), CF:L("CURRENCY"),
        #(zoneData.reputations or {}), CF:L("REPUTATION"))
    self:UpdateStatusBar(statusText)
end

-- ====================================================================
-- 显示区域名称
-- ====================================================================
function MF:DisplayZoneName(mapName, yOffset)
    if not self.elements.content or not mapName then
        return yOffset
    end
    
    local zoneName = self.elements.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    zoneName:SetPoint("TOPLEFT", self.elements.content, "TOPLEFT", 5, -yOffset)
    zoneName:SetText(mapName)
    zoneName:SetTextColor(0.8, 0.8, 1)
    yOffset = yOffset + 20
    
    -- 分隔线
    local separator = self.elements.content:CreateTexture(nil, "ARTWORK")
    separator:SetPoint("TOPLEFT", self.elements.content, "TOPLEFT", 5, -yOffset)
    separator:SetSize(self.elements.content:GetWidth() - 10, 1)
    separator:SetColorTexture(0.5, 0.5, 0.5, 0.5)
    yOffset = yOffset + 10
    
    return yOffset
end

-- ====================================================================
-- 显示货币列表
-- ====================================================================
function MF:DisplayCurrencies(currencies, yOffset)
    if not self.elements.content or not currencies or #currencies == 0 then
        return yOffset
    end
    
    local db = CopperFeverDB
    local settings = db and db.settings and db.settings.display or CF.DEFAULTS.display
    
    -- 货币标题
    local header = self.elements.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    header:SetPoint("TOPLEFT", self.elements.content, "TOPLEFT", 5, -yOffset)
    header:SetText(CF:L("CURRENCY"))
    header:SetTextColor(1, 0.82, 0)
    yOffset = yOffset + 20
    
    -- 显示每个货币
    for _, currency in ipairs(currencies) do
        local row = self:CreateCurrencyRow(currency, yOffset)
        if row then
            table.insert(self.contentRows, row)
            yOffset = yOffset + (settings.iconSize or 24) + (settings.spacing or 5)
        end
    end
    
    yOffset = yOffset + 10 -- 添加间距
    
    return yOffset
end

-- ====================================================================
-- 创建货币行
-- ====================================================================
function MF:CreateCurrencyRow(currency, yOffset)
    if not self.elements.content or not currency then
        return nil
    end
    
    local db = CopperFeverDB
    local settings = db and db.settings and db.settings.display or CF.DEFAULTS.display
    
    local row = CreateFrame("Frame", nil, self.elements.content)
    row:SetPoint("TOPLEFT", self.elements.content, "TOPLEFT", 5, -yOffset)
    row:SetSize(self.elements.content:GetWidth() - 10, settings.iconSize or 24)
    
    -- 图标
    local iconOffset = 0
    if settings.showIcons and currency.icon then
        local icon = row:CreateTexture(nil, "ARTWORK")
        icon:SetPoint("LEFT", row, "LEFT", 0, 0)
        icon:SetSize(settings.iconSize or 24, settings.iconSize or 24)
        icon:SetTexture(currency.icon)
        iconOffset = (settings.iconSize or 24) + 5
    end
    
    -- 名称
    local name = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    name:SetPoint("LEFT", row, "LEFT", iconOffset, 0)
    name:SetText(currency.name or CF:L("UNKNOWN"))
    name:SetFont(name:GetFont(), settings.fontSize or 12)
    name:SetJustifyH("LEFT")
    name:SetWidth(row:GetWidth() - iconOffset - 60)
    name:SetWordWrap(false)
    
    -- 数量
    local amount = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    amount:SetPoint("RIGHT", row, "RIGHT", 0, 0)
    amount:SetText(CF:FormatLocalizedNumber(currency.amount or 0))
    amount:SetFont(amount:GetFont(), settings.fontSize or 12)
    amount:SetJustifyH("RIGHT")
    
    -- 如果达到上限，显示为红色
    if currency.maxAmount and currency.maxAmount > 0 and 
       currency.amount >= currency.maxAmount then
        amount:SetTextColor(1, 0.3, 0.3)
    else
        amount:SetTextColor(1, 1, 1)
    end
    
    -- 工具提示
    if settings.showTooltips then
        row:EnableMouse(true)
        row:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(currency.name or CF:L("UNKNOWN"), 1, 1, 1)
            GameTooltip:AddLine(" ")
            GameTooltip:AddDoubleLine(CF:L("TOOLTIP_CURRENCY_AMOUNT"), 
                CF:FormatLocalizedNumber(currency.amount or 0), 1, 1, 1, 1, 1, 1)
            
            if currency.maxAmount and currency.maxAmount > 0 then
                GameTooltip:AddDoubleLine(CF:L("TOOLTIP_CURRENCY_MAX"), 
                    CF:FormatLocalizedNumber(currency.maxAmount), 1, 1, 1, 1, 1, 1)
            end
            
            if currency.weeklyAmount and currency.weeklyMax and currency.weeklyMax > 0 then
                GameTooltip:AddDoubleLine(CF:L("WEEKLY"), 
                    string.format("%s / %s", 
                        CF:FormatLocalizedNumber(currency.weeklyAmount), 
                        CF:FormatLocalizedNumber(currency.weeklyMax)), 
                    1, 1, 1, 1, 1, 1)
            end
            
            if currency.type then
                local typeName = CF:GetCurrencyTypeLocalizedName(currency.type)
                GameTooltip:AddDoubleLine(CF:L("TOOLTIP_CURRENCY_TYPE"), 
                    typeName, 1, 1, 1, 0.7, 0.7, 0.7)
            end
            
            GameTooltip:Show()
        end)
        
        row:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)
        
        -- 点击事件
        row:SetScript("OnMouseUp", function(self, button)
            if button == "LeftButton" then
                -- 这里可以添加点击后的操作
                CF:LogInfo("点击货币: %s", currency.name)
            end
        end)
    end
    
    return row
end

-- ====================================================================
-- 显示声望列表
-- ====================================================================
function MF:DisplayReputations(reputations, yOffset)
    if not self.elements.content or not reputations or #reputations == 0 then
        return yOffset
    end
    
    local db = CopperFeverDB
    local settings = db and db.settings and db.settings.display or CF.DEFAULTS.display
    
    -- 声望标题
    local header = self.elements.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    header:SetPoint("TOPLEFT", self.elements.content, "TOPLEFT", 5, -yOffset)
    header:SetText(CF:L("REPUTATION"))
    header:SetTextColor(1, 0.82, 0)
    yOffset = yOffset + 20
    
    -- 显示每个声望
    for _, reputation in ipairs(reputations) do
        local row = self:CreateReputationRow(reputation, yOffset)
        if row then
            table.insert(self.contentRows, row)
            yOffset = yOffset + (settings.iconSize or 24) + 10 + (settings.spacing or 5)
        end
    end
    
    yOffset = yOffset + 10 -- 添加间距
    
    return yOffset
end

-- ====================================================================
-- 创建声望行
-- ====================================================================
function MF:CreateReputationRow(reputation, yOffset)
    if not self.elements.content or not reputation then
        return nil
    end
    
    local db = CopperFeverDB
    local settings = db and db.settings and db.settings.display or CF.DEFAULTS.display
    
    local row = CreateFrame("Frame", nil, self.elements.content)
    row:SetPoint("TOPLEFT", self.elements.content, "TOPLEFT", 5, -yOffset)
    row:SetSize(self.elements.content:GetWidth() - 10, (settings.iconSize or 24) + 10)
    
    -- 名称
    local name = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    name:SetPoint("TOPLEFT", row, "TOPLEFT", 0, 0)
    name:SetText(reputation.name or CF:L("UNKNOWN"))
    name:SetFont(name:GetFont(), settings.fontSize or 12)
    name:SetJustifyH("LEFT")
    
    -- 进度百分比
    local progress = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    progress:SetPoint("TOPRIGHT", row, "TOPRIGHT", 0, 0)
    progress:SetText(string.format("%.1f%%", reputation.percent or 0))
    progress:SetFont(progress:GetFont(), settings.fontSize or 12)
    progress:SetJustifyH("RIGHT")
    
    -- 进度条
    local progressBar = CreateFrame("StatusBar", nil, row)
    progressBar:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 0)
    progressBar:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
    progressBar:SetHeight(8)
    progressBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    progressBar:SetMinMaxValues(0, 100)
    progressBar:SetValue(reputation.percent or 0)
    
    -- 根据声望等级设置颜色
    local color = self:GetReputationColor(reputation.standing or 4)
    progressBar:SetStatusBarColor(color.r, color.g, color.b)
    
    -- 进度条背景
    local bgTexture = progressBar:CreateTexture(nil, "BACKGROUND")
    bgTexture:SetAllPoints(progressBar)
    bgTexture:SetColorTexture(0.2, 0.2, 0.2, 0.5)
    
    -- 工具提示
    if settings.showTooltips then
        row:EnableMouse(true)
        row:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(reputation.name or CF:L("UNKNOWN"), 1, 1, 1)
            GameTooltip:AddLine(" ")
            
            if CF.DataManager and CF.DataManager.GetReputationStandingName then
                local standingName = CF.DataManager:GetReputationStandingName(reputation.standing)
                GameTooltip:AddDoubleLine(CF:L("TOOLTIP_REPUTATION_STANDING"), 
                    standingName, 1, 1, 1, color.r, color.g, color.b)
            end
            
            GameTooltip:AddDoubleLine(CF:L("CURRENT"), 
                string.format("%d / %d", reputation.current or 0, reputation.max or 0), 
                1, 1, 1, 1, 1, 1)
            
            GameTooltip:AddDoubleLine(CF:L("PROGRESS_PERCENTAGE"), 
                string.format("%.1f%%", reputation.percent or 0), 
                1, 1, 1, 1, 1, 1)
            
            if reputation.faction then
                local factionName = CF:GetFactionLocalizedName(reputation.faction)
                GameTooltip:AddDoubleLine(CF:L("TOOLTIP_REPUTATION_FACTION"), 
                    factionName, 1, 1, 1, 0.7, 0.7, 0.7)
            end
            
            GameTooltip:Show()
        end)
        
        row:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)
    end
    
    return row
end

-- ====================================================================
-- 获取声望颜色
-- ====================================================================
function MF:GetReputationColor(standing)
    -- 1=仇恨, 2=敌对, 3=不友好, 4=中立, 5=友好, 6=尊敬, 7=崇敬, 8=崇拜
    if standing == 1 or standing == 2 then
        return {r = 0.8, g = 0.1, b = 0.1} -- 红色
    elseif standing == 3 then
        return {r = 1.0, g = 0.5, b = 0.0} -- 橙色
    elseif standing == 4 then
        return {r = 1.0, g = 1.0, b = 0.0} -- 黄色
    elseif standing == 5 then
        return {r = 0.0, g = 0.8, b = 0.0} -- 绿色
    elseif standing >= 6 then
        return {r = 0.0, g = 0.6, b = 1.0} -- 蓝色
    end
    return {r = 1.0, g = 1.0, b = 1.0} -- 默认白色
end

-- ====================================================================
-- 清除内容
-- ====================================================================
function MF:ClearContent()
    if not self.elements.content then
        return
    end
    
    -- 清除所有行
    for _, row in ipairs(self.contentRows) do
        if row then
            row:Hide()
            row:SetParent(nil)
        end
    end
    self.contentRows = {}
    
    -- 移除所有子对象
    local children = {self.elements.content:GetChildren()}
    for _, child in ipairs(children) do
        child:Hide()
        child:SetParent(nil)
    end
    
    -- 清除所有纹理
    local regions = {self.elements.content:GetRegions()}
    for _, region in ipairs(regions) do
        if region:GetObjectType() == "Texture" or region:GetObjectType() == "FontString" then
            region:Hide()
            region:SetParent(nil)
        end
    end
end

-- ====================================================================
-- 显示无数据提示
-- ====================================================================
function MF:ShowNoData()
    if not self.elements.content then
        return
    end
    
    self:ClearContent()
    
    local noData = self.elements.content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    noData:SetPoint("CENTER", self.elements.content, "CENTER", 0, 20)
    noData:SetText(CF:L("INFO_ZONE_NO_CURRENCIES"))
    noData:SetTextColor(0.7, 0.7, 0.7)
    
    local hint = self.elements.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    hint:SetPoint("TOP", noData, "BOTTOM", 0, -10)
    hint:SetText(CF:L("INFO_CONFIGURE_ZONE"))
    hint:SetTextColor(0.5, 0.5, 0.5)
end

-- ====================================================================
-- 显示右键菜单
-- ====================================================================
function MF:ShowContextMenu()
    local menu = CreateFrame("Frame", "CopperFeverContextMenu", UIParent, "UIDropDownMenuTemplate")
    
    local menuList = {
        {
            text = CF:L("MENU_TOGGLE_WINDOW"),
            func = function() MF:Toggle() end,
            notCheckable = true,
        },
        {
            text = CF:L("MENU_LOCK_WINDOW"),
            func = function() MF:SetLocked(true) end,
            notCheckable = true,
        },
        {
            text = CF:L("MENU_UNLOCK_WINDOW"),
            func = function() MF:SetLocked(false) end,
            notCheckable = true,
        },
        {
            text = CF:L("MENU_RESET_POSITION"),
            func = function() MF:ResetPosition() end,
            notCheckable = true,
        },
        {
            text = CF:L("MENU_REFRESH_DATA"),
            func = function() 
                if CF.DataManager and CF.DataManager.RefreshData then
                    CF.DataManager:RefreshData()
                end
            end,
            notCheckable = true,
        },
        {
            text = CF:L("MENU_SETTINGS"),
            func = function() 
                if CF.ConfigPanel and CF.ConfigPanel.Open then
                    CF.ConfigPanel:Open()
                end
            end,
            notCheckable = true,
        },
    }
    
    -- 使用新的 UIDropDownMenu API (WoW 11.0+ 兼容)
    local function InitializeMenu(self, level)
        for _, item in ipairs(menuList) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = item.text
            info.func = item.func
            info.notCheckable = item.notCheckable
            UIDropDownMenu_AddButton(info, level)
        end
    end
    
    UIDropDownMenu_Initialize(menu, InitializeMenu, "MENU")
    ToggleDropDownMenu(1, nil, menu, "cursor", 0, 0)
end

-- ====================================================================
-- 保存位置
-- ====================================================================
function MF:SavePosition()
    if not self.frame then
        return
    end
    
    local db = CopperFeverDB
    if not db or not db.settings then
        return
    end
    
    local point, _, relativePoint, x, y = self.frame:GetPoint()
    
    db.settings.mainFrame.point = point
    db.settings.mainFrame.x = x
    db.settings.mainFrame.y = y
    db.settings.mainFrame.width = self.frame:GetWidth()
    db.settings.mainFrame.height = self.frame:GetHeight()
    
    CF:LogInfo("窗口位置已保存")
end

-- ====================================================================
-- 重置位置
-- ====================================================================
function MF:ResetPosition()
    if not self.frame then
        return
    end
    
    local db = CopperFeverDB
    if not db or not db.settings then
        return
    end
    
    local defaults = CF.DEFAULTS.mainFrame
    
    self.frame:ClearAllPoints()
    self.frame:SetPoint(defaults.point, UIParent, defaults.point, defaults.x, defaults.y)
    self.frame:SetSize(defaults.width, defaults.height)
    
    db.settings.mainFrame.point = defaults.point
    db.settings.mainFrame.x = defaults.x
    db.settings.mainFrame.y = defaults.y
    db.settings.mainFrame.width = defaults.width
    db.settings.mainFrame.height = defaults.height
    
    CF:ShowLocalizedMessage("MSG_POSITION_RESET")
    CF:LogInfo("窗口位置已重置")
end

-- ====================================================================
-- 显示/隐藏
-- ====================================================================
function MF:Show()
    if not self.frame then
        return
    end
    
    self.frame:Show()
    
    local db = CopperFeverDB
    if db and db.settings and db.settings.mainFrame then
        db.settings.mainFrame.shown = true
    end
    
    self:Update()
end

function MF:Hide()
    if not self.frame then
        return
    end
    
    self.frame:Hide()
    
    local db = CopperFeverDB
    if db and db.settings and db.settings.mainFrame then
        db.settings.mainFrame.shown = false
    end
end

function MF:Toggle()
    if not self.frame then
        return
    end
    
    if self.frame:IsShown() then
        self:Hide()
    else
        self:Show()
    end
end

function MF:IsShown()
    return self.frame and self.frame:IsShown()
end

-- ====================================================================
-- 设置锁定状态
-- ====================================================================
function MF:SetLocked(locked)
    if not self.frame then
        return
    end
    
    local db = CopperFeverDB
    if not db or not db.settings then
        return
    end
    
    db.settings.mainFrame.locked = locked
    self.frame:SetMovable(not locked)
    
    if locked then
        CF:LogInfo("窗口已锁定")
    else
        CF:LogInfo("窗口已解锁")
    end
end

-- ====================================================================
-- 刷新
-- ====================================================================
function MF:Refresh()
    self:Update()
end

-- ====================================================================
-- 初始化主窗口
-- ====================================================================
function MF:Initialize()
    if self.initialized then
        CF:LogWarning("MainFrame 已经初始化过了")
        return
    end
    
    CF:LogInfo("初始化主窗口...")
    
    -- 创建窗口
    self:CreateFrame()
    
    if not self.frame then
        CF:LogError("主窗口创建失败")
        return
    end
    
    -- 注册事件
    CF:RegisterEvent("DATA_UPDATED", function()
        if MF.frame and MF.frame:IsShown() then
            MF:Update()
        end
    end)
    
    CF:RegisterEvent("ZONE_CHANGED", function()
        if MF.frame and MF.frame:IsShown() then
            MF:Update()
        end
    end)
    
    CF:RegisterEvent("CURRENCY_UPDATED", function()
        if MF.frame and MF.frame:IsShown() then
            MF:Update()
        end
    end)
    
    CF:RegisterEvent("REPUTATION_UPDATED", function()
        if MF.frame and MF.frame:IsShown() then
            MF:Update()
        end
    end)
    
    self.initialized = true
    CF:LogInfo("主窗口初始化完成")
end

-- ====================================================================
-- 清理函数
-- ====================================================================
function MF:Cleanup()
    CF:LogInfo("清理主窗口...")
    
    if self.frame then
        self:SavePosition()
        self.frame:Hide()
    end
    
    self:ClearContent()
end

-- ====================================================================
-- 结束标记
-- ====================================================================