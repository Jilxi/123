local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local function setupCharacter(char)
	local humanoid = char:WaitForChild("Humanoid")
	local head = char:WaitForChild("Head")
	local root = char:WaitForChild("HumanoidRootPart")

	local animate = char:FindFirstChild("Animate")
	if animate then
		animate:Destroy()
	end

	local idleAnim = Instance.new("Animation")
	idleAnim.AnimationId = "rbxassetid://103939297784308"

	local walkAnim = Instance.new("Animation")
	walkAnim.AnimationId = "rbxassetid://136103532014102"

	local runAnim = Instance.new("Animation")
	runAnim.AnimationId = "rbxassetid://123416403401179"

	local idleTrack = humanoid:LoadAnimation(idleAnim)
	local walkTrack = humanoid:LoadAnimation(walkAnim)
	local runTrack = humanoid:LoadAnimation(runAnim)

	local normalSpeed = 9
	local runSpeed = 23
	local isRunning = false

	for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end

	idleTrack.Looped = true
	walkTrack.Looped = true
	runTrack.Looped = true

	idleTrack:Play()

	humanoid.Running:Connect(function(speed)
		if isRunning then return end
		if speed > 1 then
			if not walkTrack.IsPlaying then
				idleTrack:Stop()
				walkTrack:Play()
			end
		else
			if not idleTrack.IsPlaying then
				walkTrack:Stop()
				idleTrack:Play()
			end
		end
	end)

	humanoid.WalkSpeed = normalSpeed

	RunService.RenderStepped:Connect(function()
		if head and root then
			local relative = root.CFrame:PointToObjectSpace(head.Position)
			local yOffset = relative.Y - 1.5
			local zOffset = relative.Z
			humanoid.CameraOffset = Vector3.new(0, yOffset, zOffset)
		end
	end)

	local screenGui = Instance.new("ScreenGui")
	screenGui.Parent = player:WaitForChild("PlayerGui")

	local runButton = Instance.new("TextButton")
	runButton.Size = UDim2.new(0, 50, 0, 50)
	runButton.Position = UDim2.new(1, -110, 1, -120)
	runButton.BackgroundColor3 = Color3.new(0,0,0)
	runButton.BorderColor3 = Color3.new(0,0,0)
	runButton.TextColor3 = Color3.new(1,1,1)
	runButton.Text = "Run"
	runButton.Parent = screenGui

	runButton.MouseButton1Click:Connect(function()
		if isRunning then
			humanoid.WalkSpeed = normalSpeed
			runTrack:Stop()
			if humanoid.MoveDirection.Magnitude > 1 then
				walkTrack:Play()
			else
				idleTrack:Play()
			end
			isRunning = false
		else
			humanoid.WalkSpeed = runSpeed
			walkTrack:Stop()
			idleTrack:Stop()
			runTrack:Play()
			isRunning = true
		end
	end)
end

player.CharacterAdded:Connect(setupCharacter)
if player.Character then
	setupCharacter(player.Character)
end
