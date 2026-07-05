repeat
	task.wait()
until game:IsLoaded()

pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Jilxi/123/refs/heads/main/1.lua"))()
end)

local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}
local services = setmetatable({}, {
	__index = function(t, k)
		return cloneref(game:GetService(k))
	end,
})
local mouse = services.Players.LocalPlayer:GetMouse()

local TextColor = Color3.fromRGB(255, 255, 255)
local PlaceholderColor = Color3.fromRGB(180, 180, 180)
local DisabledTextColor = Color3.fromRGB(150, 150, 150)

function Tween(obj, t, data)
	services.TweenService
		:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data)
		:Play()
	return true
end

function Ripple(obj)
	spawn(function()
		if obj.ClipsDescendants ~= true then
			obj.ClipsDescendants = true
		end
		local Ripple = Instance.new("ImageLabel")
		Ripple.Name = "Ripple"
		Ripple.Parent = obj
		Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Ripple.BackgroundTransparency = 1.000
		Ripple.ZIndex = 8
		Ripple.Image = "rbxassetid://2708891598"
		Ripple.ImageTransparency = 0.800
		Ripple.ScaleType = Enum.ScaleType.Fit
		Ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Ripple.Position = UDim2.new(
			(mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X,
			0,
			(mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y,
			0
		)
		Tween(
			Ripple,
			{ 0.3, "Linear", "InOut" },
			{ Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0) }
		)
		wait(0.15)
		Tween(Ripple, { 0.3, "Linear", "InOut" }, { ImageTransparency = 1 })
		wait(0.3)
		Ripple:Destroy()
	end)
end

local toggled = false
local switchingTabs = false

function switchTab(new)
	if switchingTabs then
		return
	end
	local old = library.currentTab
	if old == nil then
		new[2].Visible = true
		library.currentTab = new
		services.TweenService:Create(new[1], TweenInfo.new(0.1), { ImageTransparency = 0 }):Play()
		services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), { TextTransparency = 0 }):Play()
		return
	end
	if old[1] == new[1] then
		return
	end
	switchingTabs = true
	library.currentTab = new
	services.TweenService:Create(old[1], TweenInfo.new(0.1), { ImageTransparency = 0.2 }):Play()
	services.TweenService:Create(new[1], TweenInfo.new(0.1), { ImageTransparency = 0 }):Play()
	services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), { TextTransparency = 0.2 }):Play()
	services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), { TextTransparency = 0 }):Play()
	old[2].Visible = false
	new[2].Visible = true
	task.wait(0.1)
	switchingTabs = false
end

function drag(frame, hold)
	if not hold then
		hold = frame
	end
	local dragging
	local dragInput
	local dragStart
	local startPos
	local function update(input)
		local delta = input.Position - dragStart
		frame.Position =
			UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	hold.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	services.UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

local gethui = gethui or function()
	return cloneref(game:GetService("CoreGui"))
end

function library.new(library, name, theme)
	for _, v in next, gethui():GetChildren() do
		if v.Name == "REN" then
			v:Destroy()
		end
	end

	MainColor = Color3.fromRGB(25, 25, 25)
	Background = Color3.fromRGB(25, 25, 25)
	BackgroundTransparency = 0.5
	zyColor = Color3.fromRGB(35, 40, 70)
	zyColorTransparency = 0.3
	beijingColor = Color3.fromRGB(255, 255, 255)

	local dogent = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local TabMain = Instance.new("Frame")
	local MainC = Instance.new("UICorner")
	local SB = Instance.new("Frame")
	local SBC = Instance.new("UICorner")
	local Side = Instance.new("Frame")
	local SideG = Instance.new("UIGradient")
	local TabBtns = Instance.new("ScrollingFrame")
	local TabBtnsL = Instance.new("UIListLayout")
	local ScriptTitle = Instance.new("TextLabel")
	local SBG = Instance.new("UIGradient")
	local Open = Instance.new("TextButton")
	local UIG = Instance.new("UIGradient")
	local DropShadowHolder = Instance.new("Frame")
	local DropShadow = Instance.new("ImageLabel")
	local UICornerMain = Instance.new("UICorner")
	local UIGradient = Instance.new("UIGradient")
	local UIGradientTitle = Instance.new("UIGradient")

	if syn and syn.protect_gui then
		syn.protect_gui(dogent)
	end

	dogent.Name = "REN"
	dogent.Parent = gethui()

	function UiDestroy()
		dogent:Destroy()
	end

	function ToggleUILib()
		Main.Visible = not Main.Visible
	end

	Main.Name = "Main"
	Main.Parent = dogent
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Background
	Main.BackgroundTransparency = BackgroundTransparency
	Main.BorderColor3 = MainColor
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 572, 0, 353)
	Main.ZIndex = 1
	Main.Active = true
	Main.Draggable = true

	services.UserInputService.InputEnded:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.RightShift then
			Main.Visible = not Main.Visible
		end
	end)

	drag(Main)
	UICornerMain.Parent = Main
	UICornerMain.CornerRadius = UDim.new(0, 3)

	DropShadowHolder.Name = "DropShadowHolder"
	DropShadowHolder.Parent = Main
	DropShadowHolder.BackgroundTransparency = 1.000
	DropShadowHolder.BorderSizePixel = 0
	DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
	DropShadowHolder.BorderColor3 = Color3.fromRGB(255, 255, 255)
	DropShadowHolder.ZIndex = 0

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = DropShadowHolder
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1.000
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 43, 1, 43)
	DropShadow.ZIndex = 0
	DropShadow.Image = "rbxassetid://6015897843"
	DropShadow.ImageColor3 = Color3.fromRGB(255, 255, 255)
	DropShadow.ImageTransparency = 0.500
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(52, 152, 219)),
		ColorSequenceKeypoint.new(0.25, Color3.fromRGB(41, 128, 185)),
		ColorSequenceKeypoint.new(0.50, Color3.fromRGB(31, 97, 141)),
		ColorSequenceKeypoint.new(0.75, Color3.fromRGB(21, 67, 96)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(52, 152, 219)),
	})
	UIGradient.Parent = DropShadow

	local TweenService = cloneref(game:GetService("TweenService"))
	local tweeninfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
	local tween = TweenService:Create(UIGradient, tweeninfo, { Rotation = 360 })
	tween:Play()

	TabMain.Name = "TabMain"
	TabMain.Parent = Main
	TabMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabMain.BackgroundTransparency = 1.000
	TabMain.Position = UDim2.new(0.217000037, 0, 0, 3)
	TabMain.Size = UDim2.new(0, 448, 0, 353)

	MainC.CornerRadius = UDim.new(0, 5.5)
	MainC.Name = "MainC"
	MainC.Parent = Main

	SB.Name = "SB"
	SB.Parent = Main
	SB.BackgroundColor3 = Background
	SB.BackgroundTransparency = BackgroundTransparency
	SB.BorderColor3 = MainColor
	SB.Size = UDim2.new(0, 8, 0, 353)

	SBC.CornerRadius = UDim.new(0, 6)
	SBC.Name = "SBC"
	SBC.Parent = SB

	Side.Name = "Side"
	Side.Parent = SB
	Side.BackgroundColor3 = Background
	Side.BackgroundTransparency = BackgroundTransparency
	Side.BorderColor3 = Color3.fromRGB(255, 255, 255)
	Side.BorderSizePixel = 0
	Side.ClipsDescendants = true
	Side.Position = UDim2.new(1, 0, 0, 0)
	Side.Size = UDim2.new(0, 110, 0, 353)

	SideG.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor) })
	SideG.Rotation = 90
	SideG.Name = "SideG"
	SideG.Parent = Side

	TabBtns.Name = "TabBtns"
	TabBtns.Parent = Side
	TabBtns.Active = true
	TabBtns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabBtns.BackgroundTransparency = 1.000
	TabBtns.BorderSizePixel = 0
	TabBtns.Position = UDim2.new(0, 0, 0.0973535776, 0)
	TabBtns.Size = UDim2.new(0, 110, 0, 318)
	TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
	TabBtns.ScrollBarThickness = 0

	TabBtnsL.Name = "TabBtnsL"
	TabBtnsL.Parent = TabBtns
	TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
	TabBtnsL.Padding = UDim.new(0, 12)

	ScriptTitle.Name = "ScriptTitle"
	ScriptTitle.Parent = Side
	ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScriptTitle.BackgroundTransparency = 1.000
	ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
	ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
	ScriptTitle.Font = Enum.Font.GothamBlack
	ScriptTitle.Text = name
	ScriptTitle.TextColor3 = TextColor
	ScriptTitle.TextSize = 16.000
	ScriptTitle.TextTransparency = 0
	ScriptTitle.TextScaled = true
	ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left

	UIGradientTitle.Parent = ScriptTitle

	local function NPLHKB_fake_script()
		local script = Instance.new("LocalScript", ScriptTitle)
		local button = script.Parent
		local gradient = button.UIGradient
		local ts = cloneref(game:GetService("TweenService"))
		local ti = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
		local offset = { Offset = Vector2.new(1, 0) }
		local create = ts:Create(gradient, ti, offset)
		local startingPos = Vector2.new(-1, 0)
		local list = {}
		local s, kpt = ColorSequence.new, ColorSequenceKeypoint.new
		local counter = 0
		local status = "down"
		gradient.Offset = startingPos
		local function rainbowColors()
			local sat, val = 255, 255
			for i = 1, 10 do
				local hue = i * 17
				table.insert(list, Color3.fromHSV(hue / 255, sat / 255, val / 255))
			end
		end
		rainbowColors()
		gradient.Color = s({ kpt(0, list[#list]), kpt(0.5, list[#list - 1]), kpt(1, list[#list - 2]) })
		counter = #list
		local function animate()
			create:Play()
			create.Completed:Wait()
			gradient.Offset = startingPos
			gradient.Rotation = 180
			if counter == #list - 1 and status == "down" then
				gradient.Color = s({ kpt(0, gradient.Color.Keypoints[1].Value), kpt(0.5, list[#list]), kpt(1, list[1]) })
				counter = 1
				status = "up"
			elseif counter == #list and status == "down" then
				gradient.Color = s({ kpt(0, gradient.Color.Keypoints[1].Value), kpt(0.5, list[1]), kpt(1, list[2]) })
				counter = 2
				status = "up"
			elseif counter <= #list - 2 and status == "down" then
				gradient.Color = s({ kpt(0, gradient.Color.Keypoints[1].Value), kpt(0.5, list[counter + 1]), kpt(1, list[counter + 2]) })
				counter = counter + 2
				status = "up"
			end
			create:Play()
			create.Completed:Wait()
			gradient.Offset = startingPos
			gradient.Rotation = 0
			if counter == #list - 1 and status == "up" then
				gradient.Color = s({ kpt(0, list[1]), kpt(0.5, list[#list]), kpt(1, gradient.Color.Keypoints[3].Value) })
				counter = 1
				status = "down"
			elseif counter == #list and status == "up" then
				gradient.Color = s({ kpt(0, list[2]), kpt(0.5, list[1]), kpt(1, gradient.Color.Keypoints[3].Value) })
				counter = 2
				status = "down"
			elseif counter <= #list - 2 and status == "up" then
				gradient.Color = s({ kpt(0, list[counter + 2]), kpt(0.5, list[counter + 1]), kpt(1, gradient.Color.Keypoints[3].Value) })
				counter = counter + 2
				status = "down"
			end
			animate()
		end
		animate()
	end
	coroutine.wrap(NPLHKB_fake_script)()

	SBG.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor) })
	SBG.Rotation = 90
	SBG.Name = "SBG"
	SBG.Parent = SB

	TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
	end)

	Open.Name = "Open"
	Open.Parent = dogent
	Open.BackgroundColor3 = Color3.fromRGB(28, 33, 55)
	Open.BackgroundTransparency = BackgroundTransparency
	Open.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
	Open.Size = UDim2.new(0, 61, 0, 32)
	Open.Font = Enum.Font.GothamBold
	Open.Text = "打开/关闭"
	Open.TextColor3 = TextColor
	Open.TextTransparency = 0
	Open.TextSize = 14.000
	Open.Active = true
	Open.Draggable = true
	Open.ZIndex = 100

	UIG.Parent = Open

	Open.MouseButton1Click:Connect(function()
		Main.Visible = not Main.Visible
	end)

	local window = {}

	function window.Tab(window, name, icon)
		local Tab = Instance.new("ScrollingFrame")
		local TabIco = Instance.new("ImageLabel")
		local TabText = Instance.new("TextLabel")
		local TabBtn = Instance.new("TextButton")
		local TabL = Instance.new("UIListLayout")

		Tab.Name = "Tab"
		Tab.Parent = TabMain
		Tab.Active = true
		Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab.BackgroundTransparency = 1.000
		Tab.Size = UDim2.new(1, 0, 1, 0)
		Tab.ScrollBarThickness = 2
		Tab.Visible = false

		TabIco.Name = "TabIco"
		TabIco.Parent = TabBtns
		TabIco.BackgroundTransparency = 1.000
		TabIco.BorderSizePixel = 0
		TabIco.Size = UDim2.new(0, 24, 0, 24)
		TabIco.Image = ("rbxassetid://%s"):format((icon or 4370341699))
		TabIco.ImageTransparency = 0.2

		TabText.Name = "TabText"
		TabText.Parent = TabIco
		TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabText.BackgroundTransparency = 1.000
		TabText.Position = UDim2.new(1.41666663, 0, 0, 0)
		TabText.Size = UDim2.new(0, 76, 0, 24)
		TabText.Font = Enum.Font.GothamSemibold
		TabText.Text = name
		TabText.TextColor3 = TextColor
		TabText.TextSize = 14.000
		TabText.TextTransparency = 0.2
		TabText.TextXAlignment = Enum.TextXAlignment.Left

		TabBtn.Name = "TabBtn"
		TabBtn.Parent = TabIco
		TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabBtn.BackgroundTransparency = 1.000
		TabBtn.BorderSizePixel = 0
		TabBtn.Size = UDim2.new(0, 110, 0, 24)
		TabBtn.AutoButtonColor = false
		TabBtn.Font = Enum.Font.SourceSans
		TabBtn.Text = ""
		TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
		TabBtn.TextSize = 14.000

		TabL.Name = "TabL"
		TabL.Parent = Tab
		TabL.SortOrder = Enum.SortOrder.LayoutOrder
		TabL.Padding = UDim.new(0, 4)

		TabBtn.MouseButton1Click:Connect(function()
			spawn(function()
				Ripple(TabBtn)
			end)
			switchTab({ TabIco, Tab })
		end)

		if library.currentTab == nil then
			switchTab({ TabIco, Tab })
		end

		TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
		end)

		local tab = {}

		function tab.Section(tab, name, TabVal)
			local Section = Instance.new("Frame")
			local SectionC = Instance.new("UICorner")
			local SectionText = Instance.new("TextLabel")
			local SectionOpen = Instance.new("ImageLabel")
			local SectionOpened = Instance.new("ImageLabel")
			local SectionToggle = Instance.new("ImageButton")
			local Objs = Instance.new("Frame")
			local ObjsL = Instance.new("UIListLayout")

			Section.Name = "Section"
			Section.Parent = Tab
			Section.BackgroundColor3 = zyColor
			Section.BackgroundTransparency = zyColorTransparency
			Section.BorderSizePixel = 0
			Section.ClipsDescendants = true
			Section.Size = UDim2.new(0.981000006, 0, 0, 36)

			SectionC.CornerRadius = UDim.new(0, 6)
			SectionC.Name = "SectionC"
			SectionC.Parent = Section

			SectionText.Name = "SectionText"
			SectionText.Parent = Section
			SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionText.BackgroundTransparency = 1.000
			SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
			SectionText.Size = UDim2.new(0, 401, 0, 36)
			SectionText.Font = Enum.Font.GothamBold
			SectionText.Text = name
			SectionText.TextColor3 = TextColor
			SectionText.TextSize = 16.000
			SectionText.TextTransparency = 0
			SectionText.TextXAlignment = Enum.TextXAlignment.Left

			SectionOpen.Name = "SectionOpen"
			SectionOpen.Parent = SectionText
			SectionOpen.BackgroundTransparency = 1
			SectionOpen.BorderSizePixel = 0
			SectionOpen.Position = UDim2.new(0, -33, 0, 5)
			SectionOpen.Size = UDim2.new(0, 26, 0, 26)
			SectionOpen.Image = "http://www.roblox.com/asset/?id=6031302934"

			SectionOpened.Name = "SectionOpened"
			SectionOpened.Parent = SectionOpen
			SectionOpened.BackgroundTransparency = 1.000
			SectionOpened.BorderSizePixel = 0
			SectionOpened.Size = UDim2.new(0, 26, 0, 26)
			SectionOpened.Image = "http://www.roblox.com/asset/?id=6031302932"
			SectionOpened.ImageTransparency = 1.000

			SectionToggle.Name = "SectionToggle"
			SectionToggle.Parent = SectionOpen
			SectionToggle.BackgroundTransparency = 1
			SectionToggle.BorderSizePixel = 0
			SectionToggle.Size = UDim2.new(0, 26, 0, 26)

			Objs.Name = "Objs"
			Objs.Parent = Section
			Objs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Objs.BackgroundTransparency = 1
			Objs.BorderSizePixel = 0
			Objs.Position = UDim2.new(0, 6, 0, 36)
			Objs.Size = UDim2.new(0.986347735, 0, 0, 0)

			ObjsL.Name = "ObjsL"
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

			ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if not open then return end
				Section.Size = UDim2.new(0.981000006, 0, 0, 36 + ObjsL.AbsoluteContentSize.Y + 8)
			end)

			local section = {}

			function section.Button(section, text, callback)
				local callback = callback or function() end
				local BtnModule = Instance.new("Frame")
				local Btn = Instance.new("TextButton")
				local BtnC = Instance.new("UICorner")

				BtnModule.Name = "BtnModule"
				BtnModule.Parent = Objs
				BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BtnModule.BackgroundTransparency = 1.000
				BtnModule.BorderSizePixel = 0
				BtnModule.Position = UDim2.new(0, 0, 0, 0)
				BtnModule.Size = UDim2.new(0, 428, 0, 38)

				Btn.Name = "Btn"
				Btn.Parent = BtnModule
				Btn.BackgroundColor3 = zyColor
				Btn.BackgroundTransparency = zyColorTransparency
				Btn.BorderSizePixel = 0
				Btn.Size = UDim2.new(0, 428, 0, 38)
				Btn.AutoButtonColor = false
				Btn.Font = Enum.Font.GothamBold
				Btn.Text = "   " .. text
				Btn.TextColor3 = TextColor
				Btn.TextSize = 16.000
				Btn.TextTransparency = 0
				Btn.TextXAlignment = Enum.TextXAlignment.Left

				BtnC.CornerRadius = UDim.new(0, 6)
				BtnC.Name = "BtnC"
				BtnC.Parent = Btn

				Btn.MouseButton1Click:Connect(function()
					spawn(function() Ripple(Btn) end)
					spawn(callback)
				end)
			end

			function section:Label(text)
				local LabelModule = Instance.new("Frame")
				local TextLabel = Instance.new("TextLabel")
				local LabelC = Instance.new("UICorner")

				LabelModule.Name = "LabelModule"
				LabelModule.Parent = Objs
				LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelModule.BackgroundTransparency = 1.000
				LabelModule.BorderSizePixel = 0
				LabelModule.Position = UDim2.new(0, 0, NAN, 0)
				LabelModule.Size = UDim2.new(0, 428, 0, 19)

				TextLabel.Parent = LabelModule
				TextLabel.BackgroundColor3 = zyColor
				TextLabel.BackgroundTransparency = zyColorTransparency
				TextLabel.Size = UDim2.new(0, 428, 0, 22)
				TextLabel.Font = Enum.Font.GothamBold
				TextLabel.Text = text
				TextLabel.TextColor3 = TextColor
				TextLabel.TextSize = 14.000
				TextLabel.TextTransparency = 0

				LabelC.CornerRadius = UDim.new(0, 6)
				LabelC.Name = "LabelC"
				LabelC.Parent = TextLabel

				return TextLabel
			end

			function section.Toggle(section, text, flag, enabled, callback)
				local callback = callback or function() end
				local enabled = enabled or false
				assert(text, "No text provided")
				assert(flag, "No flag provided")
				library.flags[flag] = enabled

				local ToggleModule = Instance.new("Frame")
				local ToggleBtn = Instance.new("TextButton")
				local ToggleBtnC = Instance.new("UICorner")
				local ToggleDisable = Instance.new("Frame")
				local ToggleSwitch = Instance.new("Frame")
				local ToggleSwitchC = Instance.new("UICorner")
				local ToggleDisableC = Instance.new("UICorner")

				ToggleModule.Name = "ToggleModule"
				ToggleModule.Parent = Objs
				ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleModule.BackgroundTransparency = 1.000
				ToggleModule.BorderSizePixel = 0
				ToggleModule.Position = UDim2.new(0, 0, 0, 0)
				ToggleModule.Size = UDim2.new(0, 428, 0, 38)

				ToggleBtn.Name = "ToggleBtn"
				ToggleBtn.Parent = ToggleModule
				ToggleBtn.BackgroundColor3 = zyColor
				ToggleBtn.BackgroundTransparency = zyColorTransparency
				ToggleBtn.BorderSizePixel = 0
				ToggleBtn.Size = UDim2.new(0, 428, 0, 38)
				ToggleBtn.AutoButtonColor = false
				ToggleBtn.Font = Enum.Font.GothamBold
				ToggleBtn.Text = "   " .. text
				ToggleBtn.TextColor3 = TextColor
				ToggleBtn.TextSize = 16.000
				ToggleBtn.TextTransparency = 0
				ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left

				ToggleBtnC.CornerRadius = UDim.new(0, 6)
				ToggleBtnC.Name = "ToggleBtnC"
				ToggleBtnC.Parent = ToggleBtn

				ToggleDisable.Name = "ToggleDisable"
				ToggleDisable.Parent = ToggleBtn
				ToggleDisable.BackgroundColor3 = Background
				ToggleDisable.BackgroundTransparency = BackgroundTransparency
				ToggleDisable.BorderSizePixel = 0
				ToggleDisable.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
				ToggleDisable.Size = UDim2.new(0, 36, 0, 22)

				ToggleSwitch.Name = "ToggleSwitch"
				ToggleSwitch.Parent = ToggleDisable
				ToggleSwitch.BackgroundColor3 = beijingColor
				ToggleSwitch.Size = UDim2.new(0, 24, 0, 22)

				ToggleSwitchC.CornerRadius = UDim.new(0, 6)
				ToggleSwitchC.Name = "ToggleSwitchC"
				ToggleSwitchC.Parent = ToggleSwitch

				ToggleDisableC.CornerRadius = UDim.new(0, 6)
				ToggleDisableC.Name = "ToggleDisableC"
				ToggleDisableC.Parent = ToggleDisable

				local funcs = {
					SetState = function(self, state)
						if state == nil then
							state = not library.flags[flag]
						end
						if library.flags[flag] == state then return end
						services.TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
							Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0),
							BackgroundColor3 = (state and Color3.fromRGB(96, 205, 255) or beijingColor),
						}):Play()
						library.flags[flag] = state
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

				return funcs
			end

			function section.Keybind(section, text, default, callback)
				local callback = callback or function() end
				assert(text, "No text provided")
				assert(default, "No default key provided")
				local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
				local banned = {
					Return = true, Space = true, Tab = true,
					Backquote = true, CapsLock = true, Escape = true, Unknown = true,
				}
				local shortNames = {
					RightControl = "Right Ctrl", LeftControl = "Left Ctrl",
					LeftShift = "Left Shift", RightShift = "Right Shift",
					Semicolon = ";", Quote = '"', LeftBracket = "[",
					RightBracket = "]", Equals = "=", Minus = "-",
					RightAlt = "Right Alt", LeftAlt = "Left Alt",
				}
				local bindKey = default
				local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")

				local KeybindModule = Instance.new("Frame")
				local KeybindBtn = Instance.new("TextButton")
				local KeybindBtnC = Instance.new("UICorner")
				local KeybindValue = Instance.new("TextButton")
				local KeybindValueC = Instance.new("UICorner")
				local KeybindL = Instance.new("UIListLayout")
				local UIPadding = Instance.new("UIPadding")

				KeybindModule.Name = "KeybindModule"
				KeybindModule.Parent = Objs
				KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				KeybindModule.BackgroundTransparency = 1.000
				KeybindModule.BorderSizePixel = 0
				KeybindModule.Position = UDim2.new(0, 0, 0, 0)
				KeybindModule.Size = UDim2.new(0, 428, 0, 38)

				KeybindBtn.Name = "KeybindBtn"
				KeybindBtn.Parent = KeybindModule
				KeybindBtn.BackgroundColor3 = zyColor
				KeybindBtn.BackgroundTransparency = zyColorTransparency
				KeybindBtn.BorderSizePixel = 0
				KeybindBtn.Size = UDim2.new(0, 428, 0, 38)
				KeybindBtn.AutoButtonColor = false
				KeybindBtn.Font = Enum.Font.GothamBold
				KeybindBtn.Text = "   " .. text
				KeybindBtn.TextColor3 = TextColor
				KeybindBtn.TextSize = 16.000
				KeybindBtn.TextTransparency = 0
				KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left

				KeybindBtnC.CornerRadius = UDim.new(0, 6)
				KeybindBtnC.Name = "KeybindBtnC"
				KeybindBtnC.Parent = KeybindBtn

				KeybindValue.Name = "KeybindValue"
				KeybindValue.Parent = KeybindBtn
				KeybindValue.BackgroundColor3 = Background
				KeybindValue.BackgroundTransparency = BackgroundTransparency
				KeybindValue.BorderSizePixel = 0
				KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
				KeybindValue.Size = UDim2.new(0, 100, 0, 28)
				KeybindValue.AutoButtonColor = false
				KeybindValue.Font = Enum.Font.GothamBold
				KeybindValue.Text = keyTxt
				KeybindValue.TextColor3 = TextColor
				KeybindValue.TextSize = 14.000
				KeybindValue.TextTransparency = 0

				KeybindValueC.CornerRadius = UDim.new(0, 6)
				KeybindValueC.Name = "KeybindValueC"
				KeybindValueC.Parent = KeybindValue

				KeybindL.Name = "KeybindL"
				KeybindL.Parent = KeybindBtn
				KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
				KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
				KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center

				UIPadding.Parent = KeybindBtn
				UIPadding.PaddingRight = UDim.new(0, 6)

				services.UserInputService.InputBegan:Connect(function(inp, gpe)
					if gpe then return end
					if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
					if inp.KeyCode ~= bindKey then return end
					callback(bindKey.Name)
				end)

				KeybindValue.MouseButton1Click:Connect(function()
					KeybindValue.Text = "..."
					wait()
					local key, uwu = services.UserInputService.InputEnded:Wait()
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
					KeybindValue.Text = shortNames[keyName] or keyName
				end)

				KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
					KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
				end)
				KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
			end

			function section.Textbox(section, text, flag, default, callback)
				local callback = callback or function() end
				assert(text, "No text provided")
				assert(flag, "No flag provided")
				assert(default, "No default text provided")
				library.flags[flag] = default

				local TextboxModule = Instance.new("Frame")
				local TextboxBack = Instance.new("TextButton")
				local TextboxBackC = Instance.new("UICorner")
				local BoxBG = Instance.new("TextButton")
				local BoxBGC = Instance.new("UICorner")
				local TextBox = Instance.new("TextBox")
				local TextboxBackL = Instance.new("UIListLayout")
				local TextboxBackP = Instance.new("UIPadding")

				TextboxModule.Name = "TextboxModule"
				TextboxModule.Parent = Objs
				TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextboxModule.BackgroundTransparency = 1.000
				TextboxModule.BorderSizePixel = 0
				TextboxModule.Position = UDim2.new(0, 0, 0, 0)
				TextboxModule.Size = UDim2.new(0, 428, 0, 38)

				TextboxBack.Name = "TextboxBack"
				TextboxBack.Parent = TextboxModule
				TextboxBack.BackgroundColor3 = zyColor
				TextboxBack.BackgroundTransparency = zyColorTransparency
				TextboxBack.BorderSizePixel = 0
				TextboxBack.Size = UDim2.new(0, 428, 0, 38)
				TextboxBack.AutoButtonColor = false
				TextboxBack.Font = Enum.Font.GothamBold
				TextboxBack.Text = "   " .. text
				TextboxBack.TextColor3 = TextColor
				TextboxBack.TextSize = 16.000
				TextboxBack.TextTransparency = 0
				TextboxBack.TextXAlignment = Enum.TextXAlignment.Left

				TextboxBackC.CornerRadius = UDim.new(0, 6)
				TextboxBackC.Name = "TextboxBackC"
				TextboxBackC.Parent = TextboxBack

				BoxBG.Name = "BoxBG"
				BoxBG.Parent = TextboxBack
				BoxBG.BackgroundColor3 = Background
				BoxBG.BackgroundTransparency = BackgroundTransparency
				BoxBG.BorderSizePixel = 0
				BoxBG.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
				BoxBG.Size = UDim2.new(0, 100, 0, 28)
				BoxBG.AutoButtonColor = false
				BoxBG.Font = Enum.Font.Gotham
				BoxBG.Text = ""
				BoxBG.TextColor3 = Color3.fromRGB(255, 255, 255)
				BoxBG.TextSize = 14.000

				BoxBGC.CornerRadius = UDim.new(0, 6)
				BoxBGC.Name = "BoxBGC"
				BoxBGC.Parent = BoxBG

				TextBox.Parent = BoxBG
				TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.BackgroundTransparency = 1.000
				TextBox.BorderSizePixel = 0
				TextBox.Size = UDim2.new(1, 0, 1, 0)
				TextBox.Font = Enum.Font.GothamBold
				TextBox.Text = default
				TextBox.TextColor3 = TextColor
				TextBox.PlaceholderColor3 = PlaceholderColor
				TextBox.TextSize = 14.000
				TextBox.TextTransparency = 0

				TextboxBackL.Name = "TextboxBackL"
				TextboxBackL.Parent = TextboxBack
				TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
				TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
				TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center

				TextboxBackP.Name = "TextboxBackP"
				TextboxBackP.Parent = TextboxBack
				TextboxBackP.PaddingRight = UDim.new(0, 6)

				TextBox.FocusLost:Connect(function()
					if TextBox.Text == "" then TextBox.Text = default end
					library.flags[flag] = TextBox.Text
					callback(TextBox.Text)
				end)

				TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
					BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
				end)
				BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
			end

			function section.Slider(section, text, flag, default, min, max, precise, callback)
				local callback = callback or function() end
				local min = min or 1
				local max = max or 10
				local default = default or min
				local precise = precise or false
				library.flags[flag] = default
				assert(text, "No text provided")
				assert(flag, "No flag provided")
				assert(default, "No default value provided")

				local SliderModule = Instance.new("Frame")
				local SliderBack = Instance.new("TextButton")
				local SliderBackC = Instance.new("UICorner")
				local SliderBar = Instance.new("Frame")
				local SliderBarC = Instance.new("UICorner")
				local SliderPart = Instance.new("Frame")
				local SliderPartC = Instance.new("UICorner")
				local SliderValBG = Instance.new("TextButton")
				local SliderValBGC = Instance.new("UICorner")
				local SliderValue = Instance.new("TextBox")
				local MinSlider = Instance.new("TextButton")
				local AddSlider = Instance.new("TextButton")

				SliderModule.Name = "SliderModule"
				SliderModule.Parent = Objs
				SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderModule.BackgroundTransparency = 1.000
				SliderModule.BorderSizePixel = 0
				SliderModule.Position = UDim2.new(0, 0, 0, 0)
				SliderModule.Size = UDim2.new(0, 428, 0, 38)

				SliderBack.Name = "SliderBack"
				SliderBack.Parent = SliderModule
				SliderBack.BackgroundColor3 = zyColor
				SliderBack.BackgroundTransparency = zyColorTransparency
				SliderBack.BorderSizePixel = 0
				SliderBack.Size = UDim2.new(0, 428, 0, 38)
				SliderBack.AutoButtonColor = false
				SliderBack.Font = Enum.Font.GothamBold
				SliderBack.Text = "   " .. text
				SliderBack.TextColor3 = TextColor
				SliderBack.TextSize = 16.000
				SliderBack.TextTransparency = 0
				SliderBack.TextXAlignment = Enum.TextXAlignment.Left

				SliderBackC.CornerRadius = UDim.new(0, 6)
				SliderBackC.Name = "SliderBackC"
				SliderBackC.Parent = SliderBack

				SliderBar.Name = "SliderBar"
				SliderBar.Parent = SliderBack
				SliderBar.AnchorPoint = Vector2.new(0, 0.5)
				SliderBar.BackgroundColor3 = Background
				SliderBar.BackgroundTransparency = BackgroundTransparency
				SliderBar.BorderSizePixel = 0
				SliderBar.Position = UDim2.new(0.369000018, 40, 0.5, 0)
				SliderBar.Size = UDim2.new(0, 140, 0, 12)

				SliderBarC.CornerRadius = UDim.new(0, 4)
				SliderBarC.Name = "SliderBarC"
				SliderBarC.Parent = SliderBar

				SliderPart.Name = "SliderPart"
				SliderPart.Parent = SliderBar
				SliderPart.BackgroundColor3 = beijingColor
				SliderPart.Size = UDim2.new(0, 54, 0, 13)

				SliderPartC.CornerRadius = UDim.new(0, 4)
				SliderPartC.Name = "SliderPartC"
				SliderPartC.Parent = SliderPart

				SliderValBG.Name = "SliderValBG"
				SliderValBG.Parent = SliderBack
				SliderValBG.BackgroundColor3 = Background
				SliderValBG.BackgroundTransparency = BackgroundTransparency
				SliderValBG.BorderSizePixel = 0
				SliderValBG.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
				SliderValBG.Size = UDim2.new(0, 44, 0, 28)
				SliderValBG.AutoButtonColor = false
				SliderValBG.Font = Enum.Font.Gotham
				SliderValBG.Text = ""
				SliderValBG.TextColor3 = Color3.fromRGB(255, 255, 255)
				SliderValBG.TextSize = 14.000

				SliderValBGC.CornerRadius = UDim.new(0, 6)
				SliderValBGC.Name = "SliderValBGC"
				SliderValBGC.Parent = SliderValBG

				SliderValue.Name = "SliderValue"
				SliderValue.Parent = SliderValBG
				SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderValue.BackgroundTransparency = 1.000
				SliderValue.BorderSizePixel = 0
				SliderValue.Size = UDim2.new(1, 0, 1, 0)
				SliderValue.Font = Enum.Font.GothamBold
				SliderValue.Text = "1000"
				SliderValue.TextColor3 = TextColor
				SliderValue.TextSize = 14.000
				SliderValue.TextTransparency = 0

				MinSlider.Name = "MinSlider"
				MinSlider.Parent = SliderModule
				MinSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				MinSlider.BackgroundTransparency = 1.000
				MinSlider.BorderSizePixel = 0
				MinSlider.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
				MinSlider.Size = UDim2.new(0, 20, 0, 20)
				MinSlider.Font = Enum.Font.GothamBold
				MinSlider.Text = "-"
				MinSlider.TextColor3 = TextColor
				MinSlider.TextSize = 24.000
				MinSlider.TextTransparency = 0
				MinSlider.TextWrapped = true

				AddSlider.Name = "AddSlider"
				AddSlider.Parent = SliderModule
				AddSlider.AnchorPoint = Vector2.new(0, 0.5)
				AddSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				AddSlider.BackgroundTransparency = 1.000
				AddSlider.BorderSizePixel = 0
				AddSlider.Position = UDim2.new(0.810906529, 0, 0.5, 0)
				AddSlider.Size = UDim2.new(0, 20, 0, 20)
				AddSlider.Font = Enum.Font.GothamBold
				AddSlider.Text = "+"
				AddSlider.TextColor3 = TextColor
				AddSlider.TextSize = 24.000
				AddSlider.TextTransparency = 0
				AddSlider.TextWrapped = true

				local funcs = {
					SetValue = function(self, value)
						local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
						if value then percent = (value - min) / (max - min) end
						percent = math.clamp(percent, 0, 1)
						if precise then
							value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
						else
							value = value or math.floor(min + (max - min) * percent)
						end
						library.flags[flag] = tonumber(value)
						SliderValue.Text = tostring(value)
						SliderPart.Size = UDim2.new(percent, 0, 1, 0)
						callback(tonumber(value))
					end,
				}

				MinSlider.MouseButton1Click:Connect(function()
					funcs:SetValue(math.clamp(library.flags[flag] - 1, min, max))
				end)
				AddSlider.MouseButton1Click:Connect(function()
					funcs:SetValue(math.clamp(library.flags[flag] + 1, min, max))
				end)
				funcs:SetValue(default)

				local dragging, boxFocused, allowed = false, false, { [""] = true, ["-"] = true }

				SliderBar.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						funcs:SetValue()
						dragging = true
					end
				end)
				services.UserInputService.InputEnded:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)
				services.UserInputService.InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						funcs:SetValue()
					end
				end)

				SliderValue.Focused:Connect(function() boxFocused = true end)
				SliderValue.FocusLost:Connect(function()
					boxFocused = false
					if SliderValue.Text == "" then funcs:SetValue(default) end
				end)
				SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
					if not boxFocused then return end
					SliderValue.Text = SliderValue.Text:gsub("%D+", "")
					local text = SliderValue.Text
					if not tonumber(text) then
						SliderValue.Text = SliderValue.Text:gsub("%D+", "")
					elseif not allowed[text] then
						if tonumber(text) > max then
							text = max
							SliderValue.Text = tostring(max)
						end
						funcs:SetValue(tonumber(text))
					end
				end)

				return funcs
			end

			function section.Dropdown(section, text, flag, options, callback)
				local callback = callback or function() end
				local options = options or {}
				assert(text, "No text provided")
				assert(flag, "No flag provided")
				library.flags[flag] = nil

				local DropdownModule = Instance.new("Frame")
				local DropdownTop = Instance.new("TextButton")
				local DropdownTopC = Instance.new("UICorner")
				local DropdownOpen = Instance.new("TextButton")
				local DropdownText = Instance.new("TextBox")
				local DropdownModuleL = Instance.new("UIListLayout")

				DropdownModule.Name = "DropdownModule"
				DropdownModule.Parent = Objs
				DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownModule.BackgroundTransparency = 1.000
				DropdownModule.BorderSizePixel = 0
				DropdownModule.ClipsDescendants = true
				DropdownModule.Position = UDim2.new(0, 0, 0, 0)
				DropdownModule.Size = UDim2.new(0, 428, 0, 38)

				DropdownTop.Name = "DropdownTop"
				DropdownTop.Parent = DropdownModule
				DropdownTop.BackgroundColor3 = zyColor
				DropdownTop.BackgroundTransparency = zyColorTransparency
				DropdownTop.BorderSizePixel = 0
				DropdownTop.Size = UDim2.new(0, 428, 0, 38)
				DropdownTop.AutoButtonColor = false
				DropdownTop.Font = Enum.Font.GothamBold
				DropdownTop.Text = ""
				DropdownTop.TextColor3 = Color3.fromRGB(255, 255, 255)
				DropdownTop.TextSize = 16.000
				DropdownTop.TextXAlignment = Enum.TextXAlignment.Left

				DropdownTopC.CornerRadius = UDim.new(0, 6)
				DropdownTopC.Name = "DropdownTopC"
				DropdownTopC.Parent = DropdownTop

				DropdownOpen.Name = "DropdownOpen"
				DropdownOpen.Parent = DropdownTop
				DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
				DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownOpen.BackgroundTransparency = 1.000
				DropdownOpen.BorderSizePixel = 0
				DropdownOpen.Position = UDim2.new(0.918383181, 0, 0.5, 0)
				DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
				DropdownOpen.Font = Enum.Font.GothamBold
				DropdownOpen.Text = "+"
				DropdownOpen.TextColor3 = TextColor
				DropdownOpen.TextSize = 24.000
				DropdownOpen.TextTransparency = 0
				DropdownOpen.TextWrapped = true

				DropdownText.Name = "DropdownText"
				DropdownText.Parent = DropdownTop
				DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownText.BackgroundTransparency = 1.000
				DropdownText.BorderSizePixel = 0
				DropdownText.Position = UDim2.new(0.0373831764, 0, 0, 0)
				DropdownText.Size = UDim2.new(0, 184, 0, 38)
				DropdownText.Font = Enum.Font.GothamBold
				DropdownText.PlaceholderColor3 = PlaceholderColor
				DropdownText.PlaceholderText = text
				DropdownText.Text = ""
				DropdownText.TextColor3 = TextColor
				DropdownText.TextSize = 16.000
				DropdownText.TextTransparency = 0
				DropdownText.TextXAlignment = Enum.TextXAlignment.Left

				DropdownModuleL.Name = "DropdownModuleL"
				DropdownModuleL.Parent = DropdownModule
				DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
				DropdownModuleL.Padding = UDim.new(0, 4)

				local setAllVisible = function()
					for _, option in next, DropdownModule:GetChildren() do
						if option:IsA("TextButton") and option.Name:match("Option_") then
							option.Visible = true
						end
					end
				end

				local searchDropdown = function(txt)
					for _, option in next, DropdownModule:GetChildren() do
						if option:IsA("TextButton") and option.Name:match("Option_") then
							if txt == "" then
								option.Visible = true
							else
								option.Visible = option.Text:lower():match(txt:lower()) ~= nil
							end
						end
					end
				end

				local open = false
				local ToggleDropVis = function()
					open = not open
					if open then setAllVisible() end
					DropdownOpen.Text = (open and "-" or "+")
					DropdownModule.Size = UDim2.new(0, 428, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 4 or 38))
				end

				DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
				DropdownText.Focused:Connect(function()
					if open then return end
					ToggleDropVis()
				end)
				DropdownText:GetPropertyChangedSignal("Text"):Connect(function()
					if not open then return end
					searchDropdown(DropdownText.Text)
				end)
				DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					if not open then return end
					DropdownModule.Size = UDim2.new(0, 428, 0, DropdownModuleL.AbsoluteContentSize.Y + 4)
				end)

				local funcs = {}

				funcs.AddOption = function(self, option)
					local Option = Instance.new("TextButton")
					local OptionC = Instance.new("UICorner")
					Option.Name = "Option_" .. option
					Option.Parent = DropdownModule
					Option.BackgroundColor3 = zyColor
					Option.BackgroundTransparency = zyColorTransparency
					Option.BorderSizePixel = 0
					Option.Position = UDim2.new(0, 0, 0.328125, 0)
					Option.Size = UDim2.new(0, 428, 0, 26)
					Option.AutoButtonColor = false
					Option.Font = Enum.Font.GothamBold
					Option.Text = option
					Option.TextColor3 = TextColor
					Option.TextSize = 14.000
					Option.TextTransparency = 0
					OptionC.CornerRadius = UDim.new(0, 6)
					OptionC.Name = "OptionC"
					OptionC.Parent = Option
					Option.MouseButton1Click:Connect(function()
						ToggleDropVis()
						callback(Option.Text)
						DropdownText.Text = Option.Text
						library.flags[flag] = Option.Text
					end)
				end

				funcs.RemoveOption = function(self, option)
					local opt = DropdownModule:FindFirstChild("Option_" .. option)
					if opt then opt:Destroy() end
				end

				funcs.SetOptions = function(self, opts)
					for _, v in next, DropdownModule:GetChildren() do
						if v.Name:match("Option_") then v:Destroy() end
					end
					for _, v in next, opts do
						funcs:AddOption(v)
					end
				end

				funcs:SetOptions(options)
				return funcs
			end

			-- ========== 颜色选择器 ==========
			function section.Colorpicker(section, text, flag, defaultColor, callback)
				assert(text, "No text provided")
				assert(flag, "No flag provided")

				if type(defaultColor) == "function" then
					callback = defaultColor
					defaultColor = nil
				end

				defaultColor = defaultColor or Color3.new(1, 1, 1)
				callback = callback or function() end
				assert(typeof(defaultColor) == "Color3", "defaultColor must be a Color3")

				library.flags[flag] = defaultColor

				local ColorModule = Instance.new("Frame")
				local ColorBtn = Instance.new("TextButton")
				local ColorBtnC = Instance.new("UICorner")
				local ColorPreview = Instance.new("Frame")
				local ColorPreviewC = Instance.new("UICorner")

				ColorModule.Name = "ColorModule"
				ColorModule.Parent = Objs
				ColorModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ColorModule.BackgroundTransparency = 1.000
				ColorModule.BorderSizePixel = 0
				ColorModule.Size = UDim2.new(0, 428, 0, 38)

				ColorBtn.Name = "ColorBtn"
				ColorBtn.Parent = ColorModule
				ColorBtn.BackgroundColor3 = zyColor
				ColorBtn.BackgroundTransparency = zyColorTransparency
				ColorBtn.BorderSizePixel = 0
				ColorBtn.Size = UDim2.new(0, 428, 0, 38)
				ColorBtn.AutoButtonColor = false
				ColorBtn.Font = Enum.Font.GothamBold
				ColorBtn.Text = "   " .. text
				ColorBtn.TextColor3 = TextColor
				ColorBtn.TextSize = 16.000
				ColorBtn.TextTransparency = 0
				ColorBtn.TextXAlignment = Enum.TextXAlignment.Left

				ColorBtnC.CornerRadius = UDim.new(0, 6)
				ColorBtnC.Name = "ColorBtnC"
				ColorBtnC.Parent = ColorBtn

				ColorPreview.Name = "ColorPreview"
				ColorPreview.Parent = ColorBtn
				ColorPreview.BackgroundColor3 = defaultColor
				ColorPreview.BorderSizePixel = 0
				ColorPreview.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
				ColorPreview.Size = UDim2.new(0, 36, 0, 22)

				ColorPreviewC.CornerRadius = UDim.new(0, 6)
				ColorPreviewC.Name = "ColorPreviewC"
				ColorPreviewC.Parent = ColorPreview

				local pickerGui = nil
				local isOpen = false
				local currentHue, currentSat, currentVib = Color3.toHSV(defaultColor)
				local satVibMap, satCursor, hueSlider, hueDrag, hexBox, rBox, gBox, bBox

				local function updateColor(newColor)
					ColorPreview.BackgroundColor3 = newColor
					library.flags[flag] = newColor
					callback(newColor)
				end

				local function updatePickerUI()
					if not pickerGui then return end
					local color = Color3.fromHSV(currentHue, currentSat, currentVib)
					if satVibMap then satVibMap.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1) end
					if satCursor then
						satCursor.Position = UDim2.new(currentSat, 0, 1 - currentVib, 0)
						satCursor.BackgroundColor3 = color
					end
					if hueDrag then
						hueDrag.Position = UDim2.new(0.5, 0, currentHue, 0)
						hueDrag.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
					end
					if hexBox then hexBox.Text = "#" .. color:ToHex() end
					if rBox then
						rBox.Text = tostring(math.floor(color.R * 255))
						gBox.Text = tostring(math.floor(color.G * 255))
						bBox.Text = tostring(math.floor(color.B * 255))
					end
					local newDisplay = pickerGui:FindFirstChild("Main") and pickerGui.Main:FindFirstChild("NewDisplayFrame")
					if newDisplay then newDisplay.BackgroundColor3 = color end
				end

				local function createPicker()
					if pickerGui then return end

					pickerGui = Instance.new("ScreenGui")
					pickerGui.Name = "ColorPicker_" .. flag
					pickerGui.Parent = gethui()
					pickerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

					local mainFrame = Instance.new("Frame")
					mainFrame.Name = "Main"
					mainFrame.Parent = pickerGui
					mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					mainFrame.BackgroundColor3 = zyColor
					mainFrame.BackgroundTransparency = zyColorTransparency
					mainFrame.BorderSizePixel = 0
					mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
					mainFrame.Size = UDim2.new(0, 340, 0, 340)
					mainFrame.Active = true
					mainFrame.Draggable = true
					Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

					local title = Instance.new("TextLabel")
					title.Parent = mainFrame
					title.BackgroundTransparency = 1
					title.Position = UDim2.new(0, 10, 0, 8)
					title.Size = UDim2.new(0, 200, 0, 20)
					title.Font = Enum.Font.GothamBold
					title.Text = text
					title.TextColor3 = TextColor
					title.TextSize = 14
					title.TextXAlignment = Enum.TextXAlignment.Left

					local closeBtn = Instance.new("TextButton")
					closeBtn.Parent = mainFrame
					closeBtn.BackgroundColor3 = zyColor
					closeBtn.BackgroundTransparency = zyColorTransparency
					closeBtn.Position = UDim2.new(1, -30, 0, 5)
					closeBtn.Size = UDim2.new(0, 22, 0, 22)
					closeBtn.Text = "X"
					closeBtn.TextColor3 = TextColor
					closeBtn.TextSize = 12
					closeBtn.Font = Enum.Font.GothamBold
					closeBtn.AutoButtonColor = false
					Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 4)

					closeBtn.MouseButton1Click:Connect(function()
						if pickerGui then pickerGui:Destroy(); pickerGui = nil end
						isOpen = false
					end)

					-- 饱和度/亮度面板
					satVibMap = Instance.new("ImageLabel")
					satVibMap.Parent = mainFrame
					satVibMap.Size = UDim2.new(0, 160, 0, 160)
					satVibMap.Position = UDim2.new(0, 10, 0, 38)
					satVibMap.Image = "rbxassetid://4155801252"
					satVibMap.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
					Instance.new("UICorner", satVibMap).CornerRadius = UDim.new(0, 8)

					satCursor = Instance.new("Frame")
					satCursor.Parent = satVibMap
					satCursor.Size = UDim2.new(0, 14, 0, 14)
					satCursor.AnchorPoint = Vector2.new(0.5, 0.5)
					satCursor.Position = UDim2.new(currentSat, 0, 1 - currentVib, 0)
					satCursor.BackgroundColor3 = Color3.fromHSV(currentHue, currentSat, currentVib)
					Instance.new("UICorner", satCursor).CornerRadius = UDim.new(1, 0)
					local cursorStroke = Instance.new("UIStroke", satCursor)
					cursorStroke.Thickness = 2
					cursorStroke.Transparency = 0.1
					cursorStroke.Color = Color3.fromRGB(255, 255, 255)

					-- 色相滑块
					hueSlider = Instance.new("Frame")
					hueSlider.Parent = mainFrame
					hueSlider.Size = UDim2.new(0, 8, 0, 160)
					hueSlider.Position = UDim2.new(0, 180, 0, 38)
					Instance.new("UICorner", hueSlider).CornerRadius = UDim.new(1, 0)

					local hueGradient = Instance.new("UIGradient")
					hueGradient.Rotation = 90
					local huePoints = {}
					for i = 0, 10 do
						table.insert(huePoints, ColorSequenceKeypoint.new(i / 10, Color3.fromHSV(i / 10, 1, 1)))
					end
					hueGradient.Color = ColorSequence.new(huePoints)
					hueGradient.Parent = hueSlider

					local hueDragHolder = Instance.new("Frame")
					hueDragHolder.Parent = hueSlider
					hueDragHolder.Size = UDim2.new(1, 0, 1, 0)
					hueDragHolder.BackgroundTransparency = 1

					hueDrag = Instance.new("Frame")
					hueDrag.Parent = hueDragHolder
					hueDrag.Size = UDim2.new(0, 14, 0, 14)
					hueDrag.AnchorPoint = Vector2.new(0.5, 0.5)
					hueDrag.Position = UDim2.new(0.5, 0, currentHue, 0)
					hueDrag.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
					Instance.new("UICorner", hueDrag).CornerRadius = UDim.new(1, 0)
					local dragStroke = Instance.new("UIStroke", hueDrag)
					dragStroke.Thickness = 2
					dragStroke.Transparency = 0.1
					dragStroke.Color = Color3.fromRGB(255, 255, 255)

					-- RGB 输入框
					local function createBox(y, init)
						local box = Instance.new("TextBox")
						box.Parent = mainFrame
						box.Position = UDim2.new(0, 200, 0, y)
						box.Size = UDim2.new(0, 120, 0, 25)
						box.BackgroundColor3 = Background
						box.BackgroundTransparency = BackgroundTransparency
						box.Text = tostring(init)
						box.TextColor3 = TextColor
						box.TextSize = 14
						box.Font = Enum.Font.GothamBold
						Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
						return box
					end

					rBox = createBox(38, math.floor(defaultColor.R * 255))
					gBox = createBox(68, math.floor(defaultColor.G * 255))
					bBox = createBox(98, math.floor(defaultColor.B * 255))
					hexBox = createBox(128, "#" .. defaultColor:ToHex())

					-- 旧色/新色预览
					local oldFrame = Instance.new("Frame")
					oldFrame.Parent = mainFrame
					oldFrame.Position = UDim2.new(0, 10, 0, 210)
					oldFrame.Size = UDim2.new(0, 75, 0, 24)
					oldFrame.BackgroundColor3 = defaultColor
					Instance.new("UICorner", oldFrame).CornerRadius = UDim.new(0, 8)

					local newFrame = Instance.new("Frame")
					newFrame.Name = "NewDisplayFrame"
					newFrame.Parent = mainFrame
					newFrame.Position = UDim2.new(0, 95, 0, 210)
					newFrame.Size = UDim2.new(0, 75, 0, 24)
					newFrame.BackgroundColor3 = defaultColor
					Instance.new("UICorner", newFrame).CornerRadius = UDim.new(0, 8)

					-- 确认/取消按钮
					local cancelBtn = Instance.new("TextButton")
					cancelBtn.Parent = mainFrame
					cancelBtn.Position = UDim2.new(0, 10, 0, 248)
					cancelBtn.Size = UDim2.new(0, 70, 0, 30)
					cancelBtn.BackgroundColor3 = zyColor
					cancelBtn.BackgroundTransparency = zyColorTransparency
					cancelBtn.Text = "取消"
					cancelBtn.TextColor3 = TextColor
					cancelBtn.TextSize = 14
					cancelBtn.Font = Enum.Font.GothamBold
					cancelBtn.AutoButtonColor = false
					Instance.new("UICorner", cancelBtn).CornerRadius = UDim.new(0, 6)

					local confirmBtn = Instance.new("TextButton")
					confirmBtn.Parent = mainFrame
					confirmBtn.Position = UDim2.new(0, 90, 0, 248)
					confirmBtn.Size = UDim2.new(0, 70, 0, 30)
					confirmBtn.BackgroundColor3 = Color3.fromRGB(96, 205, 255)
					confirmBtn.Text = "确认"
					confirmBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
					confirmBtn.TextSize = 14
					confirmBtn.Font = Enum.Font.GothamBold
					confirmBtn.AutoButtonColor = false
					Instance.new("UICorner", confirmBtn).CornerRadius = UDim.new(0, 6)

					-- 拖拽逻辑
					local draggingSat, draggingHue = false, false

					satVibMap.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							draggingSat = true
							currentSat = math.clamp((input.Position.X - satVibMap.AbsolutePosition.X) / satVibMap.AbsoluteSize.X, 0, 1)
							currentVib = math.clamp(1 - (input.Position.Y - satVibMap.AbsolutePosition.Y) / satVibMap.AbsoluteSize.Y, 0, 1)
							updatePickerUI()
						end
					end)

					hueSlider.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							draggingHue = true
							currentHue = math.clamp((input.Position.Y - hueSlider.AbsolutePosition.Y) / hueSlider.AbsoluteSize.Y, 0, 1)
							updatePickerUI()
						end
					end)

					services.UserInputService.InputChanged:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
							if draggingSat then
								currentSat = math.clamp((input.Position.X - satVibMap.AbsolutePosition.X) / satVibMap.AbsoluteSize.X, 0, 1)
								currentVib = math.clamp(1 - (input.Position.Y - satVibMap.AbsolutePosition.Y) / satVibMap.AbsoluteSize.Y, 0, 1)
								updatePickerUI()
							elseif draggingHue then
								currentHue = math.clamp((input.Position.Y - hueSlider.AbsolutePosition.Y) / hueSlider.AbsoluteSize.Y, 0, 1)
								updatePickerUI()
							end
						end
					end)

					services.UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							draggingSat = false
							draggingHue = false
						end
					end)

					-- RGB/Hex 输入
					local function updateFromRGB()
						local r = math.clamp(tonumber(rBox.Text) or 0, 0, 255)
						local g = math.clamp(tonumber(gBox.Text) or 0, 0, 255)
						local b = math.clamp(tonumber(bBox.Text) or 0, 0, 255)
						currentHue, currentSat, currentVib = Color3.toHSV(Color3.fromRGB(r, g, b))
						updatePickerUI()
					end

					rBox.FocusLost:Connect(function(enter) if enter then updateFromRGB() end end)
					gBox.FocusLost:Connect(function(enter) if enter then updateFromRGB() end end)
					bBox.FocusLost:Connect(function(enter) if enter then updateFromRGB() end end)

					hexBox.FocusLost:Connect(function(enter)
						if enter then
							local hex = hexBox.Text:gsub("#", "")
							local ok, col = pcall(Color3.fromHex, hex)
							if ok and typeof(col) == "Color3" then
								currentHue, currentSat, currentVib = Color3.toHSV(col)
								updatePickerUI()
							else
								hexBox.Text = "#" .. Color3.fromHSV(currentHue, currentSat, currentVib):ToHex()
							end
						end
					end)

					confirmBtn.MouseButton1Click:Connect(function()
						updateColor(Color3.fromHSV(currentHue, currentSat, currentVib))
						if pickerGui then pickerGui:Destroy(); pickerGui = nil end
						isOpen = false
					end)

					cancelBtn.MouseButton1Click:Connect(function()
						if pickerGui then pickerGui:Destroy(); pickerGui = nil end
						isOpen = false
					end)

					updatePickerUI()
				end

				ColorBtn.MouseButton1Click:Connect(function()
					if not isOpen then
						createPicker()
						isOpen = true
					else
						if pickerGui then pickerGui:Destroy(); pickerGui = nil end
						createPicker()
					end
				end)

				local funcs = {
					SetColor = function(self, newColor)
						updateColor(newColor)
						currentHue, currentSat, currentVib = Color3.toHSV(newColor)
					end,
					Module = ColorModule,
				}

				return funcs
			end

			return section
		end
		return tab
	end

	return window
end

return library
