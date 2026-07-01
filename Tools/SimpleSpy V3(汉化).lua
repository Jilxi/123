local textMap = {
    ["SimpleSpy"] = "SimpleSpy",
    ["Copy Code"] = "复制代码",
    ["Copy Remote"] = "复制远程路径",
    ["Run Code"] = "运行代码",
    ["Get Script"] = "获取脚本",
    ["Function Info"] = "函数信息",
    ["Clr Logs"] = "清空日志",
    ["Exclude (i)"] = "排除(单个)",
    ["Exclude (n)"] = "排除(同名)",
    ["Clr Blacklist"] = "清空黑名单",
    ["Block (i)"] = "阻止(单个)",
    ["Block (n)"] = "阻止(同名)",
    ["Clr Blocklist"] = "清空阻止列表",
    ["Decompile"] = "反编译",
    ["Disable Info"] = "禁用函数信息",
    ["Autoblock"] = "自动阻止",
    ["Logcheckcaller"] = "记录客户端调用",
    ["Advanced Info"] = "高级信息",
    ["Join Discord"] = "加入Discord",
    ["Load SSV2.2"] = "加载SS V2.2",
    ["Load SSV3"] = "加载SS V3",
    ["SUPER SECRET BUTTON"] = "超级秘密按钮",
    ["Copied successfully!"] = "复制成功！",
    ["Copied!"] = "已复制！",
    ["Executing..."] = "执行中...",
    ["Source not found"] = "未找到来源",
    ["Source not found!"] = "未找到来源！",
    ["Done!"] = "完成！",
    ["Excluded!"] = "已排除！",
    ["Blacklist cleared!"] = "黑名单已清空！",
    ["Blocklist cleared!"] = "阻止列表已清空！",
    ["Clearing..."] = "清空中...",
    ["Logs cleared!"] = "日志已清空！",
    ["Copied invite to your clipboard"] = "邀请链接已复制到剪贴板",
    ["Missing function (decompile)"] = "缺少函数(decompile)",
    ["No data was returned"] = "没有返回数据",
    ["Click to copy code"] = "点击复制代码",
    ["Click to copy the path of the remote"] = "点击复制远程对象的路径",
    ["Click to execute code"] = "点击执行代码",
    ["Click to copy calling script to clipboard\nWARNING: Not super reliable, nil == could not find"] = "点击复制调用脚本到剪贴板\n警告：不完全可靠，nil表示未找到",
    ["Click to view calling function information"] = "点击查看调用函数信息",
    ["Click to clear logs"] = "点击清空日志",
    ["Click to exclude this Remote.\nExcluding a remote makes SimpleSpy ignore it, but it will continue to be usable."] = "点击排除此远程对象。\n排除后SimpleSpy将忽略它，但它仍可正常使用。",
    ["Click to exclude all remotes with this name.\nExcluding a remote makes SimpleSpy ignore it, but it will continue to be usable."] = "点击排除所有同名远程对象。\n排除后SimpleSpy将忽略它们，但仍可正常使用。",
    ["Click to clear the blacklist.\nExcluding a remote makes SimpleSpy ignore it, but it will continue to be usable."] = "点击清空黑名单。\n排除后SimpleSpy将忽略远程对象，但仍可正常使用。",
    ["Click to stop this remote from firing.\nBlocking a remote won't remove it from SimpleSpy logs, but it will not continue to fire the server."] = "点击阻止此远程对象触发。\n阻止不会从日志中移除记录，但不会再向服务器发送请求。",
    ["Click to stop remotes with this name from firing.\nBlocking a remote won't remove it from SimpleSpy logs, but it will not continue to fire the server."] = "点击阻止所有同名远程对象触发。\n阻止不会从日志中移除记录，但不会再向服务器发送请求。",
    ["Click to stop blocking remotes.\nBlocking a remote won't remove it from SimpleSpy logs, but it will not continue to fire the server."] = "点击取消所有阻止。\n阻止不会从日志中移除记录，但不会再向服务器发送请求。",
    ["Decompile source script"] = "反编译来源脚本",
    ["Joins The Simple Spy Discord"] = "加入SimpleSpy的Discord群",
    ["Load's Simple Spy V2.2"] = "加载SimpleSpy V2.2",
    ["Load's Simple Spy V3"] = "加载SimpleSpy V3",
    ["You dont need a discription you already know what it does"] = "你不需要说明，你已经知道它是干什么的",
    
    ["Spy"] = "监听",
}

local function tryMatchPattern(text)
    if text:find("^%[ENABLED%] Toggle function info") or text:find("^%[DISABLED%] Toggle function info") then
        local state = text:find("^%[ENABLED%]") and "[已启用]" or "[已禁用]"
        return state .. " 切换函数信息记录（部分游戏中可能引起卡顿）"
    end
    if text:find("Intelligently detects and excludes spammy remote calls from logs") then
        local state = text:find("^%[ENABLED%]") and "[已启用]" or "[已禁用]"
        return state .. " [测试] 智能检测并排除刷屏式远程调用"
    end
    if text:find("Log remotes fired by the client") then
        local state = text:find("^%[ENABLED%]") and "[已启用]" or "[已禁用]"
        return state .. " 记录客户端主动触发的远程调用"
    end
    if text:find("Display more remoteinfo") then
        local state = text:find("^%[ENABLED%]") and "[已启用]" or "[已禁用]"
        return state .. " 显示更多远程调用详细信息"
    end
    if text:find("^Execution error!") then
        return "执行出错！" .. (text:match("\n(.*)$") or "")
    end
    if text:find("^Executed successfully!") then
        return "执行成功！" .. (text:match("\n(.*)$") or "")
    end
    return nil
end

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

loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/refs/heads/main/SimpleSpyV3/main.lua"))()

task.wait(0.5)

pcall(watchContainer, game:GetService("CoreGui"))
pcall(watchContainer, game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
