local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local IsOnMobile = false
pcall(function()
	IsOnMobile = table.find({Enum.Platform.Android, Enum.Platform.IOS}, UserInputService:GetPlatform()) ~= nil
end)
if not IsOnMobile then
	IsOnMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

local function randomString()
	local arr = {}
	for i = 1, math.random(10, 16) do
		arr[i] = string.char(math.random(97, 122))
	end
	return table.concat(arr)
end

local function getRoot(char)
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	return hum and hum.RootPart or (char and char:FindFirstChild("HumanoidRootPart"))
end

local flying = false
local flySpeed = 1
local noclip = false

local flyConn, keyDownConn, keyUpConn, charAddedConn, noclipConn
local bvName, bgName = "bv_" .. randomString(), "bg_" .. randomString()

local onStateChanged = function() end

local function stopFly()
	if not flying and not flyConn then return end
	flying = false
	if flyConn then flyConn:Disconnect() flyConn = nil end
	if keyDownConn then keyDownConn:Disconnect() keyDownConn = nil end
	if keyUpConn then keyUpConn:Disconnect() keyUpConn = nil end
	if charAddedConn then charAddedConn:Disconnect() charAddedConn = nil end

	local char = LocalPlayer.Character
	local root = getRoot(char)
	if root then
		local bv = root:FindFirstChild(bvName)
		local bg = root:FindFirstChild(bgName)
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
	end
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.PlatformStand = false
	end
	pcall(function()
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	end)
	onStateChanged()
end

local function startFly()
	stopFly()
	flying = true

	local function attachBodyMovers(char)
		local root = getRoot(char)
		if not root then return end
		local oldBv = root:FindFirstChild(bvName)
		if oldBv then oldBv:Destroy() end
		local oldBg = root:FindFirstChild(bgName)
		if oldBg then oldBg:Destroy() end

		local bg = Instance.new("BodyGyro")
		bg.Name = bgName
		bg.P = IsOnMobile and 1000 or 9e4
		bg.D = IsOnMobile and 50 or 500
		bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.CFrame = root.CFrame
		bg.Parent = root

		local bv = Instance.new("BodyVelocity")
		bv.Name = bvName
		bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
		bv.Velocity = Vector3.zero
		bv.Parent = root
	end

	if LocalPlayer.Character then
		attachBodyMovers(LocalPlayer.Character)
	end

	charAddedConn = LocalPlayer.CharacterAdded:Connect(function(newChar)
		if not flying then return end
		newChar:WaitForChild("Humanoid", 10)
		task.wait(0.1)
		if flying then
			attachBodyMovers(newChar)
			local hum = newChar:FindFirstChildOfClass("Humanoid")
			if hum then hum.PlatformStand = false end
		end
	end)

	if not IsOnMobile then
		local keys = {W = false, S = false, A = false, D = false, E = false, Q = false}
		keyDownConn = UserInputService.InputBegan:Connect(function(input, processed)
			if processed then return end
			local kc = input.KeyCode
			if kc == Enum.KeyCode.W then keys.W = true
			elseif kc == Enum.KeyCode.S then keys.S = true
			elseif kc == Enum.KeyCode.A then keys.A = true
			elseif kc == Enum.KeyCode.D then keys.D = true
			elseif kc == Enum.KeyCode.E then keys.E = true
			elseif kc == Enum.KeyCode.Q then keys.Q = true
			end
		end)
		keyUpConn = UserInputService.InputEnded:Connect(function(input)
			local kc = input.KeyCode
			if kc == Enum.KeyCode.W then keys.W = false
			elseif kc == Enum.KeyCode.S then keys.S = false
			elseif kc == Enum.KeyCode.A then keys.A = false
			elseif kc == Enum.KeyCode.D then keys.D = false
			elseif kc == Enum.KeyCode.E then keys.E = false
			elseif kc == Enum.KeyCode.Q then keys.Q = false
			end
		end)

		flyConn = RunService.Heartbeat:Connect(function()
			if not flying then return end
			local char = LocalPlayer.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			local root = getRoot(char)
			local camera = workspace.CurrentCamera
			if hum and root and camera then
				local bv = root:FindFirstChild(bvName)
				local bg = root:FindFirstChild(bgName)
				if not bv or not bg then
					attachBodyMovers(char)
					return
				end
				hum.PlatformStand = true
				bg.CFrame = camera.CFrame

				local f = (keys.W and flySpeed or 0) + (keys.S and -flySpeed or 0)
				local r = (keys.D and flySpeed or 0) + (keys.A and -flySpeed or 0)
				local u = (keys.E and flySpeed or 0) + (keys.Q and -flySpeed or 0)

				local move = camera.CFrame.LookVector * f
					+ camera.CFrame.RightVector * r
					+ Vector3.new(0, u, 0)

				bv.Velocity = move * 50
			end
		end)
	else
		local controlModule = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
		flyConn = RunService.RenderStepped:Connect(function()
			if not flying then return end
			local char = LocalPlayer.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			local root = getRoot(char)
			local camera = workspace.CurrentCamera
			if hum and root and camera then
				local bv = root:FindFirstChild(bvName)
				local bg = root:FindFirstChild(bgName)
				if not bv or not bg then
					attachBodyMovers(char)
					return
				end
				hum.PlatformStand = true
				bg.CFrame = camera.CFrame
				local dir = controlModule:GetMoveVector()
				local vel = Vector3.zero
				local mult = flySpeed * 50
				if dir.X ~= 0 then
					vel += camera.CFrame.RightVector * (dir.X * mult)
				end
				if dir.Z ~= 0 then
					vel -= camera.CFrame.LookVector * (dir.Z * mult)
				end
				bv.Velocity = vel
			end
		end)
	end
	onStateChanged()
end

local function setNoclip(state)
	noclip = state
	if noclip then
		if noclipConn then noclipConn:Disconnect() end
		noclipConn = RunService.Stepped:Connect(function()
			local char = LocalPlayer.Character
			if char then
				for _, part in ipairs(char:GetDescendants()) do
					if part:IsA("BasePart") and part.CanCollide then
						part.CanCollide = false
					end
				end
			end
		end)
	else
		if noclipConn then
			noclipConn:Disconnect()
			noclipConn = nil
		end
		local char = LocalPlayer.Character
		if char then
			for _, name in ipairs({"Head", "Torso", "UpperTorso", "LowerTorso", "HumanoidRootPart"}) do
				local part = char:FindFirstChild(name)
				if part and part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
	end
	onStateChanged()
end

local FULL_SIZE = UDim2.fromOffset(156, 94)
local PILL_SIZE = UDim2.fromOffset(72, 28)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = randomString()
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = (gethui and gethui()) or LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = FULL_SIZE
Main.Position = UDim2.new(0.5, -78, 0.22, 0)
Main.BackgroundColor3 = Color3.fromRGB(16, 17, 22)
Main.BackgroundTransparency = 0.08
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Active = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 11)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(78, 84, 104)
MainStroke.Transparency = 0.35
MainStroke.Thickness = 1
MainStroke.Parent = Main

local MiniPill = Instance.new("TextButton")
MiniPill.Name = "MiniPill"
MiniPill.Size = UDim2.fromScale(1, 1)
MiniPill.BackgroundTransparency = 1
MiniPill.Text = ""
MiniPill.AutoButtonColor = false
MiniPill.Active = true
MiniPill.Visible = false
MiniPill.Parent = Main

local MiniDot = Instance.new("Frame")
MiniDot.Size = UDim2.fromOffset(7, 7)
MiniDot.Position = UDim2.new(0, 11, 0.5, -3.5)
MiniDot.BackgroundColor3 = Color3.fromRGB(100, 108, 128)
MiniDot.BorderSizePixel = 0
MiniDot.Parent = MiniPill
Instance.new("UICorner", MiniDot).CornerRadius = UDim.new(1, 0)

local MiniText = Instance.new("TextLabel")
MiniText.Size = UDim2.new(1, -24, 1, 0)
MiniText.Position = UDim2.fromOffset(22, 0)
MiniText.BackgroundTransparency = 1
MiniText.Font = Enum.Font.GothamBold
MiniText.Text = "FLY"
MiniText.TextColor3 = Color3.fromRGB(235, 238, 248)
MiniText.TextSize = 11
MiniText.TextXAlignment = Enum.TextXAlignment.Left
MiniText.Parent = MiniPill

local ExpandedView = Instance.new("Frame")
ExpandedView.Name = "ExpandedView"
ExpandedView.Size = UDim2.fromScale(1, 1)
ExpandedView.BackgroundTransparency = 1
ExpandedView.Visible = true
ExpandedView.Parent = Main

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 26)
TopBar.BackgroundTransparency = 1
TopBar.Active = true
TopBar.Parent = ExpandedView

local DragHitbox = Instance.new("TextButton")
DragHitbox.Name = "DragHitbox"
DragHitbox.Size = UDim2.fromScale(1, 1)
DragHitbox.BackgroundTransparency = 1
DragHitbox.Text = ""
DragHitbox.AutoButtonColor = false
DragHitbox.Active = true
DragHitbox.ZIndex = 1
DragHitbox.Parent = TopBar

local TopDot = Instance.new("Frame")
TopDot.Size = UDim2.fromOffset(6, 6)
TopDot.Position = UDim2.fromOffset(10, 10)
TopDot.BackgroundColor3 = Color3.fromRGB(100, 108, 128)
TopDot.BorderSizePixel = 0
TopDot.ZIndex = 2
TopDot.Parent = TopBar
Instance.new("UICorner", TopDot).CornerRadius = UDim.new(1, 0)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -64, 1, 0)
Title.Position = UDim2.fromOffset(20, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "FLY · CLIP"
Title.TextColor3 = Color3.fromRGB(220, 224, 236)
Title.TextSize = 10
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 2
Title.Parent = TopBar

local function makeHeaderBtn(txt, xOffset, hoverColor)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.fromOffset(18, 18)
	btn.Position = UDim2.new(1, xOffset, 0.5, -9)
	btn.BackgroundColor3 = Color3.fromRGB(32, 34, 44)
	btn.BackgroundTransparency = 0.35
	btn.BorderSizePixel = 0
	btn.Font = Enum.Font.GothamBold
	btn.Text = txt
	btn.TextColor3 = hoverColor
	btn.TextSize = 12
	btn.ZIndex = 3
	btn.Parent = TopBar
	Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
	return btn
end

local MinBtn = makeHeaderBtn("−", -44, Color3.fromRGB(185, 192, 210))
local CloseBtn = makeHeaderBtn("×", -22, Color3.fromRGB(240, 100, 110))

local toggleBtns = {}

local function refreshStatus()
	local dotColor
	if flying and noclip then
		dotColor = Color3.fromRGB(56, 189, 248)
	elseif flying then
		dotColor = Color3.fromRGB(59, 130, 246)
	elseif noclip then
		dotColor = Color3.fromRGB(16, 185, 129)
	else
		dotColor = Color3.fromRGB(100, 108, 128)
	end

	local strokeColor = (flying or noclip) and dotColor or Color3.fromRGB(78, 84, 104)
	TweenService:Create(TopDot, TweenInfo.new(0.18), {BackgroundColor3 = dotColor}):Play()
	TweenService:Create(MiniDot, TweenInfo.new(0.18), {BackgroundColor3 = dotColor}):Play()
	TweenService:Create(MainStroke, TweenInfo.new(0.18), {Color = strokeColor}):Play()

	for _, entry in ipairs(toggleBtns) do
		local active = entry.query()
		TweenService:Create(entry.btn, TweenInfo.new(0.16, Enum.EasingStyle.Quad), {
			BackgroundColor3 = active and entry.color or Color3.fromRGB(27, 29, 38),
			TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 186, 204)
		}):Play()
		TweenService:Create(entry.stroke, TweenInfo.new(0.16, Enum.EasingStyle.Quad), {
			Transparency = active and 0.1 or 0.45,
			Color = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 65, 82)
		}):Play()
	end
end

onStateChanged = refreshStatus

local Body = Instance.new("Frame")
Body.Size = UDim2.new(1, -14, 1, -30)
Body.Position = UDim2.fromOffset(7, 25)
Body.BackgroundTransparency = 1
Body.Active = true
Body.Parent = ExpandedView

local function createToggleBtn(text, activeColor, pos, size, query, callback)
	local Btn = Instance.new("TextButton")
	Btn.Position = pos
	Btn.Size = size
	Btn.BackgroundColor3 = Color3.fromRGB(27, 29, 38)
	Btn.BorderSizePixel = 0
	Btn.AutoButtonColor = false
	Btn.Font = Enum.Font.GothamSemibold
	Btn.Text = text
	Btn.TextColor3 = Color3.fromRGB(180, 186, 204)
	Btn.TextSize = 11
	Btn.Parent = Body
	Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 7)

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(60, 65, 82)
	Stroke.Transparency = 0.45
	Stroke.Thickness = 1
	Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	Stroke.Parent = Btn

	table.insert(toggleBtns, {btn = Btn, stroke = Stroke, color = activeColor, query = query})

	Btn.MouseButton1Click:Connect(function()
		callback(not query())
	end)
end

createToggleBtn("飞行", Color3.fromRGB(46, 125, 246),
	UDim2.new(0, 0, 0, 0), UDim2.new(0.5, -2.5, 0, 28),
	function() return flying end,
	function(on) if on then startFly() else stopFly() end end)

createToggleBtn("穿墙", Color3.fromRGB(16, 168, 118),
	UDim2.new(0.5, 2.5, 0, 0), UDim2.new(0.5, -2.5, 0, 28),
	function() return noclip end,
	function(on) setNoclip(on) end)

local SpeedBar = Instance.new("Frame")
SpeedBar.Position = UDim2.fromOffset(0, 33)
SpeedBar.Size = UDim2.new(1, 0, 0, 26)
SpeedBar.BackgroundColor3 = Color3.fromRGB(27, 29, 38)
SpeedBar.BorderSizePixel = 0
SpeedBar.Active = true
SpeedBar.Parent = Body
Instance.new("UICorner", SpeedBar).CornerRadius = UDim.new(0, 7)

local SpeedStroke = Instance.new("UIStroke")
SpeedStroke.Color = Color3.fromRGB(60, 65, 82)
SpeedStroke.Transparency = 0.45
SpeedStroke.Thickness = 1
SpeedStroke.Parent = SpeedBar

local ResetSpeedBtn = Instance.new("TextButton")
ResetSpeedBtn.Size = UDim2.new(1, -82, 1, 0)
ResetSpeedBtn.Position = UDim2.fromOffset(8, 0)
ResetSpeedBtn.BackgroundTransparency = 1
ResetSpeedBtn.Font = Enum.Font.GothamSemibold
ResetSpeedBtn.Text = "速度"
ResetSpeedBtn.TextColor3 = Color3.fromRGB(175, 182, 200)
ResetSpeedBtn.TextSize = 11
ResetSpeedBtn.TextXAlignment = Enum.TextXAlignment.Left
ResetSpeedBtn.Parent = SpeedBar

local function makeStepBtn(txt, xOffset)
	local b = Instance.new("TextButton")
	b.Size = UDim2.fromOffset(20, 18)
	b.Position = UDim2.new(1, xOffset, 0.5, -9)
	b.BackgroundColor3 = Color3.fromRGB(39, 42, 54)
	b.BorderSizePixel = 0
	b.Font = Enum.Font.GothamBold
	b.Text = txt
	b.TextColor3 = Color3.fromRGB(232, 236, 246)
	b.TextSize = 12
	b.Parent = SpeedBar
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
	return b
end

local SubBtn = makeStepBtn("−", -76)
local AddBtn = makeStepBtn("+", -24)

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.fromOffset(28, 18)
SpeedBox.Position = UDim2.new(1, -54, 0.5, -9)
SpeedBox.BackgroundColor3 = Color3.fromRGB(18, 19, 25)
SpeedBox.BorderSizePixel = 0
SpeedBox.Font = Enum.Font.GothamBold
SpeedBox.Text = tostring(flySpeed)
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.TextSize = 11
SpeedBox.ClearTextOnFocus = false
SpeedBox.Parent = SpeedBar
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0, 5)

local function updateSpeed(val)
	val = math.clamp(math.floor(val * 10 + 0.5) / 10, 0.1, 100)
	flySpeed = val
	SpeedBox.Text = tostring(flySpeed)
end

ResetSpeedBtn.MouseButton1Click:Connect(function()
	updateSpeed(1)
end)

SubBtn.MouseButton1Click:Connect(function()
	updateSpeed(flySpeed - (flySpeed <= 1 and 0.2 or 1))
end)

AddBtn.MouseButton1Click:Connect(function()
	updateSpeed(flySpeed + (flySpeed < 1 and 0.2 or 1))
end)

SpeedBox.FocusLost:Connect(function()
	local num = tonumber(SpeedBox.Text)
	if num then
		updateSpeed(num)
	else
		SpeedBox.Text = tostring(flySpeed)
	end
end)

local minimized = false
local function setMinimized(state)
	minimized = state
	if minimized then
		ExpandedView.Visible = false
		MiniPill.Visible = true
		TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			Size = PILL_SIZE
		}):Play()
		TweenService:Create(MainCorner, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			CornerRadius = UDim.new(0, 14)
		}):Play()
	else
		MiniPill.Visible = false
		ExpandedView.Visible = true
		TweenService:Create(Main, TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			Size = FULL_SIZE
		}):Play()
		TweenService:Create(MainCorner, TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			CornerRadius = UDim.new(0, 11)
		}):Play()
	end
end

MinBtn.MouseButton1Click:Connect(function()
	setMinimized(true)
end)

local dragActiveInput = nil
local dragMoved = false
local dragStart, dragStartPos

local function bindDrag(target, isPill)
	target.InputBegan:Connect(function(input)
		if dragActiveInput then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragActiveInput = input
			dragMoved = false
			dragStart = input.Position
			dragStartPos = Main.Position
			local stateConn
			stateConn = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End or input.UserInputState == Enum.UserInputState.Cancel then
					stateConn:Disconnect()
					if dragActiveInput == input then
						dragActiveInput = nil
						if isPill and not dragMoved then
							setMinimized(false)
						end
					end
				end
			end)
		end
	end)
end

bindDrag(DragHitbox, false)
bindDrag(MiniPill, true)

local dragMoveConn = UserInputService.InputChanged:Connect(function(input)
	if input == dragActiveInput then
		local delta = input.Position - dragStart
		if delta.Magnitude > (IsOnMobile and 6 or 4) then
			dragMoved = true
		end
		Main.Position = UDim2.new(dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X, dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y)
	end
end)

local function cleanupAll()
	stopFly()
	setNoclip(false)
	if dragMoveConn then
		dragMoveConn:Disconnect()
		dragMoveConn = nil
	end
	if ScreenGui and ScreenGui.Parent then
		ScreenGui:Destroy()
	end
	if ScreenGui then ScreenGui = nil end
end

CloseBtn.MouseButton1Click:Connect(cleanupAll)
