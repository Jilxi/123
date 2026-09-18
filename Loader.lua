local url = "https://raw.githubusercontent.com/Jilxi/123/refs/heads/main/A%C3%BD%C3%BD%C3%AE%C3%BD%C3%BD-obfuscated.lua"

local function nativeNotify(title, text, duration)
    local StarterGui = game:GetService("StarterGui")
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 4,
        })
    end)
end

nativeNotify("Tailor Hub", "正在加载", 3)

local ok, result = pcall(function()
    local src = game:HttpGet(url, true)
    local chunk = loadstring(src)
    if not chunk then
        error("编译失败")
    end
    return chunk()
end)

if not ok then
    nativeNotify("Tailor Hub", "加载失败：" .. tostring(result), 5)
end
