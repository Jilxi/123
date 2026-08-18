game.Players.LocalPlayer.SimulationRadius = 1000

local input = game:GetService("UserInputService")
local players = game:GetService("Players")
local player = players.LocalPlayer
local mouse = player:GetMouse()

local createdBodyPositions = {}

-- 创建工具的函数
local function createTool()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "黑洞工具"
    tool.Parent = player.Backpack
    tool.ToolTip = "卸下即停止吸附部件"

    local function moveParts(target)
        local function updatePart(part)
            if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(player.Character) then
                local bp = part:FindFirstChildOfClass("BodyPosition")
                if not bp then
                    bp = Instance.new("BodyPosition")
                    bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bp.Parent = part
                    table.insert(createdBodyPositions, bp)
                end
                bp.Position = target
            end
        end

        for _, part in pairs(workspace:GetDescendants()) do
            updatePart(part)
        end

        workspace.DescendantAdded:Connect(updatePart)
    end

    local function clearBodyPositions()
        for _, bp in pairs(createdBodyPositions) do
            if bp and bp.Parent then
                bp:Destroy()
            end
        end
        createdBodyPositions = {}
    end

    local isHolding = false

    local function updatePartsFollowingMouse()
        while isHolding do
            currentTarget = mouse.Hit.p
            if currentTarget then
                moveParts(currentTarget)
            end
            task.wait(0) -- 每帧更新
        end
    end

    -- 工具激活逻辑
    tool.Activated:Connect(function()
        if not isHolding then
            isHolding = true
            if input.TouchEnabled then
                -- 移动端：点击时设置一次位置
                local targetPosition = mouse.Hit.p
                moveParts(targetPosition)
                isHolding = false
            else
                -- PC端：开始拖拽
                updatePartsFollowingMouse()
            end
        end
    end)

    -- 工具卸下逻辑
    tool.Unequipped:Connect(function()
        isHolding = false
        clearBodyPositions()
    end)

    -- 监听鼠标按键事件（PC）
    input.InputBegan:Connect(function(inputObj)
        if inputObj.UserInputType == Enum.UserInputType.MouseButton1 and player.Character:FindFirstChildOfClass("Tool") == tool then
            if not isHolding and not input.TouchEnabled then
                isHolding = true
                updatePartsFollowingMouse()
            end
        end
    end)

    input.InputEnded:Connect(function(inputObj)
        if inputObj.UserInputType == Enum.UserInputType.MouseButton1 and player.Character:FindFirstChildOfClass("Tool") == tool then
            isHolding = false
        end
    end)

    -- 监听场景中的触摸事件（移动端）
    input.TouchTapInWorld:Connect(function(touchPositions, gameProcessedEvent)
        if not gameProcessedEvent and player.Character:FindFirstChildOfClass("Tool") == tool then
            local touchPosition = touchPositions[1]
            local targetPosition = workspace.CurrentCamera:ScreenPointToRay(touchPosition.X, touchPosition.Y).Origin
            moveParts(targetPosition)
        end
    end)
end

createTool()

player.CharacterAdded:Connect(function()
    player.Character:WaitForChild("Humanoid")
    createTool()
end)
