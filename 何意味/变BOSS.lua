local player = game:GetService("Players").LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")
    local cam = workspace.CurrentCamera
    hum.WalkSpeed = 30
    local sfx = Instance.new("Sound", char:FindFirstChild("Head") or char)
    sfx.SoundId = "rbxassetid://2496367477"
    sfx.Volume = 4
    sfx:Play()
    task.delay(3, function() sfx:Stop() end)
    local startText = Instance.new("BillboardGui", char)
    startText.Size = UDim2.new(0,200,0,50)
    startText.StudsOffset = Vector3.new(0,5,0)
    startText.Adornee = char:FindFirstChild("Head")
    startText.AlwaysOnTop = true
    local label = Instance.new("TextLabel", startText)
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.Arcade
    label.Text = "哈哈哈..."
    label.TextColor3 = Color3.fromRGB(255,0,0)
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0,0,0)
    task.delay(3, function() startText:Destroy() end)
    local walkAnim = Instance.new("Animation")
    walkAnim.AnimationId = "rbxassetid://97172005"
    local walkTrack = hum:LoadAnimation(walkAnim)
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.Name = "战斗界面"
    local function createBtn(name, pos, func)
        local btn = Instance.new("TextButton", gui)
        btn.Name = name
        btn.Size = UDim2.new(0,110,0,110)
        btn.Position = pos
        btn.BackgroundColor3 = Color3.fromRGB(230,230,230)
        btn.TextColor3 = Color3.new(0,0,0)
        btn.BorderColor3 = Color3.new(0,0,0)
        btn.Text = name
        btn.TextScaled = true
        btn.Font = Enum.Font.SourceSansBold
        btn.AutoButtonColor = true
        btn.ClipsDescendants = true
        btn.AnchorPoint = Vector2.new(1,1)
        local corner = Instance.new("UICorner", btn)
        corner.CornerRadius = UDim.new(1,0)
        btn.MouseButton1Click:Connect(func)
    end
    local function showOverhead(c, txt)
        local b = Instance.new("BillboardGui", c)
        b.Size = UDim2.new(0,200,0,50)
        b.StudsOffset = Vector3.new(0,5,0)
        b.Adornee = c:FindFirstChild("Head")
        b.AlwaysOnTop = true
        local l = Instance.new("TextLabel", b)
        l.Size = UDim2.new(1,0,1,0)
        l.BackgroundTransparency = 1
        l.TextScaled = true
        l.Font = Enum.Font.Arcade
        l.Text = txt
        l.TextColor3 = Color3.fromRGB(200,0,0)
        l.TextStrokeTransparency = 0
        l.TextStrokeColor3 = Color3.new(0,0,0)
        task.delay(2, function() b:Destroy() end)
    end
    local function swingTrail(c)
        local rarm = c:FindFirstChild("Right Arm") or c:FindFirstChild("RightHand")
        if rarm then
            local att0 = Instance.new("Attachment", rarm)
            local att1 = Instance.new("Attachment", rarm)
            att0.Position = Vector3.new(0,1,0)
            att1.Position = Vector3.new(0,-1,0)
            local trail = Instance.new("Trail", rarm)
            trail.Attachment0 = att0
            trail.Attachment1 = att1
            trail.Lifetime = 0.2
            trail.Color = ColorSequence.new(Color3.new(1,0,0))
            game:GetService("Debris"):AddItem(trail, 0.3)
        end
    end
    game:GetService("RunService").RenderStepped:Connect(function()
        if hum.MoveDirection.Magnitude > 0 then
            local offset = Vector3.new(math.random(-1,1)*0.2, math.random(-1,1)*0.2, math.random(-1,1)*0.2)
            cam.CFrame = cam.CFrame * CFrame.new(offset)
            if not walkTrack.IsPlaying then walkTrack:Play() end
        else
            if walkTrack.IsPlaying then walkTrack:Stop() end
        end
    end)
    local function attack()
        showOverhead(char, "你逃不掉的")
        local a = Instance.new("Animation")
        a.AnimationId = "rbxassetid://209875013"
        local t = hum:LoadAnimation(a)
        t:Play()
        swingTrail(char)
    end
    local launched = false
    local function launge()
        if not launched then launched = true end
        showOverhead(char, "我要抓住你...")
        local sound = Instance.new("Sound", char:FindFirstChild("Head"))
        sound.SoundId = "rbxassetid://8502101489"
        sound.Volume = 4
        sound.PlaybackSpeed = 0.1
        sound:Play()
        task.delay(3, function() sound:Stop() end)
        local red = Instance.new("Frame", gui)
        red.Size = UDim2.new(1,0,1,0)
        red.BackgroundColor3 = Color3.new(1,0,0)
        red.BackgroundTransparency = 0.5
        red.ZIndex = 9999
        red.Name = "红色屏幕"
        local a = Instance.new("Animation")
        a.AnimationId = "rbxassetid://142495255"
        local t = hum:LoadAnimation(a)
        t:AdjustSpeed(0.9)
        t:Play()
        swingTrail(char)
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Velocity = hrp.CFrame.LookVector * 45
        bv.MaxForce = Vector3.new(1e6,0,1e6)
        bv.P = 5000
        for i = 1,15 do
            local offset = Vector3.new(math.random(-1,1), math.random(-1,1), math.random(-1,1)) * 0.5
            cam.CFrame = cam.CFrame * CFrame.new(offset)
            task.wait(0.03)
        end
        task.delay(0.6, function() bv:Destroy() end)
        task.delay(1.5, function() if gui:FindFirstChild("红色屏幕") then gui["红色屏幕"]:Destroy() end end)
    end
    local finished = false
    local function finish()
        if not finished then finished = true end
        local a1 = Instance.new("Animation")
        a1.AnimationId = "rbxassetid://243653141"
        local t1 = hum:LoadAnimation(a1)
        t1:AdjustSpeed(0.15)
        t1:Play()
        swingTrail(char)
        local head = char:FindFirstChild("Head")
        local sound = Instance.new("Sound", head)
        sound.SoundId = "rbxassetid://1497493768"
        sound.Volume = 5
        sound.PlaybackSpeed = 1.5
        sound:Play()
        showOverhead(char, "我即神明")
        t1.Stopped:Wait()
        local a2 = Instance.new("Animation")
        a2.AnimationId = "rbxassetid://243662996"
        local t2 = hum:LoadAnimation(a2)
        t2:AdjustSpeed(0.9)
        t2:Play()
        swingTrail(char)
    end
    createBtn("攻击", UDim2.new(1, -140, 1, -270), attack)
    createBtn("冲刺", UDim2.new(1, -140, 1, -140), launge)
    createBtn("终结技", UDim2.new(1, -140, 1, -10), finish)
    local mouse = player:GetMouse()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "传送"
    tool.Activated:Connect(function()
        local pos = mouse.Hit + Vector3.new(0,2.5,0)
        pos = CFrame.new(pos.X, pos.Y, pos.Z)
        char:WaitForChild("HumanoidRootPart").CFrame = pos
        local tpSound = Instance.new("Sound", char:FindFirstChild("Head") or char)
        tpSound.SoundId = "rbxassetid://7322622109"
        tpSound.Volume = 3
        tpSound:Play()
        game:GetService("Debris"):AddItem(tpSound, 3)
    end)
    tool.Parent = player.Backpack
