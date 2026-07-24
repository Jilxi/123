--[[
local textMap = {
    ["Main"] = "主页",
    ["Player"] = "玩家",
    ["Visuals"] = "视觉效果",
    ["Misc"] = "杂项",
    ["Cheats"] = "功能",
    ["Controls"] = "按键设置",
    ["Locations"] = "位置",
    ["Settings"] = "设置",
    ["Changelog"] = "更新日志",
    ["SHOP"] = "商店",
    ["POWER STATION"] = "发电站",
    ["SAFE HOUSE"] = "安全屋",
    ["BASE CAMP"] = "基地营",
    ["OBSERVATION TOWER"] = "瞭望塔",
    ["JUMPSCARE SCENE"] = "惊吓场景",
    ["FLAT ISLAND"] = "平坦岛",
    ["OUTSIDE MAP"] = "地图外",
    ["LIGHTING"] = "光照",
    ["BRIGHTNESS"] = "亮度",
    ["FULLBRIGHT"] = "全亮",
    ["ENVIRONMENT"] = "环境",
    ["NO FOG"] = "无雾",
    ["DAY TIME"] = "白天",
    ["BACKPACK & FALL ANIMATION"] = "背包与坠落动画",
    ["OFF"] = "关",
    ["ON"] = "开",
    ["KEEP BACKPACK ENABLED"] = "保持背包显示",
    ["NO FALL ANIMATION"] = "无坠落动画",
    ["INTERACTION"] = "交互",
    ["ENABLE CHAT"] = "启用聊天",
    ["EXTENDED PROMPTS"] = "扩展提示",
    ["NO LINE OF SIGHT"] = "无视线限制",
    ["INSTANT PROMPTS"] = "即时提示",
    ["DISPLAYS"] = "显示信息",
    ["DISPLAY TIMER"] = "显示计时器",
    ["DISPLAY POWER"] = "显示电量",
    ["DISPLAY RAKE TARGET"] = "显示Rake目标",
    ["DISPLAY RAKE HEALTH"] = "显示Rake血量",
    ["DISPLAY DISTANCE TRAVELLED"] = "显示行走距离",
    ["DISPLAY OTHERS UV STATS"] = "显示他人UV数据",
    ["CHARACTER"] = "角色",
    ["SPEED VALUE"] = "速度数值",
    ["SPEED"] = "速度",
    ["SPEED BYPASS (BETA)"] = "速度绕过（测试版）",
    ["JUMP HEIGHT VALUE"] = "跳跃高度数值",
    ["JUMP HEIGHT"] = "跳跃高度",
    ["HIP HEIGHT VALUE"] = "髋部高度数值",
    ["HIP HEIGHT"] = "髋部高度",
    ["FLY SPEED"] = "飞行速度",
    ["FLY"] = "飞行",
    ["INFINITE"] = "无限",
    ["INFINITE JUMP"] = "无限跳跃",
    ["INFINITE STAMINA"] = "无限体力",
    ["INFINITE NIGHT VISION"] = "无限夜视",
    ["DISABLERS"] = "禁用器",
    ["NO FALL DAMAGE"] = "无坠落伤害",
    ["NO JUMP COOLDOWN"] = "无跳跃冷却",
    ["NO PLAYER COLLISIONS"] = "无玩家碰撞",
    ["NOCLIP"] = "穿墙",
    ["SPRINT"] = "冲刺",
    ["SPRINT SPEED VALUE"] = "冲刺速度数值",
    ["ANTI-VOID"] = "防虚空",
    ["ADORNS"] = "装饰",
    ["BOXHANDLEADORMENTS"] = "箱形装饰",
    ["ESPS"] = "ESP",
    ["ESP TEXT SIZE"] = "ESP文字大小",
    ["RAKE ESP"] = "Rake ESP",
    ["SHOW RAKE HP"] = "显示Rake血量",
    ["SHOW RAKE DISTANCE"] = "显示Rake距离",
    ["SHOW RAKE HIGHLICHTS"] = "显示Rake高亮",
    ["PLAYER ESP"] = "玩家ESP",
    ["SHOW PLAYERS HP"] = "显示玩家血量",
    ["SHOW PLAYERS DISTANCE"] = "显示玩家距离",
    ["SHOW PLAYERS DISTANCE TRAVELLED"] = "显示玩家行走距离",
    ["SHOW PLAYERS INVENTORY"] = "显示玩家背包",
    ["SHOW PLAYERS HICHLIGHTS"] = "显示玩家高亮",
    ["PLACES ESP"] = "地点ESP",
    ["SHOW PLACE DISTANCE"] = "显示地点距离",
    ["SHOW PALLET HP"] = "显示托盘血量",
    ["SCRAP ESP"] = "废料ESP",
    ["SHOW SCRAP LEVEL"] = "显示废料等级",
    ["SHOW SCRAP POINTS"] = "显示废料点数",
    ["SHOW SCRAP DISTANCE"] = "显示废料距离",
    ["SHOW SCRAP HIGHLIGHTS"] = "显示废料高亮",
    ["RUSTY TRAP ESP"] = "生锈陷阱ESP",
    ["SHOW RUSTY TRAP DISTANCE"] = "显示生锈陷阱距离",
    ["SHOW RUSTY TRAP HIGHLIGHTS"] = "显示生锈陷阱高亮",
    ["RAKE TRAP ESP"] = "Rake陷阱ESP",
    ["SHOW RAKE TRAP DISTANCE"] = "显示Rake陷阱距离",
    ["SHOW RAKE TRAP HICHLICHTS"] = "显示Rake陷阱高亮",
    ["FLARE GUN ESP"] = "信号枪ESP",
    ["SHOW FLARE GUN DISTANCE"] = "显示信号枪距离",
    ["SHOW FLARE GUN HIGHLIGHTS"] = "显示信号枪高亮",
    ["SUPPLY DROP ESP"] = "补给箱ESP",
    ["SHOW SUPPLY DROP ITEMS"] = "显示补给箱物品",
    ["SHOW SUPPLY DROP DISTANCE"] = "显示补给箱距离",
    ["SHOW SUPPLY DROP HICHLIGHTS"] = "显示补给箱高亮",
    ["EFFECTS"] = "效果",
    ["DISABLE CAMERA SHAKE"] = "禁用相机抖动",
    ["DISABLE JUMPSCARE SNAP"] = "禁用惊吓定格",
    ["CAMERA & PATHFIND"] = "相机与寻路",
    ["UNLOCK ZOOM"] = "解锁缩放",
    ["FIELD OF VIEW"] = "视野",
    ["FIELD OF VIEW MODES"] = "视野模式",
    ["DEFAULT"] = "默认",
    ["GAME"] = "游戏",
    ["FIELD OF VIEW VALUE"] = "视野数值",
    ["FREE CAMERA"] = "自由相机",
    ["SPECTATE"] = "观战",
    ["CAMERA SENSITIVITY"] = "相机灵敏度",
    ["CAMERA SPEED"] = "相机速度",
    ["RAKE PATHEIND"] = "Rake寻路",
    ["NO BOBBING"] = "禁用摇晃",
    ["NOTIFIERS"] = "通知",
    ["BLOOD HOUR NOTIFIER"] = "血之时刻通知",
    ["FLARE GUN NOTIFIER"] = "信号枪通知",
    ["GAMEPASSES"] = "游戏通行证",
    ["UPGRADED FLASHLIGHT"] = "升级手电筒",
    ["NICHT VISION COGGLES"] = "夜视镜",
    ["UNLOCK SIXTH SENSE"] = "解锁第六感",
    ["TELEPORTS &FPS"] = "传送与帧率",
    ["BRING SCRAPS"] = "传送废料到身边",
    ["SELL SCRAPS"] = "出售废料",
    ["GET RADIO"] = "获取收音机",
    ["SHOW FPS"] = "显示帧率",
    ["ENVIROMENT & PERFORMANCE"] = "环境与性能",
    ["PLAY CAVE SOUNDS"] = "播放洞穴音效",
    ["DISABLE TREE CROWNS"] = "禁用树冠",
    ["DISABLE MATERIALS"] = "禁用材质",
    ["STUN STICK MODIEIERS"] = "电棍修改",
    ["RANCE"] = "范围",
    ["STUN STICK HIT RANGE"] = "电棍攻击范围",
    ["HIT FASTER"] = "加快攻击",
    ["REMOVE MALFUNCTION"] = "移除故障",
    ["AUTO STUN STICK"] = "自动电棍",
    ["ITEMS"] = "物品",
    ["KEEP ITEM ON SPAWN"] = "复活保留物品",
    ["ITEM TO KEEP"] = "保留的物品",
    ["Stun Stick"] = "电棍",
    ["UV Lamp"] = "紫外线灯",
    ["Flare Gun"] = "信号枪",
    ["Radio"] = "收音机",
    ["INSTA OPEN, TELEPORTS & CONVEYORS"] = "瞬间开启、传送与传送带",
    ["INSTANTLY OPEN SUPPLY DROP"] = "瞬间开启补给箱",
    ["TELEPORT BEHIND RAKE"] = "传送至Rake背后",
    ["HIDE BELOW MAP"] = "隐藏至地图下方",
    ["DISABLE CONVEYORS"] = "禁用传送带",
    ["ANTI & FLING"] = "防护与抛飞",
    ["ANTI-SHOCK"] = "防震击",
    ["ANTI-TRAPS"] = "防陷阱",
    ["FLING"] = "抛飞",
    ["AUTO"] = "自动",
    ["AUTO COLLECT STUN STICK"] = "自动收集电棍",
    ["AUTO COLLECT UV LAMP"] = "自动收集紫外线灯",
    ["AUTO COLLECT VEST"] = "自动收集防弹衣",
    ["HP REOUIREMENT"] = "血量要求",
    ["AUTO HEAL"] = "自动治疗",
    ["AUTO POWER STATION"] = "自动发电站",
    ["AUTO GET FLARE GUN"] = "自动获取信号枪",
    ["AUTO GET SCRAPS"] = "自动获取废料",
    ["COMBAT"] = "战斗",
    ["FIXED"] = "固定",
    ["SPEED COMPENSATION"] = "速度补偿",
    ["SHIELD STUDS RANGE"] = "护盾范围",
    ["RAKE SHIELD"] = "Rake护盾",
    ["INSTANT KILL RAKE (TRAP REQUIRED)"] = "瞬杀Rake（需要陷阱）",
    ["OBTECT CONTROI"] = "物体控制",
    ["CONTROL MODES"] = "控制模式",
    ["THROW POWER"] = "投掷力度",
    ["CONTROL OBJECTS"] = "控制物体",
    ["FEEDBACK"] = "反馈",
    ["SEND FEEDBACK"] = "发送反馈",
    ["SERVER"] = "服务器",
    ["SERVER HOP"] = "跳服",
    ["REJOIN"] = "重新加入",
    ["CONFIGURATIONS"] = "配置",
    ["SAVE CONFIG"] = "保存配置",
    ["LOAD CONFIG"] = "加载配置",
    ["GUI"] = "界面",
    ["UNLOAD GUI"] = "卸载界面",
    ["OBSERVATION TOWER TRAPDOOR"] = "瞭望塔活板门",
    ["OPEN OBSERVATION TOWER TRAPDOOR"] = "打开瞭望塔活板门",
    ["KNOCK OBSERVATION TOWER TRAPDOOR"] = "敲击瞭望塔活板门",
    ["SWITCH OBSERVATION TOWER LIGHTS"] = "切换瞭望塔灯光",
    ["SWITCH OBSERVATION TOWER RADAR"] = "切换瞭望塔雷达",
    ["SWITCH SAFE HOUSE DOOR LEVER"] = "切换安全屋门杠杆",
    ["SWITCH SAFE HOUSE LICHT LEVER"] = "切换安全屋灯杠杆",
    ["KNOCK SAFE HOUSE DOOR"] = "敲击安全屋门",
    ["GET FLUNG"] = "被抛飞",
    ["INSTANTLY FREE FROM TRAP"] = "瞬间脱离陷阱",
    ["TAKE DAMAGE"] = "受到伤害",
    ["TAKE FULL DAMAGE"] = "受到全额伤害",
    ["NORMAL"] = "正常",
    ["HURT"] = "受伤",
    ["INJURED"] = "重伤",
    ["CRAWL"] = "爬行",
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

loadstring(game:HttpGet("https://raw.githubusercontent.com/lqdxt/Loader/refs/heads/main/Vyrnox_Hub.lua"))()

task.wait(1.0)

pcall(watchContainer, game:GetService("CoreGui"))
pcall(watchContainer, game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
]]

local StarterGui = game:GetService("StarterGui")

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "通知",
        Text = "老外已删库",
        Icon = "",
        Duration = 5
    })
end)
