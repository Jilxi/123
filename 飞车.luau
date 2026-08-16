local Flymguiv2 = Instance.new("ScreenGui")
    Flymguiv2.Name = "Flym gui v2"
    Flymguiv2.Parent = game:GetService("CoreGui")
    Flymguiv2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local localPlayer = game:GetService("Players").LocalPlayer
    local Drag = Instance.new("Frame")
    Drag.Name = "Drag"
    Drag.Parent = Flymguiv2
    Drag.Active = true
    Drag.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
    Drag.BorderSizePixel = 0
    Drag.Draggable = true
    Drag.Position = UDim2.new(0.482438415, 0, 0.454874992, 0)
    Drag.Size = UDim2.new(0, 237, 0, 27)
    local FlyFrame = Instance.new("Frame")
    FlyFrame.Name = "FlyFrame"
    FlyFrame.Parent = Drag
    FlyFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    FlyFrame.BorderSizePixel = 0
    FlyFrame.Draggable = true
    FlyFrame.Position = UDim2.new(-0.00200000009, 0, 0.989000022, 0)
    FlyFrame.Size = UDim2.new(0, 237, 0, 150)
    local ddnsfbfwewefe = Instance.new("TextButton")
    ddnsfbfwewefe.Name = "ddnsfbfwewefe"
    ddnsfbfwewefe.Parent = FlyFrame
    ddnsfbfwewefe.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
    ddnsfbfwewefe.BorderSizePixel = 0
    ddnsfbfwewefe.Position = UDim2.new(-0.000210968778, 0, -0.00395679474, 0)
    ddnsfbfwewefe.Size = UDim2.new(0, 237, 0, 27)
    ddnsfbfwewefe.Font = Enum.Font.SourceSans
    ddnsfbfwewefe.Text = "GG超级飞车"
    ddnsfbfwewefe.TextColor3 = Color3.fromRGB(255, 255, 255)
    ddnsfbfwewefe.TextScaled = true
    ddnsfbfwewefe.TextSize = 14.000
    ddnsfbfwewefe.TextWrapped = true
    local Speed = Instance.new("TextBox")
    Speed.Name = "Speed"
    Speed.Parent = FlyFrame
    Speed.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
    Speed.BorderColor3 = Color3.fromRGB(0, 0, 191)
    Speed.BorderSizePixel = 0
    Speed.Position = UDim2.new(0.445025861, 0, 0.35, 0)
    Speed.Size = UDim2.new(0, 111, 0, 33)
    Speed.Font = Enum.Font.SourceSans
    Speed.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
    Speed.Text = "50"
    Speed.TextColor3 = Color3.fromRGB(255, 255, 255)
    Speed.TextScaled = true
    Speed.TextSize = 14.000
    Speed.TextWrapped = true
    local Fly = Instance.new("TextButton")
    Fly.Name = "Fly"
    Fly.Parent = FlyFrame
    Fly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
    Fly.BorderSizePixel = 0
    Fly.Position = UDim2.new(0.0759493634, 0, 0.8, 0)
    Fly.Size = UDim2.new(0, 199, 0, 32)
    Fly.Font = Enum.Font.SourceSans
    Fly.Text = "开启飞行"
    Fly.TextColor3 = Color3.fromRGB(255, 255, 255)
    Fly.TextScaled = true
    Fly.TextSize = 14.000
    Fly.TextWrapped = true
    local Speeed = Instance.new("TextLabel")
    Speeed.Name = "Speeed"
    Speeed.Parent = FlyFrame
    Speeed.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Speeed.BorderSizePixel = 0
    Speeed.Position = UDim2.new(0.0759493634, 0, 0.35, 0)
    Speeed.Size = UDim2.new(0, 87, 0, 32)
    Speeed.ZIndex = 0
    Speeed.Font = Enum.Font.SourceSans
    Speeed.Text = "速度:"
    Speeed.TextColor3 = Color3.fromRGB(255, 255, 255)
    Speeed.TextScaled = true
    Speeed.TextSize = 14.000
    Speeed.TextWrapped = true
    local Stat = Instance.new("TextLabel")
    Stat.Name = "Stat"
    Stat.Parent = FlyFrame
    Stat.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Stat.BorderSizePixel = 0
    Stat.Position = UDim2.new(0.299983799, 0, 0.2, 0)
    Stat.Size = UDim2.new(0, 85, 0, 15)
    Stat.Font = Enum.Font.SourceSans
    Stat.Text = "状态:"
    Stat.TextColor3 = Color3.fromRGB(255, 255, 255)
    Stat.TextScaled = true
    Stat.TextSize = 14.000
    Stat.TextWrapped = true
    local Stat2 = Instance.new("TextLabel")
    Stat2.Name = "Stat2"
    Stat2.Parent = FlyFrame
    Stat2.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Stat2.BorderSizePixel = 0
    Stat2.Position = UDim2.new(0.546535194, 0, 0.2, 0)
    Stat2.Size = UDim2.new(0, 27, 0, 15)
    Stat2.Font = Enum.Font.SourceSans
    Stat2.Text = "关闭"
    Stat2.TextColor3 = Color3.fromRGB(255, 0, 0)
    Stat2.TextScaled = true
    Stat2.TextSize = 14.000
    Stat2.TextWrapped = true
    local Unfly = Instance.new("TextButton")
    Unfly.Name = "Unfly"
    Unfly.Parent = FlyFrame
    Unfly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
    Unfly.BorderSizePixel = 0
    Unfly.Position = UDim2.new(0.0759493634, 0, 0.8, 0)
    Unfly.Size = UDim2.new(0, 199, 0, 32)
    Unfly.Visible = false
    Unfly.Font = Enum.Font.SourceSans
    Unfly.Text = "关闭飞行"
    Unfly.TextColor3 = Color3.fromRGB(255, 255, 255)
    Unfly.TextScaled = true
    Unfly.TextSize = 14.000
    Unfly.TextWrapped = true
    local Vfly = Instance.new("TextLabel")
    Vfly.Name = "Vfly"
    Vfly.Parent = Drag
    Vfly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
    Vfly.BorderSizePixel = 0
    Vfly.Size = UDim2.new(0, 57, 0, 27)
    Vfly.Font = Enum.Font.SourceSans
    Vfly.Text = "GG"
    Vfly.TextColor3 = Color3.fromRGB(255, 255, 255)
    Vfly.TextScaled = true
    Vfly.TextSize = 14.000
    Vfly.TextWrapped = true
    local Close = Instance.new("TextButton")
    Close.Name = "Close"
    Close.Parent = Drag
    Close.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
    Close.BorderSizePixel = 0
    Close.Position = UDim2.new(0.875, 0, 0, 0)
    Close.Size = UDim2.new(0, 27, 0, 27)
    Close.Font = Enum.Font.SourceSans
    Close.Text = "X"
    Close.TextColor3 = Color3.fromRGB(255, 255, 255)
    Close.TextScaled = true
    Close.TextSize = 14.000
    Close.TextWrapped = true
    local Minimize = Instance.new("TextButton")
    Minimize.Name = "Minimize"
    Minimize.Parent = Drag
    Minimize.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
    Minimize.BorderSizePixel = 0
    Minimize.Position = UDim2.new(0.75, 0, 0, 0)
    Minimize.Size = UDim2.new(0, 27, 0, 27)
    Minimize.Font = Enum.Font.SourceSans
    Minimize.Text = "-"
    Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
    Minimize.TextScaled = true
    Minimize.TextSize = 14.000
    Minimize.TextWrapped = true
    local Flyon = Instance.new("Frame")
    Flyon.Name = "Fly on"
    Flyon.Parent = Flymguiv2
    Flyon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Flyon.BorderSizePixel = 0
    Flyon.Position = UDim2.new(0.117647067, 0, 0.550284624, 0)
    Flyon.Size = UDim2.new(0.148000002, 0, 0.314999998, 0)
    Flyon.Visible = false
    Flyon.Active = true
    Flyon.Draggable = true
    local W = Instance.new("TextButton")
    W.Name = "W"
    W.Parent = Flyon
    W.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
    W.BorderSizePixel = 0
    W.Position = UDim2.new(0.134719521, 0, 0.0152013302, 0)
    W.Size = UDim2.new(0.708999991, 0, 0.25, 0)
    W.Font = Enum.Font.SourceSans
    W.Text = "前"
    W.TextColor3 = Color3.fromRGB(255, 255, 255)
    W.TextScaled = true
    W.TextSize = 14.000
    W.TextWrapped = true
    local S = Instance.new("TextButton")
    S.Name = "S"
    S.Parent = Flyon
    S.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
    S.BorderSizePixel = 0
    S.Position = UDim2.new(0.134000003, 0, 0.75, 0)
    S.Size = UDim2.new(0.708999991, 0, 0.25, 0)
    S.Font = Enum.Font.SourceSans
    S.Text = "后"
    S.TextColor3 = Color3.fromRGB(255, 255, 255)
    S.TextScaled = true
    S.TextSize = 14.000
    S.TextWrapped = true
    local Up = Instance.new("TextButton")
    Up.Name = "Up"
    Up.Parent = Flyon
    Up.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
    Up.BorderSizePixel = 0
    Up.Position = UDim2.new(0.134719521, 0, 0.27, 0)
    Up.Size = UDim2.new(0.708999991, 0, 0.25, 0)
    Up.Font = Enum.Font.SourceSans
    Up.Text = "上"
    Up.TextColor3 = Color3.fromRGB(255, 255, 255)
    Up.TextScaled = true
    Up.TextSize = 14.000
    Up.TextWrapped = true
    local Down = Instance.new("TextButton")
    Down.Name = "Down"
    Down.Parent = Flyon
    Down.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
    Down.BorderSizePixel = 0
    Down.Position = UDim2.new(0.134000003, 0, 0.52, 0)
    Down.Size = UDim2.new(0.708999991, 0, 0.25, 0)
    Down.Font = Enum.Font.SourceSans
    Down.Text = "下"
    Down.TextColor3 = Color3.fromRGB(255, 255, 255)
    Down.TextScaled = true
    Down.TextSize = 14.000
    Down.TextWrapped = true

    local currentSeat = nil
    local currentModel = nil
    local flying = false
    local moving = {forward = false, backward = false, up = false, down = false}
    local cameraController = nil
    local physicsController = nil
    local lastValidCameraCFrame = nil
    local cameraOffset = CFrame.new(0, 5, -15)
    local smoothFactor = 0.2
    local collisionCheckRay = Ray.new(Vector3.new(), Vector3.new())
    local controlPart = nil
    local BV = nil
    local BG = nil
    local wasSitting = false
    local isVirtualSeat = false
    local virtualVehicleModel = nil

    local function lerp(a, b, t) return a + (b - a) * math.min(t, 1) end

    local function findSeat(character)
        if not character then return nil end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.SeatPart then return humanoid.SeatPart end
        local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
        if not rootPart then return nil end
        local nearbySeats = {}
        local radius = 15
        for _, part in ipairs(workspace:GetPartsInPart(rootPart, radius)) do
            if part:IsA("Seat") or part:IsA("VehicleSeat") then table.insert(nearbySeats, part) end
        end
        if #nearbySeats > 0 then
            table.sort(nearbySeats, function(a, b) return (a.Position - rootPart.Position).Magnitude < (b.Position - rootPart.Position).Magnitude end)
            return nearbySeats[1]
        end
        if character.Parent and character.Parent:IsA("Model") then
            for _, part in ipairs(character.Parent:GetDescendants()) do
                if part:IsA("VehicleSeat") and part.Occupant == humanoid then return part end
            end
        end
        return nil
    end

    local function createVirtualSeat()
        virtualVehicleModel = Instance.new("Model")
        virtualVehicleModel.Name = "FlymVirtualVehicle"
        controlPart = Instance.new("Part")
        controlPart.Name = "ControlPart"
        controlPart.Anchored = false
        controlPart.CanCollide = false
        controlPart.Transparency = 1
        controlPart.Size = Vector3.new(2, 2, 2)
        controlPart.Position = localPlayer.Character.HumanoidRootPart.Position
        controlPart.Parent = virtualVehicleModel
        virtualVehicleModel.PrimaryPart = controlPart
        local virtualSeat = Instance.new("Seat")
        virtualSeat.Name = "VirtualSeat"
        virtualSeat.Transparency = 1
        virtualSeat.CanCollide = false
        virtualSeat.Size = Vector3.new(2, 2, 2)
        virtualSeat.CFrame = controlPart.CFrame
        virtualSeat.Parent = virtualVehicleModel
        virtualVehicleModel.Parent = workspace
        return virtualSeat
    end

    local function sitPlayerInSeat(seat)
        local char = localPlayer.Character
        if not char then return false end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        if humanoid.SeatPart == seat then return true end
        local rootPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
        if rootPart then
            rootPart.CFrame = seat.CFrame + Vector3.new(0, 3, 0)
            task.wait(0.1)
        end
        humanoid.Sit = true
        task.wait(0.1)
        if humanoid.SeatPart == seat then return true end
        if rootPart then
            rootPart.CFrame = seat.CFrame + Vector3.new(0, 3, 0)
            task.wait(0.1)
            humanoid.Sit = true
            task.wait(0.2)
        end
        return humanoid.SeatPart == seat
    end

    Fly.MouseButton1Click:Connect(function()
        local char = localPlayer.Character
        if not char then Stat2.Text = "角色未加载!"; Stat2.TextColor3 = Color3.fromRGB(255,255,0); task.wait(1.5); Stat2.Text = "关闭"; Stat2.TextColor3 = Color3.fromRGB(255,0,0); return end
        local seat = findSeat(char)
        if not seat then seat = createVirtualSeat(); isVirtualSeat = true; Stat2.Text = "使用虚拟座位"; Stat2.TextColor3 = Color3.fromRGB(255,255,0); task.wait(0.5) else isVirtualSeat = false end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        wasSitting = humanoid and humanoid.Sit
        local sitSuccess = sitPlayerInSeat(seat)
        if not sitSuccess then Stat2.Text = "坐下失败!"; Stat2.TextColor3 = Color3.fromRGB(255,255,0); task.wait(1.5); Stat2.Text = "关闭"; Stat2.TextColor3 = Color3.fromRGB(255,0,0); return end
        if isVirtualSeat then controlPart = virtualVehicleModel.PrimaryPart; currentModel = virtualVehicleModel else controlPart = seat; currentModel = seat:FindFirstAncestorOfClass("Model") or seat end
        Fly.Visible = false
        Stat2.Text = "控制中"
        Stat2.TextColor3 = Color3.fromRGB(0,255,0)
        Unfly.Visible = true
        Flyon.Visible = true
        flying = true
        currentSeat = seat
        if controlPart:FindFirstChild("FlyingBodyVelocity") then controlPart.FlyingBodyVelocity:Destroy() end
        if controlPart:FindFirstChild("FlyingBodyGyro") then controlPart.FlyingBodyGyro:Destroy() end
        BV = Instance.new("BodyVelocity")
        BV.Name = "FlyingBodyVelocity"
        BV.Parent = controlPart
        BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BV.Velocity = Vector3.new(0,0,0)
        BG = Instance.new("BodyGyro")
        BG.Name = "FlyingBodyGyro"
        BG.Parent = controlPart
        BG.MaxTorque = Vector3.new(20000,20000,20000)
        BG.D = 1500
        BG.P = 12000
        local function updateCamera()
            if not flying or not controlPart or not controlPart.Parent then
                if localPlayer.Character then
                    local hum = localPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if hum then workspace.CurrentCamera.CameraType = Enum.CameraType.Custom; workspace.CurrentCamera.CameraSubject = hum end
                end
                return
            end
            local cam = workspace.CurrentCamera
            local vehiclePos = controlPart.Position
            local vehicleLook = controlPart.CFrame.LookVector
            local idealOffset = cameraOffset
            local targetPos = controlPart.CFrame * idealOffset
            local targetLook = vehiclePos + vehicleLook * 10
            collisionCheckRay.Origin = vehiclePos
            collisionCheckRay.Direction = (targetPos.p - vehiclePos).Unit
            local hit = workspace:FindPartOnRay(collisionCheckRay, currentModel or controlPart)
            if hit then targetPos = CFrame.new(hit.Position + collisionCheckRay.Direction * 2) end
            if lastValidCameraCFrame then
                cam.CFrame = lastValidCameraCFrame:Lerp(CFrame.new(targetPos.p, targetLook), smoothFactor)
            else
                cam.CFrame = CFrame.new(targetPos.p, targetLook)
            end
            lastValidCameraCFrame = cam.CFrame
        end
        if cameraController then cameraController:Disconnect() end
        cameraController = game:GetService("RunService").RenderStepped:Connect(updateCamera)
        physicsController = _G.CreateHeartbeatConnection and _G.CreateHeartbeatConnection(function()
            if not flying then if physicsController then physicsController:Disconnect() end return end
            if not controlPart or not controlPart.Parent then Stat2.Text = "丢失连接!"; Stat2.TextColor3 = Color3.fromRGB(255,255,0); Unfly:Click(); return end
            if not BV or not BV.Parent then
                BV = controlPart:FindFirstChild("FlyingBodyVelocity")
                if not BV then BV = Instance.new("BodyVelocity"); BV.Name = "FlyingBodyVelocity"; BV.Parent = controlPart; BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge); BV.Velocity = Vector3.new(0,0,0) end
            end
            if not BG or not BG.Parent then
                BG = controlPart:FindFirstChild("FlyingBodyGyro")
                if not BG then BG = Instance.new("BodyGyro"); BG.Name = "FlyingBodyGyro"; BG.Parent = controlPart; BG.MaxTorque = Vector3.new(20000,20000,20000); BG.D = 1500; BG.P = 12000 end
            end
            local speedValue = tonumber(Speed.Text) or 50
            local moveDirection = Vector3.new(0,0,0)
            if moving.forward then moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector end
            if moving.backward then moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector end
            if moving.up then moveDirection = moveDirection + Vector3.new(0,1,0) end
            if moving.down then moveDirection = moveDirection + Vector3.new(0,-1,0) end
            if moveDirection.Magnitude > 0 then BV.Velocity = moveDirection.Unit * speedValue else BV.Velocity = Vector3.new(0,0,0) end
            if BG and BG.Parent then BG.CFrame = CFrame.new(controlPart.Position, controlPart.Position + workspace.CurrentCamera.CFrame.LookVector) end
        end) or game:GetService("RunService").Heartbeat:Connect(function()
            if not flying then return end
            if not controlPart or not controlPart.Parent then Stat2.Text = "丢失连接!"; Stat2.TextColor3 = Color3.fromRGB(255,255,0); Unfly:Click(); return end
            local speedValue = tonumber(Speed.Text) or 50
            local moveDirection = Vector3.new(0,0,0)
            if moving.forward then moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector end
            if moving.backward then moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector end
            if moving.up then moveDirection = moveDirection + Vector3.new(0,1,0) end
            if moving.down then moveDirection = moveDirection + Vector3.new(0,-1,0) end
            if BV then BV.Velocity = moveDirection.Unit * speedValue end
            if BG then BG.CFrame = CFrame.new(controlPart.Position, controlPart.Position + workspace.CurrentCamera.CFrame.LookVector) end
        end)
    end)

    W.MouseButton1Down:Connect(function() moving.forward = true end)
    W.MouseButton1Up:Connect(function() moving.forward = false end)
    S.MouseButton1Down:Connect(function() moving.backward = true end)
    S.MouseButton1Up:Connect(function() moving.backward = false end)
    Up.MouseButton1Down:Connect(function() moving.up = true end)
    Up.MouseButton1Up:Connect(function() moving.up = false end)
    Down.MouseButton1Down:Connect(function() moving.down = true end)
    Down.MouseButton1Up:Connect(function() moving.down = false end)

    Unfly.MouseButton1Click:Connect(function()
        flying = false
        for k in pairs(moving) do moving[k] = false end
        pcall(function()
            if controlPart and controlPart.Parent then
                if controlPart:FindFirstChild("FlyingBodyVelocity") then controlPart.FlyingBodyVelocity:Destroy() end
                if controlPart:FindFirstChild("FlyingBodyGyro") then controlPart.FlyingBodyGyro:Destroy() end
            end
            if isVirtualSeat and virtualVehicleModel then virtualVehicleModel:Destroy(); virtualVehicleModel = nil; isVirtualSeat = false end
        end)
        if cameraController then cameraController:Disconnect(); cameraController = nil end
        if physicsController then physicsController:Disconnect(); physicsController = nil end
        Fly.Visible = true
        Stat2.Text = "关闭"
        Stat2.TextColor3 = Color3.fromRGB(255,0,0)
        Unfly.Visible = false
        Flyon.Visible = false
        if localPlayer.Character then
            local hum = localPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                workspace.CurrentCamera.CameraSubject = hum
                if wasSitting then task.wait(0.5); hum.Sit = true end
            end
        end
    end)

    Close.MouseButton1Click:Connect(function()
        if flying then Unfly:Click() end
        Flymguiv2:Destroy()
    end)

    local function Mini()
        if Minimize.Text == "-" then Minimize.Text = "+"; FlyFrame.Visible = false else Minimize.Text = "-"; FlyFrame.Visible = true end
    end
    Minimize.MouseButton1Click:Connect(Mini)

    task.spawn(function()
        while task.wait(1) do
            if flying then
                if not controlPart or not controlPart.Parent then Stat2.Text = "丢失连接!"; Stat2.TextColor3 = Color3.fromRGB(255,255,0); Unfly:Click()
                elseif not BV or not BV.Parent or not BG or not BG.Parent then
                    Stat2.Text = "恢复控制中..."; Stat2.TextColor3 = Color3.fromRGB(255,255,0)
                    BV = controlPart:FindFirstChild("FlyingBodyVelocity")
                    BG = controlPart:FindFirstChild("FlyingBodyGyro")
                    if BV and BG then Stat2.Text = "控制中"; Stat2.TextColor3 = Color3.fromRGB(0,255,0) end
                end
                local char = localPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum and hum.SeatPart ~= currentSeat then Stat2.Text = "玩家离开座位!"; Stat2.TextColor3 = Color3.fromRGB(255,255,0); Unfly:Click() end
                end
            end
        end
    end)
