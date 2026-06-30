--什么意思
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local ChopEvent = RS:WaitForChild("ChopTree")
local MineEvent = RS:WaitForChild("MineRock")
local BuildHouseEvent = RS:WaitForChild("BuildHouse")
local BuildWallsEvent = RS:WaitForChild("BuildWalls")
local BuildTowerEvent = RS:WaitForChild("BuildTower")

local treesFolder = workspace:WaitForChild("Trees")

local treeRange, treeDelay, treeAuto, treeMode = 250, 0.1, false, "All"
local rockRange, rockDelay, rockAuto, rockMode = 250, 0.1, false, "All"
local buildDelay = 0.5

local oldFireServer = hookfunction(RS.BuildHouse.FireServer, function(...)
    return oldFireServer(...)
end)

local function getAllModels(parent)
    local found = {}
    for _, child in parent:GetChildren() do
        if child:IsA("Model") then table.insert(found, child) end
        if child:IsA("Folder") or child:IsA("Model") then
            for _, sub in getAllModels(child) do table.insert(found, sub) end
        end
    end
    return found
end

local function getPos(obj)
    local part = obj:FindFirstChildWhichIsA("BasePart")
    return part and part.Position
end

local function getRoot()
    local char = player.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

local function chopTrees()
    local root = getRoot()
    if not root then return end
    local count = 0
    local list = getAllModels(treesFolder)

    if treeMode == "All" then
        for _, obj in list do
            local pos = getPos(obj)
            if pos and (root.Position - pos).Magnitude <= treeRange then
                ChopEvent:FireServer(obj)
                count += 1
                task.wait(treeDelay)
            end
        end
    else
        local closest, d = nil, math.huge
        for _, obj in list do
            local pos = getPos(obj)
            if pos then
                local dist = (root.Position - pos).Magnitude
                if dist < d and dist <= treeRange then d, closest = dist, obj end
            end
        end
        if closest then ChopEvent:FireServer(closest); count = 1 end
    end
    return count
end

local function mineRocks()
    local part2 = workspace:FindFirstChild("Part2")
    if not part2 then return 0 end
    local rocksFolder = part2:FindFirstChild("Rocks")
    if not rocksFolder then return 0 end

    local root = getRoot()
    if not root then return end
    local count = 0
    local list = getAllModels(rocksFolder)

    if rockMode == "All" then
        for _, obj in list do
            local pos = getPos(obj)
            if pos and (root.Position - pos).Magnitude <= rockRange then
                MineEvent:FireServer(obj)
                count += 1
                task.wait(rockDelay)
            end
        end
    else
        local closest, d = nil, math.huge
        for _, obj in list do
            local pos = getPos(obj)
            if pos then
                local dist = (root.Position - pos).Magnitude
                if dist < d and dist <= rockRange then d, closest = dist, obj end
            end
        end
        if closest then MineEvent:FireServer(closest); count = 1 end
    end
    return count
end

local Window = WindUI:CreateWindow({
    Title = "Tailor",
    Icon = "tractor",
    Author = "Tree & Rock Farmer",
    Folder = "FarmHelper",
    Size = UDim2.fromOffset(520, 440),
    Theme = "Dark",
    SideBarWidth = 180,
    HasOutline = true,
})

Window:EditOpenButton({
    Title = "Tailor",
    Icon = "tractor",
    CornerRadius = UDim.new(0, 12),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromHex("2ecc71"), Color3.fromHex("f39c12")),
    Draggable = true,
})

local TreeTab = Window:Tab({ Title = "砍树", Icon = "tree-pine" })
local RockTab = Window:Tab({ Title = "挖矿", Icon = "pickaxe" })
local BuildTab = Window:Tab({ Title = "盖房", Icon = "home" })

TreeTab:Slider({ Title = "砍伐范围", Value = { Min = 10, Max = 500, Default = 250 }, Callback = function(v) treeRange = v end })
TreeTab:Slider({ Title = "间隔延迟 (秒)", Value = { Min = 0, Max = 1, Default = 0.1 }, Callback = function(v) treeDelay = v end })
TreeTab:Dropdown({ Title = "砍伐模式", Values = { "全部", "只砍最近" }, Value = "全部", Callback = function(o) treeMode = (o == "全部") and "All" or "Closest" end })
TreeTab:Divider()
TreeTab:Button({ Title = "砍一次", Desc = "手动执行砍树", Callback = function()
    local n = chopTrees()
    WindUI:Notify({ Title = "砍伐完成", Content = "砍了 " .. (n or 0) .. " 棵树", Icon = "tree-pine", Duration = 3 })
end })
TreeTab:Toggle({ Title = "自动砍树", Desc = "开启后循环砍树", Icon = "repeat", Value = false, Callback = function(s) treeAuto = s end })

RockTab:Slider({ Title = "挖矿范围", Value = { Min = 10, Max = 500, Default = 250 }, Callback = function(v) rockRange = v end })
RockTab:Slider({ Title = "间隔延迟 (秒)", Value = { Min = 0, Max = 1, Default = 0.1 }, Callback = function(v) rockDelay = v end })
RockTab:Dropdown({ Title = "挖矿模式", Values = { "全部", "只挖最近" }, Value = "全部", Callback = function(o) rockMode = (o == "全部") and "All" or "Closest" end })
RockTab:Divider()
RockTab:Button({ Title = "挖一次", Desc = "手动执行挖矿", Callback = function()
    local part2 = workspace:FindFirstChild("Part2")
    if not part2 or not part2:FindFirstChild("Rocks") then
        WindUI:Notify({ Title = "还没出矿", Content = "workspace.Part2.Rocks 不存在，等矿刷新后再试", Icon = "alert-triangle", Duration = 3 })
        return
    end
    local n = mineRocks()
    WindUI:Notify({ Title = "挖矿完成", Content = "挖了 " .. (n or 0) .. " 块石头", Icon = "pickaxe", Duration = 3 })
end })
RockTab:Toggle({ Title = "自动挖矿", Desc = "矿没出时自动跳过，出了才挖", Icon = "repeat", Value = false, Callback = function(s) rockAuto = s end })

BuildTab:Paragraph({ Title = "一键盖房", Desc = "需要有材料", Color = "Blue" })

BuildTab:Button({ Title = "盖房子", Desc = "BuildHouse", Callback = function()
    BuildHouseEvent:FireServer()
    WindUI:Notify({ Title = "盖房子", Content = "BuildHouse 已触发", Icon = "home", Duration = 2 })
end })

BuildTab:Button({ Title = "盖墙", Desc = "BuildWalls", Callback = function()
    BuildWallsEvent:FireServer()
end })

BuildTab:Button({ Title = "盖塔", Desc = "BuildTower", Callback = function()
    BuildTowerEvent:FireServer()
end })

BuildTab:Divider()

BuildTab:Button({ Title = "一键全盖", Desc = "房子 → 墙 → 塔（依次触发）", Callback = function()
    BuildHouseEvent:FireServer()
    task.wait(buildDelay)
    BuildWallsEvent:FireServer()
    task.wait(buildDelay)
    BuildTowerEvent:FireServer()
end })

task.spawn(function()
    while task.wait(0.5) do
        if treeAuto then chopTrees() end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if rockAuto then mineRocks() end
    end
end)

Window:SelectTab(1)
