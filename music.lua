local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

-- 防止重复执行导致 UI 重叠
if CoreGui:FindFirstChild("WhiteNeteaseGui") then
    CoreGui.WhiteNeteaseGui:Destroy()
end

----------------------------------------------------------------
-- 1. 创建【纯白极简长方形 UI 界面】(420 x 240)
----------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WhiteNeteaseGui"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 240) -- 【完美的横向长方形尺寸】
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(250, 250, 250) -- 【纯白底色】
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- 阴影或描边效果（让白色 UI 在游戏中更显眼）
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(220, 220, 220)
UIStroke.Thickness = 1
UIStroke.Parent = MainFrame

-- 顶部标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 32)
TitleBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Text = "网易云音乐 随身听"
Title.TextColor3 = Color3.fromRGB(30, 30, 30) -- 深色字
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -28, 0, 4)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(120, 120, 120)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextSize = 14
CloseBtn.Parent = TitleBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 24, 0, 24)
MinBtn.Position = UDim2.new(1, -56, 0, 4)
MinBtn.Text = "➖"
MinBtn.TextColor3 = Color3.fromRGB(120, 120, 120)
MinBtn.BackgroundTransparency = 1
MinBtn.TextSize = 12
MinBtn.Parent = TitleBar

-- 分割线
local Line = Instance.new("Frame")
Line.Size = UDim2.new(1, 0, 0, 1)
Line.Position = UDim2.new(0, 0, 0, 32)
Line.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
Line.BorderSizePixel = 0
Line.Parent = MainFrame

-- 主体内容
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 1, -33)
Content.Position = UDim2.new(0, 0, 0, 33)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- 搜索输入框
local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(0.75, -16, 0, 30)
SearchBox.Position = UDim2.new(0, 10, 0, 8)
SearchBox.PlaceholderText = " 🔍 键入想要搜索的歌曲..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(50, 50, 50)
SearchBox.BackgroundColor3 = Color3.fromRGB(242, 242, 242) -- 浅灰输入框
SearchBox.BorderSizePixel = 0
SearchBox.TextSize = 13
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.Parent = Content
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 4)

-- 搜索按钮（经典的网易云红色作为点缀）
local SearchBtn = Instance.new("TextButton")
SearchBtn.Size = UDim2.new(0.25, -14, 0, 30)
SearchBtn.Position = UDim2.new(0.75, 4, 0, 8)
SearchBtn.Text = "搜索"
SearchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBtn.BackgroundColor3 = Color3.fromRGB(234, 70, 70)
SearchBtn.TextSize = 13
SearchBtn.Font = Enum.Font.SourceSansBold
SearchBtn.Parent = Content
Instance.new("UICorner", SearchBtn).CornerRadius = UDim.new(0, 4)

-- 列表框
local ResultsFrame = Instance.new("ScrollingFrame")
ResultsFrame.Size = UDim2.new(1, -20, 1, -86)
ResultsFrame.Position = UDim2.new(0, 10, 0, 46)
ResultsFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
ResultsFrame.ScrollBarThickness = 4
ResultsFrame.BorderSizePixel = 0
ResultsFrame.Parent = Content
Instance.new("UICorner", ResultsFrame).CornerRadius = UDim.new(0, 4)

-- 底部状态栏与停止播放按钮
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -48, 0, 26)
StatusLabel.Position = UDim2.new(0, 10, 1, -32)
StatusLabel.Text = "  音乐就绪"
StatusLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
StatusLabel.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.TextTruncate = Enum.TextTruncate.AtEnd
StatusLabel.Parent = Content
Instance.new("UICorner", StatusLabel).CornerRadius = UDim.new(0, 4)

local StopBtn = Instance.new("TextButton")
StopBtn.Size = UDim2.new(0, 26, 0, 26)
StopBtn.Position = UDim2.new(1, -36, 1, -32)
StopBtn.Text = "⏹"
StopBtn.TextColor3 = Color3.fromRGB(100, 100, 100)
StopBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
StopBtn.TextSize = 11
StopBtn.Parent = Content
Instance.new("UICorner", StopBtn).CornerRadius = UDim.new(0, 4)

----------------------------------------------------------------
-- 2. 交互与播放逻辑（无版权判断核心）
----------------------------------------------------------------
local isMinimized = false
local originalSize = MainFrame.Size

-- 【关闭 UI】
CloseBtn.MouseButton1Click:Connect(function()
    local snd = CoreGui:FindFirstChild("WhiteNeteaseSound")
    if snd then snd:Destroy() end
    ScreenGui:Destroy()
end)

-- 【缩小展开 UI】
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        Content.Visible = false
        MainFrame:TweenSize(UDim2.new(0, 420, 0, 32), "Out", "Quad", 0.2, true)
    else
        MainFrame:TweenSize(originalSize, "Out", "Quad", 0.2, true, function()
            Content.Visible = true
        end)
    end
end)

-- 【停止播放】
StopBtn.MouseButton1Click:Connect(function()
    local snd = CoreGui:FindFirstChild("WhiteNeteaseSound")
    if snd then 
        snd:Stop()
        StatusLabel.Text = "  播放已停止"
    end
end)

-- 【提示无版权的专用弹窗函数】
local function showNoCopyrightNotice(songName)
    StatusLabel.Text = "  ❌ 提示：此歌曲暂无版权或为VIP歌曲"
    StatusLabel.TextColor3 = Color3.fromRGB(210, 40, 40)
    
    StarterGui:SetCore("SendNotification", {
        Title = "网易云音乐提示",
        Text = "❌ 【" .. songName .. "】播放失败！该歌曲暂无版权或属于VIP专享歌曲。",
        Duration = 6
    })
end

-- 【游戏原生音频下载与播放（带版权判定）】
local function playInGame(songId, songName)
    local url = "https://music.163.com/song/media/outer/url?id=" .. tostring(songId) .. ".mp3"
    StatusLabel.Text = "  正在缓冲: " .. songName
    StatusLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
    
    task.spawn(function()
        local success, audioData = pcall(function()
            return game:HttpGet(url)
        end)
        
        -- 【核心逻辑】：网易云如果无版权或属于VIP限制歌曲，直链会返回 0 字节、或非常小的拦截数据（通常小于 50KB）
        if success and audioData and #audioData > 50000 then
            if typeof(writefile) == "function" and typeof(getcustomasset) == "function" then
                local fileName = "WhiteNetease_" .. tostring(songId) .. ".mp3"
                writefile(fileName, audioData)
                local assetId = getcustomasset(fileName)
                
                local sound = CoreGui:FindFirstChild("WhiteNeteaseSound")
                if not sound then
                    sound = Instance.new("Sound")
                    sound.Name = "WhiteNeteaseSound"
                    sound.Volume = 1
                    sound.Parent = CoreGui
                end
                
                sound.SoundId = assetId
                sound:Play()
                StatusLabel.Text = "  🎵 正在播放: " .. songName
                StatusLabel.TextColor3 = Color3.fromRGB(50, 150, 50)
            else
                StatusLabel.Text = "  ❌ 执行器不支持本地文件写入"
            end
        else
            -- 判定为：无法播放/无版权
            showNoCopyrightNotice(songName)
        end
    end)
end

-- 【搜索歌曲列表生成】
SearchBtn.MouseButton1Click:Connect(function()
    local keyword = SearchBox.Text
    if keyword == "" then return end
    
    StatusLabel.Text = "  正在搜索..."
    SearchBtn.Text = "..."
    SearchBtn.Active = false
    
    for _, child in pairs(ResultsFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local url = string.format(
        "https://music.163.com/api/search/get?s=%s&type=1&offset=0&total=true&limit=12",
        HttpService:UrlEncode(keyword)
    )
    
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    
    SearchBtn.Text = "搜索"
    SearchBtn.Active = true
    
    if success and response then
        local data = HttpService:JSONDecode(response)
        if data and data.result and data.result.songs then
            StatusLabel.Text = "  搜索完成"
            
            for i, song in ipairs(data.result.songs) do
                local songName = song.name
                local artistName = song.artists[1] and song.artists[1].name or "未知"
                
                local SongBtn = Instance.new("TextButton")
                SongBtn.Size = UDim2.new(1, -8, 0, 30)
                SongBtn.Position = UDim2.new(0, 4, 0, (i-1) * 34)
                SongBtn.Text = string.format("  %d. %s - %s", i, songName, artistName)
                SongBtn.TextXAlignment = Enum.TextXAlignment.Left
                SongBtn.TextTruncate = Enum.TextTruncate.AtEnd
                SongBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- 歌曲行默认纯白
                SongBtn.TextColor3 = Color3.fromRGB(60, 60, 60)
                SongBtn.Font = Enum.Font.SourceSans
                SongBtn.TextSize = 13
                SongBtn.BorderSizePixel = 0
                SongBtn.Parent = ResultsFrame
                Instance.new("UICorner", SongBtn).CornerRadius = UDim.new(0, 4)
                
                -- 极简悬停特效（变温和的灰）
                SongBtn.MouseEnter:Connect(function() SongBtn.BackgroundColor3 = Color3.fromRGB(235, 245, 255) end)
                SongBtn.MouseLeave:Connect(function() SongBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255) end)
                
                SongBtn.MouseButton1Click:Connect(function()
                    playInGame(song.id, songName)
                end)
            end
            ResultsFrame.CanvasSize = UDim2.new(0, 0, 0, #data.result.songs * 34)
        else
            StatusLabel.Text = "  ❌ 未找到相关歌曲"
        end
    else
        StatusLabel.Text = "  ❌ 网络请求失败"
    end
end)
