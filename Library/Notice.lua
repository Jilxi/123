local TweenService = game:GetService("TweenService")
local getUI = (gethui and gethui) or function() return game:GetService("CoreGui") end
local targetGui = getUI()

local GUI_NAME = "Tailor"
local screenGui = targetGui:FindFirstChild(GUI_NAME)
if not screenGui then
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = GUI_NAME
    screenGui.Parent = targetGui
end

local container = screenGui:FindFirstChild("NotifyContainer")
if not container then
    container = Instance.new("Frame")
    container.Name = "NotifyContainer"
    container.Parent = screenGui
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(0, 260, 1, -40)
    container.Position = UDim2.new(1, -280, 0, 0)
    container.ClipsDescendants = false

    local layout = Instance.new("UIListLayout")
    layout.Parent = container
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    layout.Padding = UDim.new(0, 10)
end

local function notify(config)
    local titleText = config.Title or "提醒"
    local descText = config.Description or ""
    local length = config.Length or 3
    local hasButtons = config.Accept or config.Dismiss
    local frameHeight = hasButtons and 110 or 80

    local wrapper = Instance.new("Frame")
    wrapper.BackgroundTransparency = 1
    wrapper.Size = UDim2.new(1, 0, 0, frameHeight)
    wrapper.Parent = container

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(1, 300, 0, 0)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    frame.BackgroundTransparency = 0.2
    frame.Parent = wrapper
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(60, 60, 75)
    stroke.Thickness = 1.5

    local titleLbl = Instance.new("TextLabel", frame)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Position = UDim2.new(0, 15, 0, 12)
    titleLbl.Size = UDim2.new(1, -30, 0, 18)
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.Text = titleText
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.TextSize = 14
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    local descLbl = Instance.new("TextLabel", frame)
    descLbl.BackgroundTransparency = 1
    descLbl.Position = UDim2.new(0, 15, 0, 32)
    descLbl.Size = UDim2.new(1, -30, 0, hasButtons and 28 or 30)
    descLbl.Font = Enum.Font.GothamMedium
    descLbl.Text = descText
    descLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    descLbl.TextSize = 11
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.TextYAlignment = Enum.TextYAlignment.Top
    descLbl.TextWrapped = true

    if not hasButtons then
        local barBg = Instance.new("Frame", frame)
        barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        barBg.BorderSizePixel = 0
        barBg.Position = UDim2.new(0, 15, 1, -12)
        barBg.Size = UDim2.new(1, -30, 0, 3)
        Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

        local barFill = Instance.new("Frame", barBg)
        barFill.BackgroundColor3 = Color3.fromRGB(80, 160, 255)
        barFill.BorderSizePixel = 0
        barFill.Size = UDim2.new(1, 0, 1, 0)
        Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)
        TweenService:Create(barFill, TweenInfo.new(length, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)}):Play()
    end

    local closed = false
    local function closeNotify()
        if closed then return end
        closed = true
        local tweenOut = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 300, 0, 0)})
        tweenOut:Play()
        tweenOut.Completed:Wait()
        wrapper:Destroy()
    end

    if hasButtons then
        local btnY = frameHeight - 35

        local function makeBtn(text, xPos, width, color, callback)
            local btn = Instance.new("TextButton", frame)
            btn.Position = UDim2.new(0, xPos, 0, btnY)
            btn.Size = UDim2.new(0, width, 0, 24)
            btn.BackgroundColor3 = color
            btn.Font = Enum.Font.GothamBold
            btn.Text = text
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextSize = 11
            btn.BorderSizePixel = 0
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            btn.MouseButton1Click:Connect(function()
                if callback then callback() end
                closeNotify()
            end)
        end

        if config.Accept and config.Dismiss then
            makeBtn(config.Accept.Text or "确认", 15, 107, Color3.fromRGB(0, 120, 215), config.Accept.Callback)
            makeBtn(config.Dismiss.Text or "关闭", 128, 107, Color3.fromRGB(60, 60, 70), config.Dismiss.Callback)
        elseif config.Accept then
            makeBtn(config.Accept.Text or "确认", 15, 220, Color3.fromRGB(0, 120, 215), config.Accept.Callback)
        elseif config.Dismiss then
            makeBtn(config.Dismiss.Text or "关闭", 15, 220, Color3.fromRGB(60, 60, 70), config.Dismiss.Callback)
        end
    end

    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()

    if not hasButtons then
        task.delay(length, closeNotify)
    end
end

return notify
