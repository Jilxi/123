do
local a="TailorHub_MiniInvite_Toast"
local b="TailorHub_Invite_Dismissed.txt"
local c="DISMISSED_V1"
local d="687742398"
local function e(n1)
local o1,s1=pcall(function()
local cf=type(cloneref)=="function" and cloneref or function(w1)return w1 end
return cf(game:GetService(n1))
end)
return o1 and s1 or nil
end
local f=e("TweenService")
local g=e("Players")
local h=e("GuiService")
local i=e("CoreGui")
if not f or not g then return end
local function j()
if type(isfile)=="function" and type(readfile)=="function" then
local o1,r1=pcall(function()
if isfile(b) then
local t0=readfile(b)
if type(t0)=="string" then
t0=string.gsub(t0,"^%s*(.-)%s*$","%1")
return t0==c
end
end
return false
end)
if o1 and r1==true then return true end
end
return false
end
local function k()
if type(writefile)=="function" then
pcall(function() writefile(b,c) end)
end
end
if j() then return end
local function l()
if type(gethui)=="function" then
local o1,r1=pcall(gethui)
if o1 and typeof(r1)=="Instance" then return r1 end
end
if i then
local o1=pcall(function() return i.Name end)
if o1 then return i end
end
local lp=g.LocalPlayer
if not lp then
local wc=0
while not g.LocalPlayer and wc<50 do task.wait(0.1) wc=wc+1 end
lp=g.LocalPlayer
end
if lp then
local o1,pg=pcall(function() return lp:WaitForChild("PlayerGui",5) end)
if o1 and pg then return pg end
end
return nil
end
local m=l()
if not m then return end
pcall(function()
for _,ch in ipairs(m:GetChildren()) do
if ch.Name==a and ch:IsA("ScreenGui") then ch:Destroy() end
end
end)
local n=0
if h then
pcall(function()
local it=h:GetGuiInset()
if it and it.Y>0 then n=it.Y end
end)
end
local o=math.max(n+12,48)
local p=1
pcall(function()
local cam=workspace.CurrentCamera
if cam then
local vp=cam.ViewportSize
local md=math.min(vp.X,vp.Y)
if md>0 and md<500 then p=math.clamp(md/500,0.85,1) end
end
end)
local q={CardBg=Color3.fromRGB(26,27,30),CardStroke=Color3.fromRGB(58,60,66),TitleText=Color3.fromRGB(242,243,245),TagText=Color3.fromRGB(148,152,160),TagBg=Color3.fromRGB(38,40,45),SubText=Color3.fromRGB(168,172,180),PrimaryBtnBg=Color3.fromRGB(54,57,63),PrimaryBtnHover=Color3.fromRGB(68,72,79),PrimaryBtnPress=Color3.fromRGB(44,46,51),PrimaryBtnStroke=Color3.fromRGB(82,86,94),PrimaryBtnText=Color3.fromRGB(242,243,245),SecondaryBtnBg=Color3.fromRGB(35,37,41),SecondaryBtnHover=Color3.fromRGB(45,47,52),SecondaryBtnPress=Color3.fromRGB(29,31,35),SecondaryBtnStroke=Color3.fromRGB(56,58,64),SecondaryBtnText=Color3.fromRGB(176,180,188),SuccessBg=Color3.fromRGB(38,68,52),SuccessStroke=Color3.fromRGB(62,112,84),SuccessText=Color3.fromRGB(218,245,228),FailBg=Color3.fromRGB(74,40,42),FailStroke=Color3.fromRGB(116,62,66),FailText=Color3.fromRGB(245,216,218)}
local r=Instance.new("ScreenGui")
r.Name=a r.ResetOnSpawn=false r.IgnoreGuiInset=true r.DisplayOrder=2147483640 r.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
local t1=UDim2.new(1,-16,0,o)
local t2=UDim2.new(1,44,0,o)
local t3=UDim2.new(1,52,0,o)
local u=Instance.new("Frame")
u.Name="ToastCard" u.AnchorPoint=Vector2.new(1,0) u.Size=UDim2.fromOffset(260,84) u.Position=t2 u.BackgroundColor3=q.CardBg u.BackgroundTransparency=1 u.BorderSizePixel=0 u.Active=true u.Parent=r
local v1=Instance.new("UICorner") v1.CornerRadius=UDim.new(0,8) v1.Parent=u
local v2=Instance.new("UIStroke") v2.ApplyStrokeMode=Enum.ApplyStrokeMode.Border v2.Color=q.CardStroke v2.Thickness=1 v2.Transparency=1 v2.Parent=u
local v3=Instance.new("UIScale") v3.Scale=0.97*p v3.Parent=u
local v4=Instance.new("UIPadding") v4.PaddingTop=UDim.new(0,10) v4.PaddingBottom=UDim.new(0,10) v4.PaddingLeft=UDim.new(0,12) v4.PaddingRight=UDim.new(0,12) v4.Parent=u
local w=Instance.new("Frame") w.Name="Header" w.Size=UDim2.new(1,0,0,16) w.Position=UDim2.fromOffset(0,0) w.BackgroundTransparency=1 w.Parent=u
local x=Instance.new("TextLabel") x.Name="BrandTitle" x.Size=UDim2.new(1,-90,1,0) x.Position=UDim2.fromOffset(0,0) x.BackgroundTransparency=1 x.Font=Enum.Font.GothamBold x.Text="Tailor Hub" x.TextSize=13 x.TextColor3=q.TitleText x.TextTransparency=1 x.TextXAlignment=Enum.TextXAlignment.Left x.TextYAlignment=Enum.TextYAlignment.Center x.TextTruncate=Enum.TextTruncate.AtEnd x.Parent=w
local y=Instance.new("TextLabel") y.Name="GroupBadge" y.AnchorPoint=Vector2.new(1,0.5) y.Position=UDim2.new(1,0,0.5,0) y.Size=UDim2.fromOffset(76,16) y.BackgroundColor3=q.TagBg y.BackgroundTransparency=1 y.BorderSizePixel=0 y.Font=Enum.Font.GothamMedium y.Text=d y.TextSize=11 y.TextColor3=q.TagText y.TextTransparency=1 y.TextXAlignment=Enum.TextXAlignment.Center y.TextYAlignment=Enum.TextYAlignment.Center y.Parent=w
local z=Instance.new("UICorner") z.CornerRadius=UDim.new(0,4) z.Parent=y
local aa=Instance.new("TextLabel") aa.Name="Description" aa.Size=UDim2.new(1,0,0,16) aa.Position=UDim2.fromOffset(0,19) aa.BackgroundTransparency=1 aa.Font=Enum.Font.Gotham aa.Text="加入交流群，获取最新更新。" aa.TextSize=12 aa.TextColor3=q.SubText aa.TextTransparency=1 aa.TextXAlignment=Enum.TextXAlignment.Left aa.TextYAlignment=Enum.TextYAlignment.Center aa.TextTruncate=Enum.TextTruncate.AtEnd aa.Parent=u
local ab=Instance.new("Frame") ab.Name="Actions" ab.AnchorPoint=Vector2.new(0,1) ab.Position=UDim2.new(0,0,1,0) ab.Size=UDim2.new(1,0,0,24) ab.BackgroundTransparency=1 ab.Parent=u
local ac=Instance.new("TextButton") ac.Name="CopyButton" ac.Size=UDim2.new(0.62,-4,1,0) ac.Position=UDim2.fromOffset(0,0) ac.BackgroundColor3=q.PrimaryBtnBg ac.BackgroundTransparency=1 ac.BorderSizePixel=0 ac.AutoButtonColor=false ac.Font=Enum.Font.GothamMedium ac.Text="复制群号" ac.TextSize=12 ac.TextColor3=q.PrimaryBtnText ac.TextTransparency=1 ac.Parent=ab
local ad=Instance.new("UICorner") ad.CornerRadius=UDim.new(0,5) ad.Parent=ac
local ae=Instance.new("UIStroke") ae.ApplyStrokeMode=Enum.ApplyStrokeMode.Border ae.Color=q.PrimaryBtnStroke ae.Thickness=1 ae.Transparency=1 ae.Parent=ac
local af=Instance.new("UIScale") af.Scale=1 af.Parent=ac
local ag=Instance.new("TextButton") ag.Name="CloseButton" ag.AnchorPoint=Vector2.new(1,0) ag.Position=UDim2.new(1,0,0,0) ag.Size=UDim2.new(0.38,-4,1,0) ag.BackgroundColor3=q.SecondaryBtnBg ag.BackgroundTransparency=1 ag.BorderSizePixel=0 ag.AutoButtonColor=false ag.Font=Enum.Font.GothamMedium ag.Text="关闭" ag.TextSize=12 ag.TextColor3=q.SecondaryBtnText ag.TextTransparency=1 ag.Parent=ab
local ah=Instance.new("UICorner") ah.CornerRadius=UDim.new(0,5) ah.Parent=ag
local ai=Instance.new("UIStroke") ai.ApplyStrokeMode=Enum.ApplyStrokeMode.Border ai.Color=q.SecondaryBtnStroke ai.Thickness=1 ai.Transparency=1 ai.Parent=ag
local aj=Instance.new("UIScale") aj.Scale=1 aj.Parent=ag
local po=pcall(function() r.Parent=m end)
if not po then r:Destroy() return end
local ak={} local al={} local am=false local an=0 local ao=false local ap=false local aq=false
local function ar(inst,ti,goal)
if not inst or not inst.Parent then return nil end
local el=ak[inst]
if el then
for pn in pairs(goal) do
local pt=el[pn]
if pt then pcall(function() pt:Cancel() end) end
end
else el={} ak[inst]=el end
local ok,tw=pcall(function() return f:Create(inst,ti,goal) end)
if ok and tw then
for pn in pairs(goal) do el[pn]=tw end
tw:Play() return tw
end
return nil
end
local function as()
for _,cn in ipairs(al) do
if cn and cn.Connected then pcall(function() cn:Disconnect() end) end
end
table.clear(al)
for _,pm in pairs(ak) do
for _,tw in pairs(pm) do pcall(function() tw:Cancel() end) end
end
table.clear(ak)
if r and r.Parent then pcall(function() r:Destroy() end) end
end
table.insert(al,r.AncestryChanged:Connect(function(_,np) if not np and not am then am=true as() end end))
local function at(txt)
local cf=nil
if type(setclipboard)=="function" then cf=setclipboard
elseif type(toclipboard)=="function" then cf=toclipboard
elseif type(Clipboard)=="table" and type(Clipboard.set)=="function" then cf=Clipboard.set
elseif type(syn)=="table" and type(syn.write_clipboard)=="function" then cf=syn.write_clipboard
end
if not cf then return false end
local ok=pcall(cf,txt)
return ok==true
end
local au=TweenInfo.new(0.16,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local av=TweenInfo.new(0.12,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local function aw()
if am or ao then return end
local tb=ap and q.PrimaryBtnHover or q.PrimaryBtnBg
ar(ac,au,{BackgroundColor3=tb,TextColor3=q.PrimaryBtnText})
ar(ae,au,{Color=q.PrimaryBtnStroke})
end
local function ax()
if am then return end
local tb=aq and q.SecondaryBtnHover or q.SecondaryBtnBg
ar(ag,au,{BackgroundColor3=tb,TextColor3=q.SecondaryBtnText})
ar(ai,au,{Color=q.SecondaryBtnStroke})
end
table.insert(al,ac.MouseEnter:Connect(function() if am then return end ap=true aw() end))
table.insert(al,ac.MouseLeave:Connect(function() if am then return end ap=false ar(af,av,{Scale=1}) aw() end))
table.insert(al,ac.MouseButton1Down:Connect(function() if am then return end ar(af,av,{Scale=0.96}) if not ao then ar(ac,au,{BackgroundColor3=q.PrimaryBtnPress}) end end))
table.insert(al,ac.MouseButton1Up:Connect(function() if am then return end ar(af,av,{Scale=1}) aw() end))
table.insert(al,ac.Activated:Connect(function()
if am then return end
ar(af,TweenInfo.new(0.08,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=0.96})
task.delay(0.08,function() if not am then ar(af,av,{Scale=1}) end end)
local cp=at(d) an=an+1 local ct=an ao=true
if cp then
ac.Text="已复制群号"
ar(ac,au,{BackgroundColor3=q.SuccessBg,TextColor3=q.SuccessText})
ar(ae,au,{Color=q.SuccessStroke})
else
ac.Text="复制失败"
ar(ac,au,{BackgroundColor3=q.FailBg,TextColor3=q.FailText})
ar(ae,au,{Color=q.FailStroke})
end
task.delay(1.4,function()
if am or an~=ct then return end
ao=false
if ac and ac.Parent then ac.Text="复制群号" aw() end
end)
end))
table.insert(al,ag.MouseEnter:Connect(function() if am then return end aq=true ax() end))
table.insert(al,ag.MouseLeave:Connect(function() if am then return end aq=false ar(aj,av,{Scale=1}) ax() end))
table.insert(al,ag.MouseButton1Down:Connect(function() if am then return end ar(aj,av,{Scale=0.96}) ar(ag,au,{BackgroundColor3=q.SecondaryBtnPress}) end))
table.insert(al,ag.MouseButton1Up:Connect(function() if am then return end ar(aj,av,{Scale=1}) ax() end))
local function ay()
if am then return end
am=true k()
local bb=TweenInfo.new(0.11,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
ar(v3,bb,{Scale=0.95*p})
ar(aj,bb,{Scale=0.95})
task.delay(0.09,function()
if not r or not r.Parent then as() return end
local bc=TweenInfo.new(0.28,Enum.EasingStyle.Quint,Enum.EasingDirection.In)
local bd=TweenInfo.new(0.24,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local et=ar(u,bc,{Position=t3,BackgroundTransparency=1})
ar(v2,bd,{Transparency=1})
ar(x,bd,{TextTransparency=1})
ar(y,bd,{BackgroundTransparency=1,TextTransparency=1})
ar(aa,bd,{TextTransparency=1})
ar(ac,bd,{BackgroundTransparency=1,TextTransparency=1})
ar(ae,bd,{Transparency=1})
ar(ag,bd,{BackgroundTransparency=1,TextTransparency=1})
ar(ai,bd,{Transparency=1})
if et then
local cc
cc=et.Completed:Connect(function() if cc then cc:Disconnect() end as() end)
table.insert(al,cc)
else task.delay(0.3,as) end
end)
end
table.insert(al,ag.Activated:Connect(ay))
local az=TweenInfo.new(0.38,Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
local ba=TweenInfo.new(0.32,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
ar(u,az,{Position=t1,BackgroundTransparency=0.04})
ar(v3,az,{Scale=1*p})
ar(v2,ba,{Transparency=0.25})
ar(x,ba,{TextTransparency=0})
ar(y,ba,{BackgroundTransparency=0.15,TextTransparency=0})
ar(aa,ba,{TextTransparency=0})
ar(ac,ba,{BackgroundTransparency=0,TextTransparency=0})
ar(ae,ba,{Transparency=0.35})
ar(ag,ba,{BackgroundTransparency=0,TextTransparency=0})
ar(ai,ba,{Transparency=0.4})
end
