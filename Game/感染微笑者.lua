local OrangeHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

OrangeHub.TransparencyValue = 0.2
OrangeHub:SetTheme("Dark")

local Window = OrangeHub:CreateWindow({
    User = {
        Enabled = false,
    },
    Author = "",
    ScrollBarEnabled = true,
    Folder = "OrangeCHub",
    SideBarWidth = 180,
    Title = "感染的微笑",
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Transparent = true,
    Theme = "Dark",
    Icon = "crown",
    Size = UDim2.fromOffset(600, 500),
})

Window:EditOpenButton({
    Title = "脚本",
    Icon = "crown",
})

Window:SetToggleKey(Enum.KeyCode.N)

local PlayerSection = Window:Section({
    Icon = "user",
    Title = "玩家",
    Opened = false,
})

local PlayerTab = PlayerSection:Tab({
    Title = "玩家",
    Icon = "user",
})

local WalkSpeedValue = 16
PlayerTab:Slider({
    Title = "玩家速度",
    Value = {
        Min = 16,
        Default = 16,
        Max = 200,
    },
    Callback = function(Value)
        WalkSpeedValue = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end,
    Step = 1,
})

local JumpPowerValue = 50
PlayerTab:Slider({
    Title = "玩家跳跃高度",
    Value = {
        Min = 50,
        Default = 50,
        Max = 200,
    },
    Callback = function(Value)
        JumpPowerValue = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end,
    Step = 1,
})

PlayerTab:Slider({
    Title = "玩家镜头FOV",
    Value = {
        Min = 70,
        Default = 70,
        Max = 120,
    },
    Callback = function(Value)
        if CurrentCamera then
            CurrentCamera.FieldOfView = Value
        end
    end,
    Step = 1,
})

PlayerTab:Button({
    Locked = false,
    Callback = function()
        local Map = Workspace:FindFirstChild("Map")
        if Map then
            local Infectors = Map:FindFirstChild("Infectors")
            if Infectors then
                Infectors:Destroy()
            end
        end
    end,
    Title = "删除微笑方块",
})

local MainSection = Window:Section({
    Icon = "hand-fist",
    Title = "主要",
    Opened = false,
})

local AttackTab = MainSection:Tab({
    Title = "攻击",
    Icon = "hand-fist",
})

AttackTab:Input({
    Placeholder = "输入数字",
    Title = "攻击冷却",
    Value = "",
    Callback = function(Value)
        local cooldownValue = tonumber(Value)
        if not cooldownValue then return end
        
        if LocalPlayer.Character then
            for _, item in pairs(LocalPlayer.Character:GetChildren()) do
                if item:IsA("Tool") then
                    local cooldown = item:FindFirstChild("Cooldown")
                    if cooldown then
                        cooldown.Value = cooldownValue
                    end
                end
            end
        end
        
        if LocalPlayer.Backpack then
            for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
                if item:IsA("Tool") then
                    local cooldown = item:FindFirstChild("Cooldown")
                    if cooldown then
                        cooldown.Value = cooldownValue
                    end
                end
            end
        end
    end,
})

local AutoAttack = false
AttackTab:Toggle({
    Value = false,
    Callback = function(Value)
        AutoAttack = Value
        if Value then
            spawn(function()
                while AutoAttack and LocalPlayer.Character do
                    task.wait(0.1)
                end
            end)
        end
    end,
    Title = "自动攻击",
})

local AutoSmileAttack = false
AttackTab:Toggle({
    Value = false,
    Callback = function(Value)
        AutoSmileAttack = Value
        if Value then
            spawn(function()
                while AutoSmileAttack and LocalPlayer.Character do
                    local infected = LocalPlayer.Character:WaitForChild("Infected")
                    if infected then
                        local infectEvent = infected:WaitForChild("InfectEvent")
                        if infectEvent then
                            infectEvent:FireServer("S")
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end,
    Title = "自动微笑攻击",
})

local MoneyTab = MainSection:Tab({
    Title = "金钱",
    Icon = "circle-pound-sterling",
})

MoneyTab:Button({
    Locked = false,
    Callback = function()
        local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            for _, descendant in pairs(Workspace:GetDescendants()) do
                if descendant.Name == "Coin" or descendant.Name == "Money" then
                    humanoidRootPart.CFrame = descendant.CFrame
                    task.wait(0.05)
                end
            end
        end
    end,
    Title = "一键拾取金币",
})

local AutoCollectMoney = false
MoneyTab:Toggle({
    Value = false,
    Callback = function(Value)
        AutoCollectMoney = Value
        if Value then
            spawn(function()
                while AutoCollectMoney do
                    local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        for _, descendant in pairs(Workspace:GetDescendants()) do
                            if not AutoCollectMoney then break end
                            if descendant.Name == "Coin" or descendant.Name == "Money" then
                                humanoidRootPart.CFrame = descendant.CFrame
                                task.wait(0.1)
                            end
                        end
                    end
                    task.wait(1)
                end
            end)
        end
    end,
    Title = "自动拾取金币",
})

local KeyTab = MainSection:Tab({
    Title = "钥匙",
    Icon = "key",
})

KeyTab:Button({
    Locked = false,
    Callback = function()
        local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            for _, descendant in pairs(Workspace:GetDescendants()) do
                if descendant.Name == "Key" then
                    humanoidRootPart.CFrame = descendant.CFrame
                    task.wait(0.05)
                end
            end
        end
    end,
    Title = "一键拾取钥匙",
})

LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    task.wait(1)
    if character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = WalkSpeedValue
        character.Humanoid.JumpPower = JumpPowerValue
    end
end)
