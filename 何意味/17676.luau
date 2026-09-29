----你好呀
local Players = game:GetService("Players")
local lplr = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local gameCamera = workspace.CurrentCamera

local locked = false
local MIN_SIZE = 120
local MAX_SIZE = 400

local radarGui = Instance.new("ScreenGui")
radarGui.Name = "Radar"
radarGui.ResetOnSpawn = false
radarGui.Parent = gethui and gethui() or game:GetService("CoreGui")

-- 主容器
local container = Instance.new("Frame")
container.Size = UDim2.fromOffset(220, 220)
container.Position = UDim2.fromOffset(10, 10)
container.BackgroundColor3 = Color3.new(0, 0, 0)
container.BackgroundTransparency = 0.5
container.ClipsDescendants = true
container.Parent = radarGui
Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", container).Thickness = 2

-- 顶栏
local bar = Instance.new("Frame")
bar.Size = UDim2.new(1, -6, 0, 16)
bar.Position = UDim2.fromOffset(3, 0)
bar.BackgroundColor3 = Color3.fromHSV(0.55, 1, 1)
bar.BackgroundTransparency = 0.3
bar.ZIndex = 5
bar.Parent = container
Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 8)

-- 锁定按钮
local lockBtn = Instance.new("TextButton")
lockBtn.Size = UDim2.fromOffset(20, 16)
lockBtn.Position = UDim2.new(1, -22, 0, 0)
lockBtn.BackgroundTransparency = 1
lockBtn.Text = "🔓"
lockBtn.TextSize = 12
lockBtn.TextColor3 = Color3.new(1, 1, 1)
lockBtn.ZIndex = 6
lockBtn.Parent = bar

-- 十字线
local vLine = Instance.new("Frame")
vLine.Size = UDim2.new(0, 2, 1, 0)
vLine.Position = UDim2.new(0.5, -1, 0, 0)
vLine.BackgroundColor3 = Color3.new(1, 1, 1)
vLine.BackgroundTransparency = 0.5
vLine.BorderSizePixel = 0
vLine.Parent = container

local hLine = Instance.new("Frame")
hLine.Size = UDim2.new(1, 0, 0, 2)
hLine.Position = UDim2.new(0, 0, 0.5, -1)
hLine.BackgroundColor3 = Color3.new(1, 1, 1)
hLine.BackgroundTransparency = 0.5
hLine.BorderSizePixel = 0
hLine.Parent = container

-- 中心点
local centerDot = Instance.new("Frame")
centerDot.Size = UDim2.fromOffset(6, 6)
centerDot.Position = UDim2.new(0.5, -3, 0.5, -3)
centerDot.BackgroundColor3 = Color3.new(1, 1, 1)
centerDot.Parent = container
Instance.new("UICorner", centerDot).CornerRadius = UDim.new(1, 0)

-- 缩放手柄（右下角）
local resizeHandle = Instance.new("Frame")
resizeHandle.Size = UDim2.fromOffset(16, 16)
resizeHandle.AnchorPoint = Vector2.new(1, 1)
resizeHandle.Position = UDim2.new(1, -2, 1, -2)
resizeHandle.BackgroundColor3 = Color3.fromHSV(0.55, 1, 1)
resizeHandle.BackgroundTransparency = 0.2
resizeHandle.ZIndex = 6
resizeHandle.Parent = container
Instance.new("UICorner", resizeHandle).CornerRadius = UDim.new(1, 0)

--拖动逻辑
do
    local dragging = false
    local dragInput, dragStart, startPos

    bar.InputBegan:Connect(function(input)
        if locked then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = container.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    bar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            container.Position = UDim2.fromOffset(
                startPos.X.Offset + delta.X,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end
--缩放逻辑
do
    local resizing = false
    local resizeInput, resizeStart, startSize

    resizeHandle.InputBegan:Connect(function(input)
        if locked then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            resizeStart = input.Position
            startSize = container.Size
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
                end
            end)
        end
    end)

    resizeHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            resizeInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if resizing and input == resizeInput then
            local delta = input.Position - resizeStart
            local avg = (delta.X + delta.Y) / 2
            local newSize = math.clamp(startSize.X.Offset + avg, MIN_SIZE, MAX_SIZE)
            container.Size = UDim2.fromOffset(newSize, newSize)
        end
    end)
end

-- ========== 锁定切换 ==========
lockBtn.MouseButton1Click:Connect(function()
    locked = not locked
    lockBtn.Text = locked and "🔒" or "🔓"
    resizeHandle.Visible = not locked
end)

-- 存储所有敌人圆点
local dots = {}

-- 创建/更新敌人圆点
local function updateDots()
    local alive = lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart")

    -- 清理旧圆点
    for ent, dot in pairs(dots) do
        dot.Visible = false
    end

    if not alive then return end

    -- 根据当前容器大小动态计算中心与半径
    local size = container.AbsoluteSize
    local centerX, centerY = size.X / 2, size.Y / 2
    local edge = 4

    local root = lplr.Character.HumanoidRootPart
    local myPos = root.Position
    local facing = CFrame.lookAlong(myPos, gameCamera.CFrame.LookVector * Vector3.new(1, 0, 1))

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == lplr then continue end
        local char = plr.Character
        if not char then continue end
        local targetRoot = char:FindFirstChild("HumanoidRootPart")
        if not targetRoot then continue end

        -- 创建/复用圆点
        local dot = dots[char]
        if not dot then
            dot = Instance.new("Frame")
            dot.Size = UDim2.fromOffset(5, 5)
            dot.AnchorPoint = Vector2.new(0.5, 0.5)
            dot.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            dot.ZIndex = 3
            dot.Parent = container
            Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
            Instance.new("UIStroke", dot).Thickness = 1
            dots[char] = dot
        end

        dot.Visible = true

        -- 计算相对位置（按当前容器尺寸缩放）
        local rel = facing:PointToObjectSpace(targetRoot.Position)
        local x = math.clamp(centerX + rel.X, edge, size.X - edge)
        local y = math.clamp(centerY + rel.Z, edge, size.Y - edge)
        dot.Position = UDim2.fromOffset(x, y)
    end
end

-- 每帧更新
RunService.RenderStepped:Connect(updateDots)

-- 隐藏的圆点清理
task.spawn(function()
    while true do
        for ent, dot in pairs(dots) do
            if not ent.Parent then
                dot:Destroy()
                dots[ent] = nil
            end
        end
        task.wait(2)
    end
end)
