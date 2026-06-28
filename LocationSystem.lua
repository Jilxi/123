local LocationSystem = {}
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local FILE = "VoidCore_Locations.json"

-- ========== 内部 IO ==========
local function load()
	if not isfolder and not isfile then return {} end
	local ok, result = pcall(function()
		return HttpService:JSONDecode(readfile(FILE))
	end)
	return (ok and type(result) == "table") and result or {}
end

local function save(data)
	pcall(writefile, FILE, HttpService:JSONEncode(data))
end

-- ========== 公开 API ==========

function LocationSystem.GetFolders()
	local data = load()
	local folders = {}
	for k in pairs(data) do table.insert(folders, k) end
	table.sort(folders)
	return folders
end

function LocationSystem.CreateFolder(name)
	local data = load()
	if data[name] then return false end
	data[name] = {}
	save(data)
	return true
end

function LocationSystem.DeleteFolder(name)
	local data = load()
	if not data[name] then return false end
	data[name] = nil
	save(data)
	return true
end

function LocationSystem.SaveLocation(folder, name, position)
	local data = load()
	if not data[folder] then data[folder] = {} end
	data[folder][name] = {
		x = position.X,
		y = position.Y,
		z = position.Z,
		timestamp = os.time(),
	}
	save(data)
end

function LocationSystem.LoadLocations(folder)
	local data = load()
	if not data[folder] then return {} end
	local locs = {}
	for name, info in pairs(data[folder]) do
		table.insert(locs, {
			name = name,
			position = Vector3.new(info.x, info.y, info.z),
			timestamp = info.timestamp,
		})
	end
	table.sort(locs, function(a, b) return a.name < b.name end)
	return locs
end

function LocationSystem.DeleteLocation(folder, name)
	local data = load()
	if not data[folder] or not data[folder][name] then return false end
	data[folder][name] = nil
	save(data)
	return true
end

function LocationSystem.Teleport(loc, method)
	local char = Players.LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return false end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum and hum.Sit then
		hum.Sit = false
		task.wait(0.05)
	end

	local target = loc.position
	method = method or "CFrame"

	if method == "CFrame" then
		hrp.CFrame = CFrame.new(target)

	elseif method == "Velocity" then
		hrp.Velocity = Vector3.zero
		hrp.CFrame = CFrame.new(target)

	elseif method == "Translate" then
		local start = hrp.Position
		local delta = target - start
		for i = 1, 12 do
			hrp.CFrame = CFrame.new(start + delta * (i / 12))
			task.wait(0.01)
		end
	else
		hrp.CFrame = CFrame.new(target)
	end

	return true
end

return LocationSystem
