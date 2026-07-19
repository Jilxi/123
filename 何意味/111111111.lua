-- AutoClicker.lua
-- 用法: local ClickerModule = loadstring(game:HttpGet(URL))()
--       ClickerModule.Init(clicker, settings)

local ClickerModule = {}

function ClickerModule.Init(clicker, settings)
    local clickerUI       = nil
    local clickerConns    = {}
    local destroyAutoClicker

    local function safeConnect(signal, func)
        table.insert(clickerConns, signal:Connect(func))
    end

    local function buildAutoClicker()
        if clickerUI then return end

        local Players = game:GetService("Players")
        local VirtualInputManager = game:GetService("VirtualInputManager")
        local UserInputService = game:GetService("UserInputService")
        local GuiService = game:GetService("GuiService")
        local CoreGui = game:GetService("CoreGui")
        local HttpService = game:GetService("HttpService")

        local LocalPlayer = Players.LocalPlayer
        local Targets = {}
        local isRunning = false
        local pointsVisible = true
        local defaultPanelTransparency = 0.2
        local defaultDotTransparency = 0.9

        local Icons = {
            Remove   = "rbxassetid://122610572797061",
            Start    = "rbxassetid://128832474920642",
            Stop     = "rbxassetid://113047868752296",
            Add      = "rbxassetid://80871366492449",
            Show     = "rbxassetid://89558029527587",
            Hidden   = "rbxassetid://82900330630483",
            Drag     = "rbxassetid://139381026962112",
            Delete   = "rbxassetid://105775511743927",
            Settings = "rbxassetid://70541424009556"
        }

        -- ★修复: 点击坐标需要用 GuiInset 补偿(状态栏/刘海等), 而不是硬编码偏移
        local function getScreenPos(target)
            local pos = target.AbsolutePosition
            local size = target.AbsoluteSize
            local inset = GuiService:GetGuiInset()
            local x = pos.X + size.X / 2 + inset.X
            local y = pos.Y + size.Y / 2 + inset.Y
            return x, y
        end

        -- ★修复: 手游大多只识别触摸(Touch)事件, 鼠标事件常常不被判定为有效点击
        -- 优先用 SendTouchTapAction 模拟手指点击屏幕, 失败(执行器不支持)再回退鼠标事件
        local function performClick(x, y)
            local touchOk = pcall(function()
                VirtualInputManager:SendTouchTapAction(Vector2.new(x, y), 1, false)
            end)
            if touchOk then return end

            pcall(function()
                VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 1)
                task.wait(settings.pressDuration or 0.01)
                VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 1)
            end)
        end

        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "AutoClicker_Classic"
        ScreenGui.ResetOnSpawn = false
        pcall(function() ScreenGui.Parent = CoreGui end)
        if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
        clickerUI = ScreenGui

        local Panel = Instance.new("Frame")
        Panel.Name = "MainPanel"
        Panel.Parent = ScreenGui
        Panel.BackgroundColor3 = Color3.new(1, 1, 1)
        Panel.BackgroundTransparency = defaultPanelTransparency
        Panel.Position = UDim2.new(0, 16, 0, 34)
        Panel.Size = UDim2.new(0, 30, 0, 204)
        Panel.BorderSizePixel = 0

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 2)
        corner.Parent = Panel

        local layout = Instance.new("UIListLayout")
        layout.Parent = Panel
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        layout.Padding = UDim.new(0, 2)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        local SettingsUI = Instance.new("Frame")
        SettingsUI.Name = "SettingsUI"
        SettingsUI.Parent = ScreenGui
        SettingsUI.BackgroundColor3 = Color3.new(1, 1, 1)
        SettingsUI.BackgroundTransparency = defaultPanelTransparency
        SettingsUI.Position = UDim2.new(0.5, -100, 0.5, -75)
        SettingsUI.Size = UDim2.new(0, 200, 0, 150)
        SettingsUI.Visible = false
        SettingsUI.BorderSizePixel = 0

        local settingsCorner = Instance.new("UICorner")
        settingsCorner.CornerRadius = UDim.new(0, 2)
        settingsCorner.Parent = SettingsUI

        local settingsLayout = Instance.new("UIListLayout")
        settingsLayout.Parent = SettingsUI
        settingsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        settingsLayout.Padding = UDim.new(0, 10)
        settingsLayout.SortOrder = Enum.SortOrder.LayoutOrder

        -- ★优化: 所有可拖拽对象共用一条 InputChanged 连接, 而不是每个 dot 各开一条
        local dragState = {}
        local function makeDrag(obj, handle)
            handle = handle or obj
            safeConnect(handle.InputBegan, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragState[input] = {
                        object = obj,
                        startPos = obj.Position,
                        dragStart = input.Position,
                    }
                end
            end)
            safeConnect(handle.InputEnded, function(input)
                dragState[input] = nil
            end)
        end

        safeConnect(UserInputService.InputChanged, function(input)
            local st = dragState[input]
            if st then
                local delta = input.Position - st.dragStart
                st.object.Position = UDim2.new(
                    st.startPos.X.Scale, st.startPos.X.Offset + delta.X,
                    st.startPos.Y.Scale, st.startPos.Y.Offset + delta.Y
                )
            end
        end)

        makeDrag(SettingsUI)
        makeDrag(Panel)

        local function createBtn(name, icon, order, scale)
            local btn = Instance.new("ImageButton")
            btn.Name = name
            btn.Parent = Panel
            btn.BackgroundTransparency = 1
            btn.Image = icon
            btn.ImageColor3 = Color3.new(0, 0, 0)
            btn.LayoutOrder = order
            local sz = (name == "EyeBtn" and 20 or 24) * (scale or 1)
            btn.Size = UDim2.new(0, sz, 0, sz)
            return btn
        end
        local function createSpacer(h, order)
            local f = Instance.new("Frame")
            f.Name = "Spacer"
            f.Parent = Panel
            f.BackgroundTransparency = 1
            f.Size = UDim2.new(0, 24, 0, h)
            f.LayoutOrder = order
        end

        local PlayBtn   = createBtn("PlayBtn", Icons.Start, 1, 1)
        local AddBtn    = createBtn("AddBtn", Icons.Add, 2, 1)
        local RemoveBtn = createBtn("RemoveBtn", Icons.Remove, 3, 1)
        createSpacer(6, 4)
        local SettingsBtn = createBtn("SettingsBtn", Icons.Settings, 5, 0.6)
        createSpacer(6, 6)
        local EyeBtn = createBtn("EyeBtn", Icons.Show, 7, 1)
        createSpacer(6, 8)
        local DragBtn = createBtn("DragBtn", Icons.Drag, 9, 0.6)
        createSpacer(6, 10)
        local DeleteBtn = createBtn("DeleteBtn", Icons.Delete, 11, 0.5)

        local function createDot(index, savedPos)
            local dot = Instance.new("ImageLabel")
            dot.Name = "ClickDot"
            dot.Parent = ScreenGui
            dot.BackgroundColor3 = Color3.new(1, 1, 1)
            dot.BackgroundTransparency = defaultDotTransparency
            dot.Size = UDim2.new(0, 20, 0, 20)
            dot.Visible = pointsVisible
            dot.Active = false
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(1, 0)
            corner.Parent = dot
            local icon = Instance.new("ImageLabel")
            icon.Name = "Icon"
            icon.Parent = dot
            icon.Image = "rbxassetid://110626268563466"
            icon.Size = UDim2.new(0, 30, 0, 30)
            icon.Position = UDim2.new(0.5, 0, 0.5, 0)
            icon.AnchorPoint = Vector2.new(0.5, 0.5)
            icon.BackgroundTransparency = 1
            local label = Instance.new("TextLabel")
            label.Parent = dot
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = tostring(index)
            label.Font = Enum.Font.GothamBold
            label.TextSize = 16

            if savedPos then
                dot.Position = UDim2.new(unpack(savedPos))
            else
                local ox = ((index - 1) % 5) * 40
                local oy = math.floor((index - 1) / 5) * 40
                dot.Position = UDim2.new(0.5, ox - 80, 0.5, oy - 40)
            end

            makeDrag(dot)
            return dot
        end

        safeConnect(AddBtn.MouseButton1Click, function()
            local dot = createDot(#Targets + 1)
            table.insert(Targets, dot)
        end)

        safeConnect(RemoveBtn.MouseButton1Click, function()
            local last = table.remove(Targets)
            if last then last:Destroy() end
        end)

        safeConnect(SettingsBtn.MouseButton1Click, function()
            SettingsUI.Visible = not SettingsUI.Visible
        end)

        -- ★优化: 内部删除复用外部的 destroyAutoClicker, 避免两套清理逻辑不一致
        safeConnect(DeleteBtn.MouseButton1Click, function()
            isRunning = false
            destroyAutoClicker()
        end)

        safeConnect(EyeBtn.MouseButton1Click, function()
            pointsVisible = not pointsVisible
            EyeBtn.Image = pointsVisible and Icons.Show or Icons.Hidden
            for _, dot in ipairs(Targets) do dot.Visible = pointsVisible end
        end)

        local function createSettingsBtn(text, order, callback)
            local btn = Instance.new("TextButton")
            btn.Name = text
            btn.Parent = SettingsUI
            btn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
            btn.BackgroundTransparency = 0.1
            btn.Size = UDim2.new(0, 180, 0, 40)
            btn.Font = Enum.Font.GothamSemibold
            btn.Text = text
            btn.TextSize = 14
            btn.TextColor3 = Color3.new(0, 0, 0)
            btn.LayoutOrder = order
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 2)
            btnCorner.Parent = btn
            safeConnect(btn.MouseButton1Click, callback)
            return btn
        end

        createSettingsBtn("保存位置", 1, function()
            local dotData = {}
            for i, dot in ipairs(Targets) do
                dotData[i] = {Position = {dot.Position.X.Scale, dot.Position.X.Offset, dot.Position.Y.Scale, dot.Position.Y.Offset}}
            end
            local data = {
                panelPosition = {Panel.Position.X.Scale, Panel.Position.X.Offset, Panel.Position.Y.Scale, Panel.Position.Y.Offset},
                settingsPosition = {SettingsUI.Position.X.Scale, SettingsUI.Position.X.Offset, SettingsUI.Position.Y.Scale, SettingsUI.Position.Y.Offset},
                dotData = dotData
            }
            if not isfolder("BS脚本") then makefolder("BS脚本") end
            writefile("BS脚本/自动点击器.txt", HttpService:JSONEncode(data))
        end)

        createSettingsBtn("清空保存", 2, function()
            if isfile("BS脚本/自动点击器.txt") then delfile("BS脚本/自动点击器.txt") end
        end)

        local function loadData()
            if isfile("BS脚本/自动点击器.txt") then
                local ok, data = pcall(function() return HttpService:JSONDecode(readfile("BS脚本/自动点击器.txt")) end)
                if ok and data then
                    if data.panelPosition then Panel.Position = UDim2.new(unpack(data.panelPosition)) end
                    if data.settingsPosition then SettingsUI.Position = UDim2.new(unpack(data.settingsPosition)) end
                    if data.dotData then
                        for i, d in ipairs(data.dotData) do
                            local dot = createDot(i, d.Position)
                            table.insert(Targets, dot)
                        end
                    end
                end
            end
        end
        loadData()

        safeConnect(PlayBtn.MouseButton1Click, function()
            isRunning = not isRunning
            if isRunning then
                Panel.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
                Panel.BackgroundTransparency = defaultPanelTransparency + 0.5
                PlayBtn.Image = Icons.Stop
                for _, dot in ipairs(Targets) do dot.BackgroundTransparency = defaultDotTransparency + 0.2 end

                task.spawn(function()
                    while isRunning do
                        if #Targets == 0 then break end
                        local delay = settings.clickDelay or 0.5
                        for _, target in ipairs(Targets) do
                            if not isRunning then break end
                            if target and target.Parent then
                                local x, y = getScreenPos(target)
                                performClick(x, y)
                                task.wait(delay)
                            end
                        end
                        task.wait()
                    end
                    Panel.BackgroundColor3 = Color3.new(1, 1, 1)
                    Panel.BackgroundTransparency = defaultPanelTransparency
                    PlayBtn.Image = Icons.Start
                    for _, dot in ipairs(Targets) do
                        if dot and dot.Parent then dot.BackgroundTransparency = defaultDotTransparency end
                    end
                    isRunning = false
                end)
            else
                isRunning = false
                Panel.BackgroundColor3 = Color3.new(1, 1, 1)
                Panel.BackgroundTransparency = defaultPanelTransparency
                PlayBtn.Image = Icons.Start
                for _, dot in ipairs(Targets) do dot.BackgroundTransparency = defaultDotTransparency end
            end
        end)

        ScreenGui.Enabled = true
    end

    destroyAutoClicker = function()
        if not clickerUI then return end
        for _, c in ipairs(clickerConns) do c:Disconnect() end
        clickerConns = {}
        clickerUI:Destroy()
        clickerUI = nil
    end

    clicker:Toggle("GUI 开关", "clickerToggle", false, function(on)
        if on then
            buildAutoClicker()
        else
            destroyAutoClicker()
        end
    end)
end

return ClickerModule
