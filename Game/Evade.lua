local StarterGui = game:GetService("StarterGui")

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "通知",
        Text = "已删除,脚本已过时",
        Icon = "",
        Duration = 5
    })
end)
