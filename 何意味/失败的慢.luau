local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        local UserInputService = game:GetService("UserInputService")
        local RunService = game:GetService("RunService")
        local Debris = game:GetService("Debris")
        local player = Players.LocalPlayer
        local camera = workspace.CurrentCamera
        local autoPull, noclip, webPhysics, spiderMode = false, false, false, false
        local targetPos, currentWeb = nil, nil
        local guiMain, panelFrame, btnAuto, btnNoclip, btnSpider, subButtons = nil

        local function buildGui()
            if guiMain then guiMain:Destroy() end
            guiMain = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
            guiMain.ResetOnSpawn = false
            panelFrame = Instance.new("Frame")
            panelFrame.Size = UDim2.new(0,210,0,260)
            panelFrame.Position = UDim2.new(0.1,0,0.4,0)
            panelFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
            panelFrame.BackgroundTransparency = 0.2
            panelFrame.Active = true
            panelFrame.Parent = guiMain

            local dragging = false
            local dragStartPos = nil
            local startPos = nil
            panelFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    dragStartPos = input.Position
                    startPos = panelFrame.Position
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then dragging = false end
                    end)
                end
            end)
            panelFrame.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
                    local delta = input.Position - dragStartPos
                    panelFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end)

            local function mk(text, y)
                local btn = Instance.new("TextButton", panelFrame)
                btn.Size = UDim2.new(1, -10, 0, 40)
                btn.Position = UDim2.new(0,5,0,y)
                btn.Text = text
                btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
                btn.TextColor3 = Color3.new(1,1,1)
                btn.Font = Enum.Font.SourceSansBold
                btn.TextSize = 18
                return btn
            end

            btnAuto = mk("自动行走: 关闭", 10)
            btnNoclip = mk("穿墙模式: 关闭", 60)
            btnSpider = mk("🕷 蜘蛛侠模式", 110)
            local btnWebPull = mk("蛛网牵引: 关闭", 160)
            local btnWebPhys = mk("蛛网物理: 关闭", 210)

            subButtons = {btnWebPull, btnWebPhys}
            for _, b in ipairs(subButtons) do b.Visible = false end

            btnSpider.MouseButton1Click:Connect(function()
                spiderMode = not spiderMode
                for _, b in ipairs(subButtons) do b.Visible = spiderMode end
            end)

            btnAuto.MouseButton1Click:Connect(function()
                autoPull = not autoPull
                btnAuto.Text = "自动行走: " .. (autoPull and "开启" or "关闭")
                btnAuto.BackgroundColor3 = autoPull and Color3.fromRGB(0,120,255) or Color3.fromRGB(70,70,70)
            end)

            btnNoclip.MouseButton1Click:Connect(function()
                noclip = not noclip
                btnNoclip.Text = "穿墙模式: " .. (noclip and "开启" or "关闭")
            end)

            btnWebPull.MouseButton1Click:Connect(function()
                webPhysics = false
                autoPull = true
                btnWebPull.Text = "蛛网牵引: 开启"
                btnWebPhys.Text = "蛛网物理: 关闭"
            end)

            btnWebPhys.MouseButton1Click:Connect(function()
                webPhysics = true
                autoPull = false
                btnWebPhys.Text = "蛛网物理: 开启"
                btnWebPull.Text = "蛛网牵引: 关闭"
            end)
        end

        local function createWeb(startPos, endPos)
            if currentWeb then currentWeb:Destroy() end
            local p1 = Instance.new("Part", workspace)
            p1.Anchored = true
            p1.CanCollide = false
            p1.Transparency = 1
            p1.CFrame = CFrame.new(startPos)
            local p2 = Instance.new("Part", workspace)
            p2.Anchored = true
            p2.CanCollide = false
            p2.Transparency = 1
            p2.CFrame = CFrame.new(endPos)
            local a1 = Instance.new("Attachment", p1)
            local a2 = Instance.new("Attachment", p2)
            local beam = Instance.new("Beam", p1)
            beam.Attachment0 = a1
            beam.Attachment1 = a2
            beam.Width0 = 2
            beam.Width1 = 2
            beam.LightEmission = 1
            beam.Texture = "rbxassetid://446111271"
            beam.TextureMode = Enum.TextureMode.Stretch
            beam.TextureLength = 1
            beam.TextureSpeed = 2
            beam.Color = ColorSequence.new(Color3.new(1,1,1))
            beam.Transparency = NumberSequence.new(0.05)
            currentWeb = Instance.new("Folder", workspace)
            p1.Parent = currentWeb
            p2.Parent = currentWeb
        end

        local function useWeb()
            if not targetPos then return end
            local char = player.Character or player.CharacterAdded:Wait()
            local root = char:WaitForChild("HumanoidRootPart")
            createWeb(root.Position, targetPos)
            if webPhysics then
                local bv = Instance.new("BodyVelocity", root)
                bv.MaxForce = Vector3.new(1e6,1e6,1e6)
                bv.Velocity = (targetPos - root.Position).Unit * 100
                Debris:AddItem(bv, 0.5)
            elseif autoPull then
                local tw = TweenService:Create(root, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {CFrame = CFrame.new(targetPos + Vector3.new(0,3,0))})
                tw:Play()
            end
        end

        UserInputService.InputBegan:Connect(function(input, processed)
            if processed then return end
            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                local ray = camera:ScreenPointToRay(input.Position.X, input.Position.Y)
                local rp = RaycastParams.new()
                rp.FilterDescendantsInstances = {player.Character}
                rp.FilterType = Enum.RaycastFilterType.Blacklist
                local hit = workspace:Raycast(ray.Origin, ray.Direction * 500, rp)
                if hit then targetPos = hit.Position; useWeb() end
            end
        end)

        RunService.RenderStepped:Connect(function()
            local char = player.Character
            if char and noclip then
                for _, p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
            end
        end)

        player.CharacterAdded:Connect(function()
            wait(1)
            buildGui()
            if targetPos then wait(0.5); useWeb() end
        end)

        buildGui()
