---生成怪物,一百秒后踢出
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local userId = 5097019383
    local function spawnGuest()
        local model = Players:CreateHumanoidModelFromUserId(userId)
        model.Name = "Guest666"
        model.Parent = workspace
        local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root and model.PrimaryPart then
            model:SetPrimaryPartCFrame(root.CFrame * CFrame.new(math.random(-5,5), 0, math.random(-5,5)))
        end
        local guestRoot = model:FindFirstChild("HumanoidRootPart")
        if guestRoot then
            local bp = Instance.new("BodyPosition", guestRoot)
            bp.Position = guestRoot.Position + Vector3.new(0,5,0)
            bp.MaxForce = Vector3.new(0,5000,0)
            bp.D = 100
            bp.P = 3000
            local fire = Instance.new("Fire", guestRoot)
            fire.Heat = 10
            fire.Size = 10
            local smoke = Instance.new("Smoke", guestRoot)
            smoke.Color = Color3.new(0,0,0)
            smoke.RiseVelocity = 5
            smoke.Opacity = 0.5
            smoke.Size = 10
        end
        local humanoid = model:FindFirstChild("Humanoid")
        if humanoid then
            local tPoseAnim = Instance.new("Animation")
            tPoseAnim.AnimationId = "rbxassetid://235542946"
            local track = humanoid:LoadAnimation(tPoseAnim)
            track.Looped = true
            track:Play()
        end
        return model
    end
    spawnGuest()
    local hint = Instance.new("Hint", workspace)
    for i = 100, 1, -1 do
        hint.Text = "Countdown: " .. i
        wait(1)
    end
    hint:Destroy()
    for _, player in pairs(Players:GetPlayers()) do player:Kick("Server Shutdown") end
