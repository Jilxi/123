local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

local ZERO_VEC3 = Vector3.zero
local ZERO_PHYS = PhysicalProperties.new(0, 0, 0)

local Config = {
	OtherAngularThreshold = 50,
	OtherLinearThreshold = 100,
	SelfVelocityThreshold = 250,
}

local AntiFling = {}
local running = false
local Connections = {}
local TrackedPlayers = {}

local function disconnectList(list)
	for i = #list, 1, -1 do
		local conn = list[i]
		if conn.Connected then
			conn:Disconnect()
		end
		list[i] = nil
	end
end

local function cleanupPlayer(player)
	local entry = TrackedPlayers[player]
	if not entry then return end

	disconnectList(entry.playerConns)
	disconnectList(entry.charConns)
	table.clear(entry.parts)
	TrackedPlayers[player] = nil
end

local function trackPlayer(player)
	if not running or player == LocalPlayer then return end
	cleanupPlayer(player)

	local entry = {
		player = player,
		char = nil,
		hrp = nil,
		parts = {},
		playerConns = {},
		charConns = {},
	}
	TrackedPlayers[player] = entry

	local function onCharacterAdded(character)
		if not running or TrackedPlayers[player] ~= entry then return end

		disconnectList(entry.charConns)
		table.clear(entry.parts)

		entry.char = character
		entry.hrp = nil

		for _, inst in ipairs(character:GetDescendants()) do
			if inst:IsA("BasePart") then
				table.insert(entry.parts, inst)
			end
		end

		table.insert(entry.charConns, character.DescendantAdded:Connect(function(inst)
			if inst:IsA("BasePart") then
				table.insert(entry.parts, inst)
			end
		end))

		local hrp = character:WaitForChild("HumanoidRootPart", 10)
		if running and entry.char == character then
			entry.hrp = hrp
		end
	end

	if player.Character then
		task.spawn(onCharacterAdded, player.Character)
	end

	table.insert(entry.playerConns, player.CharacterAdded:Connect(onCharacterAdded))
end

function AntiFling.Start()
	if running then return end
	running = true

	for _, player in ipairs(Players:GetPlayers()) do
		trackPlayer(player)
	end

	table.insert(Connections, Players.PlayerAdded:Connect(trackPlayer))
	table.insert(Connections, Players.PlayerRemoving:Connect(cleanupPlayer))

	local lastSafeCFrame = nil

	table.insert(Connections, RunService.Heartbeat:Connect(function()
		-- 1. 统一检测并压制其他异常高速玩家
		for _, entry in pairs(TrackedPlayers) do
			local char = entry.char
			local hrp = entry.hrp

			if char and char.Parent and hrp and hrp.Parent then
				if hrp.AssemblyAngularVelocity.Magnitude > Config.OtherAngularThreshold
					or hrp.AssemblyLinearVelocity.Magnitude > Config.OtherLinearThreshold then

					local parts = entry.parts
					for i = #parts, 1, -1 do
						local part = parts[i]
						if part and part.Parent then
							part.CanCollide = false
							part.AssemblyAngularVelocity = ZERO_VEC3
							part.AssemblyLinearVelocity = ZERO_VEC3
							part.CustomPhysicalProperties = ZERO_PHYS
						else
							table.remove(parts, i)
						end
					end
				end
			end
		end

		-- 2. 本地角色防甩飞速度钳制与安全坐标回溯
		local localChar = LocalPlayer.Character
		local localHRP = localChar and localChar:FindFirstChild("HumanoidRootPart")
		if not localHRP then return end

		if localHRP.AssemblyLinearVelocity.Magnitude > Config.SelfVelocityThreshold
			or localHRP.AssemblyAngularVelocity.Magnitude > Config.SelfVelocityThreshold then

			localHRP.AssemblyAngularVelocity = ZERO_VEC3
			localHRP.AssemblyLinearVelocity = ZERO_VEC3

			if lastSafeCFrame then
				localHRP.CFrame = lastSafeCFrame
			end
		else
			lastSafeCFrame = localHRP.CFrame
		end
	end))
end

function AntiFling.Stop()
	if not running then return end
	running = false

	disconnectList(Connections)

	for player in pairs(TrackedPlayers) do
		cleanupPlayer(player)
	end
end

return AntiFling
