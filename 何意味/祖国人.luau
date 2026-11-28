local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local Chat = game:GetService("Chat")

if game.PlaceId == 2788229376 then
	loadstring(game:HttpGet("https://pastebin.com/raw/JFrBJBZw"))()
end

local env = getgenv and getgenv() or _G
env.FPDH = workspace.FallenPartsDestroyHeight
loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

lib:Notify(
	{Title = "made by GioBolqv1", Description = "follow me on Roblox plz"},
	{OutlineColor = Color3.fromRGB(80, 80, 80), Time = 6, Type = "default"}
)

task.delay(6, function()
	lib:Notify(
		{Title = "I CAN DO WHATEVER THE", Description = "FUUUUUUUCK I WANT *goons*"},
		{OutlineColor = Color3.fromRGB(80, 80, 80), Time = 1, Type = "default"}
	)
end)

local object

local ok = pcall(function()
	object = CoreGui
	local _ = object.Name
end)

if not ok or not object then
	object = LocalPlayer:WaitForChild("PlayerGui")
end

local customClientUiGui = Instance.new("ScreenGui")
customClientUiGui.Name = "CustomClientUI"
customClientUiGui.ResetOnSpawn = false
customClientUiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
customClientUiGui.Parent = object
local enabled = false
local enabled2 = true
local list = {}
local enabled3 = false
local enabled4 = true
local count = 0.15
local count2 = 3.5
local enabled5 = false
local enabled6 = true

local function makeDraggable(options, callback, enabled2)
	local enabled3, value, position, position2
	options.InputBegan:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseButton1
		then
			if not enabled2 or not enabled then
				enabled3 = true
				position = input.Position
				position2 = options.Position
				local connection
				connection = input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End and enabled3 then
						enabled3 = false
						connection:Disconnect()
						if (input.Position - position).Magnitude < 6 and callback then
							callback()
						end
					end
				end)
			else
				local connection2
				connection2 = input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						connection2:Disconnect()
						if callback then
							callback()
						end
					end
				end)
				return
			end
		end
	end)
	options.InputChanged:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseMovement
		then
			value = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == value and enabled3 then
			local delta = input.Position - position
			options.Position = UDim2.new(
				position2.X.Scale,
				position2.X.Offset + delta.X,
				position2.Y.Scale,
				position2.Y.Offset + delta.Y
			)
		end
	end)
end

local imageButton = Instance.new("ImageButton")
imageButton.Size = UDim2.new(0, 100, 0, 45)
imageButton.Position = UDim2.new(0.95, -120, 0.45, 0)
imageButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
imageButton.Image = "rbxthumb://type=Asset&id=101173184874869&w=150&h=150"
imageButton.ScaleType = Enum.ScaleType.Stretch
imageButton.Active = true
imageButton.BorderSizePixel = 0
imageButton.Parent = customClientUiGui
local homelanderLabel = Instance.new("TextLabel")
homelanderLabel.Size = UDim2.new(1, 0, 1, 0)
homelanderLabel.BackgroundTransparency = 1
homelanderLabel.Text = "Homelander: OFF"
homelanderLabel.TextColor3 = Color3.new(1, 1, 1)
homelanderLabel.Font = Enum.Font.Fantasy
homelanderLabel.TextSize = 12.7
homelanderLabel.ZIndex = 2
homelanderLabel.Parent = imageButton
local homelanderLabelStroke = Instance.new("UIStroke")
homelanderLabelStroke.Thickness = 1.5
homelanderLabelStroke.Color = Color3.fromRGB(0, 0, 0)
homelanderLabelStroke.Parent = homelanderLabel
local imageButtonCorner = Instance.new("UICorner")
imageButtonCorner.CornerRadius = UDim.new(0.2, 0)
imageButtonCorner.Parent = imageButton
local imageButtonStroke = Instance.new("UIStroke")
imageButtonStroke.Thickness = 2
imageButtonStroke.Color = Color3.fromRGB(50, 50, 50)
imageButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
imageButtonStroke.Parent = imageButton
local settingButtonImageButton = Instance.new("ImageButton")
settingButtonImageButton.Name = "SettingButton"
settingButtonImageButton.Size = UDim2.new(0, 45, 0, 45)
settingButtonImageButton.Position = UDim2.new(0.05, 0, 0.45, 0)
settingButtonImageButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
settingButtonImageButton.Image = "rbxthumb://type=Asset&id=104077005427988&w=150&h=150"
settingButtonImageButton.ScaleType = Enum.ScaleType.Stretch
settingButtonImageButton.Active = true
settingButtonImageButton.BorderSizePixel = 0
settingButtonImageButton.Visible = false
settingButtonImageButton.Parent = customClientUiGui
local settingButtonImageButtonCorner = Instance.new("UICorner")
settingButtonImageButtonCorner.CornerRadius = UDim.new(0.3, 0)
settingButtonImageButtonCorner.Parent = settingButtonImageButton
local settingButtonImageButtonStroke = Instance.new("UIStroke")
settingButtonImageButtonStroke.Thickness = 2
settingButtonImageButtonStroke.Color = Color3.fromRGB(50, 50, 50)
settingButtonImageButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
settingButtonImageButtonStroke.Parent = settingButtonImageButton
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 230, 0, 265)
frame.Position = UDim2.new(1, 10, 0.5, -132)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = settingButtonImageButton
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0.1, 0)
frameCorner.Parent = frame
local frameStroke = Instance.new("UIStroke")
frameStroke.Thickness = 2
frameStroke.Color = Color3.fromRGB(60, 60, 60)
frameStroke.Parent = frame
local lockButtonsButton = Instance.new("TextButton")
lockButtonsButton.Size = UDim2.new(0, 100, 0, 26)
lockButtonsButton.Position = UDim2.new(0.05, 0, 0, 6)
lockButtonsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
lockButtonsButton.TextColor3 = Color3.new(1, 1, 1)
lockButtonsButton.Font = Enum.Font.Fantasy
lockButtonsButton.TextSize = 11
lockButtonsButton.Text = "lock buttons"
lockButtonsButton.Parent = frame
local lockButtonsButtonCorner = Instance.new("UICorner")
lockButtonsButtonCorner.CornerRadius = UDim.new(0.2, 0)
lockButtonsButtonCorner.Parent = lockButtonsButton
local cameraFollowButton = Instance.new("TextButton")
cameraFollowButton.Size = UDim2.new(0, 110, 0, 26)
cameraFollowButton.Position = UDim2.new(0.5, 0, 0, 6)
cameraFollowButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
cameraFollowButton.TextColor3 = Color3.new(1, 1, 1)
cameraFollowButton.Font = Enum.Font.Fantasy
cameraFollowButton.TextSize = 10
cameraFollowButton.Text = "camera follow: on"
cameraFollowButton.Parent = frame
local cameraFollowButtonCorner = Instance.new("UICorner")
cameraFollowButtonCorner.CornerRadius = UDim.new(0.2, 0)
cameraFollowButtonCorner.Parent = cameraFollowButton
local hideButtonsButton = Instance.new("TextButton")
hideButtonsButton.Size = UDim2.new(0, 100, 0, 26)
hideButtonsButton.Position = UDim2.new(0.05, 0, 0, 38)
hideButtonsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
hideButtonsButton.TextColor3 = Color3.new(1, 1, 1)
hideButtonsButton.Font = Enum.Font.Fantasy
hideButtonsButton.TextSize = 11
hideButtonsButton.Text = "hide buttons"
hideButtonsButton.Parent = frame
local hideButtonsButtonCorner = Instance.new("UICorner")
hideButtonsButtonCorner.CornerRadius = UDim.new(0.2, 0)
hideButtonsButtonCorner.Parent = hideButtonsButton
local cameraLiftDuringButton = Instance.new("TextButton")
cameraLiftDuringButton.Size = UDim2.new(0, 110, 0, 26)
cameraLiftDuringButton.Position = UDim2.new(0.5, 0, 0, 38)
cameraLiftDuringButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
cameraLiftDuringButton.TextColor3 = Color3.new(1, 1, 1)
cameraLiftDuringButton.Font = Enum.Font.Fantasy
cameraLiftDuringButton.TextSize = 8.5
cameraLiftDuringButton.Text = "camera lift during laser: on"
cameraLiftDuringButton.Parent = frame
local cameraLiftDuringButtonCorner = Instance.new("UICorner")
cameraLiftDuringButtonCorner.CornerRadius = UDim.new(0.2, 0)
cameraLiftDuringButtonCorner.Parent = cameraLiftDuringButton

cameraLiftDuringButton.MouseButton1Click:Connect(function()
	enabled4 = not enabled4
	local text
	if not enabled4 then
		text = "off"
	else
		text = "on"
	end
	cameraLiftDuringButton.Text = "camera lift during laser: " .. text
end)

local laserEyeOffsetLabel = Instance.new("TextLabel")
laserEyeOffsetLabel.Size = UDim2.new(0.5, 0, 0, 22)
laserEyeOffsetLabel.Position = UDim2.new(0.05, 0, 0, 70)
laserEyeOffsetLabel.BackgroundTransparency = 1
laserEyeOffsetLabel.TextColor3 = Color3.new(1, 1, 1)
laserEyeOffsetLabel.Font = Enum.Font.Fantasy
laserEyeOffsetLabel.TextSize = 10
laserEyeOffsetLabel.Text = "laser eye offset:"
laserEyeOffsetLabel.TextXAlignment = Enum.TextXAlignment.Left
laserEyeOffsetLabel.Parent = frame
local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(0, 40, 0, 22)
textButton.Position = UDim2.new(0.55, 0, 0, 70)
textButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
textButton.TextColor3 = Color3.new(1, 1, 1)
textButton.Font = Enum.Font.Fantasy
textButton.TextSize = 13
textButton.Text = "▲"
textButton.Parent = frame
local textButtonCorner = Instance.new("UICorner")
textButtonCorner.CornerRadius = UDim.new(0.2, 0)
textButtonCorner.Parent = textButton
local textButton2 = Instance.new("TextButton")
textButton2.Size = UDim2.new(0, 40, 0, 22)
textButton2.Position = UDim2.new(0.75, 0, 0, 70)
textButton2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
textButton2.TextColor3 = Color3.new(1, 1, 1)
textButton2.Font = Enum.Font.Fantasy
textButton2.TextSize = 13
textButton2.Text = "▼"
textButton2.Parent = frame
local textButtonCorner2 = Instance.new("UICorner")
textButtonCorner2.CornerRadius = UDim.new(0.2, 0)
textButtonCorner2.Parent = textButton2

textButton.MouseButton1Click:Connect(function()
	count = count + 0.05
end)

textButton2.MouseButton1Click:Connect(function()
	count = count - 0.05
end)

local shiftlockButton = Instance.new("TextButton")
shiftlockButton.Size = UDim2.new(0, 100, 0, 26)
shiftlockButton.Position = UDim2.new(0.05, 0, 0, 102)
shiftlockButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
shiftlockButton.TextColor3 = Color3.new(1, 1, 1)
shiftlockButton.Font = Enum.Font.Fantasy
shiftlockButton.TextSize = 11
shiftlockButton.Text = "shiftlock: off"
shiftlockButton.Parent = frame
local shiftlockButtonCorner = Instance.new("UICorner")
shiftlockButtonCorner.CornerRadius = UDim.new(0.2, 0)
shiftlockButtonCorner.Parent = shiftlockButton

shiftlockButton.MouseButton1Click:Connect(function()
	enabled5 = not enabled5
	local text
	if not enabled5 then
		text = "off"
	else
		text = "on"
	end
	shiftlockButton.Text = "shiftlock: " .. text
end)

local laserFlingButton = Instance.new("TextButton")
laserFlingButton.Size = UDim2.new(0, 110, 0, 26)
laserFlingButton.Position = UDim2.new(0.5, 0, 0, 102)
laserFlingButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
laserFlingButton.TextColor3 = Color3.new(1, 1, 1)
laserFlingButton.Font = Enum.Font.Fantasy
laserFlingButton.TextSize = 10
laserFlingButton.Text = "laser fling: on"
laserFlingButton.Parent = frame
local laserFlingButtonCorner = Instance.new("UICorner")
laserFlingButtonCorner.CornerRadius = UDim.new(0.2, 0)
laserFlingButtonCorner.Parent = laserFlingButton

laserFlingButton.MouseButton1Click:Connect(function()
	enabled6 = not enabled6
	local text
	if not enabled6 then
		text = "off"
	else
		text = "on"
	end
	laserFlingButton.Text = "laser fling: " .. text
	if not enabled6 then
		laserCurrentTarget = nil
	end
end)

local cameraXOffsetLabel = Instance.new("TextLabel")
cameraXOffsetLabel.Size = UDim2.new(0.5, 0, 0, 22)
cameraXOffsetLabel.Position = UDim2.new(0.05, 0, 0, 134)
cameraXOffsetLabel.BackgroundTransparency = 1
cameraXOffsetLabel.TextColor3 = Color3.new(1, 1, 1)
cameraXOffsetLabel.Font = Enum.Font.Fantasy
cameraXOffsetLabel.TextSize = 10
cameraXOffsetLabel.Text = "camera X offset:"
cameraXOffsetLabel.TextXAlignment = Enum.TextXAlignment.Left
cameraXOffsetLabel.Parent = frame
local textButton3 = Instance.new("TextButton")
textButton3.Size = UDim2.new(0, 40, 0, 22)
textButton3.Position = UDim2.new(0.55, 0, 0, 134)
textButton3.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
textButton3.TextColor3 = Color3.new(1, 1, 1)
textButton3.Font = Enum.Font.Fantasy
textButton3.TextSize = 13
textButton3.Text = "◀"
textButton3.Parent = frame
local textButtonCorner3 = Instance.new("UICorner")
textButtonCorner3.CornerRadius = UDim.new(0.2, 0)
textButtonCorner3.Parent = textButton3
local textButton4 = Instance.new("TextButton")
textButton4.Size = UDim2.new(0, 40, 0, 22)
textButton4.Position = UDim2.new(0.75, 0, 0, 134)
textButton4.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
textButton4.TextColor3 = Color3.new(1, 1, 1)
textButton4.Font = Enum.Font.Fantasy
textButton4.TextSize = 13
textButton4.Text = "▶"
textButton4.Parent = frame
local textButtonCorner4 = Instance.new("UICorner")
textButtonCorner4.CornerRadius = UDim.new(0.2, 0)
textButtonCorner4.Parent = textButton4

textButton3.MouseButton1Click:Connect(function()
	count2 = count2 - 0.5
end)

textButton4.MouseButton1Click:Connect(function()
	count2 = count2 + 0.5
end)

local frame2 = Instance.new("Frame")
frame2.Size = UDim2.new(0.9, 0, 0, 60)
frame2.Position = UDim2.new(0.05, 0, 0, 168)
frame2.BackgroundTransparency = 1
frame2.Parent = frame

local function createTextButton(text, position)
	local textButton = Instance.new("TextButton")
	textButton.Size = UDim2.new(0, 25, 0, 25)
	textButton.Position = position
	textButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	textButton.TextColor3 = Color3.new(1, 1, 1)
	textButton.Font = Enum.Font.Fantasy
	textButton.TextSize = 16
	textButton.Text = text
	textButton.Parent = frame2
	local textButtonCorner = Instance.new("UICorner")
	textButtonCorner.CornerRadius = UDim.new(0.2, 0)
	textButtonCorner.Parent = textButton
	return textButton
end

local textButton5 = createTextButton("↑", UDim2.new(0.5, -12, 0, 0))
local textButton6 = createTextButton("↓", UDim2.new(0.5, -12, 0, 32))
local textButton7 = createTextButton("←", UDim2.new(0.5, -42, 0, 16))
local textButton8 = createTextButton("→", UDim2.new(0.5, 18, 0, 16))

local function updatePosition(value, value2)
	for _, item in ipairs(list) do
		item.Position = UDim2.new(
			item.Position.X.Scale,
			item.Position.X.Offset + value,
			item.Position.Y.Scale,
			item.Position.Y.Offset + value2
		)
	end
end

textButton5.MouseButton1Click:Connect(function()
	updatePosition(0, -5)
end)

textButton6.MouseButton1Click:Connect(function()
	updatePosition(0, 5)
end)

textButton7.MouseButton1Click:Connect(function()
	updatePosition(-5, 0)
end)

textButton8.MouseButton1Click:Connect(function()
	updatePosition(5, 0)
end)

lockButtonsButton.MouseButton1Click:Connect(function()
	enabled = not enabled
	local text
	if not enabled then
		text = "lock buttons"
	else
		text = "unlock buttons"
	end
	lockButtonsButton.Text = text
end)

cameraFollowButton.MouseButton1Click:Connect(function()
	enabled2 = not enabled2
	local text
	if not enabled2 then
		text = "camera follow: off"
	else
		text = "camera follow: on"
	end
	cameraFollowButton.Text = text
end)

makeDraggable(settingButtonImageButton, function()
	frame.Visible = not frame.Visible
end, false)

local flag = false
local connection
local enabled7 = false
local part
local enabled8 = false
local amount = 1
local enabled9 = false
local enabled10 = false
local amount2 = 1
local found = false
local enabled11 = true
local enabled12 = false
local connection2
local enabled13 = false
local value
local index = 0
local map = {[0] = 1, [1] = 0.5, [2] = 1.5}
Color3.fromRGB(0, 255, 0)
local value2, bodyGyro, bodyVelocity, cameraSubject, weld, connection3
local list2 = {}
local value3
local index2 = 1

local list3 = {
	{id = "rbxassetid://126046533185038", name = "idle V1"},
	{id = "rbxassetid://116874847956719", name = "idle V2"},
	{id = "rbxassetid://96251694399659", name = "idle V3"},
	{id = "rbxassetid://70950173927129", name = "idle V4"},
}

local id = list3[1].id
local map2 = {{id = "rbxassetid://114833664438028", name = "Fly"}}
local enabled14 = false
local amount3 = 0
local now = 0
local map3 = {}
local object2, object3, sound, value4
local enabled15 = false
local connection4, player
local value5 = 0
local value6 = 0
local map4 = {}
local part2
local amount4 = 0
local amount5 = 0
local run

local function sendAsync(value)
	local found = false
	if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
		local rbxGeneral = TextChatService:FindFirstChild("TextChannels")
			and TextChatService.TextChannels:FindFirstChild("RBXGeneral")
		if rbxGeneral then
			rbxGeneral:SendAsync(value)
			found = true
		end
	end
	if not found then
		local sayMessageRequest = ReplicatedStorage:FindFirstChild("SayMessageRequest", true)
		if sayMessageRequest and sayMessageRequest:IsA("RemoteEvent") then
			sayMessageRequest:FireServer(value, "All")
		end
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
			Chat:Chat(LocalPlayer.Character.Head, value, Enum.ChatColor.White)
		end
	end
end

local function disconnect()
	if connection2 then
		connection2:Disconnect()
	end
	connection2 = RunService.Heartbeat:Connect(function()
		if enabled12 then
			local character = LocalPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				task.spawn(function()
					local velocity = humanoidRootPart.Velocity
					humanoidRootPart.Velocity = Vector3.new(450000000, 4500000000, 450000000)
					RunService.RenderStepped:Wait()
					if humanoidRootPart then
						humanoidRootPart.Velocity = velocity
					end
				end)
				return
			end
		end
	end)
end

if game.PlaceId == 189707 then
	local RunService2 = game:GetService("RunService")
	local heartbeat = RunService2.Heartbeat
	local renderStepped = RunService2.RenderStepped
	local LocalPlayer2 = game.Players.LocalPlayer
	local zero = Vector3.zero

	local function onCharacterAdded(instance)
		local HumanoidRootPart = instance:WaitForChild("HumanoidRootPart")
		if HumanoidRootPart then
			local connection
			connection = heartbeat:Connect(function()
				if not HumanoidRootPart.Parent then
					connection:Disconnect()
				end
				local assemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
				HumanoidRootPart.AssemblyLinearVelocity = zero
				renderStepped:Wait()
				HumanoidRootPart.AssemblyLinearVelocity = assemblyLinearVelocity
			end)
		end
	end

	if LocalPlayer2.Character then
		onCharacterAdded(LocalPlayer2.Character)
	end
	LocalPlayer2.CharacterAdded:Connect(onCharacterAdded)
else
	print("Error not found natural disasters survival game!")
end

local function stop(value)
	local amount = value or 0.4
	for _, item in pairs(list2) do
		item:Stop(amount)
	end
	if value3 then
		if coroutine.status(value3) ~= "dead" then
			task.cancel(value3)
		end
		value3 = nil
	end
	list2 = {}
end

local function updateAnimationId(animationId, looped, value)
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end
	local amount = value or 0.4
	local animation = Instance.new("Animation")
	animation.AnimationId = animationId
	local animation2 = humanoid:LoadAnimation(animation)
	animation2.Looped = looped
	animation2:Play(amount)
	table.insert(list2, animation2)
	return animation2
end

local actionButtonsFrame = Instance.new("Frame")
actionButtonsFrame.Name = "ActionButtons"
actionButtonsFrame.Size = UDim2.new(0, 400, 0, 400)
actionButtonsFrame.Position = UDim2.new(1, -420, 0, 50)
actionButtonsFrame.BackgroundTransparency = 1
actionButtonsFrame.Visible = false
actionButtonsFrame.Parent = customClientUiGui
local utilityButtonsFrame = Instance.new("Frame")
utilityButtonsFrame.Name = "UtilityButtons"
utilityButtonsFrame.Size = UDim2.new(0, 310, 0, 100)
utilityButtonsFrame.Position = UDim2.new(1, -310, 0, 20)
utilityButtonsFrame.BackgroundTransparency = 1
utilityButtonsFrame.Visible = false
utilityButtonsFrame.Parent = customClientUiGui

local function updateName(name, position, text, text2, value)
	local imageButton = Instance.new("ImageButton")
	imageButton.Name = name
	imageButton.Size = UDim2.new(0, 45, 0, 45)
	imageButton.Position = position
	imageButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	imageButton.BorderSizePixel = 0
	imageButton.Active = true
	imageButton.AutoButtonColor = true
	imageButton.Parent = value or actionButtonsFrame
	table.insert(list, imageButton)
	local imageButtonCorner = Instance.new("UICorner")
	imageButtonCorner.CornerRadius = UDim.new(0.3, 0)
	imageButtonCorner.Parent = imageButton
	local imageButtonStroke = Instance.new("UIStroke")
	imageButtonStroke.Thickness = 2
	imageButtonStroke.Color = Color3.fromRGB(60, 60, 60)
	imageButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	imageButtonStroke.Parent = imageButton
	if text then
		imageButton.Image = "rbxthumb://type=Asset&id=" .. text .. "&w=150&h=150"
	end
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.TextColor3 = Color3.new(1, 1, 1)
	textLabel.Font = Enum.Font.Fantasy
	textLabel.TextSize = 8
	textLabel.TextWrapped = true
	textLabel.Text = text2 or ""
	textLabel.Parent = imageButton
	return imageButton, imageButtonStroke
end

local object4, object5, object6, object7, object8, object9, object10
local enabled16 = false

local function updateSize()
	local part = Instance.new("Part")
	part.Size = Vector3.new(0.05, 0.05, 0.05)
	part.Anchored = true
	part.CanCollide = false
	part.Transparency = 1
	part.CastShadow = false
	part.Parent = Workspace
	local attachment = Instance.new("Attachment", part)
	local endpoint = Instance.new("Part")
	endpoint.Size = Vector3.new(0.05, 0.05, 0.05)
	endpoint.Anchored = true
	endpoint.CanCollide = false
	endpoint.Transparency = 1
	endpoint.CastShadow = false
	endpoint.Parent = Workspace
	local attachment1 = Instance.new("Attachment", endpoint)

	local function updateAttachment0(width0, width1, value, value2, options)
		local beam = Instance.new("Beam", part)
		beam.Attachment0 = attachment
		beam.Attachment1 = attachment1
		beam.LightEmission = 1
		beam.LightInfluence = 0
		beam.FaceCamera = true
		beam.Segments = 1
		beam.Width0 = width0
		beam.Width1 = width1
		beam.Color = ColorSequence.new(options)
		beam.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, value),
			NumberSequenceKeypoint.new(1, value2),
		})
	end

	updateAttachment0(0.09, 0.04, 0, 0, {
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 220)),
		ColorSequenceKeypoint.new(0.04, Color3.fromRGB(255, 40, 40)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 0, 0)),
	})
	updateAttachment0(0.5, 0.15, 0.25, 0.88, {
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 0, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 0, 0)),
	})
	updateAttachment0(1.1, 0.3, 0.65, 1, {
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
	})
	return {origin = part, endpoint = endpoint}
end

local function updateFilterType()
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	local character = LocalPlayer.Character
	local filterDescendantsInstances = {}
	if character then
		table.insert(filterDescendantsInstances, character)
	end
	if object2 then
		table.insert(filterDescendantsInstances, object2.origin)
		table.insert(filterDescendantsInstances, object2.endpoint)
	end
	if object3 then
		table.insert(filterDescendantsInstances, object3.origin)
		table.insert(filterDescendantsInstances, object3.endpoint)
	end
	raycastParams.FilterDescendantsInstances = filterDescendantsInstances
	return raycastParams
end

local function updateHealth(instance)
	if map3[instance] then
		return
	end
	map3[instance] = true
	local humanoid = instance:FindFirstChildOfClass("Humanoid")
	if humanoid and 0 < humanoid.Health and not Players:GetPlayerFromCharacter(instance) then
		humanoid.Health = 0
		instance:BreakJoints()
	end
	task.delay(0.5, function()
		map3[instance] = nil
	end)
end

local function check(player)
	if
		player
		and player ~= LocalPlayer
		and player.Character
		and (not map4[player] or not (tick() - map4[player] < 8))
	then
		local character = player.Character
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local bodyEffects = character:FindFirstChild("BodyEffects")
		if humanoidRootPart and humanoid and not (humanoid.Health < 2) then
			if not character:FindFirstChildOfClass("ForceField") then
				local ko = bodyEffects and (bodyEffects:FindFirstChild("K.O") or bodyEffects:FindFirstChild("KO"))
				if not ko or ko.Value ~= true then
					local character2 = LocalPlayer.Character
					local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
					if
						humanoidRootPart2
						and not (1000 < (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude)
					then
						return true
					end
				end
			end
		end
	end
	return false
end

local connection5

local function enable()
	if enabled15 then
		return
	end
	enabled15 = true
	enabled14 = false
	amount3 = 0
	now = tick()
	map3 = {}
	player = nil
	value5 = 0
	value6 = 0
	map4 = {}
	amount4 = 0
	amount5 = 0
	if object2 then
		object2.origin:Destroy()
		object2.endpoint:Destroy()
		object2 = nil
	end
	if object3 then
		object3.origin:Destroy()
		object3.endpoint:Destroy()
		object3 = nil
	end
	local character = LocalPlayer.Character
	local head = character and character:FindFirstChild("Head")
	if not sound then
		sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://80876450442880"
		sound.Looped = false
		sound.Volume = 0.6
	end
	if head then
		sound.Parent = head
	end
	if connection5 then
		connection5:Disconnect()
	end
	connection5 = RunService.Heartbeat:Connect(function()
		local character = LocalPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local currentCamera = Workspace.CurrentCamera
		if humanoidRootPart and humanoid and currentCamera then
			local cFrame = humanoidRootPart.CFrame
			local velocity = humanoidRootPart.Velocity
			local rotVelocity = humanoidRootPart.RotVelocity
			local cframe = cFrame
			local found = false
			if player then
				local character2 = player.Character
				local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
				local humanoid2 = character2 and character2:FindFirstChildOfClass("Humanoid")
				if not enabled6 or not humanoidRootPart2 or not humanoid2 or not check(player) then
					player = nil
				else
					local distance = humanoidRootPart2.Velocity.Magnitude
					local amount = tick() - value5
					if 500 < distance or humanoid2.Health < 2 or 3 < amount then
						map4[player] = tick()
						player = nil
					else
						found = true
						amount4 = amount4 + 1
						amount5 = amount5 + 100
						local walkSpeed = humanoid2.WalkSpeed
						local moveDirection = humanoid2.MoveDirection
						CFrame.new()
						local amount2
						if not (50 <= distance) then
							local amount6
							if amount4 % 2 ~= 0 then
								amount6 = -1.5
							else
								amount6 = 1.5
							end
							amount2 = (CFrame.new(0, amount6, 0) + moveDirection * distance / 1.25) * CFrame.Angles(math.rad(amount5), 0, 0)
						else
							local amount7 = amount4 % 3
							if amount7 ~= 0 and amount7 == 1 then
								amount2 = CFrame.new(0, -1.5, -walkSpeed) * CFrame.Angles(0, 0, 0)
							else
								amount2 = CFrame.new(0, 1.5, walkSpeed) * CFrame.Angles(math.pi / 2, 0, 0)
							end
						end
						cframe = CFrame.new(humanoidRootPart2.Position) * amount2
						humanoidRootPart.Velocity = Vector3.new(90000000, 900000000, 90000000)
						pcall(function()
							humanoidRootPart.RotVelocity = Vector3.new(900000000, 900000000, 900000000)
						end)
					end
				end
			end
			if not found then
				if part2 then
					part2:Destroy()
					part2 = nil
				end
				local character3 = LocalPlayer.Character
				local humanoid3 = character3 and character3:FindFirstChildOfClass("Humanoid")
				if cameraSubject and currentCamera.CameraSubject ~= cameraSubject then
					currentCamera.CameraSubject = cameraSubject
					return
				elseif not cameraSubject and humanoid3 and currentCamera.CameraSubject ~= humanoid3 then
					currentCamera.CameraSubject = humanoid3
				end
			else
				if not part2 then
					part2 = Instance.new("Part")
					part2.Name = "LaserStableCameraProxy"
					part2.Size = Vector3.new(0.1, 0.1, 0.1)
					part2.Transparency = 1
					part2.Anchored = true
					part2.CanCollide = false
					part2.Parent = Workspace
					currentCamera.CameraSubject = part2
				end
				local amount8 = cFrame * CFrame.new(0, 1.5, 0)
				local cframe2
				if not enabled4 then
					cframe2 = amount8 * CFrame.new(0, 0.5, 0)
				else
					cframe2 = amount8 * CFrame.new(count2 * amount3, 0.5, 0)
				end
				part2.CFrame = cframe2
				humanoidRootPart.CFrame = cframe
				RunService.RenderStepped:Wait()
				humanoidRootPart.CFrame = cFrame
				humanoidRootPart.Velocity = velocity
				pcall(function()
					humanoidRootPart.RotVelocity = rotVelocity
				end)
				return
			end
		end
	end)
	connection4 = RunService.RenderStepped:Connect(function()
		local character = LocalPlayer.Character
		local head = character and character:FindFirstChild("Head")
		if head then
			local now2 = tick()
			local amount = math.min(now2 - now, 0.05)
			now = now2
			local cFrame = head.CFrame
			local lookVector = cFrame.LookVector
			local position = (cFrame * CFrame.new(-0.23, count, -0.55)).Position
			local position2 = (cFrame * CFrame.new(0.23, count, -0.55)).Position
			if not enabled14 then
				amount3 = math.max(0, amount3 - amount / 0.4)
			else
				amount3 = math.min(1, amount3 + amount / 0.7)
			end
			if weld then
				if not enabled4 then
					weld.C0 = CFrame.new(0, 0.5, 0)
				else
					weld.C0 = CFrame.new(count2 * amount3, 0.5, 0)
				end
			end
			if not (0 < amount3) then
				if object2 then
					object2.origin:Destroy()
					object2.endpoint:Destroy()
					object2 = nil
				end
				if object3 then
					object3.origin:Destroy()
					object3.endpoint:Destroy()
					object3 = nil
				end
			else
				if not object2 or not object3 then
					object2 = updateSize()
					object3 = updateSize()
				end
				local amount2 = amount3 ^ 3 * 1000
				local value = updateFilterType()
				local raycastResult = Workspace:Raycast(position, lookVector * amount2, value)
				local raycastResult2 = Workspace:Raycast(position2, lookVector * amount2, value)
				local position3
				if not raycastResult then
					position3 = position + lookVector * amount2
				else
					position3 = raycastResult.Position or position + lookVector * amount2
				end
				local position4 = raycastResult2 and raycastResult2.Position or position2 + lookVector * amount2
				object2.origin.Position = position
				object2.endpoint.Position = position3
				object3.origin.Position = position2
				object3.endpoint.Position = position4
				local playerFromCharacter
				if enabled14 then
					for _, object in ipairs({raycastResult, raycastResult2}) do
						if not object or not object.Instance then
							continue
						end
						local firstAncestorOfClass = object.Instance:FindFirstAncestorOfClass("Model")
						if not firstAncestorOfClass then
							continue
						end
						local playerFromCharacter2 = Players:GetPlayerFromCharacter(firstAncestorOfClass)
						if playerFromCharacter2 and check(playerFromCharacter2) then
							playerFromCharacter = playerFromCharacter2
						end
						updateHealth(firstAncestorOfClass)
					end
				end
				if playerFromCharacter then
					if player ~= playerFromCharacter then
						player = playerFromCharacter
						value5 = tick()
					end
					value6 = tick()
					return
				elseif player and tick() - value6 < 0.7 then
					return
				end
			end
			player = nil
			return
		end
	end)
end

local function disable(enabled)
	if not enabled15 then
		return
	end
	local enabled2 = enabled14
	enabled15 = false
	enabled14 = false
	amount3 = 0
	map3 = {}
	if object2 then
		object2.origin:Destroy()
		object2.endpoint:Destroy()
		object2 = nil
	end
	if object3 then
		object3.origin:Destroy()
		object3.endpoint:Destroy()
		object3 = nil
	end
	if not enabled2 or not enabled then
		if value4 then
			task.cancel(value4)
			value4 = nil
		end
		if sound then
			sound:Stop()
		end
	else
		if value4 then
			task.cancel(value4)
			value4 = nil
		end
		if sound then
			sound.Looped = false
			sound.TimePosition = 1.65
			sound:Play()
		end
	end
	if weld then
		weld.C0 = CFrame.new(0, 0.5, 0)
	end
	if connection4 then
		connection4:Disconnect()
		connection4 = nil
	end
	if connection5 then
		connection5:Disconnect()
		connection5 = nil
	end
	if part2 then
		part2:Destroy()
		part2 = nil
	end
	player = nil
end

disconnect()
local value7 = updateName("RandVoiceBtn", UDim2.new(0, 305, 0, 70), "126139598282367", "Random Voicelines")
local list4 = {}

local list5 = {
	"you people should be thanking Christ that I am who and what I am, because you need ME!",
	"I am your lord, your saviour. I am your God.",
	"I don't make mistakes, i'm not just like the rest of you.. I'm stronger, I'm smarter... I'm better. I AM BETTER!!",
	"I'm the homelander and I can do whatever the #### I want",
	"the only man in the sky, is me",
	"I AM GOD!",
}

makeDraggable(value7, function()
	local list = {}
	for _, item in ipairs(list5) do
		local found = false
		for _, item2 in ipairs(list4) do
			if item ~= item2 then
				continue
			end
			found = true
		end
		if found then
			continue
		end
		table.insert(list, item)
	end
	if #list == 0 then
		list = list5
	end
	if 0 < #list then
		local value = list[math.random(1, #list)]
		sendAsync(value)
		table.insert(list4, value)
		if 2 < #list4 then
			table.remove(list4, 1)
		end
	end
end, true)

local value8 = updateName("MemeVoiceBtn", UDim2.new(0, 255, 0, 70), "78691293764532", "")

local list6 = {
	"have you seen the memes about me?",
	"Ashley don't look at him look at me! ASHLEY! look. at. me.",
	"hahahaha.... HAHAHAHAHAHA",
	"yummers",
	"hahahaha, alriiight",
	"it was perfect. perfect, down to the last minute detail.",
}

local list7 = {}

makeDraggable(value8, function()
	local list = {}
	for _, item in ipairs(list6) do
		local found = false
		for _, item2 in ipairs(list7) do
			if item ~= item2 then
				continue
			end
			found = true
		end
		if found then
			continue
		end
		table.insert(list, item)
	end
	if #list == 0 then
		list = list6
	end
	if 0 < #list then
		local value = list[math.random(1, #list)]
		sendAsync(value)
		table.insert(list7, value)
		if 2 < #list7 then
			table.remove(list7, 1)
		end
	end
end, true)

local object11 = updateName("SpeedBtn", UDim2.new(0, 210, 0, 0), "129624286483532", "Normal", utilityButtonsFrame)
local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 1.5
uiStroke.Color = Color3.fromRGB(0, 0, 0)
uiStroke.Parent = object11.TextLabel

makeDraggable(object11, function()
	index = (index + 1) % 3
	local textLabel = object11.TextLabel
	local text
	if map[index] == 1 then
		text = "Normal"
	elseif map[index] ~= 0.5 then
		text = "Fast"
	else
		text = "Slow"
	end
	textLabel.Text = text
end, true)

local object12 = updateName("LandBtn", UDim2.new(0, 195, 0, 145), nil, "Ground Land: ON")

makeDraggable(object12, function()
	enabled11 = not enabled11
	local textLabel = object12.TextLabel
	local text
	if not enabled11 then
		text = "OFF"
	else
		text = "ON"
	end
	textLabel.Text = "Ground Land: " .. text
end, true)

local object13 = updateName("IdleAnimBtn", UDim2.new(0, 260, 0, 0), nil, "fly idle:\nidle V1", utilityButtonsFrame)
object13.TextLabel.Text = "fly idle:\n" .. list3[index2].name

makeDraggable(object13, function()
	index2 = index2 % #list3 + 1
	object13.TextLabel.Text = "fly idle:\n" .. list3[index2].name
	id = list3[index2].id
	if enabled7 and value2 == false and not enabled9 then
		stop(0.8)
		updateAnimationId(id, true, 0.8)
	end
end, true)

local object14 = updateName("FlingBtn", UDim2.new(0, 140, 0, 125), nil, "Fling: OFF")

makeDraggable(object14, function()
	enabled12 = not enabled12
	local textLabel = object14.TextLabel
	local text
	if not enabled12 then
		text = "OFF"
	else
		text = "ON"
	end
	textLabel.Text = "Fling: " .. text
end, true)

local enabled17 = false
local list8 = {}
local object15 = updateName("XRayBtn", UDim2.new(0, 155, 0, 70), nil, "X-Ray: OFF")

makeDraggable(object15, function()
	enabled17 = not enabled17
	local textLabel = object15.TextLabel
	local text
	if not enabled17 then
		text = "OFF"
	else
		text = "ON"
	end
	textLabel.Text = "X-Ray: " .. text
	if not enabled17 then
		for k, item in pairs(list8) do
			if not k or not k.Parent then
				continue
			end
			k.Transparency = item
		end
		list8 = {}
		return
	end
	list8 = {}
	for _, descendant in ipairs(Workspace:GetDescendants()) do
		if not descendant:IsA("BasePart") then
			continue
		end
		local found = false
		local firstAncestorOfClass = descendant:FindFirstAncestorOfClass("Model")
		if firstAncestorOfClass and firstAncestorOfClass:FindFirstChildOfClass("Humanoid") then
			found = true
		end
		if found or not (descendant.Transparency < 1) then
			continue
		end
		list8[descendant] = descendant.Transparency
		descendant.Transparency = 0.6
	end
end, true)

local object16, object17 = updateName(
	"TryingFlyBtn",
	UDim2.new(0.95, -120, 0.45, 50),
	"127754775766218",
	"",
	customClientUiGui
)

object16.Visible = false
local enabled18 = false
local animation

makeDraggable(object16, function()
	if enabled7 then
		enabled18 = not enabled18
		object17.Color = enabled18 and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(60, 60, 60)
		if not enabled18 then
			if animation then
				animation:Stop(0.2)
				animation = nil
			end
			value2 = nil
			if run then
				run(false)
			end
		else
			stop(0.2)
			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				local animation2 = Instance.new("Animation")
				animation2.AnimationId = "rbxassetid://89569027537835"
				animation = humanoid:LoadAnimation(animation2)
				animation.Priority = Enum.AnimationPriority.Action4
				animation.Looped = true
				animation:Play(0.2)
				return
			end
		end
	end
end, true)

local object18, object19 = updateName(
	"CompoundBtn",
	UDim2.new(0.95, -70, 0.45, 50),
	"112901173121233",
	"",
	customClientUiGui
)

object18.Visible = false
local enabled19 = false
local animation2, value9

makeDraggable(object18, function()
	if enabled7 then
		enabled19 = not enabled19
		object19.Color = enabled19 and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(60, 60, 60)
		if not enabled19 then
			if value9 then
				task.cancel(value9)
				value9 = nil
			end
			if animation2 then
				animation2:Stop(0.2)
				animation2 = nil
			end
			value2 = nil
			if run then
				run(false)
			end
		else
			stop(0.2)
			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				local animation = Instance.new("Animation")
				animation.AnimationId = "rbxassetid://82731245433251"
				animation2 = humanoid:LoadAnimation(animation)
				animation2.Priority = Enum.AnimationPriority.Action4
				animation2.Looped = false
				animation2:Play(0.2)
				value9 = task.spawn(function()
					animation2.TimePosition = 0
					animation2:AdjustSpeed(1)
					local now = tick()
					while enabled19 and tick() - now < 3.5 do
						task.wait()
					end
					if not enabled19 then
						return
					end
					while enabled19 do
						animation2.TimePosition = 3.5
						animation2:AdjustSpeed(-0.2)
						local now2 = tick()
						while enabled19 and tick() - now2 < 2.5 do
							task.wait()
						end
						if not enabled19 then
							break
						end
					end
				end)
				return
			end
		end
	end
end, true)

local value10, object20 = updateName("LaserEyesBtn", UDim2.new(0, 205, 0, 70), "137555465918674", "")

makeDraggable(value10, function()
	if not enabled15 then
		enable()
		enabled14 = true
		if value4 then
			task.cancel(value4)
			value4 = nil
		end
		if sound then
			value4 = task.spawn(function()
				sound.TimePosition = 0
				sound.Looped = false
				sound:Play()
				local now = tick()
				repeat
					task.wait()
				until not sound.IsPlaying or 1.5 <= sound.TimePosition or 5 < tick() - now
				while enabled14 and enabled15 do
					sound.TimePosition = 1.1
					sound.Looped = false
					if not sound.IsPlaying then
						sound:Play()
					end
					local now2 = tick()
					repeat
						task.wait()
					until not enabled15 or not enabled14 or 1.5 <= sound.TimePosition or 2 < tick() - now2
					if not enabled14 or not enabled15 then
						break
					end
				end
			end)
		end
		object20.Color = Color3.fromRGB(180, 0, 0)
		return
	end
	enabled14 = not enabled14
	if not enabled14 then
		if value4 then
			task.cancel(value4)
			value4 = nil
		end
		if sound then
			sound.Looped = false
			sound.TimePosition = 1.65
			sound:Play()
		end
	else
		if value4 then
			task.cancel(value4)
			value4 = nil
		end
		if sound then
			value4 = task.spawn(function()
				sound.TimePosition = 0
				sound.Looped = false
				sound:Play()
				local now = tick()
				repeat
					task.wait()
				until not sound.IsPlaying or 1.5 <= sound.TimePosition or 5 < tick() - now
				while enabled14 and enabled15 do
					sound.TimePosition = 1.1
					sound.Looped = false
					if not sound.IsPlaying then
						sound:Play()
					end
					local now2 = tick()
					repeat
						task.wait()
					until not enabled15 or not enabled14 or 1.5 <= sound.TimePosition or 2 < tick() - now2
					if not enabled14 or not enabled15 then
						break
					end
				end
			end)
		end
	end
	object20.Color = enabled14 and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(60, 60, 60)
end, true)

task.spawn(function()
	while true do
		if enabled9 and enabled16 then
			enabled16 = false
			if object4 then
				object4:Stop(0.3)
			end
			if object5 then
				object5:Stop(0.3)
			end
			if object6 then
				object6:Stop(0.3)
			end
			if object7 then
				object7:Stop(0.3)
			end
			if object8 then
				object8:Stop(0.3)
			end
			if object9 then
				object9:Stop(0.3)
			end
			if object10 then
				object10:Stop(0.3)
			end
		end
		task.wait()
	end
end)

local now2 = 0

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if
		not gameProcessed
		and not enabled9
		and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch)
	then
		now2 = tick()
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if
		not gameProcessed
		and not enabled9
		and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch)
	then
		local _ = tick() - now2
	end
end)

local list9 = {}

rebuildNoclipCache = function()
	list9 = {}
	if LocalPlayer.Character then
		for _, descendant in ipairs(LocalPlayer.Character:GetDescendants()) do
			if not descendant:IsA("BasePart") then
				continue
			end
			table.insert(list9, descendant)
		end
	end
end

local function disconnect2(enabled)
	flag = enabled
	if connection then
		connection:Disconnect()
		connection = nil
	end
	if enabled then
		rebuildNoclipCache()
		connection = RunService.RenderStepped:Connect(function()
			for _, item in ipairs(list9) do
				item.CanCollide = false
			end
		end)
		return
	end
	if LocalPlayer.Character then
		local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then
			pcall(function()
				humanoidRootPart.CanCollide = true
			end)
		end
	end
end

run = function(value)
	if not enabled9 then
		if value2 ~= value then
			value2 = value
			if value then
				stop(0.4)
				value3 = task.spawn(function()
					if amount2 == 3 then
						local object = updateAnimationId(map2[1].id, true, 0.3)
						if object then
							object.Priority = Enum.AnimationPriority.Action2
							object.TimePosition = 1
							object:AdjustSpeed(8)
							task.delay(0.1, function()
								if object then
									object:AdjustSpeed(1)
								end
							end)
						end
						local currentCamera = Workspace.CurrentCamera
						task.spawn(function()
							task.wait(0.5)
							while enabled7 and amount2 == 3 and not enabled9 do
								local amount3 = 0.5 + amount / 10 * 0.7
								local vector3 = Vector3.new(
									math.random(-100, 100) / 1000 * amount3,
									math.random(-100, 100) / 1000 * amount3,
									math.random(-100, 100) / 1000 * amount3
								)
								currentCamera.CFrame = currentCamera.CFrame * CFrame.new(vector3)
								RunService.RenderStepped:Wait()
							end
						end)
						return
					end
					amount2 = 1
					local now = tick()
					local object2 = updateAnimationId("rbxassetid://114833664438028", false, 0.2)
					if object2 then
						object2:AdjustSpeed(2)
					end
					while tick() - now < 0.225 do
						amount = 1 + (tick() - now) / 0.225 * 1
						task.wait()
					end
					if object2 then
						object2:Stop(0.2)
					end
					amount2 = 2
					local now2 = tick()
					local object3 = updateAnimationId("rbxassetid://114833664438028", false, 0.2)
					if object3 then
						object3:AdjustSpeed(2)
					end
					while tick() - now2 < 0.33 do
						amount = 2 + (tick() - now2) / 0.33 * 3
						task.wait()
					end
					if object3 then
						object3:Stop(0.3)
					end
					amount2 = 3
					local object4 = updateAnimationId(map2[1].id, true, 0.3)
					if object4 then
						object4.Priority = Enum.AnimationPriority.Action2
						object4.TimePosition = 1
						object4:AdjustSpeed(8)
						task.delay(0.1, function()
							if object4 then
								object4:AdjustSpeed(1)
							end
						end)
					end
					local currentCamera2 = Workspace.CurrentCamera
					task.spawn(function()
						task.wait(0.5)
						while enabled7 and amount2 == 3 and not enabled9 do
							local amount3 = 0.5 + amount / 10 * 0.7
							local vector3 = Vector3.new(
								math.random(-100, 100) / 1000 * amount3,
								math.random(-100, 100) / 1000 * amount3,
								math.random(-100, 100) / 1000 * amount3
							)
							currentCamera2.CFrame = currentCamera2.CFrame * CFrame.new(vector3)
							RunService.RenderStepped:Wait()
						end
					end)
					local now3 = tick()
					while value2 == true do
						local amount3 = (tick() - now3) / 5
						currentStage3Multiplier = 5 + math.min(amount3, 1) * 5
						amount = currentStage3Multiplier
						task.wait()
					end
				end)
				return
			end
			stop(0.8)
			updateAnimationId(id, true, 0.8)
			amount = 1
			amount2 = 1
			return
		end
	end
end

local function enable2()
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local currentCamera = Workspace.CurrentCamera
	if not humanoid or not currentCamera then
		return Vector3.new()
	end
	local vector3 = Vector3.new()
	local found = false
	if UserInputService:IsKeyDown(Enum.KeyCode.W) then
		vector3 = vector3 + currentCamera.CFrame.LookVector
		found = true
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.S) then
		vector3 = vector3 - currentCamera.CFrame.LookVector
		found = true
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.A) then
		vector3 = vector3 - currentCamera.CFrame.RightVector
		found = true
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.D) then
		vector3 = vector3 + currentCamera.CFrame.RightVector
		found = true
	end
	local vector32 = Vector3.new(0, 0, 0)
	if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
		local amount
		if amount2 ~= 3 then
			amount = 1
		else
			amount = 2
		end
		vector32 = vector32 + Vector3.new(0, 1 * amount, 0)
		found = true
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
		local amount3
		if amount2 ~= 3 then
			amount3 = 1
		else
			amount3 = 10
		end
		vector32 = vector32 - Vector3.new(0, 1 * amount3, 0)
		found = true
	end
	local amount4 = vector3 + vector32
	if not found and 0.05 < humanoid.MoveDirection.Magnitude then
		local moveDirection = humanoid.MoveDirection
		local unit = Vector3.new(currentCamera.CFrame.LookVector.X, 0, currentCamera.CFrame.LookVector.Z).Unit
		local unit2 = Vector3.new(currentCamera.CFrame.RightVector.X, 0, currentCamera.CFrame.RightVector.Z).Unit
		local value = moveDirection:Dot(unit)
		local value2 = moveDirection:Dot(unit2)
		amount4 = amount4 + currentCamera.CFrame.RightVector * value2 + currentCamera.CFrame.LookVector * value
	end
	return 0 < amount4.Magnitude and amount4.Unit or Vector3.new()
end

local function enable3(position, part)
	if enabled9 or enabled10 or not enabled11 or not (2 <= amount2) then
		return
	end
	enabled9 = true
	enabled10 = true
	value = nil
	stop(0.1)
	local character = LocalPlayer.Character
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local color3 = part and part.Color or Color3.fromRGB(100, 100, 100)
	local plastic = part and part.Material or Enum.Material.Plastic
	local amount3 = amount / 5
	task.spawn(function()
		local amount = math.floor(15 * amount3)
		for i = 1, amount do
			local amount2 = i / amount * math.pi * 2
			local amount4 = math.random(4, 12) * amount3
			local vector3 = Vector3.new(math.cos(amount2) * amount4, 0, math.sin(amount2) * amount4)
			local amount5 = math.random(100, 300) / 100 * amount3
			local part = Instance.new("Part")
			part.Size = Vector3.new(amount5, amount5, amount5)
			part.Position = position + vector3 + Vector3.new(0, -1, 0)
			part.Color = color3
			part.Material = plastic
			part.CanCollide = false
			part.Anchored = false
			part.Parent = workspace
			part.AssemblyLinearVelocity = Vector3.new(0, 30 * amount3, 0) + vector3.Unit * (10 * amount3)
			part.AssemblyAngularVelocity = Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
			Debris:AddItem(part, 2.5)
			task.spawn(function()
				task.wait(1.5)
				TweenService:Create(part, TweenInfo.new(1), {Transparency = 1}):Play()
			end)
		end
	end)
	local amount4 = amount3 * 1.5
	local currentCamera = Workspace.CurrentCamera
	local now = tick()
	local amount5 = 0.8
	task.spawn(function()
		while tick() - now < amount5 do
			local vector3 = Vector3.new(
				math.random(-100, 100) / 1000 * amount4,
				math.random(-100, 100) / 1000 * amount4,
				math.random(-100, 100) / 1000 * amount4
			)
			currentCamera.CFrame = currentCamera.CFrame * CFrame.new(vector3)
			RunService.RenderStepped:Wait()
		end
	end)
	if bodyVelocity then
		bodyVelocity.velocity = Vector3.new(0, 0, 0)
	end
	if humanoidRootPart then
		humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
	end
	if humanoidRootPart and humanoid then
		local amount6 = position.Y + (humanoidRootPart.Size.Y / 2 + humanoid.HipHeight)
		local lookVector = humanoidRootPart.CFrame.LookVector
		local unit = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
		local tweenInfo = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local cFrame = CFrame.lookAt(
			Vector3.new(humanoidRootPart.Position.X, amount6, humanoidRootPart.Position.Z),
			Vector3.new(humanoidRootPart.Position.X, amount6, humanoidRootPart.Position.Z) + unit
		)
		TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = cFrame}):Play()
		task.wait(0.08)
		humanoidRootPart.CFrame = cFrame
	end
	local object = updateAnimationId("rbxassetid://79698004825744", false, 0.1)
	if object then
		object:AdjustSpeed(2)
		local amount7 = math.max(0, object.Length / 2 - 0.5)
		local now2 = tick()
		while tick() - now2 < amount7 do
			if enabled7 then
				task.wait()
				continue
			end
			object:Stop(0.1)
			if humanoid then
				humanoid.AutoRotate = true
				humanoid.PlatformStand = false
			end
			local currentCamera2 = Workspace.CurrentCamera
			if currentCamera2 and humanoid then
				currentCamera2.CameraSubject = humanoid
				currentCamera2.CameraType = Enum.CameraType.Custom
			end
			stop(0)
			enabled9 = false
			value2 = nil
			task.delay(0.3, function()
				enabled10 = false
			end)
			return
		end
		if enabled7 then
			amount2 = 1
			updateAnimationId(id, true, 0.5)
			local now3 = tick()
			while tick() - now3 < 0.5 do
				if enabled7 then
					task.wait()
					continue
				end
				if humanoid then
					humanoid.AutoRotate = true
					humanoid.PlatformStand = false
				end
				local currentCamera3 = Workspace.CurrentCamera
				if currentCamera3 and humanoid then
					currentCamera3.CameraSubject = humanoid
					currentCamera3.CameraType = Enum.CameraType.Custom
				end
				stop(0)
				enabled9 = false
				value2 = nil
				task.delay(0.3, function()
					enabled10 = false
				end)
				return
			end
		end
	end
	enabled9 = false
	value2 = nil
	task.delay(0.3, function()
		enabled10 = false
	end)
end

local function destroy()
	if bodyGyro then
		bodyGyro:Destroy()
	end
	if bodyVelocity then
		bodyVelocity:Destroy()
	end
	if cameraSubject then
		cameraSubject:Destroy()
	end
	stop()
	value2 = nil
	amount = 1
	amount2 = 1
	value = nil
	enabled13 = false
	if part then
		part:Destroy()
		part = nil
	end
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local currentCamera = Workspace.CurrentCamera
	if currentCamera and humanoid then
		currentCamera.CameraSubject = humanoid
		currentCamera.CameraType = Enum.CameraType.Custom
		humanoid.AutoRotate = true
		humanoid.PlatformStand = false
		humanoid.CameraOffset = Vector3.new(0, 0, 0)
		TweenService:Create(
			currentCamera,
			TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{FieldOfView = 70}
		):Play()
	end
	if connection3 then
		connection3:Disconnect()
		connection3 = nil
	end
	disable(false)
end

local function updateAutoRotate()
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	local head = character and character:FindFirstChild("Head")
	local currentCamera = Workspace.CurrentCamera
	if not humanoidRootPart or not humanoid or not currentCamera then
		return
	end
	if not found then
		task.spawn(function()
			humanoidRootPart.Anchored = true
			local animation = Instance.new("Animation")
			animation.AnimationId = "rbxassetid://79698004825744"
			local animation2 = humanoid:LoadAnimation(animation)
			animation2:Play()
			animation2:Stop()
			RunService.Heartbeat:Wait()
			humanoidRootPart.Anchored = false
			found = true
		end)
	end
	humanoid.AutoRotate = false
	humanoid.PlatformStand = true
	if not part then
		part = Instance.new("Part")
		part.Name = "MobileFlyGroundPart"
		part.Size = Vector3.new(10, 10, 10)
		part.Transparency = 1
		part.CanCollide = false
		part.Anchored = false
		part.Massless = true
		part.Parent = workspace
	end
	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.P = 40000
	bodyGyro.D = 500
	bodyGyro.maxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
	bodyGyro.Parent = humanoidRootPart
	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.velocity = Vector3.zero
	bodyVelocity.maxForce = Vector3.new(9000000000, 9000000000, 9000000000)
	bodyVelocity.Parent = humanoidRootPart
	if head then
		local camFocusPart = Instance.new("Part")
		camFocusPart.Name = "CamFocus"
		camFocusPart.Transparency = 1
		camFocusPart.CanCollide = false
		camFocusPart.Massless = true
		camFocusPart.Size = Vector3.new(0.1, 0.1, 0.1)
		camFocusPart.Parent = character
		local weld2 = Instance.new("Weld")
		weld2.Part0 = head
		weld2.Part1 = camFocusPart
		weld2.C0 = CFrame.new(0, 0.5, 0)
		weld2.Parent = camFocusPart
		currentCamera.CameraSubject = camFocusPart
		cameraSubject = camFocusPart
		weld = weld2
	end
	connection3 = RunService.RenderStepped:Connect(function(dt)
		if not enabled7 or not humanoidRootPart or not currentCamera or enabled9 or enabled13 then
			return
		end
		local object = enable2()
		local filterDescendantsInstances = {character, part}
		for _, player in ipairs(Players:GetPlayers()) do
			if not player.Character then
				continue
			end
			table.insert(filterDescendantsInstances, player.Character)
		end
		local raycastParams = RaycastParams.new()
		raycastParams.FilterDescendantsInstances = filterDescendantsInstances
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		local flag = bodyVelocity.velocity.Y < -5
		if not flag then
			value = nil
		elseif value == nil then
			local raycastResult = workspace:Raycast(humanoidRootPart.Position, Vector3.new(0, -500, 0), raycastParams)
			local amount3
			if not raycastResult then
				amount3 = 999
			else
				amount3 = humanoidRootPart.Position.Y - raycastResult.Position.Y or 999
			end
			value = amount3
		end
		local amount4 = math.max(3, bodyVelocity.velocity.Magnitude * dt * 0.75 + 1)
		local raycastResult2 = workspace:Raycast(humanoidRootPart.Position, Vector3.new(0, -amount4, 0), raycastParams)
		if
			raycastResult2
			and raycastResult2.Instance
			and enabled11
			and flag
			and raycastResult2.Instance.CanCollide
			and raycastResult2.Instance.Transparency <= 0.75
			and 2 <= amount2
			and 30 < bodyVelocity.velocity.Magnitude
			and 5 <= (value or 0)
		then
			enable3(raycastResult2.Position, raycastResult2.Instance)
			return
		end
		if not (0 < object.Magnitude) then
			bodyVelocity.velocity = Vector3.zero
			if enabled5 or enabled2 then
				bodyGyro.CFrame = bodyGyro.CFrame:Lerp(
					CFrame.lookAt(
						humanoidRootPart.Position,
						humanoidRootPart.Position + currentCamera.CFrame.LookVector
					),
					0.1
				)
			end
			run(false)
			if currentCamera.FieldOfView ~= 70 then
				TweenService:Create(currentCamera, TweenInfo.new(0.7), {FieldOfView = 70}):Play()
			end
		else
			bodyVelocity.velocity = object * (33.8 * amount * map[index])
			if enabled5 then
				bodyGyro.CFrame = bodyGyro.CFrame:Lerp(
					CFrame.lookAt(
						humanoidRootPart.Position,
						humanoidRootPart.Position + currentCamera.CFrame.LookVector
					),
					0.15
				)
			elseif not enabled2 then
				local vector3 = Vector3.new(object.X, 0, object.Z)
				if 0.05 < vector3.Magnitude then
					bodyGyro.CFrame = bodyGyro.CFrame:Lerp(
						CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + vector3.Unit),
						0.15
					)
				end
			else
				bodyGyro.CFrame = bodyGyro.CFrame:Lerp(
					CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + object),
					0.15
				)
			end
			run(true)
			if amount2 == 3 then
				if currentCamera.FieldOfView < 89.9 then
					TweenService:Create(currentCamera, TweenInfo.new(0.35), {FieldOfView = 90}):Play()
				end
			elseif 70.1 < currentCamera.FieldOfView then
				TweenService:Create(currentCamera, TweenInfo.new(0.7), {FieldOfView = 70}):Play()
			end
		end
		pcall(function()
			if part and humanoidRootPart then
				part.CFrame = humanoidRootPart.CFrame * CFrame.new(0, -(humanoidRootPart.Size.Y / 2) - 5, 0)
			end
		end)
	end)
	run(false)
	enable()
end

hideButtonsButton.MouseButton1Click:Connect(function()
	enabled3 = not enabled3
	local text
	if not enabled3 then
		text = "hide buttons"
	else
		text = "show buttons"
	end
	hideButtonsButton.Text = text
	if enabled3 then
		actionButtonsFrame.Visible = false
		utilityButtonsFrame.Visible = false
		object16.Visible = false
		object18.Visible = false
		return
	end
	if enabled7 then
		actionButtonsFrame.Visible = true
		utilityButtonsFrame.Visible = true
		object16.Visible = true
		object18.Visible = true
	end
end)

makeDraggable(imageButton, function()
	enabled7 = not enabled7
	local text
	if not enabled7 then
		text = "OFF"
	else
		text = "ON"
	end
	homelanderLabel.Text = "Homelander: " .. text
	if not enabled7 then
		enabled9 = false
	end
	if not enabled7 then
		actionButtonsFrame.Visible = false
		utilityButtonsFrame.Visible = false
		object16.Visible = false
		object18.Visible = false
		settingButtonImageButton.Visible = false
	else
		if not enabled3 then
			actionButtonsFrame.Visible = true
			utilityButtonsFrame.Visible = true
			object16.Visible = true
			object18.Visible = true
		end
		settingButtonImageButton.Visible = true
	end
	if enabled7 then
		enabled8 = flag
		disconnect2(true)
		updateAutoRotate()
		return
	end
	if enabled18 then
		enabled18 = false
		if animation then
			animation:Stop(0.2)
			animation = nil
		end
		object17.Color = Color3.fromRGB(60, 60, 60)
	end
	if enabled19 then
		enabled19 = false
		if value9 then
			task.cancel(value9)
			value9 = nil
		end
		if animation2 then
			animation2:Stop(0.2)
			animation2 = nil
		end
		object19.Color = Color3.fromRGB(60, 60, 60)
	end
	if enabled14 then
		enabled14 = false
		object20.Color = Color3.fromRGB(60, 60, 60)
	end
	destroy()
	disconnect2(enabled8)
	frame.Visible = false
end, false)

LocalPlayer.CharacterAdded:Connect(function(character)
	rebuildNoclipCache()
	if enabled7 then
		destroy()
		task.wait(0.2)
		if enabled7 then
			disconnect2(true)
			updateAutoRotate()
		end
	end
	if game.PlaceId == 189707 then
		local RunService = game:GetService("RunService")
		local heartbeat = RunService.Heartbeat
		local renderStepped = RunService.RenderStepped
		local zero = Vector3.zero
		local HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
		if HumanoidRootPart then
			local connection
			connection = heartbeat:Connect(function()
				if not HumanoidRootPart.Parent then
					connection:Disconnect()
				end
				local assemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
				HumanoidRootPart.AssemblyLinearVelocity = zero
				renderStepped:Wait()
				HumanoidRootPart.AssemblyLinearVelocity = assemblyLinearVelocity
			end)
		end
	end
end)

local screenGui = Instance.new("ScreenGui", object)
screenGui.Enabled = false
local frame3 = Instance.new("Frame", screenGui)
frame3.BorderSizePixel = 0
frame3.BackgroundColor3 = Color3.fromRGB(254, 199, 255)
frame3.Size = UDim2.new(0, 316, 0, 128)
frame3.Position = UDim2.new(0.5, -150, 0.5, -50)
local imageLabel = Instance.new("ImageLabel", frame3)
imageLabel.BorderSizePixel = 0
imageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
imageLabel.Image = "rbxassetid://97587406223179"
imageLabel.Size = UDim2.new(0, 316, 0, 142)
imageLabel.Position = UDim2.new(0, 0, -0.10938, 0)
local textBox = Instance.new("TextBox", imageLabel)
textBox.PlaceholderText = "shortened name/display"
textBox.Size = UDim2.new(0.9, -20, 0.3, -10)
textBox.Position = UDim2.new(0.05, 0, 0.3, 0)
textBox.Text = ""
textBox.BackgroundColor3 = Color3.fromRGB(113, 27, 255)
textBox.TextColor3 = Color3.new(1, 1, 1)
local banishButton = Instance.new("TextButton", imageLabel)
banishButton.Size = UDim2.new(0.4, 0, 0.25, 0)
banishButton.Position = UDim2.new(0.3, 0, 0.65, 0)
banishButton.Text = "banish >:3"
banishButton.BackgroundColor3 = Color3.fromRGB(255, 232, 204)

local function getPlayer(text)
	local text2 = text:lower()
	for _, player in pairs(Players:GetPlayers()) do
		if
			player == LocalPlayer
			or not player.Name:lower():match("^" .. text2) and not player.DisplayName:lower():match("^" .. text2)
		then
			continue
		end
		return player
	end
end

banishButton.MouseButton1Click:Connect(function()
	local player = getPlayer(textBox.Text)
	if player then
		local character = LocalPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		local humanoidRootPart2 = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart and humanoidRootPart2 then
			local cFrame = humanoidRootPart.CFrame
			workspace.FallenPartsDestroyHeight = -99999
			local bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
			bodyVelocity.Velocity = Vector3.new(450000000, 4500000000, 450000000)
			bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			local now = tick()
			while tick() - now < 1.5 do
				humanoidRootPart.CFrame = humanoidRootPart2.CFrame
				RunService.Heartbeat:Wait()
			end
			bodyVelocity:Destroy()
			humanoidRootPart.CFrame = cFrame
			workspace.FallenPartsDestroyHeight = env.FPDH
		end
	end
end)

