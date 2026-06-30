repeat
    task.wait()
until game:IsLoaded()

local Library = {}
Library.currentTab = nil
Library.flags = {}

_G.AIFeatures = _G.AIFeatures or {}

local CoreGui = cloneref(game:GetService('CoreGui'))
local Players = cloneref(game:GetService('Players'))
local TweenService = cloneref(game:GetService('TweenService'))
local UserInputService = cloneref(game:GetService('UserInputService'))
local RunService = cloneref(game:GetService('RunService'))

local gethui = gethui or function()
    return CoreGui
end
local mouse = cloneref(Players.LocalPlayer:GetMouse())

local function Tween(obj, t, data)
    TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
    return true
end

local function Ripple(obj)
    spawn(function()
        if obj.ClipsDescendants ~= true then
            obj.ClipsDescendants = true
        end

        local Ripple = Instance.new('ImageLabel')
        Ripple.Name = 'Ripple'
        Ripple.Parent = obj
        Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Ripple.BackgroundTransparency = 1
        Ripple.ZIndex = 8
        Ripple.Image = 'rbxassetid://2708891598'
        Ripple.ImageTransparency = 0.8
        Ripple.ScaleType = Enum.ScaleType.Fit
        Ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
        Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)

        Tween(Ripple, {0.3, 'Linear', 'InOut'}, {
            Position = UDim2.new(-5.5, 0, -5.5, 0),
            Size = UDim2.new(12, 0, 12, 0),
        })
        wait(0.15)
        Tween(Ripple, {0.3, 'Linear', 'InOut'}, {ImageTransparency = 1})
        wait(0.3)
        Ripple:Destroy()
    end)
end

local switchingTabs = false

local function switchTab(new)
    if switchingTabs then
        return
    end
    local old = Library.currentTab
    if old == nil then
        new[2].Visible = true
        Library.currentTab = new
        TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
        TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
        return
    end
    if old[1] == new[1] then
        return
    end
    switchingTabs = true
    Library.currentTab = new
    TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.2}):Play()
    TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.2}):Play()
    TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
    old[2].Visible = false
    new[2].Visible = true
    task.wait(0.1)
    switchingTabs = false
end

----------------------------------------------------------------
-- 🎨 冰川极光蓝 (Glacier Aurora) 配色方案 + 可选彩虹描边系统
----------------------------------------------------------------

local COLOR_SCHEMES = {
    ['❄️ 冰川极光'] = {
        ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHex('0A84FF')),
            ColorSequenceKeypoint.new(0.5, Color3.fromHex('00E5FF')),
            ColorSequenceKeypoint.new(1, Color3.fromHex('0A84FF')),
        }),
        2,
    },
    ['🌈 彩虹'] = {
        ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 165, 0)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 130, 238)),
        }),
        2,
    },
}

local currentColorScheme = '❄️ 冰川极光'

local function createRainbowBorder(frame, colorScheme, thickness)
    local oldStroke = frame:FindFirstChild('RainbowStroke')
    if oldStroke then
        oldStroke:Destroy()
    end

    local corner = frame:FindFirstChildOfClass('UICorner')
    if not corner then
        corner = Instance.new('UICorner')
        corner.Parent = frame
        corner.CornerRadius = UDim.new(0, 12)
    end

    local stroke = Instance.new('UIStroke')
    stroke.Name = 'RainbowStroke'
    stroke.Thickness = thickness or 2
    stroke.Color = Color3.new(1, 1, 1)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.LineJoinMode = Enum.LineJoinMode.Round
    stroke.Parent = frame

    local gradient = Instance.new('UIGradient')
    gradient.Name = 'BorderGradient'
    local schemeData = COLOR_SCHEMES[colorScheme] or COLOR_SCHEMES['❄️ 冰川极光']
    gradient.Color = schemeData[1]
    gradient.Rotation = 0
    gradient.Parent = stroke

    return stroke
end

local function startBorderAnimation(frame, speed)
    local stroke = frame:FindFirstChild('RainbowStroke')
    if not stroke then
        return nil
    end
    local gradient = stroke:FindFirstChild('BorderGradient')
    if not gradient then
        return nil
    end

    local animation = RunService.Heartbeat:Connect(function()
        if not gradient or gradient.Parent == nil then
            animation:Disconnect()
            return
        end
        gradient.Rotation = (gradient.Rotation + (speed or 3) * 0.5) % 360
    end)
    return animation
end

local function changeBorderColor(frame, colorScheme)
    local stroke = frame:FindFirstChild('RainbowStroke')
    if not stroke then
        return
    end
    local gradient = stroke:FindFirstChild('BorderGradient')
    if not gradient then
        return
    end
    if COLOR_SCHEMES[colorScheme] then
        gradient.Color = COLOR_SCHEMES[colorScheme][1]
    end
end

local function toggleBorder(frame, enabled)
    local stroke = frame:FindFirstChild('RainbowStroke')
    if stroke then
        stroke.Enabled = enabled
    end
end

----------------------------------------------------------------

function Library.new(Library, name, opts)
    opts = opts or {}
    for _, v in next, (gethui()):GetChildren() do
        if v.Name == 'XA_LuaWare' then
            v:Destroy()
        end
    end

    -- 冰川极光蓝配色
    local Background = Color3.fromHex('111218')      -- 深邃夜空黑
    local MainColor = Color3.fromHex('111218')
    local ElementColor = Color3.fromHex('1B1D26')     -- 雾面暗灰蓝
    local BackgroundColor = Color3.fromRGB(255, 255, 255)
    local TextColor = Color3.fromHex('FFFFFF')        -- 冰晶白
    local SubTextColor = Color3.fromHex('989EAD')     -- 悬浮灰
    local PrimaryColor = Color3.fromHex('0A84FF')     -- 科技高亮蓝
    local AccentColor = Color3.fromHex('00E5FF')      -- 极光电光青

    local dogent = Instance.new('ScreenGui')
    local Main = Instance.new('Frame')
    local TabMain = Instance.new('Frame')
    local MainC = Instance.new('UICorner')
    local UIStrokeMain = Instance.new('UIStroke')
    local SB = Instance.new('Frame')
    local SBC = Instance.new('UICorner')
    local Side = Instance.new('Frame')
    local SideG = Instance.new('UIGradient')
    local TabBtns = Instance.new('ScrollingFrame')
    local TabBtnsL = Instance.new('UIListLayout')
    local ScriptTitle = Instance.new('TextLabel')
    local SBG = Instance.new('UIGradient')
    local Open = Instance.new('TextButton')

    if syn and syn.protect_gui then
        syn.protect_gui(dogent)
    end

    dogent.Name = 'XA_LuaWare'
    dogent.Parent = gethui()
    Library.Gui = dogent

    local function ToggleUILib()
        Main.Visible = not Main.Visible
    end

    Main.Name = 'Main'
    Main.Parent = dogent
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Background
    Main.BackgroundTransparency = 0.15
    Main.BorderColor3 = MainColor
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 572, 0, 353)
    Main.ZIndex = 1
    Main.Active = true
    Main.Draggable = true
    Main.ClipsDescendants = true

    MainC.CornerRadius = UDim.new(0, 12)
    MainC.Name = 'MainC'
    MainC.Parent = Main

    -- 边框(默认科技蓝静态描边,可选开启极光流动动画)
    UIStrokeMain.Parent = Main
    UIStrokeMain.Thickness = 1
    UIStrokeMain.Color = PrimaryColor
    UIStrokeMain.Transparency = 0.4

    local borderAnimation = nil
    if opts.AnimatedBorder then
        UIStrokeMain:Destroy()
        local rainbowStroke = createRainbowBorder(Main, currentColorScheme, 2)
        borderAnimation = startBorderAnimation(Main, 5)
    end

    TabMain.Name = 'TabMain'
    TabMain.Parent = Main
    TabMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabMain.BackgroundTransparency = 1
    TabMain.Position = UDim2.new(0.217000037, 0, 0, 3)
    TabMain.Size = UDim2.new(0, 448, 0, 346)

    SB.Name = 'SB'
    SB.Parent = Main
    SB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SB.BackgroundTransparency = 0.5
    SB.BorderColor3 = MainColor
    SB.Size = UDim2.new(0, 8, 0, 353)

    SBC.CornerRadius = UDim.new(0, 8)
    SBC.Name = 'SBC'
    SBC.Parent = SB

    Side.Name = 'Side'
    Side.Parent = SB
    Side.BackgroundColor3 = ElementColor
    Side.BackgroundTransparency = 0.1
    Side.BorderColor3 = Color3.fromRGB(25, 25, 25)
    Side.BorderSizePixel = 0
    Side.ClipsDescendants = true
    Side.Position = UDim2.new(1, 0, 0, 0)
    Side.Size = UDim2.new(0, 110, 0, 353)

    local SideCorner = Instance.new('UICorner')
    SideCorner.Parent = Side
    SideCorner.CornerRadius = UDim.new(0, 10)

    SideG.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, ElementColor),
        ColorSequenceKeypoint.new(1, ElementColor),
    }
    SideG.Rotation = 90
    SideG.Name = 'SideG'
    SideG.Parent = Side

    TabBtns.Name = 'TabBtns'
    TabBtns.Parent = Side
    TabBtns.Active = true
    TabBtns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabBtns.BackgroundTransparency = 1
    TabBtns.BorderSizePixel = 0
    TabBtns.Position = UDim2.new(0, 0, 0.0973535776, 0)
    TabBtns.Size = UDim2.new(0, 110, 0, 318)
    TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabBtns.ScrollBarThickness = 0

    TabBtnsL.Name = 'TabBtnsL'
    TabBtnsL.Parent = TabBtns
    TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
    TabBtnsL.Padding = UDim.new(0, 12)

    ScriptTitle.Name = 'ScriptTitle'
    ScriptTitle.Parent = Side
    ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.BackgroundTransparency = 1
    ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
    ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
    ScriptTitle.Font = Enum.Font.GothamSemibold
    ScriptTitle.Text = name
    ScriptTitle.TextColor3 = PrimaryColor
    ScriptTitle.TextSize = 14
    ScriptTitle.TextScaled = true
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Center

    -- 标题呼吸流光动画(蓝→青→蓝),取代原来的全色相轮转
    task.spawn(function()
        local t = 0
        while true do
            t = (t + task.wait(0.05)) % 4
            local alpha = (math.sin(t * math.pi / 2) + 1) / 2
            ScriptTitle.TextColor3 = PrimaryColor:Lerp(AccentColor, alpha)
        end
    end)

    SBG.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, ElementColor),
        ColorSequenceKeypoint.new(1, ElementColor),
    }
    SBG.Rotation = 90
    SBG.Name = 'SBG'
    SBG.Parent = SB

    TabBtnsL:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
        TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
    end)

    Open.Name = 'Open'
    Open.Parent = dogent
    Open.BackgroundColor3 = ElementColor
    Open.BackgroundTransparency = 0.25
    Open.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
    Open.Size = UDim2.new(0, 61, 0, 32)
    Open.Font = Enum.Font.SourceSans
    Open.Text = '隐藏/打开'
    Open.TextColor3 = TextColor
    Open.TextSize = 14
    Open.Active = true
    Open.Draggable = true

    local OpenCorner = Instance.new('UICorner')
    OpenCorner.Parent = Open
    OpenCorner.CornerRadius = UDim.new(0, 8)

    local OpenStroke = Instance.new('UIStroke')
    OpenStroke.Parent = Open
    OpenStroke.Thickness = 1
    OpenStroke.Color = PrimaryColor
    OpenStroke.Transparency = 0.5

    Open.MouseButton1Click:Connect(ToggleUILib)

    Library.ToggleKeybind = Enum.KeyCode.LeftControl
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Library.ToggleKeybind then
            ToggleUILib()
        end
    end)

    -- 暴露配色 & 描边控制接口,方便外部脚本调用
    Library.Colors = {
        Background = Background,
        Element = ElementColor,
        Text = TextColor,
        SubText = SubTextColor,
        Primary = PrimaryColor,
        Accent = AccentColor,
    }
    Library.SetBorderScheme = function(self, schemeName)
        changeBorderColor(Main, schemeName)
    end
    Library.SetBorderEnabled = function(self, enabled)
        toggleBorder(Main, enabled)
    end

    local Window = {}

    function Window.Tab(Window, name, icon)
        local Tab = Instance.new('ScrollingFrame')
        local TabIco = Instance.new('ImageLabel')
        local TabText = Instance.new('TextLabel')
        local TabBtn = Instance.new('TextButton')
        local TabL = Instance.new('UIListLayout')

        Tab.Name = 'Tab'
        Tab.Parent = TabMain
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Tab.BackgroundTransparency = 1
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 2
        Tab.ScrollBarImageColor3 = PrimaryColor
        Tab.Visible = false

        local TabCorner = Instance.new('UICorner')
        TabCorner.Parent = Tab
        TabCorner.CornerRadius = UDim.new(0, 8)

        TabIco.Name = 'TabIco'
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 24, 0, 24)
        TabIco.Image = ('rbxassetid://%s'):format((icon or 4370341699))
        TabIco.ImageTransparency = 0.2
        TabIco.ImageColor3 = PrimaryColor

        TabText.Name = 'TabText'
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabText.BackgroundTransparency = 1
        TabText.Position = UDim2.new(1.41666663, 0, 0, 0)
        TabText.Size = UDim2.new(0, 76, 0, 24)
        TabText.Font = Enum.Font.GothamSemibold
        TabText.Text = name
        TabText.TextColor3 = TextColor
        TabText.TextSize = 14
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.2

        TabBtn.Name = 'TabBtn'
        TabBtn.Parent = TabIco
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundTransparency = 1
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 110, 0, 24)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ''
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14

        TabL.Name = 'TabL'
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 4)

        TabBtn.MouseButton1Click:Connect(function()
            spawn(function()
                Ripple(TabBtn)
            end)
            switchTab({TabIco, Tab})
        end)

        if Library.currentTab == nil then
            switchTab({TabIco, Tab})
        end

        TabL:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
        end)

        local tab = {}

        function tab.Section(tab, name, TabVal)
            local Section = Instance.new('Frame')
            local SectionC = Instance.new('UICorner')
            local SectionText = Instance.new('TextLabel')
            local SectionOpen = Instance.new('ImageLabel')
            local SectionOpened = Instance.new('ImageLabel')
            local SectionToggle = Instance.new('ImageButton')
            local Objs = Instance.new('Frame')
            local ObjsL = Instance.new('UIListLayout')

            Section.Name = 'Section'
            Section.Parent = Tab
            Section.BackgroundColor3 = ElementColor
            Section.BackgroundTransparency = 1
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(0.981000006, 0, 0, 36)

            SectionC.CornerRadius = UDim.new(0, 8)
            SectionC.Name = 'SectionC'
            SectionC.Parent = Section

            SectionText.Name = 'SectionText'
            SectionText.Parent = Section
            SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.BackgroundTransparency = 1
            SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
            SectionText.Size = UDim2.new(0, 401, 0, 36)
            SectionText.Font = Enum.Font.GothamSemibold
            SectionText.Text = name
            SectionText.TextColor3 = TextColor
            SectionText.TextSize = 16
            SectionText.TextXAlignment = Enum.TextXAlignment.Left

            SectionOpen.Name = 'SectionOpen'
            SectionOpen.Parent = SectionText
            SectionOpen.BackgroundTransparency = 1
            SectionOpen.BorderSizePixel = 0
            SectionOpen.Position = UDim2.new(0, -33, 0, 5)
            SectionOpen.Size = UDim2.new(0, 26, 0, 26)
            SectionOpen.Image = 'http://www.roblox.com/asset/?id=6031302934'
            SectionOpen.ImageColor3 = PrimaryColor

            SectionOpened.Name = 'SectionOpened'
            SectionOpened.Parent = SectionOpen
            SectionOpened.BackgroundTransparency = 1
            SectionOpened.BorderSizePixel = 0
            SectionOpened.Size = UDim2.new(0, 26, 0, 26)
            SectionOpened.Image = 'http://www.roblox.com/asset/?id=6031302932'
            SectionOpened.ImageTransparency = 1
            SectionOpened.ImageColor3 = AccentColor

            SectionToggle.Name = 'SectionToggle'
            SectionToggle.Parent = SectionOpen
            SectionToggle.BackgroundTransparency = 1
            SectionToggle.BorderSizePixel = 0
            SectionToggle.Size = UDim2.new(0, 26, 0, 26)

            Objs.Name = 'Objs'
            Objs.Parent = Section
            Objs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Objs.BackgroundTransparency = 1
            Objs.BorderSizePixel = 0
            Objs.Position = UDim2.new(0, 6, 0, 36)
            Objs.Size = UDim2.new(0.986347735, 0, 0, 0)

            ObjsL.Name = 'ObjsL'
            ObjsL.Parent = Objs
            ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
            ObjsL.Padding = UDim.new(0, 8)

            local open = TabVal
            if TabVal ~= false then
                Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
                SectionOpened.ImageTransparency = (open and 0 or 1)
                SectionOpen.ImageTransparency = (open and 1 or 0)
            end

            SectionToggle.MouseButton1Click:Connect(function()
                open = not open
                Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
                SectionOpened.ImageTransparency = (open and 0 or 1)
                SectionOpen.ImageTransparency = (open and 1 or 0)
            end)

            ObjsL:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                if not open then
                    return
                end
                Section.Size = UDim2.new(0.981000006, 0, 0, 36 + ObjsL.AbsoluteContentSize.Y + 8)
            end)

            local section = {}

            function section.Button(section, text, callback)
                local callback = callback or function() end
                local BtnModule = Instance.new('Frame')
                local Btn = Instance.new('TextButton')
                local BtnC = Instance.new('UICorner')

                BtnModule.Name = 'BtnModule'
                BtnModule.Parent = Objs
                BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BtnModule.BackgroundTransparency = 1
                BtnModule.BorderSizePixel = 0
                BtnModule.Position = UDim2.new(0, 0, 0, 0)
                BtnModule.Size = UDim2.new(0, 428, 0, 38)

                Btn.Name = 'Btn'
                Btn.Parent = BtnModule
                Btn.BackgroundColor3 = ElementColor
                Btn.BackgroundTransparency = 0.1
                Btn.BorderSizePixel = 0
                Btn.Size = UDim2.new(0, 428, 0, 38)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamSemibold
                Btn.Text = '   ' .. text
                Btn.TextColor3 = TextColor
                Btn.TextSize = 16
                Btn.TextXAlignment = Enum.TextXAlignment.Left

                BtnC.CornerRadius = UDim.new(0, 6)
                BtnC.Name = 'BtnC'
                BtnC.Parent = Btn

                Btn.MouseButton1Click:Connect(function()
                    spawn(function()
                        Ripple(Btn)
                    end)
                    spawn(callback)
                end)

                if _G.AutoRegisterAI then
                    _G.AIFeatures[text] = {type = 'button', callback = callback}
                end

                return BtnModule
            end

            function section:Label(text)
                local LabelModule = Instance.new('Frame')
                local TextLabel = Instance.new('TextLabel')
                local LabelC = Instance.new('UICorner')

                LabelModule.Name = 'LabelModule'
                LabelModule.Parent = Objs
                LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelModule.BackgroundTransparency = 1
                LabelModule.BorderSizePixel = 0
                LabelModule.Position = UDim2.new(0, 0, 0, 0)
                LabelModule.Size = UDim2.new(0, 428, 0, 19)

                TextLabel.Parent = LabelModule
                TextLabel.BackgroundColor3 = ElementColor
                TextLabel.BackgroundTransparency = 0.1
                TextLabel.Size = UDim2.new(0, 428, 0, 22)
                TextLabel.Font = Enum.Font.GothamSemibold
                TextLabel.Text = text
                TextLabel.TextColor3 = SubTextColor
                TextLabel.TextSize = 14
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left

                LabelC.CornerRadius = UDim.new(0, 6)
                LabelC.Name = 'LabelC'
                LabelC.Parent = TextLabel

                if _G.AutoRegisterAI then
                    _G.AIFeatures[text] = {type = 'label', object = TextLabel, getText = function() return TextLabel.Text end}
                end

                return TextLabel
            end

            function section.Colorpicker(section, text, flag, defaultColor, callback)
                assert(text, 'No text provided')
                assert(flag, 'No flag provided')

                if type(defaultColor) == 'function' then
                    callback = defaultColor
                    defaultColor = nil
                end

                defaultColor = defaultColor or AccentColor
                callback = callback or function() end

                assert(typeof(defaultColor) == 'Color3', 'defaultColor must be a Color3')

                Library.flags[flag] = defaultColor

                local ColorModule = Instance.new('Frame')
                local ColorBtn = Instance.new('TextButton')
                local ColorBtnC = Instance.new('UICorner')
                local ColorPreview = Instance.new('Frame')
                local ColorPreviewC = Instance.new('UICorner')

                ColorModule.Name = 'ColorModule'
                ColorModule.Parent = Objs
                ColorModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorModule.BackgroundTransparency = 1
                ColorModule.BorderSizePixel = 0
                ColorModule.Size = UDim2.new(0, 428, 0, 38)

                ColorBtn.Name = 'ColorBtn'
                ColorBtn.Parent = ColorModule
                ColorBtn.BackgroundColor3 = ElementColor
                ColorBtn.BackgroundTransparency = 0.1
                ColorBtn.BorderSizePixel = 0
                ColorBtn.Size = UDim2.new(0, 428, 0, 38)
                ColorBtn.AutoButtonColor = false
                ColorBtn.Font = Enum.Font.GothamSemibold
                ColorBtn.Text = '   ' .. text
                ColorBtn.TextColor3 = TextColor
                ColorBtn.TextSize = 16
                ColorBtn.TextXAlignment = Enum.TextXAlignment.Left

                ColorBtnC.CornerRadius = UDim.new(0, 6)
                ColorBtnC.Name = 'ColorBtnC'
                ColorBtnC.Parent = ColorBtn

                ColorPreview.Name = 'ColorPreview'
                ColorPreview.Parent = ColorBtn
                ColorPreview.BackgroundColor3 = defaultColor
                ColorPreview.BorderSizePixel = 0
                ColorPreview.Position = UDim2.new(0.901869178, 0, 0.289473683, 0)
                ColorPreview.Size = UDim2.new(0, 36, 0, 22)

                ColorPreviewC.CornerRadius = UDim.new(0, 6)
                ColorPreviewC.Name = 'ColorPreviewC'
                ColorPreviewC.Parent = ColorPreview

                local function updateColor(newColor)
                    ColorPreview.BackgroundColor3 = newColor
                    Library.flags[flag] = newColor
                    callback(newColor)
                end

                local pickerGui = nil
                local isOpen = false
                local currentHue, currentSat, currentVib = Color3.toHSV(defaultColor)
                local satVibMap, satCursor, hueSlider, hueDrag

                local function updatePickerUI()
                    if not pickerGui then
                        return
                    end
                    local color = Color3.fromHSV(currentHue, currentSat, currentVib)

                    if satVibMap then
                        satVibMap.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
                    end
                    if satCursor then
                        satCursor.Position = UDim2.new(currentSat, 0, 1 - currentVib, 0)
                        satCursor.BackgroundColor3 = color
                    end
                    if hueDrag then
                        hueDrag.Position = UDim2.new(0.5, 0, currentHue, 0)
                        hueDrag.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
                    end

                    local mainF = pickerGui:FindFirstChild('Main')
                    if mainF then
                        local newDisplay = mainF:FindFirstChild('NewDisplayFrame')
                        if newDisplay then
                            newDisplay.BackgroundColor3 = color
                        end
                        local rBox = mainF:FindFirstChild('RBox')
                        local gBox = mainF:FindFirstChild('GBox')
                        local bBox = mainF:FindFirstChild('BBox')
                        local hexBox = mainF:FindFirstChild('HexBox')
                        if rBox then
                            rBox.Text = tostring(math.floor(color.R * 255))
                            gBox.Text = tostring(math.floor(color.G * 255))
                            bBox.Text = tostring(math.floor(color.B * 255))
                        end
                        if hexBox then
                            hexBox.Text = '#' .. color:ToHex()
                        end
                    end
                end

                local function createPicker()
                    if pickerGui then
                        return
                    end

                    pickerGui = Instance.new('ScreenGui')
                    pickerGui.Name = 'ColorPicker'
                    pickerGui.Parent = gethui()
                    pickerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

                    local mainFrame = Instance.new('Frame')
                    mainFrame.Name = 'Main'
                    mainFrame.Parent = pickerGui
                    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                    mainFrame.BackgroundColor3 = Background
                    mainFrame.BackgroundTransparency = 0.05
                    mainFrame.BorderSizePixel = 0
                    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
                    mainFrame.Size = UDim2.new(0, 340, 0, 340)
                    mainFrame.Active = true
                    mainFrame.Draggable = true

                    local corner = Instance.new('UICorner')
                    corner.CornerRadius = UDim.new(0, 8)
                    corner.Parent = mainFrame

                    local stroke = Instance.new('UIStroke')
                    stroke.Thickness = 1
                    stroke.Color = PrimaryColor
                    stroke.Transparency = 0.4
                    stroke.Parent = mainFrame

                    local title = Instance.new('TextLabel')
                    title.Parent = mainFrame
                    title.BackgroundTransparency = 1
                    title.Position = UDim2.new(0, 10, 0, 10)
                    title.Size = UDim2.new(0, 200, 0, 20)
                    title.Font = Enum.Font.GothamSemibold
                    title.Text = text
                    title.TextColor3 = TextColor
                    title.TextSize = 14
                    title.TextXAlignment = Enum.TextXAlignment.Left

                    local closeBtn = Instance.new('TextButton')
                    closeBtn.Parent = mainFrame
                    closeBtn.BackgroundColor3 = ElementColor
                    closeBtn.Position = UDim2.new(1, -30, 0, 5)
                    closeBtn.Size = UDim2.new(0, 20, 0, 20)
                    closeBtn.Text = 'X'
                    closeBtn.TextColor3 = TextColor
                    closeBtn.TextSize = 12
                    closeBtn.AutoButtonColor = false

                    local closeCorner = Instance.new('UICorner')
                    closeCorner.CornerRadius = UDim.new(0, 4)
                    closeCorner.Parent = closeBtn

                    closeBtn.MouseButton1Click:Connect(function()
                        if pickerGui then
                            pickerGui:Destroy()
                            pickerGui = nil
                        end
                        isOpen = false
                    end)

                    satVibMap = Instance.new('ImageLabel')
                    satVibMap.Parent = mainFrame
                    satVibMap.Size = UDim2.new(0, 160, 0, 160)
                    satVibMap.Position = UDim2.new(0, 10, 0, 40)
                    satVibMap.Image = 'rbxassetid://4155801252'
                    satVibMap.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
                    satVibMap.BackgroundTransparency = 0

                    local satCorner = Instance.new('UICorner')
                    satCorner.CornerRadius = UDim.new(0, 8)
                    satCorner.Parent = satVibMap

                    satCursor = Instance.new('Frame')
                    satCursor.Parent = satVibMap
                    satCursor.Size = UDim2.new(0, 14, 0, 14)
                    satCursor.AnchorPoint = Vector2.new(0.5, 0.5)
                    satCursor.BackgroundColor3 = Color3.fromHSV(currentHue, currentSat, currentVib)

                    local cursorCorner = Instance.new('UICorner')
                    cursorCorner.CornerRadius = UDim.new(1, 0)
                    cursorCorner.Parent = satCursor

                    local cursorStroke = Instance.new('UIStroke')
                    cursorStroke.Thickness = 2
                    cursorStroke.Transparency = 0.1
                    cursorStroke.Color = Color3.fromRGB(255, 255, 255)
                    cursorStroke.Parent = satCursor

                    hueSlider = Instance.new('Frame')
                    hueSlider.Parent = mainFrame
                    hueSlider.Size = UDim2.new(0, 8, 0, 160)
                    hueSlider.Position = UDim2.new(0, 180, 0, 40)

                    local hueCorner = Instance.new('UICorner')
                    hueCorner.CornerRadius = UDim.new(1, 0)
                    hueCorner.Parent = hueSlider

                    local hueGradient = Instance.new('UIGradient')
                    hueGradient.Rotation = 90
                    local huePoints = {}
                    for i = 0, 10 do
                        local t = i / 10
                        table.insert(huePoints, ColorSequenceKeypoint.new(t, Color3.fromHSV(t, 1, 1)))
                    end
                    hueGradient.Color = ColorSequence.new(huePoints)
                    hueGradient.Parent = hueSlider

                    local hueDragHolder = Instance.new('Frame')
                    hueDragHolder.Parent = hueSlider
                    hueDragHolder.Size = UDim2.new(1, 0, 1, 0)
                    hueDragHolder.BackgroundTransparency = 1

                    hueDrag = Instance.new('Frame')
                    hueDrag.Parent = hueDragHolder
                    hueDrag.Size = UDim2.new(0, 14, 0, 14)
                    hueDrag.AnchorPoint = Vector2.new(0.5, 0.5)
                    hueDrag.Position = UDim2.new(0.5, 0, currentHue, 0)
                    hueDrag.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)

                    local dragCorner = Instance.new('UICorner')
                    dragCorner.CornerRadius = UDim.new(1, 0)
                    dragCorner.Parent = hueDrag

                    local dragStroke = Instance.new('UIStroke')
                    dragStroke.Thickness = 2
                    dragStroke.Transparency = 0.1
                    dragStroke.Color = Color3.fromRGB(255, 255, 255)
                    dragStroke.Parent = hueDrag

                    local inputsFrame = Instance.new('Frame')
                    inputsFrame.Parent = mainFrame
                    inputsFrame.Position = UDim2.new(0, 200, 0, 40)
                    inputsFrame.Size = UDim2.new(0, 120, 0, 120)
                    inputsFrame.BackgroundTransparency = 1

                    local function createInputBox(nameTag, y, placeholder, initialValue)
                        local box = Instance.new('TextBox')
                        box.Name = nameTag
                        box.Parent = inputsFrame
                        box.Position = UDim2.new(0, 0, 0, y)
                        box.Size = UDim2.new(0, 120, 0, 25)
                        box.BackgroundColor3 = ElementColor
                        box.Text = tostring(initialValue)
                        box.TextColor3 = TextColor
                        box.TextSize = 14
                        box.PlaceholderText = placeholder

                        local boxCorner = Instance.new('UICorner')
                        boxCorner.CornerRadius = UDim.new(0, 4)
                        boxCorner.Parent = box

                        return box
                    end

                    local rBox = createInputBox('RBox', 0, 'R', math.floor(defaultColor.R * 255))
                    local gBox = createInputBox('GBox', 30, 'G', math.floor(defaultColor.G * 255))
                    local bBox = createInputBox('BBox', 60, 'B', math.floor(defaultColor.B * 255))
                    local hexBox = createInputBox('HexBox', 90, 'Hex', '#' .. defaultColor:ToHex())
                    hexBox.Parent = mainFrame
                    hexBox.Position = UDim2.new(0, 200, 0, 170)

                    local oldColorFrame = Instance.new('Frame')
                    oldColorFrame.Parent = mainFrame
                    oldColorFrame.Position = UDim2.new(0, 10, 0, 210)
                    oldColorFrame.Size = UDim2.new(0, 75, 0, 24)
                    oldColorFrame.BackgroundColor3 = defaultColor
                    local oldCorner = Instance.new('UICorner')
                    oldCorner.CornerRadius = UDim.new(0, 8)
                    oldCorner.Parent = oldColorFrame

                    local newDisplayFrame = Instance.new('Frame')
                    newDisplayFrame.Name = 'NewDisplayFrame'
                    newDisplayFrame.Parent = mainFrame
                    newDisplayFrame.Position = UDim2.new(0, 95, 0, 210)
                    newDisplayFrame.Size = UDim2.new(0, 75, 0, 24)
                    newDisplayFrame.BackgroundColor3 = defaultColor
                    local newCorner = Instance.new('UICorner')
                    newCorner.CornerRadius = UDim.new(0, 8)
                    newCorner.Parent = newDisplayFrame

                    local btnFrame = Instance.new('Frame')
                    btnFrame.Parent = mainFrame
                    btnFrame.Position = UDim2.new(0, 10, 0, 250)
                    btnFrame.Size = UDim2.new(0, 160, 0, 40)
                    btnFrame.BackgroundTransparency = 1

                    local cancelBtn = Instance.new('TextButton')
                    cancelBtn.Parent = btnFrame
                    cancelBtn.Size = UDim2.new(0, 70, 0, 30)
                    cancelBtn.Position = UDim2.new(0, 0, 0, 5)
                    cancelBtn.BackgroundColor3 = ElementColor
                    cancelBtn.Text = 'Cancel'
                    cancelBtn.TextColor3 = TextColor
                    cancelBtn.TextSize = 14
                    local cancelCorner = Instance.new('UICorner')
                    cancelCorner.CornerRadius = UDim.new(0, 6)
                    cancelCorner.Parent = cancelBtn

                    local confirmBtn = Instance.new('TextButton')
                    confirmBtn.Parent = btnFrame
                    confirmBtn.Size = UDim2.new(0, 70, 0, 30)
                    confirmBtn.Position = UDim2.new(0, 80, 0, 5)
                    confirmBtn.BackgroundColor3 = PrimaryColor
                    confirmBtn.Text = 'Confirm'
                    confirmBtn.TextColor3 = TextColor
                    confirmBtn.TextSize = 14
                    local confirmCorner = Instance.new('UICorner')
                    confirmCorner.CornerRadius = UDim.new(0, 6)
                    confirmCorner.Parent = confirmBtn

                    local function updateFromRGB()
                        local r = math.clamp(tonumber(rBox.Text) or 0, 0, 255)
                        local g = math.clamp(tonumber(gBox.Text) or 0, 0, 255)
                        local b = math.clamp(tonumber(bBox.Text) or 0, 0, 255)
                        local newColor = Color3.fromRGB(r, g, b)
                        currentHue, currentSat, currentVib = Color3.toHSV(newColor)
                        updatePickerUI()
                    end

                    local draggingSat = false
                    local draggingHue = false

                    satVibMap.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            draggingSat = true
                            local x = (input.Position.X - satVibMap.AbsolutePosition.X) / satVibMap.AbsoluteSize.X
                            local y = (input.Position.Y - satVibMap.AbsolutePosition.Y) / satVibMap.AbsoluteSize.Y
                            currentSat = math.clamp(x, 0, 1)
                            currentVib = math.clamp(1 - y, 0, 1)
                            updatePickerUI()
                        end
                    end)
                    UserInputService.InputChanged:Connect(function(input)
                        if draggingSat and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                            local x = (input.Position.X - satVibMap.AbsolutePosition.X) / satVibMap.AbsoluteSize.X
                            local y = (input.Position.Y - satVibMap.AbsolutePosition.Y) / satVibMap.AbsoluteSize.Y
                            currentSat = math.clamp(x, 0, 1)
                            currentVib = math.clamp(1 - y, 0, 1)
                            updatePickerUI()
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            draggingSat = false
                            draggingHue = false
                        end
                    end)
                    hueSlider.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            draggingHue = true
                            local y = (input.Position.Y - hueSlider.AbsolutePosition.Y) / hueSlider.AbsoluteSize.Y
                            currentHue = math.clamp(y, 0, 1)
                            updatePickerUI()
                        end
                    end)
                    UserInputService.InputChanged:Connect(function(input)
                        if draggingHue and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                            local y = (input.Position.Y - hueSlider.AbsolutePosition.Y) / hueSlider.AbsoluteSize.Y
                            currentHue = math.clamp(y, 0, 1)
                            updatePickerUI()
                        end
                    end)

                    rBox.FocusLost:Connect(function(enter) if enter then updateFromRGB() end end)
                    gBox.FocusLost:Connect(function(enter) if enter then updateFromRGB() end end)
                    bBox.FocusLost:Connect(function(enter) if enter then updateFromRGB() end end)
                    hexBox.FocusLost:Connect(function(enter)
                        if enter then
                            local hex = hexBox.Text:gsub('#', '')
                            local success, col = pcall(Color3.fromHex, hex)
                            if success and typeof(col) == 'Color3' then
                                currentHue, currentSat, currentVib = Color3.toHSV(col)
                                updatePickerUI()
                            else
                                hexBox.Text = '#' .. Color3.fromHSV(currentHue, currentSat, currentVib):ToHex()
                            end
                        end
                    end)

                    confirmBtn.MouseButton1Click:Connect(function()
                        local newColor = Color3.fromHSV(currentHue, currentSat, currentVib)
                        updateColor(newColor)
                        pickerGui:Destroy()
                        pickerGui = nil
                        isOpen = false
                    end)
                    cancelBtn.MouseButton1Click:Connect(function()
                        pickerGui:Destroy()
                        pickerGui = nil
                        isOpen = false
                    end)

                    updatePickerUI()
                end

                ColorBtn.MouseButton1Click:Connect(function()
                    if not isOpen then
                        createPicker()
                        isOpen = true
                    else
                        if pickerGui then
                            pickerGui:Destroy()
                            pickerGui = nil
                        end
                        createPicker()
                    end
                end)

                local funcs = {
                    SetColor = function(self, newColor)
                        updateColor(newColor)
                    end,
                    Module = ColorModule,
                }

                if _G.AutoRegisterAI then
                    _G.AIFeatures[text] = {type = 'colorpicker', object = funcs, flag = flag, control = function(value) funcs:SetColor(value) end}
                end

                return funcs
            end

            function section.Toggle(section, text, flag, enabled, callback)
                local callback = callback or function() end
                local enabled = enabled or false
                assert(text, 'No text provided')
                assert(flag, 'No flag provided')

                Library.flags[flag] = enabled

                local ToggleModule = Instance.new('Frame')
                local ToggleBtn = Instance.new('TextButton')
                local ToggleBtnC = Instance.new('UICorner')
                local ToggleDisable = Instance.new('Frame')
                local ToggleSwitch = Instance.new('Frame')
                local ToggleSwitchC = Instance.new('UICorner')
                local ToggleDisableC = Instance.new('UICorner')

                ToggleModule.Name = 'ToggleModule'
                ToggleModule.Parent = Objs
                ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleModule.BackgroundTransparency = 1
                ToggleModule.BorderSizePixel = 0
                ToggleModule.Position = UDim2.new(0, 0, 0, 0)
                ToggleModule.Size = UDim2.new(0, 428, 0, 38)

                ToggleBtn.Name = 'ToggleBtn'
                ToggleBtn.Parent = ToggleModule
                ToggleBtn.BackgroundColor3 = ElementColor
                ToggleBtn.BackgroundTransparency = 0.1
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.Size = UDim2.new(0, 428, 0, 38)
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.Font = Enum.Font.GothamSemibold
                ToggleBtn.Text = '   ' .. text
                ToggleBtn.TextColor3 = TextColor
                ToggleBtn.TextSize = 16
                ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left

                ToggleBtnC.CornerRadius = UDim.new(0, 6)
                ToggleBtnC.Name = 'ToggleBtnC'
                ToggleBtnC.Parent = ToggleBtn

                ToggleDisable.Name = 'ToggleDisable'
                ToggleDisable.Parent = ToggleBtn
                ToggleDisable.BackgroundColor3 = Background
                ToggleDisable.BorderSizePixel = 0
                ToggleDisable.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
                ToggleDisable.Size = UDim2.new(0, 36, 0, 22)

                local ToggleDisableCorner = Instance.new('UICorner')
                ToggleDisableCorner.Parent = ToggleDisable
                ToggleDisableCorner.CornerRadius = UDim.new(0, 11)

                ToggleSwitch.Name = 'ToggleSwitch'
                ToggleSwitch.Parent = ToggleDisable
                ToggleSwitch.BackgroundColor3 = BackgroundColor
                ToggleSwitch.Size = UDim2.new(0, 24, 0, 22)

                ToggleSwitchC.CornerRadius = UDim.new(0, 6)
                ToggleSwitchC.Name = 'ToggleSwitchC'
                ToggleSwitchC.Parent = ToggleSwitch

                ToggleDisableC.CornerRadius = UDim.new(0, 6)
                ToggleDisableC.Name = 'ToggleDisableC'
                ToggleDisableC.Parent = ToggleDisable

                local funcs = {
                    SetState = function(self, state)
                        if state == nil then
                            state = not Library.flags[flag]
                        end
                        if Library.flags[flag] == state then
                            return
                        end

                        -- 激活态使用极光电光青(AccentColor)
                        TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
                            Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0),
                            BackgroundColor3 = (state and AccentColor or BackgroundColor),
                        }):Play()

                        Library.flags[flag] = state
                        callback(state)
                    end,
                    Module = ToggleModule,
                }

                if enabled ~= false then
                    funcs:SetState(flag, true)
                end

                ToggleBtn.MouseButton1Click:Connect(function()
                    funcs:SetState()
                end)

                if _G.AutoRegisterAI then
                    _G.AIFeatures[text] = {type = 'toggle', object = funcs, flag = flag, control = function(value) funcs:SetState(value) end}
                end

                return funcs
            end

            function section.Keybind(section, text, default, callback)
                local callback = callback or function() end
                assert(text, 'No text provided')
                assert(default, 'No default key provided')

                local default = (typeof(default) == 'string' and Enum.KeyCode[default] or default)
                local banned = {Return = true, Space = true, Tab = true, Backquote = true, CapsLock = true, Escape = true, Unknown = true}
                local shortNames = {
                    RightControl = 'Right Ctrl', LeftControl = 'Left Ctrl', LeftShift = 'Left Shift',
                    RightShift = 'Right Shift', Semicolon = ';', Quote = '"', LeftBracket = '[',
                    RightBracket = ']', Equals = '=', Minus = '-', RightAlt = 'Right Alt', LeftAlt = 'Left Alt',
                }

                local bindKey = default
                local keyTxt = (default and (shortNames[default.Name] or default.Name) or 'None')

                local KeybindModule = Instance.new('Frame')
                local KeybindBtn = Instance.new('TextButton')
                local KeybindBtnC = Instance.new('UICorner')
                local KeybindValue = Instance.new('TextButton')
                local KeybindValueC = Instance.new('UICorner')
                local KeybindL = Instance.new('UIListLayout')
                local UIPadding = Instance.new('UIPadding')

                KeybindModule.Name = 'KeybindModule'
                KeybindModule.Parent = Objs
                KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindModule.BackgroundTransparency = 1
                KeybindModule.BorderSizePixel = 0
                KeybindModule.Position = UDim2.new(0, 0, 0, 0)
                KeybindModule.Size = UDim2.new(0, 428, 0, 38)

                KeybindBtn.Name = 'KeybindBtn'
                KeybindBtn.Parent = KeybindModule
                KeybindBtn.BackgroundColor3 = ElementColor
                KeybindBtn.BackgroundTransparency = 0.1
                KeybindBtn.BorderSizePixel = 0
                KeybindBtn.Size = UDim2.new(0, 428, 0, 38)
                KeybindBtn.AutoButtonColor = false
                KeybindBtn.Font = Enum.Font.GothamSemibold
                KeybindBtn.Text = '   ' .. text
                KeybindBtn.TextColor3 = TextColor
                KeybindBtn.TextSize = 16
                KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left

                KeybindBtnC.CornerRadius = UDim.new(0, 6)
                KeybindBtnC.Name = 'KeybindBtnC'
                KeybindBtnC.Parent = KeybindBtn

                KeybindValue.Name = 'KeybindValue'
                KeybindValue.Parent = KeybindBtn
                KeybindValue.BackgroundColor3 = Background
                KeybindValue.BorderSizePixel = 0
                KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
                KeybindValue.Size = UDim2.new(0, 100, 0, 28)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = Enum.Font.Gotham
                KeybindValue.Text = keyTxt
                KeybindValue.TextColor3 = TextColor
                KeybindValue.TextSize = 14

                KeybindValueC.CornerRadius = UDim.new(0, 6)
                KeybindValueC.Name = 'KeybindValueC'
                KeybindValueC.Parent = KeybindValue

                KeybindL.Name = 'KeybindL'
                KeybindL.Parent = KeybindBtn
                KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
                KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center

                UIPadding.Parent = KeybindBtn
                UIPadding.PaddingRight = UDim.new(0, 6)

                UserInputService.InputBegan:Connect(function(inp, gpe)
                    if gpe then return end
                    if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
                    if inp.KeyCode ~= bindKey then return end
                    callback(bindKey.Name)
                end)

                KeybindValue.MouseButton1Click:Connect(function()
                    KeybindValue.Text = '...'
                    wait()
                    local key = UserInputService.InputEnded:Wait()
                    local keyName = tostring(key.KeyCode.Name)
                    if key.UserInputType ~= Enum.UserInputType.Keyboard then
                        KeybindValue.Text = keyTxt
                        return
                    end
                    if banned[keyName] then
                        KeybindValue.Text = keyTxt
                        return
                    end
                    wait()
                    bindKey = Enum.KeyCode[keyName]
                    keyTxt = shortNames[keyName] or keyName
                    KeybindValue.Text = keyTxt
                end)

                KeybindValue:GetPropertyChangedSignal('TextBounds'):Connect(function()
                    KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
                end)
                KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)

                if _G.AutoRegisterAI then
                    _G.AIFeatures[text] = {type = 'keybind', callback = callback}
                end
            end

            function section.Textbox(section, text, flag, default, callback)
                local callback = callback or function() end
                assert(text, 'No text provided')
                assert(flag, 'No flag provided')
                assert(default, 'No default text provided')

                Library.flags[flag] = default

                local TextboxModule = Instance.new('Frame')
                local TextboxBack = Instance.new('TextButton')
                local TextboxBackC = Instance.new('UICorner')
                local BoxBG = Instance.new('TextButton')
                local BoxBGC = Instance.new('UICorner')
                local TextBox = Instance.new('TextBox')
                local TextboxBackL = Instance.new('UIListLayout')
                local TextboxBackP = Instance.new('UIPadding')

                TextboxModule.Name = 'TextboxModule'
                TextboxModule.Parent = Objs
                TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxModule.BackgroundTransparency = 1
                TextboxModule.BorderSizePixel = 0
                TextboxModule.Position = UDim2.new(0, 0, 0, 0)
                TextboxModule.Size = UDim2.new(0, 428, 0, 38)

                TextboxBack.Name = 'TextboxBack'
                TextboxBack.Parent = TextboxModule
                TextboxBack.BackgroundColor3 = ElementColor
                TextboxBack.BackgroundTransparency = 0.1
                TextboxBack.BorderSizePixel = 0
                TextboxBack.Size = UDim2.new(0, 428, 0, 38)
                TextboxBack.AutoButtonColor = false
                TextboxBack.Font = Enum.Font.GothamSemibold
                TextboxBack.Text = '   ' .. text
                TextboxBack.TextColor3 = TextColor
                TextboxBack.TextSize = 16
                TextboxBack.TextXAlignment = Enum.TextXAlignment.Left

                TextboxBackC.CornerRadius = UDim.new(0, 6)
                TextboxBackC.Name = 'TextboxBackC'
                TextboxBackC.Parent = TextboxBack

                BoxBG.Name = 'BoxBG'
                BoxBG.Parent = TextboxBack
                BoxBG.BackgroundColor3 = Background
                BoxBG.BorderSizePixel = 0
                BoxBG.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
                BoxBG.Size = UDim2.new(0, 100, 0, 28)
                BoxBG.AutoButtonColor = false
                BoxBG.Font = Enum.Font.Gotham
                BoxBG.Text = ''
                BoxBG.TextColor3 = TextColor
                BoxBG.TextSize = 14

                BoxBGC.CornerRadius = UDim.new(0, 6)
                BoxBGC.Name = 'BoxBGC'
                BoxBGC.Parent = BoxBG

                TextBox.Parent = BoxBG
                TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.BackgroundTransparency = 1
                TextBox.BorderSizePixel = 0
                TextBox.Size = UDim2.new(1, 0, 1, 0)
                TextBox.Font = Enum.Font.Gotham
                TextBox.Text = default
                TextBox.TextColor3 = TextColor
                TextBox.TextSize = 14

                TextboxBackL.Name = 'TextboxBackL'
                TextboxBackL.Parent = TextboxBack
                TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
                TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center

                TextboxBackP.Name = 'TextboxBackP'
                TextboxBackP.Parent = TextboxBack
                TextboxBackP.PaddingRight = UDim.new(0, 6)

                TextBox.FocusLost:Connect(function()
                    if TextBox.Text == '' then
                        TextBox.Text = default
                    end
                    Library.flags[flag] = TextBox.Text
                    callback(TextBox.Text)
                end)

                TextBox:GetPropertyChangedSignal('TextBounds'):Connect(function()
                    BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
                end)
                BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)

                if _G.AutoRegisterAI then
                    _G.AIFeatures[text] = {
                        type = 'textbox',
                        object = TextBox,
                        flag = flag,
                        control = function(value)
                            TextBox.Text = tostring(value)
                            Library.flags[flag] = tostring(value)
                            callback(tostring(value))
                        end,
                    }
                end

                return TextboxModule
            end

            function section.Slider(section, text, flag, default, min, max, precise, callback)
                local callback = callback or function() end
                local min = min or 1
                local max = max or 10
                local default = default or min
                local precise = precise or false

                Library.flags[flag] = default

                assert(text, 'No text provided')
                assert(flag, 'No flag provided')
                assert(default, 'No default value provided')

                local SliderModule = Instance.new('Frame')
                local SliderBack = Instance.new('TextButton')
                local SliderBackC = Instance.new('UICorner')
                local SliderBar = Instance.new('Frame')
                local SliderBarC = Instance.new('UICorner')
                local SliderPart = Instance.new('Frame')
                local SliderPartC = Instance.new('UICorner')
                local SliderValBG = Instance.new('TextButton')
                local SliderValBGC = Instance.new('UICorner')
                local SliderValue = Instance.new('TextBox')
                local MinSlider = Instance.new('TextButton')
                local AddSlider = Instance.new('TextButton')

                SliderModule.Name = 'SliderModule'
                SliderModule.Parent = Objs
                SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderModule.BackgroundTransparency = 1
                SliderModule.BorderSizePixel = 0
                SliderModule.Position = UDim2.new(0, 0, 0, 0)
                SliderModule.Size = UDim2.new(0, 428, 0, 38)

                SliderBack.Name = 'SliderBack'
                SliderBack.Parent = SliderModule
                SliderBack.BackgroundColor3 = ElementColor
                SliderBack.BackgroundTransparency = 0.1
                SliderBack.BorderSizePixel = 0
                SliderBack.Size = UDim2.new(0, 428, 0, 38)
                SliderBack.AutoButtonColor = false
                SliderBack.Font = Enum.Font.GothamSemibold
                SliderBack.Text = '   ' .. text
                SliderBack.TextColor3 = TextColor
                SliderBack.TextSize = 16
                SliderBack.TextXAlignment = Enum.TextXAlignment.Left

                SliderBackC.CornerRadius = UDim.new(0, 6)
                SliderBackC.Name = 'SliderBackC'
                SliderBackC.Parent = SliderBack

                SliderBar.Name = 'SliderBar'
                SliderBar.Parent = SliderBack
                SliderBar.AnchorPoint = Vector2.new(0, 0.5)
                SliderBar.BackgroundColor3 = Background
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0.369000018, 40, 0.5, 0)
                SliderBar.Size = UDim2.new(0, 140, 0, 12)

                SliderBarC.CornerRadius = UDim.new(0, 6)
                SliderBarC.Name = 'SliderBarC'
                SliderBarC.Parent = SliderBar

                SliderPart.Name = 'SliderPart'
                SliderPart.Parent = SliderBar
                -- 滑块条用极光电光青
                SliderPart.BackgroundColor3 = AccentColor
                SliderPart.BorderSizePixel = 0
                SliderPart.Size = UDim2.new(0, 54, 0, 13)

                SliderPartC.CornerRadius = UDim.new(0, 6)
                SliderPartC.Name = 'SliderPartC'
                SliderPartC.Parent = SliderPart

                SliderValBG.Name = 'SliderValBG'
                SliderValBG.Parent = SliderBack
                SliderValBG.BackgroundColor3 = Background
                SliderValBG.BorderSizePixel = 0
                SliderValBG.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
                SliderValBG.Size = UDim2.new(0, 44, 0, 28)
                SliderValBG.AutoButtonColor = false
                SliderValBG.Font = Enum.Font.Gotham
                SliderValBG.Text = ''
                SliderValBG.TextColor3 = TextColor
                SliderValBG.TextSize = 14

                SliderValBGC.CornerRadius = UDim.new(0, 6)
                SliderValBGC.Name = 'SliderValBGC'
                SliderValBGC.Parent = SliderValBG

                SliderValue.Name = 'SliderValue'
                SliderValue.Parent = SliderValBG
                SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.BackgroundTransparency = 1
                SliderValue.BorderSizePixel = 0
                SliderValue.Size = UDim2.new(1, 0, 1, 0)
                SliderValue.Font = Enum.Font.Gotham
                SliderValue.Text = '1000'
                SliderValue.TextColor3 = TextColor
                SliderValue.TextSize = 14

                MinSlider.Name = 'MinSlider'
                MinSlider.Parent = SliderModule
                MinSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                MinSlider.BackgroundTransparency = 1
                MinSlider.BorderSizePixel = 0
                MinSlider.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
                MinSlider.Size = UDim2.new(0, 20, 0, 20)
                MinSlider.Font = Enum.Font.Gotham
                MinSlider.Text = '-'
                MinSlider.TextColor3 = TextColor
                MinSlider.TextSize = 24
                MinSlider.TextWrapped = true

                AddSlider.Name = 'AddSlider'
                AddSlider.Parent = SliderModule
                AddSlider.AnchorPoint = Vector2.new(0, 0.5)
                AddSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                AddSlider.BackgroundTransparency = 1
                AddSlider.BorderSizePixel = 0
                AddSlider.Position = UDim2.new(0.810906529, 0, 0.5, 0)
                AddSlider.Size = UDim2.new(0, 20, 0, 20)
                AddSlider.Font = Enum.Font.Gotham
                AddSlider.Text = '+'
                AddSlider.TextColor3 = TextColor
                AddSlider.TextSize = 24
                AddSlider.TextWrapped = true

                local funcs = {
                    SetValue = function(self, value)
                        local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                        if value then
                            percent = (value - min) / (max - min)
                        end
                        percent = math.clamp(percent, 0, 1)

                        if precise then
                            value = value or tonumber(string.format('%.1f', tostring(min + (max - min) * percent)))
                        else
                            value = value or math.floor(min + (max - min) * percent)
                        end

                        Library.flags[flag] = tonumber(value)
                        SliderValue.Text = tostring(value)
                        SliderPart.Size = UDim2.new(percent, 0, 1, 0)
                        callback(tonumber(value))
                    end,
                }

                MinSlider.MouseButton1Click:Connect(function()
                    local currentValue = Library.flags[flag]
                    currentValue = math.clamp(currentValue - 1, min, max)
                    funcs:SetValue(currentValue)
                end)

                AddSlider.MouseButton1Click:Connect(function()
                    local currentValue = Library.flags[flag]
                    currentValue = math.clamp(currentValue + 1, min, max)
                    funcs:SetValue(currentValue)
                end)

                funcs:SetValue(default)

                local dragging, boxFocused, allowed = false, false, {[''] = true, ['-'] = true}

                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        funcs:SetValue()
                        dragging = true
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                        dragging = false
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        funcs:SetValue()
                    end
                end)

                SliderValue.Focused:Connect(function()
                    boxFocused = true
                end)

                SliderValue.FocusLost:Connect(function()
                    boxFocused = false
                    if SliderValue.Text == '' then
                        funcs:SetValue(default)
                    end
                end)

                SliderValue:GetPropertyChangedSignal('Text'):Connect(function()
                    if not boxFocused then
                        return
                    end
                    SliderValue.Text = SliderValue.Text:gsub('%D+', '')
                    local text = SliderValue.Text
                    if not tonumber(text) then
                        SliderValue.Text = SliderValue.Text:gsub('%D+', '')
                    elseif not allowed[text] then
                        if tonumber(text) > max then
                            text = max
                            SliderValue.Text = tostring(max)
                        end
                        funcs:SetValue(tonumber(text))
                    end
                end)

                if _G.AutoRegisterAI then
                    _G.AIFeatures[text] = {type = 'slider', object = funcs, flag = flag, control = function(value) funcs:SetValue(value) end}
                end

                return funcs, SliderModule
            end

            function section.Dropdown(section, text, flag, options, default, callback)
                local callback = callback or function() end
                if type(default) == 'function' then
                    callback = default
                    default = nil
                end
                local options = options or {}

                assert(text, 'No text provided')
                assert(flag, 'No flag provided')

                Library.flags[flag] = options[default]

                local DropdownModule = Instance.new('Frame')
                local DropdownTop = Instance.new('TextButton')
                local DropdownTopC = Instance.new('UICorner')
                local DropdownOpen = Instance.new('TextButton')
                local DropdownText = Instance.new('TextBox')
                local DropdownModuleL = Instance.new('UIListLayout')

                DropdownModule.Name = 'DropdownModule'
                DropdownModule.Parent = Objs
                DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownModule.BackgroundTransparency = 1
                DropdownModule.BorderSizePixel = 0
                DropdownModule.ClipsDescendants = true
                DropdownModule.Position = UDim2.new(0, 0, 0, 0)
                DropdownModule.Size = UDim2.new(0, 428, 0, 38)

                DropdownTop.Name = 'DropdownTop'
                DropdownTop.Parent = DropdownModule
                DropdownTop.BackgroundColor3 = ElementColor
                DropdownTop.BackgroundTransparency = 0.1
                DropdownTop.BorderSizePixel = 0
                DropdownTop.Size = UDim2.new(0, 428, 0, 38)
                DropdownTop.AutoButtonColor = false
                DropdownTop.Font = Enum.Font.GothamSemibold
                DropdownTop.Text = ''
                DropdownTop.TextColor3 = TextColor
                DropdownTop.TextSize = 16
                DropdownTop.TextXAlignment = Enum.TextXAlignment.Left

                DropdownTopC.CornerRadius = UDim.new(0, 6)
                DropdownTopC.Name = 'DropdownTopC'
                DropdownTopC.Parent = DropdownTop

                DropdownOpen.Name = 'DropdownOpen'
                DropdownOpen.Parent = DropdownTop
                DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
                DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownOpen.BackgroundTransparency = 1
                DropdownOpen.BorderSizePixel = 0
                DropdownOpen.Position = UDim2.new(0.918383181, 0, 0.5, 0)
                DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
                DropdownOpen.Font = Enum.Font.Gotham
                DropdownOpen.Text = '+'
                DropdownOpen.TextColor3 = TextColor
                DropdownOpen.TextSize = 24
                DropdownOpen.TextWrapped = true

                DropdownText.Name = 'DropdownText'
                DropdownText.Parent = DropdownTop
                DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.BackgroundTransparency = 1
                DropdownText.BorderSizePixel = 0
                DropdownText.Position = UDim2.new(0.0373831764, 0, 0, 0)
                DropdownText.Size = UDim2.new(0, 184, 0, 38)
                DropdownText.Font = Enum.Font.GothamSemibold
                DropdownText.PlaceholderColor3 = SubTextColor
                DropdownText.PlaceholderText = default and text .. ' - ' .. options[default] or text
                DropdownText.Text = ''
                DropdownText.TextColor3 = TextColor
                DropdownText.TextSize = 16
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left

                DropdownModuleL.Name = 'DropdownModuleL'
                DropdownModuleL.Parent = DropdownModule
                DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownModuleL.Padding = UDim.new(0, 4)

                local setAllVisible = function()
                    for _, option in ipairs(DropdownModule:GetChildren()) do
                        if option:IsA('TextButton') and option.Name:match('Option_') then
                            option.Visible = true
                        end
                    end
                end

                local searchDropdown = function(text)
                    for _, option in ipairs(DropdownModule:GetChildren()) do
                        if option:IsA('TextButton') and option.Name:match('Option_') then
                            option.Visible = (text == '' or option.Text:lower():match(text:lower()))
                        end
                    end
                end

                local open = false
                local ToggleDropVis = function()
                    open = not open
                    if open then
                        setAllVisible()
                    end
                    DropdownOpen.Text = (open and '-' or '+')
                    DropdownModule.Size = UDim2.new(0, 428, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 4 or 38))
                end

                DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
                DropdownText.Focused:Connect(function()
                    if open then return end
                    ToggleDropVis()
                end)

                DropdownText:GetPropertyChangedSignal('Text'):Connect(function()
                    if not open then return end
                    searchDropdown(DropdownText.Text)
                end)

                DropdownModuleL:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
                    if not open then return end
                    DropdownModule.Size = UDim2.new(0, 428, 0, DropdownModuleL.AbsoluteContentSize.Y + 4)
                end)

                local funcs = {}
                funcs.AddOption = function(self, option)
                    option = tostring(option)
                    local Option = Instance.new('TextButton')
                    local OptionC = Instance.new('UICorner')

                    Option.Name = 'Option_' .. option
                    Option.Parent = DropdownModule
                    Option.BackgroundColor3 = ElementColor
                    Option.BackgroundTransparency = 0.05
                    Option.BorderSizePixel = 0
                    Option.Position = UDim2.new(0, 0, 0.328125, 0)
                    Option.Size = UDim2.new(0, 428, 0, 26)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.Gotham
                    Option.Text = option
                    Option.TextColor3 = TextColor
                    Option.TextSize = 14

                    OptionC.CornerRadius = UDim.new(0, 6)
                    OptionC.Name = 'OptionC'
                    OptionC.Parent = Option

                    Option.MouseButton1Click:Connect(function()
                        ToggleDropVis()
                        callback(Option.Text)
                        DropdownText.Text = text .. ' - ' .. Option.Text
                        Library.flags[flag] = Option.Text
                    end)
                end

                funcs.RemoveOption = function(self, option)
                    option = tostring(option)
                    local opt = DropdownModule:FindFirstChild('Option_' .. option)
                    if opt then
                        opt:Destroy()
                    end
                end

                funcs.SetOptions = function(self, options)
                    for _, v in next, DropdownModule:GetChildren() do
                        if v.Name:match('Option_') then
                            v:Destroy()
                        end
                    end
                    for _, v in next, options do
                        self:AddOption(v)
                    end
                end

                funcs:SetOptions(options)

                if _G.AutoRegisterAI then
                    _G.AIFeatures[text] = {type = 'dropdown', object = funcs, flag = flag, control = function(value) Library.flags[flag] = value; callback(value) end}
                end

                return funcs
            end

            return section
        end
        return tab
    end
    return Window
end

return Library
