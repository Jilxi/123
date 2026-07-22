--计时器
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TimerGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "TimerFrame"
mainFrame.Size = UDim2.new(0, 120, 0, 40)
mainFrame.Position = UDim2.new(0, 20, 0.5, -20)
mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local timerLabel = Instance.new("TextLabel")
timerLabel.Name = "TimerLabel"
timerLabel.Size = UDim2.new(1, 0, 1, 0)
timerLabel.Position = UDim2.new(0, 0, 0, 0)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "0:00"
timerLabel.TextColor3 = Color3.new(0.5, 1, 0)
timerLabel.TextScaled = true
timerLabel.Font = Enum.Font.RobotoMono
timerLabel.Parent = mainFrame

local textGradient = Instance.new("UIGradient")
textGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.5, 1, 0)),
    ColorSequenceKeypoint.new(1, Color3.new(0, 0.4, 0))
}
textGradient.Rotation = 90
textGradient.Parent = timerLabel

local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 8)
padding.PaddingRight = UDim.new(0, 8)
padding.PaddingTop = UDim.new(0, 4)
padding.PaddingBottom = UDim.new(0, 4)
padding.Parent = mainFrame

local startButton = Instance.new("TextButton")
startButton.Name = "StartButton"
startButton.Size = UDim2.new(0, 40, 0, 40)
startButton.Position = UDim2.new(0, 20, 0.5, 30)
startButton.BackgroundColor3 = Color3.new(0, 0, 0.5)
startButton.BorderSizePixel = 0
startButton.Text = "开始"
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.TextScaled = true
startButton.Font = Enum.Font.RobotoMono
startButton.Parent = screenGui

local creditLabel = Instance.new("TextLabel")
creditLabel.Name = "CreditLabel"
creditLabel.Size = UDim2.new(0, 200, 0, 30)
creditLabel.Position = UDim2.new(0, 70, 0.5, 30)
creditLabel.BackgroundTransparency = 1
creditLabel.Text = "计时器"
creditLabel.TextColor3 = Color3.new(1, 1, 1)
creditLabel.TextScaled = true
creditLabel.Font = Enum.Font.RobotoMono
creditLabel.TextXAlignment = Enum.TextXAlignment.Left
creditLabel.Parent = screenGui

local startTime = nil
local timerRunning = false
local heartbeatConnection = nil

local function updateTimer()
    if not timerRunning or not startTime then return end
    
    local currentTime = tick()
    local elapsed = currentTime - startTime
    
    local minutes = math.floor(elapsed / 60)
    local seconds = math.floor(elapsed % 60)
    
    timerLabel.Text = string.format("%d:%02d", minutes, seconds)
end

startButton.MouseButton1Click:Connect(function()
    if not timerRunning then
        
        timerRunning = true
        startTime = tick()
        startButton.Text = "停止"
        startButton.BackgroundColor3 = Color3.new(1, 0, 0)
        
        textGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.new(0.5, 1, 0)),
            ColorSequenceKeypoint.new(1, Color3.new(0, 0.4, 0)) 
        }
        
        heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(updateTimer)
    else
        
        timerRunning = false
        startButton.Text = "开始"
        startButton.BackgroundColor3 = Color3.new(0, 0, 0.5) -- Back to dark blue
        
        
        textGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.new(0.5, 0.8, 1)), -- Sky blue at top
            ColorSequenceKeypoint.new(1, Color3.new(0, 0.2, 0.6))  -- Dark blue at bottom
        }
        
        
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
    end
end)
