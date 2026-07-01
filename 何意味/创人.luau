local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local plr = Players.LocalPlayer
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "投掷控制面板"
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 320, 0, 230)
    frame.Position = UDim2.new(0.3, 0, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.Active = true
    frame.Draggable = true
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 35)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Text = "🧲 投掷控制面板"
    spawn(function() while true do title.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1); task.wait(0.1) end end)
    local nameBox = Instance.new("TextBox", frame)
    nameBox.Size = UDim2.new(0.62, 0, 0, 28)
    nameBox.Position = UDim2.new(0.05, 0, 0, 50)
    nameBox.PlaceholderText = "输入玩家名(支持模糊匹配)"
    nameBox.ClearTextOnFocus = false
    nameBox.Font = Enum.Font.Gotham
    nameBox.TextSize = 15
    nameBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Instance.new("UICorner", nameBox).CornerRadius = UDim.new(0, 8)
    local dropdownBtn = Instance.new("TextButton", frame)
    dropdownBtn.Size = UDim2.new(0.28, 0, 0, 28)
    dropdownBtn.Position = UDim2.new(0.69, 0, 0, 50)
    dropdownBtn.Text = "选择玩家 ▼"
    dropdownBtn.Font = Enum.Font.Gotham
    dropdownBtn.TextSize = 15
    dropdownBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    Instance.new("UICorner", dropdownBtn).CornerRadius = UDim.new(0, 8)
    local dropdownContainer = Instance.new("ScrollingFrame", frame)
    dropdownContainer.Size = UDim2.new(0.92, 0, 0, 100)
    dropdownContainer.Position = UDim2.new(0.04, 0, 0, 80)
    dropdownContainer.BackgroundColor3 = Color3.fromRGB(30,30,30)
    dropdownContainer.Visible = false
    Instance.new("UICorner", dropdownContainer).CornerRadius = UDim.new(0, 8)
    local dropdownButtons = {}
    local function updateDropdown()
        for _, btn in pairs(dropdownButtons) do btn:Destroy() end
        dropdownButtons = {}
        local yPos = 0
        for i, p in ipairs(Players:GetPlayers()) do
            local btn = Instance.new("TextButton", dropdownContainer)
            btn.Size = UDim2.new(1, -10, 0, 25)
            btn.Position = UDim2.new(0, 5, 0, yPos)
            btn.Text = p.Name
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            btn.MouseButton1Click:Connect(function() nameBox.Text = p.Name; dropdownContainer.Visible = false end)
            yPos = yPos + 30
            table.insert(dropdownButtons, btn)
        end
        dropdownContainer.CanvasSize = UDim2.new(0, 0, 0, yPos)
    end
    spawn(function() while true do updateDropdown(); task.wait(5) end end)
    dropdownBtn.MouseButton1Click:Connect(function() dropdownContainer.Visible = not dropdownContainer.Visible end)
    local flingSpin
    local function startFling()
        if flingSpin then flingSpin:Destroy() end
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        flingSpin = Instance.new("BodyAngularVelocity")
        flingSpin.AngularVelocity = Vector3.new(0, 999999, 0)
        flingSpin.MaxTorque = Vector3.new(999999, 999999, 999999)
        flingSpin.Parent = hrp
    end
    local function stopFling() if flingSpin then flingSpin:Destroy() end end
    local flingBtn = Instance.new("TextButton", frame)
    flingBtn.Size = UDim2.new(0.92, 0, 0, 35)
    flingBtn.Position = UDim2.new(0.04, 0, 0, 190)
    flingBtn.Text = "▶️ 单次投掷"
    flingBtn.Font = Enum.Font.GothamBold
    flingBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Instance.new("UICorner", flingBtn).CornerRadius = UDim.new(0, 10)
    local loopToggleBtn = Instance.new("TextButton", frame)
    loopToggleBtn.Size = UDim2.new(0.4, 0, 0, 35)
    loopToggleBtn.Position = UDim2.new(0.05, 0, 0, 145)
    loopToggleBtn.Text = "🔁 循环投掷: 关闭"
    loopToggleBtn.Font = Enum.Font.GothamBold
    loopToggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Instance.new("UICorner", loopToggleBtn).CornerRadius = UDim.new(0, 10)
    local looping = false
    loopToggleBtn.MouseButton1Click:Connect(function()
        looping = not looping
        loopToggleBtn.Text = looping and "🔁 循环投掷: 开启" or "🔁 循环投掷: 关闭"
        if not looping then stopFling() end
    end)
    local destroyBtn = Instance.new("TextButton", frame)
    destroyBtn.Size = UDim2.new(0.4, 0, 0, 35)
    destroyBtn.Position = UDim2.new(0.55, 0, 0, 145)
    destroyBtn.Text = "❌ 关闭面板"
    destroyBtn.Font = Enum.Font.GothamBold
    destroyBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
    Instance.new("UICorner", destroyBtn).CornerRadius = UDim.new(0, 10)
    destroyBtn.MouseButton1Click:Connect(function() gui:Destroy() end)
    local function findTarget(name)
        local nameLower = name:lower()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= plr and p.Name:lower():find(nameLower) then return p end
        end
    end
    local function teleportAndFlingOnce(target)
        if not target or not target.Character then return end
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(2,0,0)
        startFling()
    end
    flingBtn.MouseButton1Click:Connect(function()
        local target = findTarget(nameBox.Text)
        if target then teleportAndFlingOnce(target) end
    end)
    RunService.Heartbeat:Connect(function()
        if looping then
            local target = findTarget(nameBox.Text)
            if target and target.Character then
                local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(2,0,0)
                    startFling()
                end
            else
                stopFling()
            end
        end
    end)
    local noclipEnabled = false
    RunService.Stepped:Connect(function()
        if noclipEnabled and plr.Character then
            for _, part in pairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
    UIS.InputBegan:Connect(function(input) if input.KeyCode == Enum.KeyCode.E then noclipEnabled = not noclipEnabled end end)
