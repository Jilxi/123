local HttpService = game:GetService("HttpService")

local ScriptLoader = {}

local GITHUB_USER = "Jilxi"
local GITHUB_REPO = "123"
local GITHUB_FOLDER = "123/Game"
local GITHUB_BRANCH = "main"

local cache = {
    fileList = nil,
    fileUrls = {},
    lastFetch = 0,
    cooldown = 30
}

function ScriptLoader:GetFileList()
    local now = tick()
    if cache.fileList and (now - cache.lastFetch) < cache.cooldown then
        return cache.fileList, cache.fileUrls
    end

    local apiUrl = string.format(
        "https://api.github.com/repos/%s/%s/contents/%s?ref=%s",
        GITHUB_USER, GITHUB_REPO, GITHUB_FOLDER, GITHUB_BRANCH
    )

    local ok, result = pcall(function()
        return request({
            Url = apiUrl,
            Method = "GET",
            Headers = { ["Accept"] = "application/vnd.github.v3+json" }
        })
    end)

    if not ok or not result or result.StatusCode ~= 200 then
        return nil, nil, "获取文件列表失败: " .. tostring(result and result.StatusCode or "无响应")
    end

    local data = HttpService:JSONDecode(result.Body)
    local names = {}
    local urls = {}

    for _, item in pairs(data) do
        if item.type == "file" and item.name:match("%.lua$") then
            if item.name ~= "ScriptLoader.lua" then
                table.insert(names, item.name)
                urls[item.name] = item.download_url
            end
        end
    end

    cache.fileList = names
    cache.fileUrls = urls
    cache.lastFetch = now

    return names, urls
end

function ScriptLoader:Execute(fileName)
    local _, urls, err = self:GetFileList()
    if err then return false, err end

    local url = urls[fileName]
    if not url then return false, "找不到文件: " .. fileName end

    local ok, result = pcall(function()
        return request({
            Url = url,
            Method = "GET"
        })
    end)

    if not ok or not result or result.StatusCode ~= 200 then
        return false, "下载失败: " .. tostring(result and result.StatusCode or "无响应")
    end

    local fn, parseErr = loadstring(result.Body)
    if not fn then
        return false, "解析失败: " .. tostring(parseErr)
    end

    local success, runErr = pcall(fn)
    if not success then
        return false, "执行失败: " .. tostring(runErr)
    end

    return true
end

function ScriptLoader:ClearCache()
    cache.fileList = nil
    cache.fileUrls = {}
    cache.lastFetch = 0
end

return ScriptLoader
