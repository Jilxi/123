local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local SPEED_MULTIPLIER = 30
local JUMP_POWER = 60
local JUMP_GAP = 0.3

local character = game.Players.LocalPlayer.Character

for i,v in ipairs(character:GetDescendants()) do
    if v:IsA("BasePart") then
        v.CanCollide = false
    end
end

local ball = character.HumanoidRootPart
ball.Shape = Enum.PartType.Ball
ball.Size = Vector3.new(5,5,5)
local humanoid = character:WaitForChild("Humanoid")

local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Blacklist
params.FilterDescendantsInstances = {character}

local tc = RunService.RenderStepped:Connect(function(delta)
    ball.CanCollide = true
    humanoid.PlatformStand = true

    local moveDir = humanoid.MoveDirection
    if moveDir.Magnitude > 0.1 then
        local flatMove = Vector3.new(moveDir.X, 0, moveDir.Z)
     local rotAxis = Vector3.new(0, 1, 0):Cross(flatMove).Unit
        ball.RotVelocity = ball.RotVelocity + rotAxis * flatMove.Magnitude * delta * SPEED_MULTIPLIER
    end
end)

UserInputService.JumpRequest:Connect(function()
    local result = workspace:Raycast(
        ball.Position,
        Vector3.new(0, -((ball.Size.Y / 2) + JUMP_GAP), 0),
        params
    )
    if result then
        ball.Velocity = ball.Velocity + Vector3.new(0, JUMP_POWER, 0)
    end
end)

Camera.CameraSubject = ball
humanoid.Died:Connect(function() tc:Disconnect() end)
