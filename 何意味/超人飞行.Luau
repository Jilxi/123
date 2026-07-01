local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local StarterGui = game:GetService("StarterGui")
    local plr = Players.LocalPlayer
    while not plr do Players.PlayerAdded:Wait(); plr = Players.LocalPlayer end
    local FLY_SPEED = 50
    local flying = false
    local flyToggled = false
    local ctrl = {f = 0, b = 0, l = 0, r = 0}
    local bg, bv, flyLoop = nil, nil, nil
    local function getCharacter()
        local character = plr.Character
        if not character then plr.CharacterAdded:Wait(); character = plr.Character end
        return character
    end
    local SysBroker = Instance.new("ScreenGui")
    SysBroker.Name = "FlySystem"
    SysBroker.Parent = game:GetService("CoreGui")
    SysBroker.ResetOnSpawn = false
    SysBroker.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Parent = SysBroker
    Background.AnchorPoint = Vector2.new(0.5, 0.5)
    Background.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Background.BorderColor3 = Color3.fromRGB(0, 255, 255)
    Background.Position = UDim2.new(0.5, 0, 0.5, 0)
    Background.Size = UDim2.new(0, 250, 0, 150)
    Background.Active = true
    Background.Draggable = true
    local TitleBar = Instance.new("TextLabel")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = Background
    TitleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TitleBar.BackgroundTransparency = 0.25
    TitleBar.Size = UDim2.new(1, 0, 0, 25)
    TitleBar.Font = Enum.Font.SourceSansBold
    TitleBar.Text = "更帅的飞行"
    TitleBar.TextColor3 = Color3.fromRGB(0, 255, 255)
    TitleBar.TextSize = 16
    local SpeedFrame = Instance.new("Frame")
    SpeedFrame.Parent = Background
    SpeedFrame.BackgroundTransparency = 1
    SpeedFrame.Position = UDim2.new(0, 10, 0, 30)
    SpeedFrame.Size = UDim2.new(1, -20, 0, 25)
    local SpeedLabel = Instance.new("TextLabel")
    SpeedLabel.Parent = SpeedFrame
    SpeedLabel.Size = UDim2.new(0.4, 0, 1, 0)
    SpeedLabel.Text = "飞行速度:"
    SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
    SpeedLabel.TextSize = 14
    local SpeedBox = Instance.new("TextBox")
    SpeedBox.Parent = SpeedFrame
    SpeedBox.Position = UDim2.new(0.4, 5, 0, 0)
    SpeedBox.Size = UDim2.new(0.6, -5, 1, 0)
    SpeedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedBox.Text = tostring(FLY_SPEED)
    SpeedBox.ClearTextOnFocus = false
    SpeedBox.TextSize = 14
    local FlyButton = Instance.new("TextButton")
    FlyButton.Name = "FlyButton"
    FlyButton.Parent = Background
    FlyButton.Position = UDim2.new(0.1, 0, 0.5, 0)
    FlyButton.Size = UDim2.new(0.8, 0, 0.25, 0)
    FlyButton.Text = "开启飞行 (F)"
    FlyButton.Font = Enum.Font.SourceSansBold
    FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    FlyButton.TextSize = 14
    local FlyPad = Instance.new("ImageButton")
    FlyPad.Name = "FlyPad"
    FlyPad.Parent = SysBroker
    FlyPad.BackgroundTransparency = 1
    FlyPad.Position = UDim2.new(0.1, 0, 0.6, 0)
    FlyPad.Size = UDim2.new(0, 100, 0, 100)
    FlyPad.Image = "rbxassetid://6764432293"
    FlyPad.ImageRectOffset = Vector2.new(713, 315)
    FlyPad.ImageRectSize = Vector2.new(75, 75)
    FlyPad.Visible = UserInputService.TouchEnabled
    local function createTouchButton(name, pos, size)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Parent = FlyPad
        btn.BackgroundTransparency = 1
        btn.Position = pos
        btn.Size = size
        btn.Text = ""
        btn.ZIndex = 2
        return btn
    end
    local FlyWButton = createTouchButton("FlyWButton", UDim2.new(0.3, 0, 0, 0), UDim2.new(0.4, 0, 0.3, 0))
    local FlyAButton = createTouchButton("FlyAButton", UDim2.new(0, 0, 0.35, 0), UDim2.new(0.3, 0, 0.4, 0))
    local FlySButton = createTouchButton("FlySButton", UDim2.new(0.3, 0, 0.7, 0), UDim2.new(0.4, 0, 0.3, 0))
    local FlyDButton = createTouchButton("FlyDButton", UDim2.new(0.7, 0, 0.35, 0), UDim2.new(0.3, 0, 0.4, 0))
    local function stopAllAnimations(humanoid)
        if humanoid and humanoid:FindFirstChild("Animator") then
            for _, track in pairs(humanoid.Animator:GetPlayingAnimationTracks()) do track:Stop() end
        end
    end
    local function playAnimation(humanoid, assetId, time, speed)
        stopAllAnimations(humanoid)
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://"..assetId
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
        animTrack:AdjustSpeed(speed or 1)
        if time then animTrack.TimePosition = time end
        return animTrack
    end
    local function updateFlySpeed()
        local newSpeed = tonumber(SpeedBox.Text)
        if newSpeed and newSpeed > 0 and newSpeed <= 500 then
            FLY_SPEED = math.floor(newSpeed)
            SpeedBox.Text = tostring(FLY_SPEED)
        else
            SpeedBox.Text = tostring(FLY_SPEED)
        end
    end
    local function stopFlying()
        if not flying then return end
        flying = false
        if flyLoop then flyLoop:Disconnect(); flyLoop = nil end
        local character = getCharacter()
        if character and character:FindFirstChild("HumanoidRootPart") then
            if bg then bg:Destroy() end
            if bv then bv:Destroy() end
            character.Humanoid.PlatformStand = false
            stopAllAnimations(character.Humanoid)
        end
        FlyButton.Text = "开启飞行 (F)"
        FlyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        ctrl = {f = 0, b = 0, l = 0, r = 0}
    end
    local function startFlying()
        if flying then return end
        local character = getCharacter()
        if not character or not character:FindFirstChild("Humanoid") or not character:FindFirstChild("HumanoidRootPart") then return end
        flying = true
        flyToggled = true
        character.Humanoid.PlatformStand = true
        bg = Instance.new("BodyGyro")
        bg.Name = "FlyGyro"
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = character.HumanoidRootPart.CFrame
        bg.Parent = character.HumanoidRootPart
        bv = Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"
        bv.velocity = Vector3.new(0, 0.1, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Parent = character.HumanoidRootPart
        FlyButton.Text = "关闭飞行 (F)"
        FlyButton.BackgroundColor3 = Color3.fromRGB(215, 60, 0)
        playAnimation(character.Humanoid, "10714347256", 4, 0)
        flyLoop = RunService.Heartbeat:Connect(function()
            if not flying or not character or not character.Parent then stopFlying(); return end
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not hrp or not bg or not bv then stopFlying(); return end
            local cam = workspace.CurrentCamera
            if not cam then return end
            local speed = FLY_SPEED
            if (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 then speed = 0 end
            local move = (cam.CFrame.LookVector * (ctrl.f + ctrl.b)) + (cam.CFrame.RightVector * (ctrl.l + ctrl.r))
            bv.Velocity = move * speed
            bg.CFrame = cam.CFrame * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed / FLY_SPEED), 0, 0)
        end)
    end
    local function handleInput(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.W then ctrl.f = 1; playAnimation(getCharacter().Humanoid, "10714177846", 4.65, 0)
        elseif input.KeyCode == Enum.KeyCode.S then ctrl.b = -1; playAnimation(getCharacter().Humanoid, "10147823318", 4.11, 0)
        elseif input.KeyCode == Enum.KeyCode.A then ctrl.l = -1; playAnimation(getCharacter().Humanoid, "10147823318", 3.55, 0)
        elseif input.KeyCode == Enum.KeyCode.D then ctrl.r = 1; playAnimation(getCharacter().Humanoid, "10147823318", 4.81, 0)
        elseif input.KeyCode == Enum.KeyCode.F then if flying then stopFlying() else startFlying() end end
    end
    local function handleInputEnd(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.W then ctrl.f = 0
        elseif input.KeyCode == Enum.KeyCode.S then ctrl.b = 0
        elseif input.KeyCode == Enum.KeyCode.A then ctrl.l = 0
        elseif input.KeyCode == Enum.KeyCode.D then ctrl.r = 0 end
        if ctrl.f == 0 and ctrl.b == 0 and ctrl.l == 0 and ctrl.r == 0 then
            if flying then playAnimation(getCharacter().Humanoid, "10714347256", 4, 0)
            else stopAllAnimations(getCharacter().Humanoid) end
        end
    end
    local function setupTouchControls()
        FlyWButton.MouseButton1Down:Connect(function() ctrl.f = 1 end)
        FlyWButton.MouseButton1Up:Connect(function() ctrl.f = 0 end)
        FlySButton.MouseButton1Down:Connect(function() ctrl.b = -1 end)
        FlySButton.MouseButton1Up:Connect(function() ctrl.b = 0 end)
        FlyAButton.MouseButton1Down:Connect(function() ctrl.l = -1 end)
        FlyAButton.MouseButton1Up:Connect(function() ctrl.l = 0 end)
        FlyDButton.MouseButton1Down:Connect(function() ctrl.r = 1 end)
        FlyDButton.MouseButton1Up:Connect(function() ctrl.r = 0 end)
    end
    FlyButton.MouseButton1Click:Connect(function() if flying then stopFlying() else startFlying() end end)
    SpeedBox.FocusLost:Connect(function(enterPressed) if enterPressed then updateFlySpeed() end end)
    local function setupCharacterHandling()
        plr.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid").Died:Connect(stopFlying)
            if flyToggled then task.wait(1); startFlying() end
        end)
        if plr.Character then plr.Character:WaitForChild("Humanoid").Died:Connect(stopFlying) end
    end
    local function initializeSystem()
        setupTouchControls()
        setupCharacterHandling()
        UserInputService.InputBegan:Connect(handleInput)
        UserInputService.InputEnded:Connect(handleInputEnd)
    end
    initializeSystem()
