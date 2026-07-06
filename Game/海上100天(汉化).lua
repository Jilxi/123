local textMap = {
    ["Rayfield Settings"] = "Rayfield 设置",
    ["Anonymised Analytics"] = "匿名数据分析",
    ["Rayfield Keybind"] = "Rayfield 热键",
    ["General"] = "常规",
    ["System"] = "系统",
    ["Search this page"] = "在此页面搜索",
    ["Loading Saved Configuration"] = "正在加载保存的配置",
    ["ZHUB | 100 Days At Sea"] = "由Tailor汉化 | 海上 100 天",
    ["ZHUB Loading..."] = "ZHUB 加载中...",
    ["by ZHUB Team"] = "由 ZHUB 团队制作",
    ["Rayfield UI"] = "Rayfield 界面",
    ["Change the link in the loadstring from github to https://sirius.menu/rayfield"] = "请将 loadstring 中的链接从 github 更改为 https://sirius.menu/rayfield",
    ["If you are the script author"] = "如果您是脚本作者",
    ["Notify the script author where possible to ensure their version of Rayfield is updated."] = "请尽可能通知脚本作者，以确保他们更新 Rayfield 版本。",
    ["If you are not the script author"] = "如果您不是脚本作者",
    ["Automation"] = "自动化",
    ["⚔️ Weapon"] = "⚔️ 武器",
    ["⚙️ Misc"] = "⚙️ 杂项",
    ["🌾 Farming"] = "🌾 刷级/收集",
    ["👁️ ESP"] = "👁️ 透视",
    ["👤 Player"] = "👤 玩家",
    ["📋 Credits"] = "📋 制作人员",
    ["🗺️ Teleport"] = "🗺️ 传送",
    ["Auto Attack"] = "自动攻击",
    ["Auto Attack (Nearest Mob)"] = "自动攻击（最近怪物）",
    ["Auto Attack Delay"] = "自动攻击延迟",
    ["Infinite Harpoon Range"] = "无限鱼叉范围",
    ["Harpoon"] = "鱼叉",
    ["Aimlock"] = "自瞄锁定",
    ["Select Target Mob"] = "选择目标怪物",
    ["🔄 Refresh Mobs List"] = "🔄 刷新怪物列表",
    ["Camera Distance"] = "相机距离",
    ["Click Teleport (Hold CTRL)"] = "点击传送（按住 CTRL）",
    ["Field of View"] = "视野 (FOV)",
    ["Fullbright"] = "全局高亮 (夜视)",
    ["Click Features"] = "点击功能",
    ["World"] = "世界",
    ["Third Person"] = "第三人称",
    ["Auto Chest Farm"] = "自动刷箱子",
    ["Auto Collect Debris"] = "自动收集碎片",
    ["Auto Press E (Proximity Prompts)"] = "自动按 E（触发交互）",
    ["Collect Delay (seconds)"] = "收集延迟（秒）",
    ["Farm Delay (seconds)"] = "刷怪/刷箱延迟（秒）",
    ["Mob Farm Delay"] = "刷怪延迟",
    ["Reset Opened Chests List"] = "重置已开箱子列表",
    ["Auto Farm Mobs"] = "自动刷怪",
    ["Debris Collection"] = "碎片收集",
    ["Chest Farming"] = "刷箱子",
    ["Skip Opened Chests"] = "跳过已开箱子",
    ["Teleport All Debris to Me"] = "传送所有碎片到我这里",
    ["⚡ Open ALL Chests"] = "⚡ 打开所有箱子",
    ["Chest ESP"] = "箱子透视",
    ["ESP Max Distance"] = "透视最大距离",
    ["Item ESP"] = "物品透视",
    ["Mob ESP"] = "怪物透视",
    ["Player ESP"] = "玩家透视",
    ["Display Options"] = "显示选项",
    ["Item & Player ESP"] = "物品与玩家透视",
    ["Fly"] = "飞行",
    ["God Mode"] = "上帝模式 (无敌)",
    ["Infinite Jump"] = "无限跳跃",
    ["Instant Interact"] = "瞬间交互",
    ["Instant Proximity Prompts"] = "瞬间触发交互 (秒按E)",
    ["No Clip"] = "穿墙",
    ["No Fall Damage"] = "无坠落伤害",
    ["Health"] = "生命值",
    ["Movement"] = "移动",
    ["Interaction"] = "交互",
    ["Speed Hack"] = "速度修改",
    ["Walk Speed"] = "行走速度",
    ["Chest Teleport"] = "箱子传送",
    ["Player Teleport"] = "玩家传送",
    ["Debris Teleport"] = "碎片传送",
    ["Select Chest"] = "选择箱子",
    ["None"] = "无",
    ["Select Debris"] = "选择碎片",
    ["Select Player"] = "选择玩家",
    ["Teleport to Chest"] = "传送到箱子",
    ["Teleport to Debris"] = "传送到碎片",
    ["Teleport to Player"] = "传送到玩家",
    ["🔄 Refresh Chests List"] = "🔄 刷新箱子列表",
    ["🔄 Refresh Debris List"] = "🔄 刷新碎片列表",
    ["🔄 Refresh Player List"] = "🔄 刷新玩家列表",
    ["Script Info"] = "脚本信息",
    ["ZHUB | 100 Days At Sea V2.1"] = "ZHUB | 海上 100 天 V2.1",
    ["Created by ZHUB Team\nUI: Rayfield\n\nChanges in V2.1:\n✅ Added: Open ALL Chests button\n🗑️ Removed: Bring Player to Me\n✅ Chest farm skips opened chests\n✅ All previous V2.0 features retained"] = "由 ZHUB 团队制作\nUI: Rayfield\n\nV2.1 更新日志:\n✅ 新增: 打开所有箱子按钮\n🗑️ 移除: 将玩家传送到我身边\n✅ 刷箱子功能将跳过已打开的箱子\n✅ 保留了 V2.0 的所有功能",
    ["Reset Aimbot System"] = "重置自瞄系统",
    ["Color Picker"] = "颜色选择器",
    ["Dropdown"] = "下拉菜单",
    ["Dynamic Input"] = "动态输入",
    ["Target Player"] = "目标玩家",
    ["Keybind"] = "按键绑定",
    ["Target Keybind"] = "目标按键",
    ["Paragraph Title"] = "段落标题",
    ["Aimbot"] = "自瞄",
    ["ESP Range"] = "透视范围",
    ["Enable Tracers"] = "启用追踪线",
}

local mt = getrawmetatable(game)
local oldIndex = mt.__newindex
setreadonly(mt, false)

mt.__newindex = newcclosure(function(t, k, v)
    if k == "Text" and (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) then
        local new = textMap[v]
        if new then v = new end
    elseif k == "PlaceholderText" and t:IsA("TextBox") then
        local new = textMap[v]
        if new then v = new end
    elseif k == "Title" and (t:IsA("TextButton") or t:IsA("Frame")) then
        local new = textMap[v]
        if new then v = new end
    end
    return oldIndex(t, k, v)
end)

setreadonly(mt, true)

loadstring(game:HttpGet("https://raw.githubusercontent.com/Notzephyr/UIX/refs/heads/main/100DaysAtSea.lua"))()
