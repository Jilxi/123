local textMap = {
    ["Cobalt"] = "Cobalt",
    ["Clear Logs"] = "清空日志",
    ["Copy Calling Code"] = "复制调用代码",
    ["Copy Intercept Code"] = "复制拦截代码",
    ["Copy Remote Path"] = "复制远程路径",
    ["Copy Script Path"] = "复制脚本路径",
    ["Replay"] = "重放",
    ["Select..."] = "选择...",
    ["Search for logs..."] = "搜索日志...",
    ["Calling Code"] = "调用代码",
    ["Intercept Code"] = "拦截代码",
    ["Decompiled Script"] = "反编译脚本",
    ["Remote Path"] = "远程路径",
    ["Script Path"] = "脚本路径",
    ["Instance Path Lookup Chain"] = "实例路径查找链",
    ["Function Info"] = "函数信息",
    ["Blocked Remotes"] = "已阻止的远程对象",
    ["Ignored Remotes"] = "已忽略的远程对象",
    ["Ignore Remotes"] = "忽略远程对象",
    ["Time: "] = "时间：",
    ["Auto Ignore Spammy Events"] = "自动忽略刷屏事件",
    ["Built-in Anticheat Bypass"] = "内置反作弊绕过",
    ["DPI Scale"] = "DPI缩放",
    ["Execute On Teleport"] = "传送时自动执行",
    ["Ignore Player Module Remotes"] = "忽略玩家模块远程对象",
    ["Log Blocked Remotes"] = "记录已阻止的远程对象",
    ["Log Events from Actors"] = "记录来自Actor的事件",
    ["Logs Per Page"] = "每页日志数量",
    ["Prefer buffer.fromstring"] = "优先使用buffer.fromstring",
    ["Show Cobalt Watermark"] = "显示Cobalt水印",
    ["Use alternative metamethod hook"] = "使用替代元方法钩子",
    ["All"] = "全部",
    ["None"] = "无",
    ["ERROR"] = "错误",
    ["Failed to replay event"] = "重放事件失败",
    ["Replayed event successfully!"] = "事件重放成功！",
    ["Replaying event..."] = "正在重放事件...",
    ["Please rejoin for the fix to take effect!"] = "请重新进入游戏以使修复生效！",
    ["Starting Export..."] = "开始导出...",
}

local function translateInstance(obj)
    pcall(function()
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            local new = textMap[obj.Text]
            if new then obj.Text = new end
        end
        if obj:IsA("TextBox") then
            local new = textMap[obj.PlaceholderText]
            if new then obj.PlaceholderText = new end
        end
    end)
end

local function watchContainer(container)
    for _, obj in ipairs(container:GetDescendants()) do
        translateInstance(obj)
    end
    container.DescendantAdded:Connect(function(obj)
        task.defer(translateInstance, obj)
        pcall(function()
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                obj:GetPropertyChangedSignal("Text"):Connect(function()
                    local new = textMap[obj.Text]
                    if new and obj.Text ~= new then obj.Text = new end
                end)
            end
        end)
    end)
end

loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau"))()

task.wait(0.5)

pcall(watchContainer, game:GetService("CoreGui"))
pcall(watchContainer, game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
