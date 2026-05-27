local _8y9Lib = {}
_8y9Lib.__index = _8y9Lib
local Players           = game:GetService("Players")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local CoreGui           = game:GetService("CoreGui")
local TextService       = game:GetService("TextService")
local LocalPlayer = Players.LocalPlayer
local Mouse       = LocalPlayer:GetMouse()
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local Theme = {
	Background   = Color3.fromRGB(13,  13,  13),
	Surface      = Color3.fromRGB(20,  20,  20),
	SurfaceHover = Color3.fromRGB(28,  28,  28),
	Border       = Color3.fromRGB(40,  40,  40),
	Accent       = Color3.fromRGB(255, 255, 255),
	AccentDim    = Color3.fromRGB(160, 160, 160),
	Text         = Color3.fromRGB(255, 255, 255),
	TextDim      = Color3.fromRGB(140, 140, 140),
	TextMuted    = Color3.fromRGB(80,  80,  80),
	Toggle_ON    = Color3.fromRGB(255, 255, 255),
	Toggle_OFF   = Color3.fromRGB(50,  50,  50),
	Slider       = Color3.fromRGB(255, 255, 255),
	SliderBG     = Color3.fromRGB(40,  40,  40),
	NavSelected  = Color3.fromRGB(30,  30,  30),
	NavHover     = Color3.fromRGB(22,  22,  22),
	CardBG       = Color3.fromRGB(17,  17,  17),
	CardBorder   = Color3.fromRGB(35,  35,  35),
	ButtonBG     = Color3.fromRGB(28,  28,  28),
	ButtonBorder = Color3.fromRGB(50,  50,  50),
	InputBG      = Color3.fromRGB(25,  25,  25),
	InputBorder  = Color3.fromRGB(55,  55,  55),
	DropdownBG   = Color3.fromRGB(22,  22,  22),
	Shadow       = Color3.fromRGB(0,   0,   0),
}
local _vp       = workspace.CurrentCamera.ViewportSize
local _sw, _sh  = _vp.X, _vp.Y
local _mw = math.min(math.floor(_sw * 0.88), 460)
local _mh = math.min(math.floor(_sh * 0.82), 620)
local Sizes = IsMobile and {
	WindowW     = _mw,       WindowH   = _mh,
	NavW        = 130,       NavH      = 40,
	CardPad     = 10,        CardGap   = 8,
	FontTitle   = 12,        FontBody  = 10,
	FontNav     = 10,        FontLabel = 9,
	ToggleW     = 34,        ToggleH   = 20,
	SliderH     = 4,         ThumbR    = 7,
	RowH        = 32,        IconSize  = 14,
	CornerR     = 8,         CardR     = 9,
	ButtonH     = 32,        InputH    = 28,
	DropH       = 28,        BotBarH   = 46,
	LogoSize    = 24,
} or {
	WindowW     = 1000,  WindowH   = 600,
	NavW        = 190,   NavH      = 42,
	CardPad     = 18,    CardGap   = 12,
	FontTitle   = 14,    FontBody  = 12,
	FontNav     = 12,    FontLabel = 11,
	ToggleW     = 42,    ToggleH   = 24,
	SliderH     = 4,     ThumbR    = 9,
	RowH        = 36,    IconSize  = 17,
	CornerR     = 8,     CardR     = 10,
	ButtonH     = 36,    InputH    = 32,
	DropH       = 32,    BotBarH   = 54,
	LogoSize    = 32,
}
local function Tween(obj, props, t, style, dir)
	TweenService:Create(obj,
		TweenInfo.new(t or 0.18, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out),
		props
	):Play()
end
local function Corner(parent, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or Sizes.CornerR)
	c.Parent = parent
	return c
end
local function Stroke(parent, color, thickness)
	local s = Instance.new("UIStroke")
	s.Color = color or Theme.Border
	s.Thickness = thickness or 1
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = parent
	return s
end
local function Padding(parent, all, top, bottom, left, right)
	local p = Instance.new("UIPadding")
	if all then
		p.PaddingTop    = UDim.new(0, all)
		p.PaddingBottom = UDim.new(0, all)
		p.PaddingLeft   = UDim.new(0, all)
		p.PaddingRight  = UDim.new(0, all)
	else
		p.PaddingTop    = UDim.new(0, top    or 0)
		p.PaddingBottom = UDim.new(0, bottom or 0)
		p.PaddingLeft   = UDim.new(0, left   or 0)
		p.PaddingRight  = UDim.new(0, right  or 0)
	end
	p.Parent = parent
	return p
end
local function ListLayout(parent, dir, pad, align)
	local l = Instance.new("UIListLayout")
	l.FillDirection = dir or Enum.FillDirection.Vertical
	l.Padding       = UDim.new(0, pad or 6)
	l.HorizontalAlignment = align or Enum.HorizontalAlignment.Left
	l.SortOrder     = Enum.SortOrder.LayoutOrder
	l.Parent        = parent
	return l
end
local function Label(parent, text, size, color, weight, xalign)
	local l = Instance.new("TextLabel")
	l.Text              = text
	l.TextSize          = size  or Sizes.FontBody
	l.TextColor3        = color or Theme.Text
	l.Font              = weight or Enum.Font.GothamBold
	l.TextXAlignment    = xalign or Enum.TextXAlignment.Left
	l.BackgroundTransparency = 1
	l.AutomaticSize     = Enum.AutomaticSize.XY
	l.Parent            = parent
	return l
end
local function Frame(parent, size, pos, color, trans)
	local f = Instance.new("Frame")
	f.Size                   = size or UDim2.new(1,0,0,40)
	f.Position               = pos  or UDim2.new(0,0,0,0)
	f.BackgroundColor3       = color or Theme.Surface
	f.BackgroundTransparency = trans or 0
	f.BorderSizePixel        = 0
	f.Parent                 = parent
	return f
end
local function ImageLabel(parent, id, size, pos)
	local i = Instance.new("ImageLabel")
	i.Image                  = id
	i.Size                   = size or UDim2.new(0,16,0,16)
	i.Position               = pos  or UDim2.new(0,0,0,0)
	i.BackgroundTransparency = 1
	i.Parent                 = parent
	return i
end
local NavIcons = {
	MAIN     = "⌂",
	VISUALS  = "◎",
	AIMBOT   = "◉",
	PLAYER   = "♟",
	WEAPONS  = "⌘",
	MISC     = "⊞",
	WORLD    = "◈",
	CONFIGS  = "☰",
	SETTINGS = "✦",
}
function _8y9Lib.new(config)
	config = config or {}
	local self = setmetatable({}, _8y9Lib)
	self.Tabs       = {}
	self.CurrentTab = nil
	self.Toggled    = true
	self.Callbacks  = {}
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name              = "8y9Lib_" .. tostring(math.random(1e5))
	ScreenGui.ZIndexBehavior    = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn      = false
	ScreenGui.DisplayOrder      = 999
	pcall(function() ScreenGui.Parent = CoreGui end)
	if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
	self.ScreenGui = ScreenGui
	local Window = Frame(ScreenGui,
		UDim2.new(0, Sizes.WindowW, 0, Sizes.WindowH),
		UDim2.new(0.5, 0, 0.5, 0),
		Theme.Background)
	Window.Name             = "8y9Window"
	Window.ClipsDescendants = true
	Window.AnchorPoint      = Vector2.new(0.5, 0.5)
	Corner(Window, 12)
	Stroke(Window, Theme.Border, 1)
	self.Window = Window
	Window.Size                   = UDim2.new(0, Sizes.WindowW, 0, 0)
	Window.BackgroundTransparency = 1
	Tween(Window, {
		Size = UDim2.new(0, Sizes.WindowW, 0, Sizes.WindowH),
		BackgroundTransparency = 0
	}, 0.35, Enum.EasingStyle.Quint)
	if not IsMobile then
		local dragging, dragStart, startPos = false, nil, nil
		Window.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				local mp = input.Position
				if mp.Y - Window.AbsolutePosition.Y < 55 then
					dragging  = true
					dragStart = mp
					startPos  = Window.Position
				end
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				local delta = input.Position - dragStart
				Window.Position = UDim2.new(
					startPos.X.Scale, startPos.X.Offset + delta.X,
					startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
			end
		end)
	end
	local TopBar = Frame(Window,
		UDim2.new(1,0,0,0), UDim2.new(0,0,0,0),
		Theme.Background, 1)
	TopBar.Name           = "TopBar"
	TopBar.ZIndex         = 10
	TopBar.AutomaticSize  = Enum.AutomaticSize.Y
	if not IsMobile then
		local BtnHolder = Frame(TopBar,
			UDim2.new(0,60,0,36),
			UDim2.new(1,-68,0,8),
			Theme.Background, 1)
		BtnHolder.Name = "WinBtns"
		local function WinBtn(pos, color, action)
			local b = Instance.new("TextButton")
			b.Size = UDim2.new(0,22,0,22)
			b.Position = pos
			b.BackgroundColor3 = color
			b.Text = ""
			b.BorderSizePixel = 0
			b.Font = Enum.Font.GothamBold
			b.Parent = BtnHolder
			Corner(b, 11)
			b.MouseButton1Click:Connect(action)
			b.MouseEnter:Connect(function()
				Tween(b, {BackgroundColor3 = color:Lerp(Color3.new(1,1,1), 0.2)}, 0.12)
			end)
			b.MouseLeave:Connect(function()
				Tween(b, {BackgroundColor3 = color}, 0.12)
			end)
			return b
		end
		WinBtn(UDim2.new(0,0,0,0), Color3.fromRGB(60,60,60), function()
			self.Toggled = not self.Toggled
			if self.Toggled then
				Tween(Window, {Size = UDim2.new(0,Sizes.WindowW,0,Sizes.WindowH)}, 0.3, Enum.EasingStyle.Quint)
			else
				Tween(Window, {Size = UDim2.new(0,Sizes.WindowW,0,52)}, 0.3, Enum.EasingStyle.Quint)
			end
		end)
		WinBtn(UDim2.new(0,30,0,0), Color3.fromRGB(60,60,60), function()
			Tween(Window, {Size = UDim2.new(0,Sizes.WindowW,0,0), BackgroundTransparency=1}, 0.25, Enum.EasingStyle.Quint)
			task.delay(0.3, function() ScreenGui:Destroy() end)
		end)
	end
	local NavPanel = Frame(Window,
		UDim2.new(0, Sizes.NavW, 1, 0),
		UDim2.new(0,0,0,0),
		Theme.Surface)
	NavPanel.Name  = "NavPanel"
	NavPanel.ZIndex = 2
	local NavBorder = Frame(NavPanel,
		UDim2.new(0,1,1,0), UDim2.new(1,-1,0,0),
		Theme.Border)
	NavBorder.Name = "NavBorder"
	local LogoArea = Frame(NavPanel,
		UDim2.new(1,0,0,60), UDim2.new(0,0,0,0),
		Theme.Surface, 1)
	LogoArea.Name = "LogoArea"
	Padding(LogoArea, nil, 0, 0, 14, 0)
	local LogoRow = Frame(LogoArea, UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), Theme.Surface, 1)
	LogoRow.Name = "LogoRow"
	ListLayout(LogoRow, Enum.FillDirection.Horizontal, 8)
	local LogoBox = Frame(LogoRow,
		UDim2.new(0, Sizes.LogoSize, 0, Sizes.LogoSize),
		UDim2.new(0,0,0.5,-Sizes.LogoSize/2),
		config.Icon and Theme.Surface or Theme.Accent)
	Corner(LogoBox, 6)
	if config.Icon then
		local IconImg = Instance.new("ImageLabel")
		IconImg.Image                  = config.Icon
		IconImg.Size                   = UDim2.new(1,0,1,0)
		IconImg.BackgroundTransparency = 1
		IconImg.ScaleType              = Enum.ScaleType.Fit
		IconImg.Parent                 = LogoBox
		Corner(IconImg, 6)
	else
		local LogoX = Label(LogoBox, (config.Name or "8y9"):sub(1,1):upper(), Sizes.LogoSize - 8, Theme.Background, Enum.Font.GothamBold, Enum.TextXAlignment.Center)
		LogoX.Size = UDim2.new(1,0,1,0)
		LogoX.TextYAlignment = Enum.TextYAlignment.Center
	end
	local LogoText = Frame(LogoRow, UDim2.new(0,90,0,Sizes.LogoSize), UDim2.new(0,0,0,0), Theme.Surface, 1)
	local LogoName = Label(LogoText, config.Name or "8y9", Sizes.FontTitle + 2, Theme.Text, Enum.Font.GothamBold)
	LogoName.Position = UDim2.new(0,0,0,2)
	local LogoSub  = Label(LogoText, "8y9 Library", Sizes.FontLabel - 1, Theme.TextMuted, Enum.Font.Gotham)
	LogoSub.Position  = UDim2.new(0,0,0, Sizes.FontTitle + 4)
	local NavSep = Frame(NavPanel,
		UDim2.new(1, -28, 0, 1), UDim2.new(0, 14, 0, 62),
		Theme.Border)
	NavSep.Name = "NavSep"
	local NavScroll = Instance.new("ScrollingFrame")
	NavScroll.Name              = "NavScroll"
	NavScroll.Size              = UDim2.new(1,0,1,-70)
	NavScroll.Position          = UDim2.new(0,0,0,70)
	NavScroll.BackgroundTransparency = 1
	NavScroll.BorderSizePixel   = 0
	NavScroll.ScrollBarThickness = 0
	NavScroll.CanvasSize        = UDim2.new(0,0,0,0)
	NavScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	NavScroll.Parent            = NavPanel
	Padding(NavScroll, nil, 4, 4, 8, 8)
	ListLayout(NavScroll, Enum.FillDirection.Vertical, 3)
	self.NavScroll = NavScroll
	self.NavBtns   = {}
	local ContentArea = Frame(Window,
		UDim2.new(1,-Sizes.NavW,1,-Sizes.BotBarH),
		UDim2.new(0,Sizes.NavW,0,0),
		Theme.Background)
	ContentArea.Name            = "ContentArea"
	ContentArea.ClipsDescendants = true
	self.ContentArea = ContentArea
	local ContentHeader = Frame(ContentArea,
		UDim2.new(1,0,0,54),
		UDim2.new(0,0,0,0),
		Theme.Background)
	ContentHeader.Name = "ContentHeader"
	Padding(ContentHeader, nil, 0, 0, Sizes.CardPad, Sizes.CardPad)
	local PageTitle = Label(ContentHeader, "MAIN", Sizes.FontTitle + 2, Theme.Text, Enum.Font.GothamBold)
	PageTitle.Position = UDim2.new(0, Sizes.CardPad, 0, 12)
	self.PageTitle = PageTitle
	local PageSubtitle = Label(ContentHeader, "Main features and quick access", Sizes.FontBody, Theme.TextDim, Enum.Font.Gotham)
	PageSubtitle.Position = UDim2.new(0, Sizes.CardPad, 0, 30)
	self.PageSubtitle = PageSubtitle
	if not IsMobile then
		local SearchBox = Frame(ContentHeader,
			UDim2.new(0, 220, 0, 32),
			UDim2.new(1, -270, 0.5, -16),
			Theme.InputBG)
		Corner(SearchBox, 8)
		Stroke(SearchBox, Theme.InputBorder, 1)
		local SearchIcon = Label(SearchBox, "🔍", Sizes.FontBody, Theme.TextMuted, Enum.Font.Gotham)
		SearchIcon.Position = UDim2.new(0,8,0.5,-8)
		local SearchInput = Instance.new("TextBox")
		SearchInput.Size = UDim2.new(1,-30,1,0)
		SearchInput.Position = UDim2.new(0,26,0,0)
		SearchInput.BackgroundTransparency = 1
		SearchInput.PlaceholderText = "Search features..."
		SearchInput.PlaceholderColor3 = Theme.TextMuted
		SearchInput.TextColor3 = Theme.Text
		SearchInput.Font = Enum.Font.Gotham
		SearchInput.TextSize = Sizes.FontBody
		SearchInput.TextXAlignment = Enum.TextXAlignment.Left
		SearchInput.ClearTextOnFocus = false
		SearchInput.Parent = SearchBox
	end
	local HeaderSep = Frame(ContentArea,
		UDim2.new(1,0,0,1), UDim2.new(0,0,0,54),
		Theme.Border)
	local ContentScroll = Instance.new("ScrollingFrame")
	ContentScroll.Name              = "ContentScroll"
	ContentScroll.Size              = UDim2.new(1,0,1,-54)
	ContentScroll.Position          = UDim2.new(0,0,0,54)
	ContentScroll.BackgroundTransparency = 1
	ContentScroll.BorderSizePixel   = 0
	ContentScroll.ScrollBarThickness = 2
	ContentScroll.ScrollBarImageColor3 = Theme.Border
	ContentScroll.CanvasSize        = UDim2.new(0,0,0,0)
	ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ContentScroll.Parent            = ContentArea
	self.ContentScroll = ContentScroll
	local BotBar = Frame(Window,
		UDim2.new(1,-Sizes.NavW, 0, Sizes.BotBarH),
		UDim2.new(0, Sizes.NavW, 1, -Sizes.BotBarH),
		Theme.Surface)
	BotBar.Name  = "BotBar"
	local BotSep = Frame(BotBar, UDim2.new(1,0,0,1), UDim2.new(0,0,0,0), Theme.Border)
	local BotBtnRow = Frame(BotBar,
		UDim2.new(1,0,1,-1), UDim2.new(0,0,0,1),
		Theme.Surface, 1)
	Padding(BotBtnRow, nil, 0, 0, Sizes.CardPad, Sizes.CardPad)
	ListLayout(BotBtnRow, Enum.FillDirection.Horizontal, 8)
	BotBtnRow.Name = "BotBtnRow"
	self.BotBtnRow = BotBtnRow
	self._FloatGui = nil
	self._FloatBtn = nil
	task.defer(function()
		self:_CreateFloatButton(config)
	end)
	return self
end
local function CreateNavBtn(self, name, icon, onClick)
	local S = Sizes
	local Btn = Instance.new("TextButton")
	Btn.Name               = name
	Btn.Size               = UDim2.new(1,0,0,S.NavH)
	Btn.BackgroundColor3   = Theme.Surface
	Btn.BackgroundTransparency = 1
	Btn.BorderSizePixel    = 0
	Btn.Text               = ""
	Btn.AutoButtonColor    = false
	Btn.Parent             = self.NavScroll
	Corner(Btn, 7)
	local Indicator = Frame(Btn, UDim2.new(0,3,0,20), UDim2.new(0,0,0.5,-10), Theme.Accent)
	Indicator.Name  = "Indicator"
	Corner(Indicator, 2)
	Indicator.BackgroundTransparency = 1
	local BtnRow = Frame(Btn, UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), Theme.Surface, 1)
	Padding(BtnRow, nil, 0, 0, 12, 0)
	ListLayout(BtnRow, Enum.FillDirection.Horizontal, 8)
	local IconLbl = Label(BtnRow, icon or "◆", S.FontNav, Theme.TextDim, Enum.Font.GothamBold)
	IconLbl.Size  = UDim2.new(0, S.IconSize, 1, 0)
	IconLbl.TextYAlignment = Enum.TextYAlignment.Center
	local NameLbl = Label(BtnRow, name, S.FontNav, Theme.TextDim, Enum.Font.GothamBold)
	NameLbl.Size  = UDim2.new(0, S.NavW - 36, 1, 0)
	NameLbl.TextYAlignment = Enum.TextYAlignment.Center
	Btn.MouseEnter:Connect(function()
		if self.CurrentTab ~= name then
			Tween(Btn, {BackgroundTransparency = 0, BackgroundColor3 = Theme.NavHover}, 0.15)
			Tween(IconLbl, {TextColor3 = Theme.AccentDim}, 0.15)
			Tween(NameLbl, {TextColor3 = Theme.AccentDim}, 0.15)
		end
	end)
	Btn.MouseLeave:Connect(function()
		if self.CurrentTab ~= name then
			Tween(Btn, {BackgroundTransparency = 1}, 0.15)
			Tween(IconLbl, {TextColor3 = Theme.TextDim}, 0.15)
			Tween(NameLbl, {TextColor3 = Theme.TextDim}, 0.15)
		end
	end)
	Btn.MouseButton1Click:Connect(function()
		onClick()
		for _, nb in pairs(self.NavBtns) do
			Tween(nb.Btn,       {BackgroundTransparency=1}, 0.15)
			Tween(nb.Icon,      {TextColor3 = Theme.TextDim}, 0.15)
			Tween(nb.Name,      {TextColor3 = Theme.TextDim}, 0.15)
			Tween(nb.Indicator, {BackgroundTransparency=1}, 0.15)
		end
		self.CurrentTab = name
		Tween(Btn,       {BackgroundTransparency=0, BackgroundColor3=Theme.NavSelected}, 0.15)
		Tween(IconLbl,   {TextColor3 = Theme.Text},  0.15)
		Tween(NameLbl,   {TextColor3 = Theme.Text},  0.15)
		Tween(Indicator, {BackgroundTransparency=0}, 0.15)
	end)
	return {Btn=Btn, Icon=IconLbl, Name=NameLbl, Indicator=Indicator}
end
function _8y9Lib:AddTab(name, icon)
	local S = Sizes
	local Page = Frame(self.ContentScroll,
		UDim2.new(1,0,0,0), UDim2.new(0,0,0,0),
		Theme.Background, 1)
	Page.Name          = name .. "_Page"
	Page.AutomaticSize = Enum.AutomaticSize.Y
	Page.Visible       = false
	Padding(Page, nil, S.CardPad, S.CardPad, S.CardPad, S.CardPad)
	local Grid = Instance.new("UIGridLayout")
	Grid.CellSize     = UDim2.new(0.5, -S.CardGap/2, 0, 0)
	Grid.CellPadding  = UDim2.new(0, S.CardGap, 0, S.CardGap)
	Grid.FillDirection = Enum.FillDirection.Horizontal
	Grid.SortOrder    = Enum.SortOrder.LayoutOrder
	Grid.Parent       = Page
	if IsMobile then
		Grid.CellSize = UDim2.new(1, 0, 0, 0)
	end
	local tabData = {
		Name    = name,
		Page    = Page,
		Grid    = Grid,
		Cards   = {},
		NavBtn  = nil,
	}
	local navBtn = CreateNavBtn(self, name, icon or "◆", function()
		self:_ShowTab(name)
	end)
	tabData.NavBtn = navBtn
	table.insert(self.NavBtns, navBtn)
	self.Tabs[name] = tabData
	if not self.CurrentTab then
		self:_ShowTab(name)
		self.CurrentTab = name
		local nb = navBtn
		nb.Btn.BackgroundTransparency = 0
		nb.Btn.BackgroundColor3       = Theme.NavSelected
		nb.Icon.TextColor3            = Theme.Text
		nb.Name.TextColor3            = Theme.Text
		nb.Indicator.BackgroundTransparency = 0
	end
	local Tab = {}
	function Tab:AddSection(sectionName)
		local S2 = Sizes
		local Card = Frame(Page,
			UDim2.new(1,0,0,0), UDim2.new(0,0,0,0),
			Theme.CardBG)
		Card.Name          = sectionName .. "_Card"
		Card.AutomaticSize = Enum.AutomaticSize.Y
		Card.LayoutOrder   = #tabData.Cards + 1
		Corner(Card, S2.CardR)
		Stroke(Card, Theme.CardBorder, 1)
		local CardInner = Frame(Card, UDim2.new(1,0,0,0), UDim2.new(0,0,0,0), Theme.CardBG, 1)
		CardInner.AutomaticSize = Enum.AutomaticSize.Y
		Padding(CardInner, nil, S2.CardPad, S2.CardPad, S2.CardPad, S2.CardPad)
		ListLayout(CardInner, Enum.FillDirection.Vertical, 6)
		local TitleRow = Frame(CardInner, UDim2.new(1,0,0,22), UDim2.new(0,0,0,0), Theme.CardBG, 1)
		ListLayout(TitleRow, Enum.FillDirection.Horizontal, 8)
		local TitleLbl = Label(TitleRow, sectionName:upper(), S2.FontLabel + 1, Theme.TextMuted, Enum.Font.GothamBold)
		TitleLbl.Size = UDim2.new(1,0,1,0)
		TitleLbl.TextYAlignment = Enum.TextYAlignment.Center
		local SepLine = Frame(CardInner, UDim2.new(1,0,0,1), UDim2.new(0,0,0,0), Theme.Border)
		table.insert(tabData.Cards, Card)
		local Section = {}
		function Section:AddToggle(opts)
			opts = opts or {}
			local Row = Frame(CardInner,
				UDim2.new(1,0,0,S2.RowH), UDim2.new(0,0,0,0),
				Theme.CardBG, 1)
			ListLayout(Row, Enum.FillDirection.Horizontal, 0)
			local LabelCol = Frame(Row, UDim2.new(1,-S2.ToggleW-8,1,0), UDim2.new(0,0,0,0), Theme.CardBG, 1)
			local MainLbl  = Label(LabelCol, opts.Name or "Toggle", S2.FontBody, Theme.Text, Enum.Font.GothamBold)
			MainLbl.Position = UDim2.new(0,0,0,2)
			if opts.Description then
				local DescLbl = Label(LabelCol, opts.Description, S2.FontLabel, Theme.TextDim, Enum.Font.Gotham)
				DescLbl.Position = UDim2.new(0,0,0,S2.FontBody+4)
			end
			local ToggleHolder = Frame(Row, UDim2.new(0,S2.ToggleW+8,1,0), UDim2.new(0,0,0,0), Theme.CardBG, 1)
			local ToggleBG = Frame(ToggleHolder,
				UDim2.new(0,S2.ToggleW,0,S2.ToggleH),
				UDim2.new(0,4,0.5,-S2.ToggleH/2),
				opts.Default and Theme.Toggle_ON or Theme.Toggle_OFF)
			Corner(ToggleBG, S2.ToggleH/2)
			local Thumb = Frame(ToggleBG,
				UDim2.new(0,S2.ToggleH-4,0,S2.ToggleH-4),
				opts.Default
					and UDim2.new(1,-(S2.ToggleH-2),0.5,-(S2.ToggleH-4)/2)
					or  UDim2.new(0,2,0.5,-(S2.ToggleH-4)/2),
				Color3.new(0,0,0))
			Corner(Thumb, (S2.ToggleH-4)/2)
			local state = opts.Default or false
			local ToggleBtn = Instance.new("TextButton")
			ToggleBtn.Size = UDim2.new(1,0,1,0)
			ToggleBtn.BackgroundTransparency = 1
			ToggleBtn.Text = ""
			ToggleBtn.Parent = Row
			local function SetToggle(val, animate)
				state = val
				local t = animate and 0.18 or 0
				if state then
					Tween(ToggleBG, {BackgroundColor3 = Theme.Toggle_ON}, t)
					Tween(Thumb, {Position = UDim2.new(1,-(S2.ToggleH-2),0.5,-(S2.ToggleH-4)/2)}, t)
					Tween(Thumb, {BackgroundColor3 = Theme.Background}, t)
				else
					Tween(ToggleBG, {BackgroundColor3 = Theme.Toggle_OFF}, t)
					Tween(Thumb, {Position = UDim2.new(0,2,0.5,-(S2.ToggleH-4)/2)}, t)
					Tween(Thumb, {BackgroundColor3 = Color3.fromRGB(120,120,120)}, t)
				end
				if opts.Callback then pcall(opts.Callback, state) end
			end
			SetToggle(opts.Default or false, false)
			ToggleBtn.MouseButton1Click:Connect(function()
				SetToggle(not state, true)
			end)
			return {
				Set = function(_, v) SetToggle(v, true) end,
				Get = function() return state end,
			}
		end
		function Section:AddSlider(opts)
			opts = opts or {}
			local Min   = opts.Min   or 0
			local Max   = opts.Max   or 100
			local Value = opts.Value or Min
			local Step  = opts.Step  or 1
			local Row = Frame(CardInner,
				UDim2.new(1,0,0,S2.RowH+10), UDim2.new(0,0,0,0),
				Theme.CardBG, 1)
			local LblRow = Frame(Row, UDim2.new(1,0,0,S2.FontBody+4), UDim2.new(0,0,0,0), Theme.CardBG, 1)
			ListLayout(LblRow, Enum.FillDirection.Horizontal, 0)
			local SlLbl  = Label(LblRow, opts.Name or "Slider", S2.FontBody, Theme.Text, Enum.Font.GothamBold)
			SlLbl.Size   = UDim2.new(1,0,1,0)
			local ValLbl = Label(LblRow, tostring(Value), S2.FontBody, Theme.AccentDim, Enum.Font.GothamBold, Enum.TextXAlignment.Right)
			ValLbl.Size  = UDim2.new(0,40,1,0)
			local Track = Frame(Row,
				UDim2.new(1,0,0,S2.SliderH),
				UDim2.new(0,0,0,S2.RowH-4),
				Theme.SliderBG)
			Corner(Track, S2.SliderH/2)
			local Fill = Frame(Track,
				UDim2.new((Value-Min)/(Max-Min),0,1,0),
				UDim2.new(0,0,0,0),
				Theme.Slider)
			Corner(Fill, S2.SliderH/2)
			local Thumb = Frame(Track,
				UDim2.new(0,S2.ThumbR*2,0,S2.ThumbR*2),
				UDim2.new((Value-Min)/(Max-Min),0,0.5,-S2.ThumbR),
				Theme.Accent)
			Corner(Thumb, S2.ThumbR)
			local dragging = false
			local function Update(px)
				local rel = math.clamp((px - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
				local raw = Min + rel * (Max - Min)
				local snapped = math.floor(raw / Step + 0.5) * Step
				snapped = math.clamp(snapped, Min, Max)
				Value = snapped
				local pct = (Value - Min) / (Max - Min)
				Tween(Fill,  {Size = UDim2.new(pct,0,1,0)}, 0.06)
				Tween(Thumb, {Position = UDim2.new(pct,-S2.ThumbR,0.5,-S2.ThumbR)}, 0.06)
				ValLbl.Text = tostring(math.floor(Value*100+0.5)/100)
				if opts.Callback then pcall(opts.Callback, Value) end
			end
			Track.InputBegan:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton1
				or inp.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					Update(inp.Position.X)
				end
			end)
			UserInputService.InputChanged:Connect(function(inp)
				if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement
				or inp.UserInputType == Enum.UserInputType.Touch) then
					Update(inp.Position.X)
				end
			end)
			UserInputService.InputEnded:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton1
				or inp.UserInputType == Enum.UserInputType.Touch then
					dragging = false
				end
			end)
			return {
				Set = function(_, v)
					Value = math.clamp(v, Min, Max)
					local pct = (Value-Min)/(Max-Min)
					Tween(Fill,  {Size = UDim2.new(pct,0,1,0)}, 0.15)
					Tween(Thumb, {Position = UDim2.new(pct,-S2.ThumbR,0.5,-S2.ThumbR)}, 0.15)
					ValLbl.Text = tostring(Value)
					if opts.Callback then pcall(opts.Callback, Value) end
				end,
				Get = function() return Value end,
			}
		end
		function Section:AddDropdown(opts)
			opts = opts or {}
			local options = opts.Options or {}
			local selected = opts.Default or (options[1] or "")
			local open = false
			local Row = Frame(CardInner,
				UDim2.new(1,0,0,S2.RowH), UDim2.new(0,0,0,0),
				Theme.CardBG, 1)
			ListLayout(Row, Enum.FillDirection.Horizontal, 8)
			local LblCol = Frame(Row, UDim2.new(0.5,0,1,0), UDim2.new(0,0,0,0), Theme.CardBG, 1)
			Label(LblCol, opts.Name or "Dropdown", S2.FontBody, Theme.Text, Enum.Font.GothamBold)
			local DropBtn = Frame(Row, UDim2.new(0.5,-8,0,S2.DropH), UDim2.new(0,0,0.5,-S2.DropH/2), Theme.InputBG)
			Corner(DropBtn, 6)
			Stroke(DropBtn, Theme.InputBorder, 1)
			Padding(DropBtn, nil, 0, 0, 8, 4)
			ListLayout(DropBtn, Enum.FillDirection.Horizontal, 0)
			local SelLbl = Label(DropBtn, selected, S2.FontBody, Theme.Text, Enum.Font.Gotham)
			SelLbl.Size  = UDim2.new(1,-16,1,0)
			SelLbl.TextYAlignment = Enum.TextYAlignment.Center
			local Arrow = Label(DropBtn, "▾", S2.FontBody, Theme.TextDim, Enum.Font.GothamBold)
			Arrow.Size   = UDim2.new(0,14,1,0)
			Arrow.TextXAlignment = Enum.TextXAlignment.Right
			Arrow.TextYAlignment = Enum.TextYAlignment.Center
			local Menu = Frame(CardInner,
				UDim2.new(1,0,0,0), UDim2.new(0,0,0,0),
				Theme.DropdownBG)
			Menu.Name          = "DropMenu"
			Menu.AutomaticSize = Enum.AutomaticSize.Y
			Menu.Visible       = false
			Menu.ZIndex        = 20
			Corner(Menu, 6)
			Stroke(Menu, Theme.InputBorder, 1)
			Padding(Menu, 4)
			ListLayout(Menu, Enum.FillDirection.Vertical, 2)
			for _, opt in ipairs(options) do
				local OptBtn = Instance.new("TextButton")
				OptBtn.Size = UDim2.new(1,0,0,S2.DropH-4)
				OptBtn.BackgroundColor3 = Theme.DropdownBG
				OptBtn.BackgroundTransparency = 1
				OptBtn.Text = ""
				OptBtn.BorderSizePixel = 0
				OptBtn.Parent = Menu
				Corner(OptBtn, 5)
				local OptLbl = Label(OptBtn, opt, S2.FontBody, Theme.TextDim, Enum.Font.Gotham)
				OptLbl.Size = UDim2.new(1,-8,1,0)
				OptLbl.Position = UDim2.new(0,8,0,0)
				OptLbl.TextYAlignment = Enum.TextYAlignment.Center
				OptBtn.MouseEnter:Connect(function()
					Tween(OptBtn, {BackgroundTransparency=0, BackgroundColor3=Theme.NavHover}, 0.12)
					Tween(OptLbl, {TextColor3=Theme.Text}, 0.12)
				end)
				OptBtn.MouseLeave:Connect(function()
					Tween(OptBtn, {BackgroundTransparency=1}, 0.12)
					Tween(OptLbl, {TextColor3=Theme.TextDim}, 0.12)
				end)
				OptBtn.MouseButton1Click:Connect(function()
					selected = opt
					SelLbl.Text = opt
					Menu.Visible = false
					open = false
					Tween(Arrow, {Rotation=0}, 0.15)
					if opts.Callback then pcall(opts.Callback, opt) end
				end)
			end
			local DB = Instance.new("TextButton")
			DB.Size = UDim2.new(1,0,1,0)
			DB.BackgroundTransparency = 1
			DB.Text = ""
			DB.Parent = DropBtn
			DB.MouseButton1Click:Connect(function()
				open = not open
				Menu.Visible = open
				Tween(Arrow, {Rotation = open and 180 or 0}, 0.2)
			end)
			return {
				Set = function(_, v)
					selected = v
					SelLbl.Text = v
					if opts.Callback then pcall(opts.Callback, v) end
				end,
				Get = function() return selected end,
			}
		end
		function Section:AddInput(opts)
			opts = opts or {}
			local Row = Frame(CardInner,
				UDim2.new(1,0,0,S2.RowH), UDim2.new(0,0,0,0),
				Theme.CardBG, 1)
			ListLayout(Row, Enum.FillDirection.Horizontal, 8)
			local LblCol = Frame(Row, UDim2.new(0.45,0,1,0), UDim2.new(0,0,0,0), Theme.CardBG, 1)
			Label(LblCol, opts.Name or "Input", S2.FontBody, Theme.Text, Enum.Font.GothamBold)
			if opts.Description then
				local D = Label(LblCol, opts.Description, S2.FontLabel, Theme.TextDim, Enum.Font.Gotham)
				D.Position = UDim2.new(0,0,0,S2.FontBody+4)
			end
			local InputBox = Frame(Row, UDim2.new(0.55,-8,0,S2.InputH), UDim2.new(0,0,0.5,-S2.InputH/2), Theme.InputBG)
			Corner(InputBox, 6)
			Stroke(InputBox, Theme.InputBorder, 1)
			local TBox = Instance.new("TextBox")
			TBox.Size               = UDim2.new(1,-16,1,0)
			TBox.Position           = UDim2.new(0,8,0,0)
			TBox.BackgroundTransparency = 1
			TBox.Text               = opts.Default or ""
			TBox.PlaceholderText    = opts.Placeholder or ""
			TBox.PlaceholderColor3  = Theme.TextMuted
			TBox.TextColor3         = Theme.Text
			TBox.Font               = Enum.Font.Gotham
			TBox.TextSize           = S2.FontBody
			TBox.TextXAlignment     = Enum.TextXAlignment.Left
			TBox.ClearTextOnFocus   = false
			TBox.Parent             = InputBox
			TBox.FocusLost:Connect(function()
				if opts.Callback then pcall(opts.Callback, TBox.Text) end
			end)
			TBox.Focused:Connect(function()
				Tween(InputBox, {BackgroundColor3 = Theme.NavSelected}, 0.15)
			end)
			TBox.FocusLost:Connect(function()
				Tween(InputBox, {BackgroundColor3 = Theme.InputBG}, 0.15)
			end)
			return {
				Set = function(_, v) TBox.Text = v end,
				Get = function() return TBox.Text end,
			}
		end
		function Section:AddKeybind(opts)
			opts = opts or {}
			local bound = opts.Default or Enum.KeyCode.Unknown
			local listening = false
			local Row = Frame(CardInner,
				UDim2.new(1,0,0,S2.RowH), UDim2.new(0,0,0,0),
				Theme.CardBG, 1)
			ListLayout(Row, Enum.FillDirection.Horizontal, 8)
			local LblCol = Frame(Row, UDim2.new(0.5,0,1,0), UDim2.new(0,0,0,0), Theme.CardBG, 1)
			Label(LblCol, opts.Name or "Key Bind", S2.FontBody, Theme.Text, Enum.Font.GothamBold)
			local KeyBtn = Instance.new("TextButton")
			KeyBtn.Size              = UDim2.new(0.5,-8,0,S2.InputH)
			KeyBtn.Position          = UDim2.new(0,0,0.5,-S2.InputH/2)
			KeyBtn.BackgroundColor3  = Theme.ButtonBG
			KeyBtn.BorderSizePixel   = 0
			KeyBtn.Text              = tostring(bound):gsub("Enum.KeyCode.","")
			KeyBtn.TextColor3        = Theme.Text
			KeyBtn.Font              = Enum.Font.GothamBold
			KeyBtn.TextSize          = S2.FontBody
			KeyBtn.AutoButtonColor   = false
			KeyBtn.Parent            = Row
			Corner(KeyBtn, 6)
			Stroke(KeyBtn, Theme.ButtonBorder, 1)
			KeyBtn.MouseButton1Click:Connect(function()
				listening = true
				KeyBtn.Text = "..."
				KeyBtn.TextColor3 = Theme.AccentDim
			end)
			UserInputService.InputBegan:Connect(function(inp, gp)
				if listening and not gp then
					if inp.UserInputType == Enum.UserInputType.Keyboard then
						bound = inp.KeyCode
						KeyBtn.Text = tostring(bound):gsub("Enum.KeyCode.","")
						KeyBtn.TextColor3 = Theme.Text
						listening = false
						if opts.Callback then pcall(opts.Callback, bound) end
					end
				end
			end)
			return {
				Get = function() return bound end,
			}
		end
		function Section:AddLabel(text)
			local Row = Frame(CardInner,
				UDim2.new(1,0,0,S2.RowH-8), UDim2.new(0,0,0,0),
				Theme.CardBG, 1)
			local L = Label(Row, text or "", S2.FontBody, Theme.TextDim, Enum.Font.Gotham)
			L.Size = UDim2.new(1,0,1,0)
			L.TextYAlignment = Enum.TextYAlignment.Center
			return {Set = function(_,v) L.Text = v end}
		end
		function Section:AddSeparator()
			Frame(CardInner, UDim2.new(1,0,0,1), UDim2.new(0,0,0,0), Theme.Border)
		end
		return Section
	end
	return Tab
end
function _8y9Lib:AddBottomButton(opts)
	opts = opts or {}
	local S = Sizes
	local Btn = Instance.new("TextButton")
	Btn.Size             = UDim2.new(0, opts.Width or 120, 1, -12)
	Btn.BackgroundColor3 = opts.Primary and Theme.Accent or Theme.ButtonBG
	Btn.BorderSizePixel  = 0
	Btn.Text             = opts.Name or "Button"
	Btn.TextColor3       = opts.Primary and Theme.Background or Theme.Text
	Btn.Font             = Enum.Font.GothamBold
	Btn.TextSize         = S.FontBody
	Btn.AutoButtonColor  = false
	Btn.Parent           = self.BotBtnRow
	Corner(Btn, S.CornerR - 2)
	if not opts.Primary then Stroke(Btn, Theme.ButtonBorder, 1) end
	Btn.MouseEnter:Connect(function()
		Tween(Btn, {BackgroundColor3 = opts.Primary
			and Theme.Accent:Lerp(Color3.new(0.8,0.8,0.8),0.2)
			or Theme.NavHover}, 0.15)
	end)
	Btn.MouseLeave:Connect(function()
		Tween(Btn, {BackgroundColor3 = opts.Primary and Theme.Accent or Theme.ButtonBG}, 0.15)
	end)
	Btn.MouseButton1Click:Connect(function()
		Tween(Btn, {BackgroundTransparency = 0.3}, 0.08)
		task.delay(0.08, function()
			Tween(Btn, {BackgroundTransparency = 0}, 0.12)
		end)
		if opts.Callback then pcall(opts.Callback) end
	end)
	if opts.RightAlign then
		Btn.Size = UDim2.new(0, opts.Width or 140, 1, -12)
		Btn.LayoutOrder = 999
		local spacer = Frame(self.BotBtnRow, UDim2.new(1,0,0,1), UDim2.new(0,0,0,0), Theme.Background, 1)
		spacer.LayoutOrder = 998
	end
	return Btn
end
function _8y9Lib:Notify(opts)
	opts = opts or {}
	local S = Sizes
	local NotiHolder = Frame(self.ScreenGui,
		UDim2.new(0,260,0,0), UDim2.new(1,-275,1,-20),
		Theme.CardBG)
	NotiHolder.AutomaticSize = Enum.AutomaticSize.Y
	NotiHolder.Position      = UDim2.new(1,10,1,-80)
	Corner(NotiHolder, S.CornerR)
	Stroke(NotiHolder, Theme.Border, 1)
	Padding(NotiHolder, 12)
	ListLayout(NotiHolder, Enum.FillDirection.Vertical, 4)
	Label(NotiHolder, opts.Title or "Notification", S.FontBody, Theme.Text, Enum.Font.GothamBold)
	if opts.Content then
		Label(NotiHolder, opts.Content, S.FontLabel, Theme.TextDim, Enum.Font.Gotham)
	end
	Tween(NotiHolder, {Position = UDim2.new(1,-275,1,-80)}, 0.3, Enum.EasingStyle.Quint)
	local dur = opts.Duration or 3
	task.delay(dur, function()
		Tween(NotiHolder, {Position = UDim2.new(1,10,1,-80), BackgroundTransparency=1}, 0.25)
		task.delay(0.3, function() NotiHolder:Destroy() end)
	end)
end
function _8y9Lib:_ShowTab(name)
	for tname, tdata in pairs(self.Tabs) do
		tdata.Page.Visible = (tname == name)
	end
	local tab = self.Tabs[name]
	if tab then
		self.PageTitle.Text    = name
		self.PageSubtitle.Text = tab.Subtitle or (name:sub(1,1):upper()..name:sub(2):lower().." features and settings")
		local Page = tab.Page
		Page.Position = UDim2.new(0.05,0,0,0)
		Page.BackgroundTransparency = 1
		Tween(Page, {Position=UDim2.new(0,0,0,0), BackgroundTransparency=1}, 0.2, Enum.EasingStyle.Quint)
	end
end
function _8y9Lib:Toggle()
	self.Toggled = not self.Toggled
	if self.Toggled then
		self.Window.Visible = true
		Tween(self.Window, {
			Size = UDim2.new(0,Sizes.WindowW,0,Sizes.WindowH),
			BackgroundTransparency = 0
		}, 0.3, Enum.EasingStyle.Quint)
		if self._FloatBtn then
			Tween(self._FloatBtn, {BackgroundTransparency = 0.3}, 0.2)
		end
	else
		Tween(self.Window, {
			Size = UDim2.new(0,Sizes.WindowW,0,0),
			BackgroundTransparency = 1
		}, 0.25, Enum.EasingStyle.Quint)
		task.delay(0.3, function() self.Window.Visible = false end)
		if self._FloatBtn then
			Tween(self._FloatBtn, {BackgroundTransparency = 0}, 0.2)
		end
	end
end
function _8y9Lib:Destroy()
	if self.ScreenGui then self.ScreenGui:Destroy() end
end
_8y9Lib.IsMobile = IsMobile
_8y9Lib.Device   = IsMobile and "Mobile" or "PC"
function _8y9Lib:_CreateFloatButton(config)
	local floatGui = Instance.new("ScreenGui")
	floatGui.Name           = "8y9FloatBtn"
	floatGui.ResetOnSpawn   = false
	floatGui.DisplayOrder   = 1000
	floatGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	pcall(function() floatGui.Parent = CoreGui end)
	if not floatGui.Parent then floatGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
	local BtnSize = IsMobile and 52 or 46
	local Frame_ = Instance.new("Frame")
	Frame_.Name                  = "FloatFrame"
	Frame_.Size                  = UDim2.new(0, BtnSize, 0, BtnSize)
	Frame_.Position              = IsMobile and UDim2.new(1, -(BtnSize+14), 0, 180) or UDim2.new(1, -(BtnSize+14), 0, 140)
	Frame_.BackgroundColor3      = Color3.fromRGB(15,15,15)
	Frame_.BackgroundTransparency = 0
	Frame_.BorderSizePixel       = 0
	Frame_.Active                = true
	Frame_.Parent                = floatGui
	Corner(Frame_, 14)
	local GlowStroke = Instance.new("UIStroke")
	GlowStroke.Color     = Color3.fromRGB(70,70,70)
	GlowStroke.Thickness = 1.5
	GlowStroke.Parent    = Frame_
	local Highlight = Frame(Frame_,
		UDim2.new(1,-6,1,-6), UDim2.new(0,3,0,3),
		Color3.fromRGB(255,255,255), 0.92)
	Corner(Highlight, 11)
	local IconHolder = Frame(Frame_,
		UDim2.new(1,-10,1,-10), UDim2.new(0,5,0,5),
		Color3.fromRGB(0,0,0), 1)
	Corner(IconHolder, 10)
	if config and config.Icon then
		local FImg = Instance.new("ImageLabel")
		FImg.Image                  = config.Icon
		FImg.Size                   = UDim2.new(1,0,1,0)
		FImg.BackgroundTransparency = 1
		FImg.ScaleType              = Enum.ScaleType.Fit
		FImg.Parent                 = IconHolder
	else
		local FLbl = Label(IconHolder,
			(config and config.Name or "8"):sub(1,1):upper(),
			BtnSize - 20, Theme.Text, Enum.Font.GothamBold, Enum.TextXAlignment.Center)
		FLbl.Size = UDim2.new(1,0,1,0)
		FLbl.TextYAlignment = Enum.TextYAlignment.Center
	end
	local ClickBtn = Instance.new("TextButton")
	ClickBtn.Size                   = UDim2.new(1,0,1,0)
	ClickBtn.BackgroundTransparency = 1
	ClickBtn.Text                   = ""
	ClickBtn.ZIndex                 = 10
	ClickBtn.Parent                 = Frame_
	self._FloatBtn = Frame_
	local dragging, dragStart, startPos_ = false, nil, nil
	local moved = false
	Frame_.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1
		or inp.UserInputType == Enum.UserInputType.Touch then
			dragging  = true
			moved     = false
			dragStart = inp.Position
			startPos_ = Frame_.Position
			Tween(Frame_, {BackgroundColor3 = Color3.fromRGB(25,25,25)}, 0.1)
		end
	end)
	UserInputService.InputChanged:Connect(function(inp)
		if dragging and (
			inp.UserInputType == Enum.UserInputType.MouseMovement or
			inp.UserInputType == Enum.UserInputType.Touch
		) then
			local delta = inp.Position - dragStart
			if delta.Magnitude > 4 then moved = true end
			Frame_.Position = UDim2.new(
				startPos_.X.Scale, startPos_.X.Offset + delta.X,
				startPos_.Y.Scale, startPos_.Y.Offset + delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1
		or inp.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			Tween(Frame_, {BackgroundColor3 = Color3.fromRGB(15,15,15)}, 0.15)
		end
	end)
	ClickBtn.MouseButton1Click:Connect(function()
		if not moved then
			self:Toggle()
			Tween(Frame_, {BackgroundColor3 = Color3.fromRGB(50,50,50)}, 0.08)
			task.delay(0.08, function()
				Tween(Frame_, {BackgroundColor3 = Color3.fromRGB(15,15,15)}, 0.2)
			end)
		end
	end)
	if not IsMobile then
		UserInputService.InputBegan:Connect(function(inp, gp)
			if not gp and inp.KeyCode == Enum.KeyCode.K then
				self:Toggle()
				Tween(Frame_, {BackgroundColor3 = Color3.fromRGB(50,50,50)}, 0.08)
				task.delay(0.08, function()
					Tween(Frame_, {BackgroundColor3 = Color3.fromRGB(15,15,15)}, 0.2)
				end)
			end
		end)
	end
	return floatGui
end
return _8y9Lib