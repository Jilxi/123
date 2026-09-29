-- 加载字符串: loadstring(game:HttpGet("https://pastebin.com/raw/96XzjEiK"))()
-- 注意: 此脚本依赖游戏的网络所有权漏洞工作，请比其他玩家更靠近未锚定的部件，以便脚本能捕获这些部件的网络控制权

local naturalDisasterSurvivalGravityInversionGui = Instance.new("ScreenGui")
naturalDisasterSurvivalGravityInversionGui.Name = tostring(math.random())
naturalDisasterSurvivalGravityInversionGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
naturalDisasterSurvivalGravityInversionGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
naturalDisasterSurvivalGravityInversionGui.ResetOnSpawn = false
naturalDisasterSurvivalGravityInversionGui.IgnoreGuiInset = true
naturalDisasterSurvivalGravityInversionGui.ClipToDeviceSafeArea = false
naturalDisasterSurvivalGravityInversionGui.DisplayOrder = -1e+09

-- 创建重力反转切换按钮
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.FontFace = Font.new(
	"rbxasset://fonts/families/SourceSansPro.json",
	Enum.FontWeight.Bold,
	Enum.FontStyle.Normal
)
toggleButton.TextColor3 = Color3.new(0.49, 0.49, 0.49)
toggleButton.Text = "(G) 重力反转: ..."
toggleButton.AnchorPoint = Vector2.new(0, 1)
toggleButton.BackgroundColor3 = Color3.new(0.176, 0.176, 0.176)
toggleButton.Position = UDim2.new(0, 10, 1, -10)
toggleButton.BorderSizePixel = 0
toggleButton.BorderColor3 = Color3.new()
toggleButton.TextSize = 16
toggleButton.Size = UDim2.new(0, 175, 0, 25)
toggleButton.Parent = naturalDisasterSurvivalGravityInversionGui

-- 按钮样式
local uIStroke = Instance.new("UIStroke")
uIStroke.Name = "UIStroke"
uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uIStroke.Color = Color3.new(0.49, 0.49, 0.49)
uIStroke.Thickness = 2
uIStroke.Parent = toggleButton

local uICorner = Instance.new("UICorner")
uICorner.Name = "UICorner"
uICorner.CornerRadius = UDim.new(0, 4)
uICorner.Parent = toggleButton

local uIScale = Instance.new("UIScale")
uIScale.Name = "UIScale"
uIScale.Parent = naturalDisasterSurvivalGravityInversionGui

-- 获取本地玩家
local Players = game:GetService("Players")
local client = Players.LocalPlayer
local inversionEnabled = false

-- 设置网络控制范围
client.ReplicationFocus = workspace
if typeof(sethiddenproperty) == "function" then
	_G.CreateHeartbeatConnection(function()
		if inversionEnabled then
			sethiddenproperty(client, "SimulationRadius", math.huge)  -- 设置超大模拟范围
		end
	end)
else
	-- 不支持sethiddenproperty时的警告
	_G.NotifyWarning("警告", "不支持'sethiddenproperty'功能；可能导致无法控制过远的部件", 5)
end

-- 查找结构文件夹
local structureFolder
repeat
	for _, child in pairs(workspace:GetChildren()) do
		if child:IsA("Folder") and child.Name == "Structure" then
			structureFolder = child
		end
	end
	if not structureFolder then
		task.wait()
	end
until structureFolder

local instances = {}  -- 存储创建的实例

-- 应用反重力效果
function applyForce(instance)
	if
		inversionEnabled and
		instance:IsA("BasePart") and
		not instance.Anchored  -- 只对未锚定的部件生效
	then
		-- 创建附件
		local attachment = Instance.new("Attachment", instance)
		table.insert(instances, attachment)

		-- 创建线性速度
		local linearVelocity = Instance.new("LinearVelocity")
		linearVelocity.MaxForce = math.huge  -- 最大作用力
		linearVelocity.VectorVelocity = Vector3.new(0, 35, 0)  -- 向上的速度
		linearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
		linearVelocity.Attachment0 = attachment
		linearVelocity.Parent = instance
		table.insert(instances, linearVelocity)
	end
end

local connection
local thread

-- 切换重力反转状态
function toggle()
	inversionEnabled = not inversionEnabled

	-- 更新按钮状态
	local color = Color3.new(1, 0, 0)  -- 红色
	if inversionEnabled then
		color = Color3.new(0, 1, 0)  -- 绿色
		toggleButton.Text = "(G) 重力反转: 开启"
	else
		toggleButton.Text = "(G) 重力反转: 关闭"
	end
	toggleButton.TextColor3 = color
	uIStroke.Color = color

	-- 取消之前的任务
	if thread then
		task.cancel(thread)
	end

	-- 创建新任务
	thread = task.spawn(function()
		if connection then
			connection:Disconnect()
		end

		-- 清除所有效果
		for _, instance in pairs(instances) do
			instance:Destroy()
		end
		table.clear(instances)

		-- 如果开启状态，应用新效果
		if inversionEnabled then
			connection = structureFolder.DescendantAdded:Connect(applyForce)
			for _, descendant in pairs(structureFolder:GetDescendants()) do
				applyForce(descendant)
			end
		end
	end)
end

-- 绑定按钮事件
toggleButton.Activated:Connect(toggle)
game:GetService("ContextActionService"):BindAction(
	"toggleGravityInversion",
	function(_, inputState)
		if inputState == Enum.UserInputState.Begin then
			toggle()
		end
	end,
	false,
	Enum.KeyCode.G  -- G键切换
)

-- 初始化
toggle()

-- 界面缩放功能
function updateUIScale()
	uIScale.Scale = naturalDisasterSurvivalGravityInversionGui.AbsoluteSize.Y / 400
end

naturalDisasterSurvivalGravityInversionGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateUIScale)
updateUIScale()

-- 将界面添加到核心GUI
naturalDisasterSurvivalGravityInversionGui.Parent = game:GetService("CoreGui")
