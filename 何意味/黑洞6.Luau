local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local angle = 1
local radius = 10
local blackHoleActive = false

local function setupPlayer()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local Folder = Instance.new("Folder", Workspace)
    local Part = Instance.new("Part", Folder)
    local Attachment1 = Instance.new("Attachment", Part)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1

    return humanoidRootPart, Attachment1
end

local humanoidRootPart, Attachment1 = setupPlayer()

if not getgenv().Network then
    getgenv().Network = {
        BaseParts = {},
        Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
    }

    Network.RetainPart = function(part)
        if typeof(part) == "Instance" and part:IsA("BasePart") and part:IsDescendantOf(Workspace) then
            table.insert(Network.BaseParts, part)
            part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
            part.CanCollide = false
        end
    end

    local function EnablePartControl()
        LocalPlayer.ReplicationFocus = Workspace
        RunService.Heartbeat:Connect(function()
            sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
            for _, part in pairs(Network.BaseParts) do
                if part:IsDescendantOf(Workspace) then
                    part.Velocity = Network.Velocity
                end
            end
        end)
    end

    EnablePartControl()
end

local function ForcePart(v)
    if v:IsA("Part") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
        for _, x in next, v:GetChildren() do
            if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                x:Destroy()
            end
        end
        if v:FindFirstChild("Attachment") then
            v:FindFirstChild("Attachment"):Destroy()
        end
        if v:FindFirstChild("AlignPosition") then
            v:FindFirstChild("AlignPosition"):Destroy()
        end
        if v:FindFirstChild("Torque") then
            v:FindFirstChild("Torque"):Destroy()
        end
        v.CanCollide = false
        
        local Torque = Instance.new("Torque", v)
        Torque.Torque = Vector3.new(1000000, 1000000, 1000000)
        local AlignPosition = Instance.new("AlignPosition", v)
        local Attachment2 = Instance.new("Attachment", v)
        Torque.Attachment0 = Attachment2
        AlignPosition.MaxForce = math.huge
        AlignPosition.MaxVelocity = math.huge
        AlignPosition.Responsiveness = 500
        AlignPosition.Attachment0 = Attachment2
        AlignPosition.Attachment1 = Attachment1
    end
end

local function toggleBlackHole()
    blackHoleActive = not blackHoleActive
    if blackHoleActive then
        for _, v in next, Workspace:GetDescendants() do
            ForcePart(v)
        end

        Workspace.DescendantAdded:Connect(function(v)
            if blackHoleActive then
                ForcePart(v)
            end
        end)

        spawn(function()
            while blackHoleActive and RunService.RenderStepped:Wait() do
                angle = angle + math.rad(2)

                local offsetX = math.cos(angle) * radius
                local offsetZ = math.sin(angle) * radius

                Attachment1.WorldCFrame = humanoidRootPart.CFrame * CFrame.new(offsetX, 0, offsetZ)
            end
        end)
    else
        Attachment1.WorldCFrame = CFrame.new(0, -1000, 0)
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    humanoidRootPart, Attachment1 = setupPlayer()
    if blackHoleActive then
        toggleBlackHole()
    end
end)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/miroeramaa/TurtleLib/main/TurtleUiLib.lua"))()
local window = library:Window("Projeto LKB")

window:Slider("Radius Blackhole",1,100,10, function(Value)
   radius = Value
end)

window:Toggle("Blackhole", true, function(Value)
       if Value then
            toggleBlackHole()
        else
            blackHoleActive = false
        end
end)

spawn(function()
    while true do
        RunService.RenderStepped:Wait()
        if blackHoleActive then
            angle = angle + math.rad(angleSpeed)
        end
    end
end)

toggleBlackHole()
end)
blackhole:Button("黑洞脚本(盗版环绕V1)", function()
  local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local Folder = Instance.new("Folder", Workspace)
local Part = Instance.new("Part", Folder)
local Attachment1 = Instance.new("Attachment", Part)
Part.Anchored = true
Part.CanCollide = false
Part.Transparency = 1

if not getgenv().Network then
	getgenv().Network = {
		BaseParts = {},
		Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
	}

	Network.RetainPart = function(Part)
		if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(Workspace) then
			table.insert(Network.BaseParts, Part)
			Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
			Part.CanCollide = false
		end
	end

	local function EnablePartControl()
		LocalPlayer.ReplicationFocus = Workspace
		RunService.Heartbeat:Connect(function()
			sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
			for _, Part in pairs(Network.BaseParts) do
				if Part:IsDescendantOf(Workspace) then
					Part.Velocity = Network.Velocity
				end
			end
		end)
	end

	EnablePartControl()
end

local function ForcePart(v)
	if v:IsA("Part") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
		for _, x in next, v:GetChildren() do
			if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
				x:Destroy()
			end
		end
		if v:FindFirstChild("Attachment") then
			v:FindFirstChild("Attachment"):Destroy()
		end
		if v:FindFirstChild("AlignPosition") then
			v:FindFirstChild("AlignPosition"):Destroy()
		end
		if v:FindFirstChild("Torque") then
			v:FindFirstChild("Torque"):Destroy()
		end
		v.CanCollide = false
		local Torque = Instance.new("Torque", v)
		Torque.Torque = Vector3.new(100000, 100000, 100000)
		local AlignPosition = Instance.new("AlignPosition", v)
		local Attachment2 = Instance.new("Attachment", v)
		Torque.Attachment0 = Attachment2
		AlignPosition.MaxForce = 999999999999999
		AlignPosition.MaxVelocity = math.huge
		AlignPosition.Responsiveness = 200
		AlignPosition.Attachment0 = Attachment2
		AlignPosition.Attachment1 = Attachment1
	end
end



local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")

local LocalPlayer = Players.LocalPlayer

-- Sound Effects
local function playSound(soundId)
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. soundId
	sound.Parent = SoundService
	sound:Play()
	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end

-- Play initial sound
playSound("2865227271")

--Properties:
local SuperRingPartV1 = Instance.new("ScreenGui")
SuperRingPartV1.Name = "SuperRingPartV1"
SuperRingPartV1.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
SuperRingPartV1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SuperRingPartV1.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = SuperRingPartV1
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 201, 255)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.331818193, 0, 0.288944721, 0)
MainFrame.Size = UDim2.new({0, 265},0, 89)

local UICorner = Instance.new("UICorner")
UICorner.Parent = MainFrame

local Tittle = Instance.new("TextLabel")
Tittle.Name = "Tittle"
Tittle.Parent = MainFrame
Tittle.BackgroundColor3 = Color3.fromRGB(60, 223, 255)
Tittle.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tittle.BorderSizePixel = 0
Tittle.Size = UDim2.new(0, 265, 0, 25)
Tittle.Font = Enum.Font.SourceSans
Tittle.Text = "环绕 V1 制作者 Rip_IKASI"
Tittle.TextColor3 = Color3.fromRGB(0, 0, 0)
Tittle.TextSize = 14.000

local UICorner_2 = Instance.new("UICorner")
UICorner_2.Parent = Tittle

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(39, 205, 255)
ToggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0.0490566045, 0, 0.215277776, 0)
ToggleButton.Size = UDim2.new(0, 239, 0, 41)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.Text = "Start Ring Part"
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextSize = 14.000

local DecreaseRadius = Instance.new("TextButton")
DecreaseRadius.Name = "DecreaseRadius"
DecreaseRadius.Parent = MainFrame
DecreaseRadius.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DecreaseRadius.BackgroundTransparency = 1.000
DecreaseRadius.BorderColor3 = Color3.fromRGB(0, 0, 0)
DecreaseRadius.BorderSizePixel = 0
DecreaseRadius.Position = UDim2.new(0.0905660391, 0, 0.583333313, 0)
DecreaseRadius.Size = UDim2.new(0, 47, 0, 41)
DecreaseRadius.Font = Enum.Font.SourceSans
DecreaseRadius.Text = "-"
DecreaseRadius.TextColor3 = Color3.fromRGB(0, 0, 0)
DecreaseRadius.TextSize = 51.000

local IncreaseRadius = Instance.new("TextButton")
IncreaseRadius.Name = "IncreaseRadius"
IncreaseRadius.Parent = MainFrame
IncreaseRadius.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
IncreaseRadius.BackgroundTransparency = 1.000
IncreaseRadius.BorderColor3 = Color3.fromRGB(0, 0, 0)
IncreaseRadius.BorderSizePixel = 0
IncreaseRadius.Position = UDim2.new(0.747169793, 0, 0.583333313, 0)
IncreaseRadius.Size = UDim2.new(0, 47, 0, 41)
IncreaseRadius.Font = Enum.Font.SourceSans
IncreaseRadius.Text = "+"
IncreaseRadius.TextColor3 = Color3.fromRGB(0, 0, 0)
IncreaseRadius.TextSize = 51.000

local RadiusDisplay = Instance.new("TextLabel")
RadiusDisplay.Name = "RadiusDisplay"
RadiusDisplay.Parent = MainFrame
RadiusDisplay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RadiusDisplay.BackgroundTransparency = 1.000
RadiusDisplay.BorderColor3 = Color3.fromRGB(0, 0, 0)
RadiusDisplay.BorderSizePixel = 0
RadiusDisplay.Position = UDim2.new(0.245283023, 0, 0.548611104, 0)
RadiusDisplay.Size = UDim2.new(0, 133, 0, 50)
RadiusDisplay.Font = Enum.Font.SourceSans
RadiusDisplay.Text = "半径 : 50"
RadiusDisplay.TextColor3 = Color3.fromRGB(0, 0, 0)
RadiusDisplay.TextSize = 23.000

local Watermark = Instance.new("TextLabel")
Watermark.Name = "Watermark"
Watermark.Parent = MainFrame
Watermark.BackgroundColor3 = Color3.fromRGB(24, 201, 255)
Watermark.BorderColor3 = Color3.fromRGB(0, 0, 0)
Watermark.BorderSizePixel = 0
Watermark.Position = UDim2.new(0, 0, 0.826388896, 0)
Watermark.Size = UDim2.new(0, 264, 0, 25)
Watermark.Font = Enum.Font.SourceSans
Watermark.Text = "Super Ring Part V1 By Rip_IKASI"
Watermark.TextColor3 = Color3.fromRGB(0, 0, 0)
Watermark.TextSize = 14.000

local UICorner_3 = Instance.new("UICorner")
UICorner_3.Parent = Watermark

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.BackgroundTransparency = 1.000
MinimizeButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(0.894339621, 0, 0, 0)
MinimizeButton.Size = UDim2.new(0, 26, 0, 25)
MinimizeButton.Font = Enum.Font.SourceSans
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeButton.TextSize = 51.000

-- Round the minimize button
local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 15)
MinimizeCorner.Parent = MinimizeButton

-- Minimize functionality
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		MainFrame:TweenSize(UDim2.new(0, 265,0, 23), "Out", "Quad", 0.3, true)
		MinimizeButton.Text = "开"
		ToggleButton.Visible = false
		DecreaseRadius.Visible = false
		IncreaseRadius.Visible = false
		RadiusDisplay.Visible = false
		Watermark.Visible = false
	else
		MainFrame:TweenSize(UDim2.new(0, 265,0, 151), "Out", "Quad", 0.3, true)
		MinimizeButton.Text = "关"
		ToggleButton.Visible = true
		DecreaseRadius.Visible = true
		IncreaseRadius.Visible = true
		RadiusDisplay.Visible = true
		Watermark.Visible = true
	end
	playSound("12221967")
end)

-- Make GUI draggable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- Ring Parts Logic
if not getgenv().Network then
	getgenv().Network = {
		BaseParts = {},
		Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
	}
	Network.RetainPart = function(Part)
		if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(workspace) then
			table.insert(Network.BaseParts, Part)
			Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
			Part.CanCollide = false
		end
	end
	local function EnablePartControl()
		LocalPlayer.ReplicationFocus = workspace
		RunService.Heartbeat:Connect(function()
			sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
			for _, Part in pairs(Network.BaseParts) do
				if Part:IsDescendantOf(workspace) then
					Part.Velocity = Network.Velocity
				end
			end
		end)
	end
	EnablePartControl()
end

local radius = 50
local height = 100
local rotationSpeed = 200
local attractionStrength = 1000
local ringPartsEnabled = false

local function RetainPart(Part)
	if Part:IsA("BasePart") and not Part.Anchored and Part:IsDescendantOf(workspace) then
		if Part.Parent == LocalPlayer.Character or Part:IsDescendantOf(LocalPlayer.Character) then
			return false
		end

		Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		Part.CanCollide = false
		return true
	end
	return false
end

local parts = {}
local function addPart(part)
	if RetainPart(part) then
		if not table.find(parts, part) then
			table.insert(parts, part)
		end
	end
end

local function removePart(part)
	local index = table.find(parts, part)
	if index then
		table.remove(parts, index)
	end
end

for _, part in pairs(workspace:GetDescendants()) do
	addPart(part)
end

workspace.DescendantAdded:Connect(addPart)
workspace.DescendantRemoving:Connect(removePart)

RunService.Heartbeat:Connect(function()
	if not ringPartsEnabled then return end

	local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if humanoidRootPart then
		local tornadoCenter = humanoidRootPart.Position
		for _, part in pairs(parts) do
			if part.Parent and not part.Anchored then
				local pos = part.Position
				local distance = (Vector3.new(pos.X, tornadoCenter.Y, pos.Z) - tornadoCenter).Magnitude
				local angle = math.atan2(pos.Z - tornadoCenter.Z, pos.X - tornadoCenter.X)
				local newAngle = angle + math.rad(rotationSpeed)
				local targetPos = Vector3.new(
					tornadoCenter.X + math.cos(newAngle) * math.min(radius, distance),
					tornadoCenter.Y + (height * (math.abs(math.sin((pos.Y - tornadoCenter.Y) / height)))),
					tornadoCenter.Z + math.sin(newAngle) * math.min(radius, distance)
				)
				local directionToTarget = (targetPos - part.Position).unit
				part.Velocity = directionToTarget * attractionStrength
			end
		end
	end
end)

-- Button functionality
ToggleButton.MouseButton1Click:Connect(function()
	ringPartsEnabled = not ringPartsEnabled
	ToggleButton.Text = ringPartsEnabled and "开" or "关"
	ToggleButton.BackgroundColor3 = ringPartsEnabled and Color3.fromRGB(50, 205, 50) or Color3.fromRGB(160, 82, 45)
	playSound("12221967")
end)

DecreaseRadius.MouseButton1Click:Connect(function()
	radius = math.max(1, radius - 5)
	RadiusDisplay.Text = "半径: " .. radius
	playSound("12221967")
end)

IncreaseRadius.MouseButton1Click:Connect(function()
	radius = math.min(1000, radius + 5)
	RadiusDisplay.Text = "半径: " .. radius
	playSound("12221967")
end)

-- Get player thumbnail
local userId = Players:GetUserIdFromNameAsync("Robloxlukasgames")
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420
local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

StarterGui:SetCore("SendNotification", {
	Title = "环绕V1",
	Text = "CN_2014ldx",
	Icon = content,
	Duration = 5
})

-- Chat message (Updated for new chat system)
local function SendChatMessage(message)
	if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
		local textChannel = TextChatService.TextChannels.RBXGeneral
		textChannel:SendAsync(message)
	else
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
	end
end

-- Send the chat message
SendChatMessage("")
