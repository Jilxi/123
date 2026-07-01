





















































































local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local WeaponFramework = ReplicatedStorage:WaitForChild("WeaponFramework")
local Remotes = WeaponFramework:WaitForChild("Remotes")

local Network = Remotes:WaitForChild("Network")
local Reload = Remotes:WaitForChild("Reload")
local TripodsFolder = Workspace:WaitForChild("Tripods")

_G.ContinuousAttack = true
_G.AimBotBypass = true
_G.FireRate = 0.05

local function drawTrajectory(startPos, endPos)
    local sPos = Vector3.new(startPos.X, startPos.Y, startPos.Z)
    local ePos = Vector3.new(endPos.X, endPos.Y, endPos.Z)
    local distance = (sPos - ePos).Magnitude
    
    local tracer = Instance.new("Part")
    tracer.Name = "AttackTracer"
    tracer.Anchored = true
    tracer.CanCollide = false
    tracer.Material = Enum.Material.Neon
    tracer.Color = Color3.fromRGB(255, 0, 0)
    tracer.Size = Vector3.new(0.08, 0.08, distance)
    tracer.CFrame = CFrame.lookAt(sPos, ePos) * CFrame.new(0, 0, -distance / 2)
    tracer.Parent = Workspace
    Debris:AddItem(tracer, 0.04) 
end

local function findDeepPart(root)
    local head = root:FindFirstChild("HEAD")
    if head then
        local backHead = head:FindFirstChild("BACK_HEAD")
        if backHead then
            local backPlate = backHead:FindFirstChild("BACK_PLATE")
            if backPlate then
                local headBottom = backPlate:FindFirstChild("HEAD_BOTTOM")
                if headBottom and headBottom:IsA("BasePart") then
                    return headBottom
                end
            end
        end
    end
    return root:FindFirstChild("Neck") or root.PrimaryPart or root:FindFirstChildWhichIsA("BasePart")
end

task.spawn(function()
    print("[Tailor-Hub] 正在尝试绕过服务器全方位校验，血量监控已就绪...")
    
    local shotCount = 0
    local maxMagazine = 30 
    local weaponName = "HK416"

    while _G.ContinuousAttack do
        local character = LocalPlayer.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        local currentTool = character and character:FindFirstChild(weaponName)
        
        if rootPart and currentTool then
            local targets = TripodsFolder:GetChildren()
            
            for _, tripod in ipairs(targets) do
                if not _G.ContinuousAttack then break end
                
                local targetPart = findDeepPart(tripod)
                
                local humanoid = tripod:FindFirstChildOfClass("Humanoid")
                local isAlive = true
                if humanoid and humanoid.Health <= 0 then
                    isAlive = false
                end
                
                if targetPart and isAlive then
                    local startPos = rootPart.Position
                    local endPos = targetPart.Position
                    
                    if _G.AimBotBypass then
                        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, endPos)
                        rootPart.CFrame = CFrame.lookAt(rootPart.Position, Vector3.new(endPos.X, rootPart.Position.Y, endPos.Z))
                    end
                    
                    local shootArgs = {
                        weaponName,
                        vector.create(startPos.X, startPos.Y, startPos.Z),
                        vector.create(endPos.X, endPos.Y, endPos.Z)
                    }
                    Network:FireServer(unpack(shootArgs))
                    
                    drawTrajectory(startPos, endPos)
                    
                    if humanoid then
                        print(string.format("[击中反馈] 目标: %s | 当前血量: %.1f / %.1f", tripod.Name, humanoid.Health, humanoid.MaxHealth))
                    end
                    
                    shotCount = shotCount + 1
                    
                    if shotCount >= maxMagazine then
                        Reload:FireServer(weaponName) 
                        shotCount = 0
                        task.wait(0.3)
                    end
                    
                    task.wait(_G.FireRate)
                end
            end
        else
            task.wait(1)
        end
        task.wait()
    end
end)
