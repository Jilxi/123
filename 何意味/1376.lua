--角色数据
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WatermarkGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local watermark = Instance.new("TextLabel")
watermark.Name = "WatermarkLabel"
watermark.Parent = screenGui
watermark.BackgroundTransparency = 1
watermark.Size = UDim2.new(0, 180, 0, 25)
watermark.Position = UDim2.new(0.01, 0, 0.01, 0)
watermark.Font = Enum.Font.GothamBold
watermark.TextSize = 12
watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
watermark.TextStrokeTransparency = 0.5
watermark.TextXAlignment = Enum.TextXAlignment.Left
watermark.TextYAlignment = Enum.TextYAlignment.Top

local stats = {
    function() return "名字: "..player.Name end,
    function() return "延迟: "..math.floor(player:GetNetworkPing() * 1000).."ms" end,
    function() return "帧率: "..math.floor(workspace:GetRealPhysicsFPS()) end,
    function() return "时间: "..os.date("%H:%M:%S") end,
    function() return "血量: "..(player.Character and player.Character:FindFirstChildOfClass("Humanoid") and math.floor(player.Character:FindFirstChildOfClass("Humanoid").Health) or "N/A") end,
    function() return "坐标: "..(player.Character and player.Character:FindFirstChild("HumanoidRootPart") and 
        "("..math.floor(player.Character.HumanoidRootPart.Position.X)..","..math.floor(player.Character.HumanoidRootPart.Position.Y)..","..math.floor(player.Character.HumanoidRootPart.Position.Z)..")" or "N/A") end,
    function() return "服务器 id: "..game.GameId end,
    function() return "账户年龄: " .. player.AccountAge .. "天" end 
}

local hue = 0
local hueSpeed = 0.4 -- lower value for smoother transition

while true do
	hue = (hue + hueSpeed * 0.2) % 1
	watermark.TextColor3 = Color3.fromHSV(hue, 1, 1)

	local textLines = {}
	for _, func in ipairs(stats) do
		table.insert(textLines, func())
	end
	watermark.Text = table.concat(textLines, " | ")
	wait(0.1)
end
