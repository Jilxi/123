local textMap = {
    ["Dex++"] = "Dex++",
    ["Explorer"] = "对象浏览器",
    ["Properties"] = "属性",
    ["Click part to select"] = "点击部件以选中",
    ["Notepad"] = "记事本",
    ["Console"] = "控制台",
    ["Save Instance"] = "保存实例",
    ["3D Viewer"] = "3D预览",
    ["3D Preview"] = "3D预览",
    ["Save As"] = "另存为",
    ["Name"] = "名称",
    ["Cancel"] = "取消",
    ["Save"] = "保存",
    ["OK"] = "确定",
    ["Close"] = "关闭",
    ["Reset"] = "重置",
    ["Delete"] = "删除",
    ["Type"] = "类型",
    ["Search"] = "搜索",
    ["Cut"] = "剪切",
    ["Copy"] = "复制",
    ["Paste Into"] = "粘贴到此处",
    ["Duplicate"] = "克隆",
    ["Delete Children"] = "删除所有子项",
    ["Rename"] = "重命名",
    ["Group"] = "编组",
    ["Ungroup"] = "取消编组",
    ["Select Children"] = "选择所有子项",
    ["Jump to Parent"] = "跳转到父级",
    ["Expand All"] = "全部展开",
    ["Collapse All"] = "全部折叠",
    ["Clear Search and Jump to"] = "清除搜索并跳转",
    ["Copy Path"] = "复制路径",
    ["Insert Object"] = "插入对象",
    ["Save to File"] = "保存到文件",
    ["Copy Roblox API Page URL"] = "复制Roblox API页面链接",
    ["3D Preview Object"] = "3D预览对象",
    ["View Object (Right click to reset)"] = "查看对象（右键重置）",
    ["View Script"] = "查看脚本",
    ["Dump Functions"] = "转储函数",
    ["Fire TouchTransmitter"] = "触发TouchTransmitter",
    ["Fire ClickDetector"] = "触发ClickDetector",
    ["Fire ProximityPrompt"] = "触发ProximityPrompt",
    ["Block From Firing"] = "屏蔽触发",
    ["Unblock"] = "取消屏蔽",
    ["Save Script"] = "保存脚本",
    ["Save Script Bytecode"] = "保存脚本字节码",
    ["Select Character"] = "选择角色",
    ["View Player"] = "查看玩家",
    ["Select Local Player"] = "选择本地玩家",
    ["Select All Characters"] = "选择所有角色",
    ["Refresh Nil Instances"] = "刷新Nil实例",
    ["Hide Nil Instances"] = "隐藏Nil实例",
    ["Play Tween"] = "播放Tween",
    ["Load Animation"] = "加载动画",
    ["Stop Animation"] = "停止动画",
    ["Teleport To"] = "传送到此",
    ["Search workspace"] = "搜索工作区",
    ["Search properties"] = "搜索属性",
    ["Add Attribute"] = "添加属性",
    ["Edit"] = "编辑",
    ["Basic Colors"] = "基本颜色",
    ["Custom Colors (RC = Set)"] = "自定义颜色（右键=设置）",
    ["More Colors"] = "更多颜色",
    ["Red:"] = "红:",
    ["Green:"] = "绿:",
    ["Blue:"] = "蓝:",
    ["Hue:"] = "色相:",
    ["Sat:"] = "饱和度:",
    ["Val:"] = "明度:",
    ["Time"] = "时间",
    ["Value"] = "数值",
    ["Envelope"] = "包络",
    ["Color"] = "颜色",
    ["Run a command"] = "输入命令",
    ["Clear"] = "清空",
    ["Ctrl Scroll"] = "Ctrl滚动缩放",
    ["Auto Scroll"] = "自动滚动",
    ["Size"] = "字号",
    ["Copy to Clipboard"] = "复制到剪贴板",
    ["Execute"] = "执行",
    ["Decompile Scripts (LocalScript and ModuleScript)"] = "反编译脚本（LocalScript与ModuleScript）",
    ["Decompile Timeout (s)"] = "反编译超时(秒)",
    ["Decompiler Max Threads"] = "反编译最大线程数",
    ["Decompile Ignore"] = "反编译忽略项",
    ["Save Nil Instances"] = "保存Nil实例",
    ["Remove Player Characters"] = "移除玩家角色",
    ["Save Player Instance"] = "保存Player实例",
    ["Isolate StarterPlayer"] = "隔离StarterPlayer",
    ["Ignore Default Properties"] = "忽略默认属性",
    ["Show Status"] = "显示状态",
    ["Stop Viewing"] = "停止预览",
    ["Exit"] = "退出",
    ["Refresh"] = "刷新",
    ["Enable Auto Refresh"] = "启用自动刷新",
    ["Disable Auto Refresh"] = "禁用自动刷新",
    ["Enable Auto Rotate"] = "启用自动旋转",
    ["Disable Auto Rotate"] = "禁用自动旋转",
    ["Lock Camera"] = "锁定相机",
    ["Unlock Camera"] = "解锁相机",
    ["Zoom In"] = "放大",
    ["Zoom Out"] = "缩小",
    ["Ultimate Debugging Suite"] = "终极调试套件",
    ["Fetching API"] = "正在获取API",
    ["Fetching RMD"] = "正在获取RMD",
    ["Loading Modules"] = "正在加载模块",
    ["Initializing Modules"] = "正在初始化模块",
    ["Complete"] = "完成",
    ["Developed by Chillz."] = "开发者：Chillz",
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

loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()

task.wait(0.5)

pcall(watchContainer, game:GetService("CoreGui"))
pcall(watchContainer, game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
