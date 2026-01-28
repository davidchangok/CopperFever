-- ====================================================================
-- Copper Fever - UI\MainFrame.lua
-- 主显示窗口
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever

-- ====================================================================
-- 主窗口初始化
-- ====================================================================
CF.MainFrame = CF.MainFrame or {}
local MF = CF.MainFrame

-- 窗口引用
MF.frame = nil
MF.titleBar = nil
MF.contentFrame = nil
MF.currencyFrame = nil
MF.reputationFrame = nil

-- 显示项目列表
MF.currencyItems = {}
MF.reputationItems = {}

-- 更新状态
MF.isUpdating = false
MF.currentMapID = nil

-- ====================================================================
-- 创建主窗口
-- ====================================================================
function MF:Create()
    if self.frame then
        return self.frame
    end
    
    CF:LogInfo("创建主窗口...")
    
    -- 创建主框架
    local frame = CreateFrame("Frame", "CopperFeverMainFrame", UIParent, "BackdropTemplate")
    self.frame = frame
    
    -- 设置框架属性
    frame:SetSize(CF.DEFAULTS.mainFrame.width, CF.DEFAULTS.mainFrame.height)
    frame:SetPoint(CF.DEFAULTS.mainFrame.point, UIParent, CF.DEFAULTS.mainFrame.point, 
                   CF.DEFAULTS.mainFrame.x, CF.DEFAULTS.mainFrame.y)
    frame:SetFrameStrata(CF.FRAME_STRATA.MAIN)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    
    -- 设置背景
    local bgColor = CF.DEFAULTS.mainFrame.backgroundColor
    local borderColor = CF.DEFAULTS.mainFrame.borderColor
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    frame:SetBackdropColor(bgColor.r, bgColor.g, bgColor.b, bgColor.a)
    frame:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
    
    -- 设置透明度
    frame:SetAlpha(CF.DEFAULTS.mainFrame.alpha)
    
    -- 拖动脚本
    frame:SetScript("OnDragStart", function(self)
        if not MF:IsLocked() then
            self:StartMoving()
        end
    end)
    
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        MF:SavePosition()
    end)
    
    -- 创建标题栏
    self:CreateTitleBar(frame)
    
    -- 创建内容框架
    self:CreateContentFrame(frame)
    
    -- 创建货币显示区域
    self:CreateCurrencyFrame(self.contentFrame)
    
    -- 创建声望显示区域
    self:CreateReputationFrame(self.contentFrame)
    
    -- 初始化显示
    self:UpdateLayout()
    
    -- 从保存的配置加载位置
    self:LoadPosition()
    
    CF:LogInfo("主窗口创建完成")
    
    return frame
end

-- ====================================================================
-- 创建标题栏
-- ====================================================================
function MF:CreateTitleBar(parent)
    local titleBar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    self.titleBar = titleBar
    
    titleBar:SetPoint("TOPLEFT", parent, "TOPLEFT", 8, -8)
    titleBar:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -8, -8)
    titleBar:SetHeight(30)
    
    -- 标题文本
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", titleBar, "LEFT", 5, 0)
    title:SetText(CF:Colorize(CF.L["MAIN_FRAME_TITLE"], CF.COLORS.GOLD))
    titleBar.title = title
    
    -- 关闭按钮
    local closeBtn = CreateFrame("Button", nil, titleBar, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", titleBar, "TOPRIGHT", 5, 5)
    closeBtn:SetSize(20, 20)
    closeBtn:SetScript("OnClick", function()
        MF:Hide()
    end)
    titleBar.closeBtn = closeBtn
    
    -- 锁定按钮
    local lockBtn = CreateFrame("Button", nil, titleBar)
    lockBtn:SetSize(20, 20)
    lockBtn:SetPoint("RIGHT", closeBtn, "LEFT", -5, 0)
    lockBtn:SetNormalTexture("Interface\\AddOns\\CopperFever\\Textures\\LockIcon")
    lockBtn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    lockBtn:SetScript("OnClick", function()
        MF:ToggleLock()
    end)
    lockBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(CF.L["TOOLTIP_LOCK_WINDOW"])
        GameTooltip:Show()
    end)
    lockBtn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    titleBar.lockBtn = lockBtn
    
    -- 刷新按钮
    local refreshBtn = CreateFrame("Button", nil, titleBar)
    refreshBtn:SetSize(20, 20)
    refreshBtn:SetPoint("RIGHT", lockBtn, "LEFT", -5, 0)
    refreshBtn:SetNormalTexture("Interface\\AddOns\\CopperFever\\Textures\\RefreshIcon")
    refreshBtn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    refreshBtn:SetScript("OnClick", function()
        MF:Refresh()
    end)
    refreshBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(CF.L["BUTTON_REFRESH"])
        GameTooltip:Show()
    end)
    refreshBtn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    titleBar.refreshBtn = refreshBtn
end

-- ====================================================================
-- 创建内容框架
-- ====================================================================
function MF:CreateContentFrame(parent)
    local contentFrame = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate")
    self.contentFrame = contentFrame
    
    contentFrame:SetPoint("TOPLEFT", self.titleBar, "BOTTOMLEFT", 0, -5)
    contentFrame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -28, 8)
    
    -- 创建滚动子框架
    local scrollChild = CreateFrame("Frame", nil, contentFrame)
    contentFrame:SetScrollChild(scrollChild)
    scrollChild:SetSize(contentFrame:GetWidth(), 1)
    
    contentFrame.scrollChild = scrollChild
end

-- ====================================================================
-- 创建货币显示区域
-- ====================================================================
function MF:CreateCurrencyFrame(parent)
    local currencyFrame = CreateFrame("Frame", nil, parent.scrollChild)
    self.currencyFrame = currencyFrame
    
    currencyFrame:SetPoint("TOPLEFT", parent.scrollChild, "TOPLEFT", 5, -5)
    currencyFrame:SetPoint("TOPRIGHT", parent.scrollChild, "TOPRIGHT", -5, -5)
    currencyFrame:SetHeight(1)
    
    -- 标题
    local title = currencyFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", currencyFrame, "TOPLEFT", 0, 0)
    title:SetText(CF:Colorize(CF.L["CURRENCY"], CF.COLORS.YELLOW))
    currencyFrame.title = title
end

-- ====================================================================
-- 创建声望显示区域
-- ====================================================================
function MF:CreateReputationFrame(parent)
    local reputationFrame = CreateFrame("Frame", nil, parent.scrollChild)
    self.reputationFrame = reputationFrame
    
    reputationFrame:SetPoint("TOPLEFT", self.currencyFrame, "BOTTOMLEFT", 0, -10)
    reputationFrame:SetPoint("TOPRIGHT", self.currencyFrame, "BOTTOMRIGHT", 0, -10)
    reputationFrame:SetHeight(1)
    
    -- 标题
    local title = reputationFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", reputationFrame, "TOPLEFT", 0, 0)
    title:SetText(CF:Colorize(CF.L["REPUTATION"], CF.COLORS.YELLOW))
    reputationFrame.title = title
end

-- ====================================================================
-- 创建货币显示项
-- ====================================================================
function MF:CreateCurrencyItem(parent, index)
    local item = CreateFrame("Frame", nil, parent)
    item:SetHeight(30)
    
    -- 图标
    local icon = item:CreateTexture(nil, "ARTWORK")
    icon:SetSize(24, 24)
    icon:SetPoint("LEFT", item, "LEFT", 0, 0)
    item.icon = icon
    
    -- 名称
    local name = item:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    name:SetPoint("LEFT", icon, "RIGHT", 5, 0)
    name:SetJustifyH("LEFT")
    item.name = name
    
    -- 数量
    local amount = item:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    amount:SetPoint("RIGHT", item, "RIGHT", 0, 0)
    amount:SetJustifyH("RIGHT")
    item.amount = amount
    
    -- 鼠标提示
    item:EnableMouse(true)
    item:SetScript("OnEnter", function(self)
        if self.currencyData then
            MF:ShowCurrencyTooltip(self, self.currencyData)
        end
    end)
    item:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    return item
end

-- ====================================================================
-- 创建声望显示项
-- ====================================================================
function MF:CreateReputationItem(parent, index)
    local item = CreateFrame("Frame", nil, parent)
    item:SetHeight(40)
    
    -- 名称
    local name = item:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    name:SetPoint("TOPLEFT", item, "TOPLEFT", 0, 0)
    name:SetJustifyH("LEFT")
    item.name = name
    
    -- 等级
    local standing = item:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    standing:SetPoint("TOPRIGHT", item, "TOPRIGHT", 0, 0)
    standing:SetJustifyH("RIGHT")
    item.standing = standing
    
    -- 进度条
    local bar = CreateFrame("StatusBar", nil, item)
    bar:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -3)
    bar:SetPoint("TOPRIGHT", standing, "BOTTOMRIGHT", 0, -3)
    bar:SetHeight(12)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar:SetMinMaxValues(0, 100)
    bar:SetValue(0)
    item.bar = bar
    
    -- 进度条背景
    local barBg = bar:CreateTexture(nil, "BACKGROUND")
    barBg:SetAllPoints(bar)
    barBg:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
    barBg:SetVertexColor(0.3, 0.3, 0.3, 0.5)
    bar.bg = barBg
    
    -- 进度文本
    local barText = bar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    barText:SetPoint("CENTER", bar, "CENTER", 0, 0)
    bar.text = barText
    
    -- 鼠标提示
    item:EnableMouse(true)
    item:SetScript("OnEnter", function(self)
        if self.reputationData then
            MF:ShowReputationTooltip(self, self.reputationData)
        end
    end)
    item:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    return item
end

-- ====================================================================
-- 更新显示
-- ====================================================================
function MF:Update()
    if self.isUpdating then
        return
    end
    
    self.isUpdating = true
    
    -- 获取当前区域数据
    local zoneData = CF.DataManager:GetCurrentZoneData()
    
    if not zoneData then
        self:ShowNoData()
        self.isUpdating = false
        return
    end
    
    self.currentMapID = zoneData.mapID
    
    -- 更新标题显示当前区域
    if self.titleBar and self.titleBar.title then
        local titleText = CF:Colorize(CF.L["MAIN_FRAME_TITLE"], CF.COLORS.GOLD) .. 
                         " - " .. CF:Colorize(zoneData.mapName, CF.COLORS.COMMON)
        self.titleBar.title:SetText(titleText)
    end
    
    -- 更新货币显示
    self:UpdateCurrencyDisplay(zoneData.currencies)
    
    -- 更新声望显示
    self:UpdateReputationDisplay(zoneData.reputations)
    
    -- 更新布局
    self:UpdateLayout()
    
    self.isUpdating = false
end

-- ====================================================================
-- 更新货币显示
-- ====================================================================
function MF:UpdateCurrencyDisplay(currencies)
    if not currencies or #currencies == 0 then
        -- 隐藏所有货币项
        for _, item in ipairs(self.currencyItems) do
            item:Hide()
        end
        
        -- 显示"无数据"消息
        if not self.currencyFrame.noDataText then
            local text = self.currencyFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            text:SetPoint("TOPLEFT", self.currencyFrame.title, "BOTTOMLEFT", 0, -5)
            text:SetText(CF:Colorize(CF.L["INFO_ZONE_NO_CURRENCIES"], CF.COLORS.GRAY))
            self.currencyFrame.noDataText = text
        end
        self.currencyFrame.noDataText:Show()
        
        return
    end
    
    -- 隐藏"无数据"消息
    if self.currencyFrame.noDataText then
        self.currencyFrame.noDataText:Hide()
    end
    
    -- 确保有足够的显示项
    while #self.currencyItems < #currencies do
        local item = self:CreateCurrencyItem(self.currencyFrame, #self.currencyItems + 1)
        table.insert(self.currencyItems, item)
    end
    
    -- 获取布局设置
    local db = CopperFeverDB
    local settings = db and db.settings or CF.DEFAULTS
    local iconSize = settings.display.iconSize or CF.DEFAULTS.display.iconSize
    local spacing = settings.display.spacing or CF.DEFAULTS.display.spacing
    local showIcons = settings.display.showIcons ~= false
    
    -- 更新每个货币项
    for i, currency in ipairs(currencies) do
        local item = self.currencyItems[i]
        
        -- 设置图标
        if showIcons and currency.icon then
            item.icon:SetTexture(currency.icon)
            item.icon:SetSize(iconSize, iconSize)
            item.icon:Show()
        else
            item.icon:Hide()
        end
        
        -- 设置名称
        local nameColor = CF:GetQualityColor(2)  -- 默认绿色
        item.name:SetText(CF:Colorize(currency.name, nameColor))
        
        -- 设置数量
        local amountText = CF:FormatLocalizedNumber(currency.amount)
        if currency.maxAmount and currency.maxAmount > 0 then
            amountText = amountText .. " / " .. CF:FormatLocalizedNumber(currency.maxAmount)
        end
        item.amount:SetText(CF:Colorize(amountText, CF.COLORS.COMMON))
        
        -- 保存数据用于提示
        item.currencyData = currency
        
        -- 定位
        if i == 1 then
            item:SetPoint("TOPLEFT", self.currencyFrame.title, "BOTTOMLEFT", 0, -5)
        else
            item:SetPoint("TOPLEFT", self.currencyItems[i-1], "BOTTOMLEFT", 0, -spacing)
        end
        item:SetPoint("TOPRIGHT", self.currencyFrame, "TOPRIGHT", 0, 0)
        
        item:Show()
    end
    
    -- 隐藏未使用的项
    for i = #currencies + 1, #self.currencyItems do
        self.currencyItems[i]:Hide()
    end
end

-- ====================================================================
-- 更新声望显示
-- ====================================================================
function MF:UpdateReputationDisplay(reputations)
    if not reputations or #reputations == 0 then
        -- 隐藏所有声望项
        for _, item in ipairs(self.reputationItems) do
            item:Hide()
        end
        return
    end
    
    -- 确保有足够的显示项
    while #self.reputationItems < #reputations do
        local item = self:CreateReputationItem(self.reputationFrame, #self.reputationItems + 1)
        table.insert(self.reputationItems, item)
    end
    
    -- 获取布局设置
    local db = CopperFeverDB
    local settings = db and db.settings or CF.DEFAULTS
    local spacing = settings.display.spacing or CF.DEFAULTS.display.spacing
    
    -- 更新每个声望项
    for i, reputation in ipairs(reputations) do
        local item = self.reputationItems[i]
        
        -- 设置名称
        local nameColor = CF:GetQualityColor(2)  -- 默认绿色
        item.name:SetText(CF:Colorize(reputation.name, nameColor))
        
        -- 设置等级
        local standingName = CF.DataManager:GetReputationStandingName(reputation.standing)
        local standingColor = CF:GetQualityColor(reputation.standing - 1)
        item.standing:SetText(CF:Colorize(standingName, standingColor))
        
        -- 设置进度条
        item.bar:SetMinMaxValues(0, reputation.max)
        item.bar:SetValue(reputation.current)
        item.bar:SetStatusBarColor(standingColor.r, standingColor.g, standingColor.b)
        
        -- 设置进度文本
        local percentText = string.format("%.1f%%", reputation.percent)
        item.bar.text:SetText(percentText)
        
        -- 保存数据用于提示
        item.reputationData = reputation
        
        -- 定位
        if i == 1 then
            item:SetPoint("TOPLEFT", self.reputationFrame.title, "BOTTOMLEFT", 0, -5)
        else
            item:SetPoint("TOPLEFT", self.reputationItems[i-1], "BOTTOMLEFT", 0, -spacing)
        end
        item:SetPoint("TOPRIGHT", self.reputationFrame, "TOPRIGHT", 0, 0)
        
        item:Show()
    end
    
    -- 隐藏未使用的项
    for i = #reputations + 1, #self.reputationItems do
        self.reputationItems[i]:Hide()
    end
end

-- ====================================================================
-- 更新布局
-- ====================================================================
function MF:UpdateLayout()
    if not self.frame then return end
    
    -- 计算货币区域高度
    local currencyHeight = 20  -- 标题高度
    for i, item in ipairs(self.currencyItems) do
        if item:IsShown() then
            currencyHeight = currencyHeight + item:GetHeight() + 5
        end
    end
    if self.currencyFrame.noDataText and self.currencyFrame.noDataText:IsShown() then
        currencyHeight = currencyHeight + 20
    end
    self.currencyFrame:SetHeight(currencyHeight)
    
    -- 计算声望区域高度
    local reputationHeight = 20  -- 标题高度
    for i, item in ipairs(self.reputationItems) do
        if item:IsShown() then
            reputationHeight = reputationHeight + item:GetHeight() + 5
        end
    end
    self.reputationFrame:SetHeight(reputationHeight)
    
    -- 更新滚动子框架高度
    local totalHeight = currencyHeight + reputationHeight + 20
    self.contentFrame.scrollChild:SetHeight(math.max(totalHeight, self.contentFrame:GetHeight()))
end

-- ====================================================================
-- 显示货币提示信息
-- ====================================================================
function MF:ShowCurrencyTooltip(frame, currencyData)
    GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
    GameTooltip:SetText(currencyData.name, 1, 1, 1)
    
    -- 当前数量
    CF:AddLocalizedTooltipLine(GameTooltip, "CURRENT", CF.COLORS.COMMON)
    GameTooltip:AddDoubleLine(CF.L["CURRENT"], CF:FormatLocalizedNumber(currencyData.amount), 
                              1, 1, 1, 1, 1, 1)
    
    -- 最大数量
    if currencyData.maxAmount and currencyData.maxAmount > 0 then
        GameTooltip:AddDoubleLine(CF.L["MAX"], CF:FormatLocalizedNumber(currencyData.maxAmount), 
                                  1, 1, 1, 1, 1, 1)
    end
    
    -- 本周获得
    if currencyData.weeklyAmount and currencyData.weeklyAmount > 0 then
        GameTooltip:AddDoubleLine(CF.L["EARNED_THIS_WEEK"], CF:FormatLocalizedNumber(currencyData.weeklyAmount), 
                                  1, 1, 1, 1, 1, 1)
    end
    
    GameTooltip:Show()
end

-- ====================================================================
-- 显示声望提示信息
-- ====================================================================
function MF:ShowReputationTooltip(frame, reputationData)
    GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
    GameTooltip:SetText(reputationData.name, 1, 1, 1)
    
    -- 当前等级
    local standingName = CF.DataManager:GetReputationStandingName(reputationData.standing)
    GameTooltip:AddDoubleLine(CF.L["REPUTATION_LEVEL"], standingName, 1, 1, 1, 1, 1, 1)
    
    -- 进度
    local progressText = string.format("%d / %d (%.1f%%)", 
                                       reputationData.current, 
                                       reputationData.max, 
                                       reputationData.percent)
    GameTooltip:AddDoubleLine(CF.L["CURRENT"], progressText, 1, 1, 1, 1, 1, 1)
    
    GameTooltip:Show()
end

-- ====================================================================
-- 显示"无数据"消息
-- ====================================================================
function MF:ShowNoData()
    -- 清空显示
    for _, item in ipairs(self.currencyItems) do
        item:Hide()
    end
    for _, item in ipairs(self.reputationItems) do
        item:Hide()
    end
    
    -- 显示消息
    if not self.noDataText then
        local text = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("CENTER", self.frame, "CENTER", 0, 0)
        self.noDataText = text
    end
    
    self.noDataText:SetText(CF:Colorize(CF.L["ERROR_NO_DATA_AVAILABLE"], CF.COLORS.GRAY))
    self.noDataText:Show()
end

-- ====================================================================
-- 窗口控制函数
-- ====================================================================

function MF:Show()
    if not self.frame then
        self:Create()
    end
    
    self.frame:Show()
    self:Update()
end

function MF:Hide()
    if self.frame then
        self.frame:Hide()
    end
end

function MF:Toggle()
    if self.frame and self.frame:IsShown() then
        self:Hide()
    else
        self:Show()
    end
end

function MF:IsShown()
    return self.frame and self.frame:IsShown()
end

function MF:Refresh()
    CF.DataManager:RefreshData()
    self:Update()
end

-- ====================================================================
-- 锁定/解锁
-- ====================================================================

function MF:IsLocked()
    local db = CopperFeverDB
    return db and db.settings and db.settings.mainFrame and db.settings.mainFrame.locked or false
end

function MF:SetLocked(locked)
    local db = CopperFeverDB
    if db and db.settings and db.settings.mainFrame then
        db.settings.mainFrame.locked = locked
    end
    
    -- 更新锁定图标
    if self.titleBar and self.titleBar.lockBtn then
        if locked then
            self.titleBar.lockBtn:SetNormalTexture("Interface\\AddOns\\CopperFever\\Textures\\LockedIcon")
        else
            self.titleBar.lockBtn:SetNormalTexture("Interface\\AddOns\\CopperFever\\Textures\\UnlockedIcon")
        end
    end
end

function MF:ToggleLock()
    self:SetLocked(not self:IsLocked())
end

-- ====================================================================
-- 位置保存和加载
-- ====================================================================

function MF:SavePosition()
    if not self.frame then return end
    
    local db = CopperFeverDB
    if not db or not db.settings or not db.settings.mainFrame then return end
    
    local point, _, relativePoint, x, y = self.frame:GetPoint()
    
    db.settings.mainFrame.point = point
    db.settings.mainFrame.x = x
    db.settings.mainFrame.y = y
end

function MF:LoadPosition()
    if not self.frame then return end
    
    local db = CopperFeverDB
    if not db or not db.settings or not db.settings.mainFrame then return end
    
    local settings = db.settings.mainFrame
    
    if settings.point and settings.x and settings.y then
        self.frame:ClearAllPoints()
        self.frame:SetPoint(settings.point, UIParent, settings.point, settings.x, settings.y)
    end
end

function MF:ResetPosition()
    if not self.frame then return end
    
    self.frame:ClearAllPoints()
    self.frame:SetPoint(CF.DEFAULTS.mainFrame.point, UIParent, CF.DEFAULTS.mainFrame.point,
                       CF.DEFAULTS.mainFrame.x, CF.DEFAULTS.mainFrame.y)
    
    self:SavePosition()
    
    CF:ShowLocalizedSuccess("MSG_POSITION_RESET")
end

-- ====================================================================
-- 应用设置
-- ====================================================================

function MF:ApplySettings()
    if not self.frame then return end
    
    local db = CopperFeverDB
    if not db or not db.settings then return end
    
    local settings = db.settings.mainFrame or CF.DEFAULTS.mainFrame
    
    -- 应用大小
    if settings.width and settings.height then
        self.frame:SetSize(settings.width, settings.height)
    end
    
    -- 应用缩放
    if settings.scale then
        self.frame:SetScale(settings.scale)
    end
    
    -- 应用透明度
    if settings.alpha then
        self.frame:SetAlpha(settings.alpha)
    end
    
    -- 应用背景颜色
    if settings.backgroundColor then
        local bg = settings.backgroundColor
        self.frame:SetBackdropColor(bg.r, bg.g, bg.b, bg.a)
    end
    
    -- 应用边框颜色
    if settings.borderColor then
        local border = settings.borderColor
        self.frame:SetBackdropBorderColor(border.r, border.g, border.b, border.a)
    end
    
    -- 应用锁定状态
    self:SetLocked(settings.locked or false)
    
    -- 刷新显示
    self:Update()
end

-- ====================================================================
-- 初始化
-- ====================================================================
function MF:Initialize()
    CF:LogInfo("初始化主窗口...")
    
    -- 创建窗口（不显示）
    self:Create()
    
    -- 应用保存的设置
    self:ApplySettings()
    
    -- 根据配置决定是否显示
    local db = CopperFeverDB
    if db and db.settings and db.settings.mainFrame and db.settings.mainFrame.shown then
        self:Show()
    else
        self:Hide()
    end
    
    CF:LogInfo("主窗口初始化完成")
end