local function makeDraggable(frame)
        local dragging, dragStart, startPos
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
                input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
            end
        end)
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end
    local function createKeyButton(parent, keyText, keyCode, position)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 60, 0, 60)
        button.Position = position
        button.Text = keyText
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 26
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.BorderSizePixel = 0
        local corner = Instance.new("UICorner", button)
        corner.CornerRadius = UDim.new(0, 12)
        button.BackgroundTransparency = 0.2
        button.Parent = parent
        button.MouseButton1Down:Connect(function()
            pcall(function() game:GetService("VirtualInputManager"):SendKeyEvent(true, keyCode, false, nil) end)
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end)
        button.MouseButton1Up:Connect(function()
            pcall(function() game:GetService("VirtualInputManager"):SendKeyEvent(false, keyCode, false, nil) end)
            button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end)
    end
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "WASDQEGui"
    local wasdFrame = Instance.new("Frame")
    wasdFrame.Size = UDim2.new(0, 200, 0, 200)
    wasdFrame.Position = UDim2.new(0, 10, 1, -210)
    wasdFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    wasdFrame.BorderSizePixel = 0
    wasdFrame.Active = true
    wasdFrame.Draggable = false
    local wasdCorner = Instance.new("UICorner", wasdFrame)
    wasdCorner.CornerRadius = UDim.new(0, 12)
    wasdFrame.BackgroundTransparency = 0.2
    wasdFrame.Parent = gui
    makeDraggable(wasdFrame)
    local wasdCloseBtn = Instance.new("TextButton", wasdFrame)
    wasdCloseBtn.Size = UDim2.new(0, 24, 0, 24)
    wasdCloseBtn.Position = UDim2.new(1, -30, 0, 5)
    wasdCloseBtn.Text = "X"
    wasdCloseBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
    wasdCloseBtn.TextColor3 = Color3.new(1,1,1)
    wasdCloseBtn.BorderSizePixel = 0
    local closeCorner = Instance.new("UICorner", wasdCloseBtn)
    closeCorner.CornerRadius = UDim.new(0, 6)
    wasdCloseBtn.MouseButton1Click:Connect(function() wasdFrame.Visible = false end)
    local wasdContent = Instance.new("Frame", wasdFrame)
    wasdContent.Position = UDim2.new(0, 0, 0, 30)
    wasdContent.Size = UDim2.new(1, 0, 1, -30)
    wasdContent.BackgroundTransparency = 1
    createKeyButton(wasdContent, "W", Enum.KeyCode.W, UDim2.new(0.33, 0, 0, 0))
    createKeyButton(wasdContent, "A", Enum.KeyCode.A, UDim2.new(0, 0, 0, 70))
    createKeyButton(wasdContent, "S", Enum.KeyCode.S, UDim2.new(0.33, 0, 0, 70))
    createKeyButton(wasdContent, "D", Enum.KeyCode.D, UDim2.new(0.66, 0, 0, 70))
    local qeFrame = Instance.new("Frame")
    qeFrame.Size = UDim2.new(0, 100, 0, 160)
    qeFrame.Position = UDim2.new(1, -110, 1, -170)
    qeFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    qeFrame.BorderSizePixel = 0
    qeFrame.Active = true
    qeFrame.Draggable = false
    local qeCorner = Instance.new("UICorner", qeFrame)
    qeCorner.CornerRadius = UDim.new(0, 12)
    qeFrame.BackgroundTransparency = 0.2
    qeFrame.Parent = gui
    makeDraggable(qeFrame)
    local qeCloseBtn = Instance.new("TextButton", qeFrame)
    qeCloseBtn.Size = UDim2.new(0, 24, 0, 24)
    qeCloseBtn.Position = UDim2.new(1, -30, 0, 5)
    qeCloseBtn.Text = "X"
    qeCloseBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
    qeCloseBtn.TextColor3 = Color3.new(1,1,1)
    qeCloseBtn.BorderSizePixel = 0
    local qeCloseCorner = Instance.new("UICorner", qeCloseBtn)
    qeCloseCorner.CornerRadius = UDim.new(0, 6)
    qeCloseBtn.MouseButton1Click:Connect(function() qeFrame.Visible = false end)
    local qeContent = Instance.new("Frame", qeFrame)
    qeContent.Position = UDim2.new(0, 0, 0, 30)
    qeContent.Size = UDim2.new(1, 0, 1, -30)
    qeContent.BackgroundTransparency = 1
    createKeyButton(qeContent, "E", Enum.KeyCode.E, UDim2.new(0.15, 0, 0, 0))
    createKeyButton(qeContent, "Q", Enum.KeyCode.Q, UDim2.new(0.15, 0, 0, 70))
