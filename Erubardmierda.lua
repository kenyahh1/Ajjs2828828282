local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace        = game:GetService("Workspace")
local Lighting         = game:GetService("Lighting")
local TweenService     = game:GetService("TweenService")
local LocalPlayer      = Players.LocalPlayer

local ACCENT     = Color3.fromHex("#9d56ff")
local BG_DARK    = Color3.fromRGB(3, 3, 3)
local BG_ELEM    = Color3.fromRGB(15, 15, 15)
local TEXT_WHITE = Color3.fromRGB(255, 255, 255)
local TEXT_GRAY  = Color3.fromRGB(112, 112, 112)
local OUTLINE    = Color3.fromRGB(26, 26, 26)

local function getGuiParent()
    if gethui then return gethui() end
    local ok, cg = pcall(function() return game:GetService("CoreGui") end)
    if ok and cg then return cg end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local VxnityUI = {}
VxnityUI.__index = VxnityUI

function VxnityUI:Notify(o)
    local parent = getGuiParent()
    local prev   = parent:FindFirstChild("VNotif")
    if prev then prev:Destroy() end
    local gui   = Instance.new("ScreenGui")
    gui.Name    = "VNotif"
    gui.ResetOnSpawn  = false
    gui.IgnoreGuiInset = true
    gui.Parent  = parent
    local f = Instance.new("Frame", gui)
    f.Size = UDim2.fromOffset(270, 56)
    f.BackgroundColor3 = Color3.fromRGB(10,10,10)
    f.BorderSizePixel  = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,8)
    local st = Instance.new("UIStroke", f)
    st.Color = ACCENT; st.Thickness = 1.5
    local tl = Instance.new("TextLabel", f)
    tl.Size = UDim2.new(1,-10,0.5,0); tl.Position = UDim2.fromOffset(10,4)
    tl.BackgroundTransparency = 1; tl.Text = o.Title or ""
    tl.TextColor3 = TEXT_WHITE; tl.Font = Enum.Font.GothamBold
    tl.TextSize = 13; tl.TextXAlignment = Enum.TextXAlignment.Left
    local dl = Instance.new("TextLabel", f)
    dl.Size = UDim2.new(1,-10,0.5,0); dl.Position = UDim2.new(0,10,0.5,0)
    dl.BackgroundTransparency = 1; dl.Text = o.Desc or ""
    dl.TextColor3 = TEXT_GRAY; dl.Font = Enum.Font.Gotham
    dl.TextSize = 11; dl.TextXAlignment = Enum.TextXAlignment.Left
    f.Position = UDim2.new(1, 10, 1, -70)
    TweenService:Create(f, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(1,-285,1,-70)}):Play()
    task.delay(o.Duration or 3, function()
        if gui and gui.Parent then
            TweenService:Create(f, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(1,10,1,-70)}):Play()
            task.wait(0.35)
            gui:Destroy()
        end
    end)
end

function VxnityUI:CreateWindow(opts)
    local isMobile = UserInputService.TouchEnabled
    local SZ  = 370
    local topH = isMobile and 40 or 46

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VxnityHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 999
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = getGuiParent()

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.fromOffset(SZ, SZ)
    Main.Position = UDim2.new(0.5,-SZ/2,0.5,-SZ/2)
    Main.BackgroundColor3 = BG_DARK
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0,10)
    local mst = Instance.new("UIStroke", Main)
    mst.Color = OUTLINE; mst.Thickness = 1.5

    local Top = Instance.new("Frame", Main)
    Top.Size = UDim2.new(1,0,0,topH)
    Top.BackgroundColor3 = Color3.fromRGB(5,5,5)
    Top.BorderSizePixel = 0
    Instance.new("UICorner", Top).CornerRadius = UDim.new(0,10)
    local fix = Instance.new("Frame", Top)
    fix.Size = UDim2.new(1,0,0,10)
    fix.Position = UDim2.new(0,0,1,-10)
    fix.BackgroundColor3 = Color3.fromRGB(5,5,5)
    fix.BorderSizePixel = 0

    local ttl = Instance.new("TextLabel", Top)
    ttl.Size = UDim2.new(0,200,0.5,0); ttl.Position = UDim2.fromOffset(12,0)
    ttl.BackgroundTransparency=1; ttl.Text = opts.Title or "vxnity hub"
    ttl.TextColor3=TEXT_WHITE; ttl.Font=Enum.Font.GothamBold
    ttl.TextSize=isMobile and 13 or 15; ttl.TextXAlignment=Enum.TextXAlignment.Left

    local aut = Instance.new("TextLabel", Top)
    aut.Size = UDim2.new(0,200,0.5,0); aut.Position = UDim2.new(0,12,0.5,0)
    aut.BackgroundTransparency=1; aut.Text = opts.Author or ""
    aut.TextColor3=ACCENT; aut.Font=Enum.Font.Gotham
    aut.TextSize=isMobile and 10 or 11; aut.TextXAlignment=Enum.TextXAlignment.Left

    local function mkBtn(xOff, col)
        local b = Instance.new("TextButton", Top)
        b.Size=UDim2.fromOffset(13,13); b.Position=UDim2.new(1,xOff,0.5,-6)
        b.BackgroundColor3=col; b.Text=""; b.BorderSizePixel=0
        Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)
        return b
    end
    local MinBtn   = mkBtn(-56, Color3.fromRGB(255,189,68))
    local CloseBtn = mkBtn(-34, Color3.fromRGB(255,95,87))

    local Content = Instance.new("Frame", Main)
    Content.Size = UDim2.new(1,0,1,-topH)
    Content.Position = UDim2.new(0,0,0,topH)
    Content.BackgroundTransparency = 1

    local TabPanel = Instance.new("ScrollingFrame", Content)
    TabPanel.Size = UDim2.new(0,132,1,0)
    TabPanel.BackgroundColor3 = Color3.fromRGB(5,5,5)
    TabPanel.BorderSizePixel = 0
    TabPanel.ScrollBarThickness = 0
    TabPanel.CanvasSize = UDim2.new(0,0,0,0)
    TabPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local tll = Instance.new("UIListLayout", TabPanel)
    tll.SortOrder = Enum.SortOrder.LayoutOrder; tll.Padding = UDim.new(0,2)
    local tpad = Instance.new("UIPadding", TabPanel)
    tpad.PaddingTop=UDim.new(0,5); tpad.PaddingLeft=UDim.new(0,4); tpad.PaddingRight=UDim.new(0,4)

    local Sep = Instance.new("Frame", Content)
    Sep.Size=UDim2.new(0,1,1,0); Sep.Position=UDim2.fromOffset(132,0)
    Sep.BackgroundColor3=OUTLINE; Sep.BorderSizePixel=0

    local PageHolder = Instance.new("Frame", Content)
    PageHolder.Size=UDim2.new(1,-133,1,0); PageHolder.Position=UDim2.fromOffset(133,0)
    PageHolder.BackgroundTransparency=1; PageHolder.ClipsDescendants=true

    local drag,dStart,dPos=false,nil,nil
    Top.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            drag=true; dStart=i.Position; dPos=Main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local d=i.Position-dStart
            Main.Position=UDim2.new(dPos.X.Scale,dPos.X.Offset+d.X,dPos.Y.Scale,dPos.Y.Offset+d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
    end)

    local minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        TweenService:Create(Main,TweenInfo.new(0.2),{Size=minimized and UDim2.fromOffset(SZ,topH) or UDim2.fromOffset(SZ,SZ)}):Play()
    end)

    local OpenBtn = Instance.new("TextButton", ScreenGui)
    OpenBtn.Size=UDim2.fromOffset(72,26); OpenBtn.Position=UDim2.new(0,10,0.5,-13)
    OpenBtn.BackgroundColor3=ACCENT; OpenBtn.Text="vxnity"
    OpenBtn.TextColor3=TEXT_WHITE; OpenBtn.Font=Enum.Font.GothamBold
    OpenBtn.TextSize=12; OpenBtn.BorderSizePixel=0; OpenBtn.Visible=false
    Instance.new("UICorner",OpenBtn).CornerRadius=UDim.new(0,7)

    CloseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(Main,TweenInfo.new(0.16),{Size=UDim2.fromOffset(SZ,0)}):Play()
        task.wait(0.2); Main.Visible=false; OpenBtn.Visible=true
    end)
    OpenBtn.MouseButton1Click:Connect(function()
        Main.Visible=true; Main.Size=UDim2.fromOffset(SZ,SZ); OpenBtn.Visible=false
    end)

    local od,ods,osp=false,nil,nil
    OpenBtn.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            od=true; ods=i.Position; osp=OpenBtn.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if od and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local d=i.Position-ods
            OpenBtn.Position=UDim2.new(osp.X.Scale,osp.X.Offset+d.X,osp.Y.Scale,osp.Y.Offset+d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then od=false end
    end)

    local winObj    = {}
    local curTab    = nil
    local secCount  = 0

    local function setActive(page, btn)
        if curTab then
            curTab.Page.Visible=false
            TweenService:Create(curTab.Btn,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(12,12,12)}):Play()
            local l=curTab.Btn:FindFirstChildWhichIsA("TextLabel")
            if l then l.TextColor3=TEXT_GRAY end
        end
        page.Visible=true
        TweenService:Create(btn,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(20,9,33)}):Play()
        local l=btn:FindFirstChildWhichIsA("TextLabel")
        if l then l.TextColor3=ACCENT end
        curTab={Page=page,Btn=btn}
    end

    local function mkElem(parent, h)
        local f=Instance.new("Frame",parent)
        f.Size=UDim2.new(1,-6,0,h or 46)
        f.BackgroundColor3=BG_ELEM; f.BorderSizePixel=0
        Instance.new("UICorner",f).CornerRadius=UDim.new(0,7)
        local s=Instance.new("UIStroke",f); s.Color=OUTLINE; s.Thickness=1
        return f
    end

    local function buildTabAPI(page)
        local api={}
        local scr=Instance.new("ScrollingFrame",page)
        scr.Size=UDim2.new(1,0,1,0); scr.BackgroundTransparency=1
        scr.BorderSizePixel=0; scr.ScrollBarThickness=3
        scr.ScrollBarImageColor3=ACCENT; scr.CanvasSize=UDim2.new(0,0,0,0)
        scr.AutomaticCanvasSize=Enum.AutomaticSize.Y
        local ll=Instance.new("UIListLayout",scr)
        ll.SortOrder=Enum.SortOrder.LayoutOrder; ll.Padding=UDim.new(0,4)
        local pd=Instance.new("UIPadding",scr)
        pd.PaddingTop=UDim.new(0,5); pd.PaddingLeft=UDim.new(0,5)
        pd.PaddingRight=UDim.new(0,5); pd.PaddingBottom=UDim.new(0,5)

        local ord=0
        local function nxt() ord=ord+1 return ord end

        function api:Section(o)
            local sf=Instance.new("Frame",scr)
            sf.Size=UDim2.new(1,-6,0,18); sf.BackgroundTransparency=1; sf.LayoutOrder=nxt()
            local ln=Instance.new("Frame",sf)
            ln.Size=UDim2.new(1,0,0,1); ln.Position=UDim2.new(0,0,0.5,0)
            ln.BackgroundColor3=OUTLINE; ln.BorderSizePixel=0
            local lb=Instance.new("TextLabel",sf)
            lb.Size=UDim2.new(0,0,1,0); lb.AutomaticSize=Enum.AutomaticSize.X
            lb.BackgroundColor3=BG_DARK; lb.BorderSizePixel=0
            lb.Position=UDim2.new(0,6,0,0)
            lb.Text="  "..(o.Title or "").."  "
            lb.TextColor3=TEXT_GRAY; lb.Font=Enum.Font.GothamBold; lb.TextSize=10
        end

        function api:Paragraph(o)
            local f=mkElem(scr,44); f.LayoutOrder=nxt()
            local t=Instance.new("TextLabel",f)
            t.Size=UDim2.new(1,-10,0.5,0); t.Position=UDim2.fromOffset(9,3)
            t.BackgroundTransparency=1; t.Text=o.Title or ""
            t.TextColor3=TEXT_WHITE; t.Font=Enum.Font.GothamBold
            t.TextSize=12; t.TextXAlignment=Enum.TextXAlignment.Left
            local d=Instance.new("TextLabel",f)
            d.Size=UDim2.new(1,-10,0.5,0); d.Position=UDim2.new(0,9,0.5,0)
            d.BackgroundTransparency=1; d.Text=o.Desc or ""
            d.TextColor3=TEXT_GRAY; d.Font=Enum.Font.Gotham
            d.TextSize=10; d.TextXAlignment=Enum.TextXAlignment.Left; d.TextWrapped=true
        end

        function api:Toggle(o)
            local f=mkElem(scr,46); f.LayoutOrder=nxt()
            local tl=Instance.new("TextLabel",f)
            tl.Size=UDim2.new(1,-56,0.5,0); tl.Position=UDim2.fromOffset(9,4)
            tl.BackgroundTransparency=1; tl.Text=o.Title or ""
            tl.TextColor3=TEXT_WHITE; tl.Font=Enum.Font.GothamBold
            tl.TextSize=12; tl.TextXAlignment=Enum.TextXAlignment.Left
            if o.Desc and o.Desc~="" then
                local dl=Instance.new("TextLabel",f)
                dl.Size=UDim2.new(1,-56,0.5,0); dl.Position=UDim2.new(0,9,0.5,0)
                dl.BackgroundTransparency=1; dl.Text=o.Desc
                dl.TextColor3=TEXT_GRAY; dl.Font=Enum.Font.Gotham
                dl.TextSize=10; dl.TextXAlignment=Enum.TextXAlignment.Left
            end
            local bg=Instance.new("Frame",f)
            bg.Size=UDim2.fromOffset(32,17); bg.Position=UDim2.new(1,-42,0.5,-8)
            bg.BackgroundColor3=Color3.fromRGB(38,38,38); bg.BorderSizePixel=0
            Instance.new("UICorner",bg).CornerRadius=UDim.new(1,0)
            local kn=Instance.new("Frame",bg)
            kn.Size=UDim2.fromOffset(11,11); kn.Position=UDim2.fromOffset(3,3)
            kn.BackgroundColor3=Color3.fromRGB(170,170,170); kn.BorderSizePixel=0
            Instance.new("UICorner",kn).CornerRadius=UDim.new(1,0)
            local val=false
            local obj={}
            function obj:Set(v)
                val=v
                TweenService:Create(bg,TweenInfo.new(0.12),{BackgroundColor3=v and ACCENT or Color3.fromRGB(38,38,38)}):Play()
                TweenService:Create(kn,TweenInfo.new(0.12),{
                    Position=v and UDim2.fromOffset(18,3) or UDim2.fromOffset(3,3),
                    BackgroundColor3=v and TEXT_WHITE or Color3.fromRGB(170,170,170)
                }):Play()
                if o.Callback then o.Callback(v) end
            end
            local btn=Instance.new("TextButton",f)
            btn.Size=UDim2.new(1,0,1,0); btn.BackgroundTransparency=1; btn.Text=""
            btn.MouseButton1Click:Connect(function() obj:Set(not val) end)
            return obj
        end

        function api:Slider(o)
            local vd=o.Value or {}
            local mn=vd.Min or o.Min or 0
            local mx=vd.Max or o.Max or 100
            local df=vd.Default or o.Default or mn
            local cur=df
            local f=mkElem(scr,60); f.LayoutOrder=nxt()
            local tl=Instance.new("TextLabel",f)
            tl.Size=UDim2.new(1,-58,0.5,0); tl.Position=UDim2.fromOffset(9,3)
            tl.BackgroundTransparency=1; tl.Text=o.Title or ""
            tl.TextColor3=TEXT_WHITE; tl.Font=Enum.Font.GothamBold
            tl.TextSize=12; tl.TextXAlignment=Enum.TextXAlignment.Left
            local vl=Instance.new("TextLabel",f)
            vl.Size=UDim2.fromOffset(46,16); vl.Position=UDim2.new(1,-54,0,3)
            vl.BackgroundTransparency=1; vl.Text=tostring(df)
            vl.TextColor3=ACCENT; vl.Font=Enum.Font.GothamBold
            vl.TextSize=11; vl.TextXAlignment=Enum.TextXAlignment.Right
            local track=Instance.new("Frame",f)
            track.Size=UDim2.new(1,-18,0,5); track.Position=UDim2.new(0,9,1,-13)
            track.BackgroundColor3=Color3.fromRGB(28,28,28); track.BorderSizePixel=0
            Instance.new("UICorner",track).CornerRadius=UDim.new(1,0)
            local fill=Instance.new("Frame",track)
            fill.Size=UDim2.new((df-mn)/math.max(mx-mn,1),0,1,0)
            fill.BackgroundColor3=ACCENT; fill.BorderSizePixel=0
            Instance.new("UICorner",fill).CornerRadius=UDim.new(1,0)
            local hit=Instance.new("TextButton",f)
            hit.Size=UDim2.new(1,0,0,18); hit.Position=UDim2.new(0,0,1,-18)
            hit.BackgroundTransparency=1; hit.Text=""
            local sliding=false
            local function upd(ix)
                local rel=math.clamp((ix-track.AbsolutePosition.X)/math.max(track.AbsoluteSize.X,1),0,1)
                cur=math.floor((mn+rel*(mx-mn))*10+0.5)/10
                fill.Size=UDim2.new(rel,0,1,0); vl.Text=tostring(cur)
                if o.Callback then o.Callback(cur) end
            end
            hit.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    sliding=true; upd(i.Position.X)
                end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if sliding and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                    upd(i.Position.X)
                end
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    sliding=false
                end
            end)
            if o.Callback then o.Callback(df) end
        end

        function api:Button(o)
            local f=mkElem(scr,38); f.LayoutOrder=nxt()
            local tl=Instance.new("TextLabel",f)
            tl.Size=UDim2.new(1,-28,1,0); tl.Position=UDim2.fromOffset(9,0)
            tl.BackgroundTransparency=1; tl.Text=o.Title or ""
            tl.TextColor3=TEXT_WHITE; tl.Font=Enum.Font.GothamBold
            tl.TextSize=12; tl.TextXAlignment=Enum.TextXAlignment.Left
            if o.Desc and o.Desc~="" then
                tl.Size=UDim2.new(1,-28,0.5,0); tl.Position=UDim2.fromOffset(9,3)
                local dl=Instance.new("TextLabel",f)
                dl.Size=UDim2.new(1,-28,0.5,0); dl.Position=UDim2.new(0,9,0.5,0)
                dl.BackgroundTransparency=1; dl.Text=o.Desc
                dl.TextColor3=TEXT_GRAY; dl.Font=Enum.Font.Gotham
                dl.TextSize=10; dl.TextXAlignment=Enum.TextXAlignment.Left
            end
            local arr=Instance.new("TextLabel",f)
            arr.Size=UDim2.fromOffset(16,16); arr.Position=UDim2.new(1,-24,0.5,-8)
            arr.BackgroundTransparency=1; arr.Text="›"
            arr.TextColor3=ACCENT; arr.Font=Enum.Font.GothamBold; arr.TextSize=18
            local btn=Instance.new("TextButton",f)
            btn.Size=UDim2.new(1,0,1,0); btn.BackgroundTransparency=1; btn.Text=""
            btn.MouseButton1Click:Connect(function()
                TweenService:Create(f,TweenInfo.new(0.06),{BackgroundColor3=Color3.fromRGB(20,9,33)}):Play()
                task.wait(0.09)
                TweenService:Create(f,TweenInfo.new(0.06),{BackgroundColor3=BG_ELEM}):Play()
                if o.Callback then o.Callback() end
            end)
        end

        function api:Input(o)
            local f=mkElem(scr,58); f.LayoutOrder=nxt()
            local tl=Instance.new("TextLabel",f)
            tl.Size=UDim2.new(1,-10,0,17); tl.Position=UDim2.fromOffset(9,4)
            tl.BackgroundTransparency=1; tl.Text=o.Title or ""
            tl.TextColor3=TEXT_WHITE; tl.Font=Enum.Font.GothamBold
            tl.TextSize=12; tl.TextXAlignment=Enum.TextXAlignment.Left
            local ibg=Instance.new("Frame",f)
            ibg.Size=UDim2.new(1,-18,0,22); ibg.Position=UDim2.new(0,9,1,-26)
            ibg.BackgroundColor3=Color3.fromRGB(20,20,20); ibg.BorderSizePixel=0
            Instance.new("UICorner",ibg).CornerRadius=UDim.new(0,5)
            local ist=Instance.new("UIStroke",ibg); ist.Color=OUTLINE; ist.Thickness=1
            local tb=Instance.new("TextBox",ibg)
            tb.Size=UDim2.new(1,-8,1,0); tb.Position=UDim2.fromOffset(4,0)
            tb.BackgroundTransparency=1; tb.Text=o.Value or ""
            tb.PlaceholderText="Enter value..."
            tb.TextColor3=TEXT_WHITE; tb.PlaceholderColor3=TEXT_GRAY
            tb.Font=Enum.Font.Gotham; tb.TextSize=11
            tb.TextXAlignment=Enum.TextXAlignment.Left; tb.ClearTextOnFocus=false
            tb.FocusLost:Connect(function() ist.Color=OUTLINE; if o.Callback then o.Callback(tb.Text) end end)
            tb:GetPropertyChangedSignal("Text"):Connect(function() ist.Color=ACCENT end)
        end

        function api:AddToggle(o) return api:Toggle(o) end
        return api
    end

    local function buildSec(secIdx)
        local sObj={}; local tabIdx=0
        function sObj:Tab(tabOpts)
            tabIdx=tabIdx+1
            local btn=Instance.new("Frame",TabPanel)
            btn.Name=tabOpts.Title or "Tab"
            btn.Size=UDim2.new(1,0,0,28)
            btn.BackgroundColor3=Color3.fromRGB(12,12,12)
            btn.BorderSizePixel=0
            btn.LayoutOrder=secIdx*1000+tabIdx
            Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6)
            local bar=Instance.new("Frame",btn)
            bar.Size=UDim2.fromOffset(3,14); bar.Position=UDim2.new(0,2,0.5,-7)
            bar.BackgroundColor3=ACCENT; bar.BorderSizePixel=0; bar.Visible=false
            Instance.new("UICorner",bar).CornerRadius=UDim.new(1,0)
            local lbl=Instance.new("TextLabel",btn)
            lbl.Name="TextLabel"
            lbl.Size=UDim2.new(1,-10,1,0); lbl.Position=UDim2.fromOffset(9,0)
            lbl.BackgroundTransparency=1; lbl.Text=tabOpts.Title or "Tab"
            lbl.TextColor3=TEXT_GRAY; lbl.Font=Enum.Font.Gotham
            lbl.TextSize=11; lbl.TextXAlignment=Enum.TextXAlignment.Left
            local page=Instance.new("Frame",PageHolder)
            page.Name=(tabOpts.Title or "Tab").."Page"
            page.Size=UDim2.new(1,0,1,0)
            page.BackgroundTransparency=1; page.Visible=false
            local cb=Instance.new("TextButton",btn)
            cb.Size=UDim2.new(1,0,1,0); cb.BackgroundTransparency=1; cb.Text=""
            cb.MouseButton1Click:Connect(function() bar.Visible=true; setActive(page,btn) end)
            if curTab==nil then setActive(page,btn); bar.Visible=true end
            return buildTabAPI(page)
        end
        return sObj
    end

    function winObj:Section(o)
        secCount=secCount+1
        local lb=Instance.new("TextLabel",TabPanel)
        lb.Size=UDim2.new(1,0,0,14); lb.BackgroundTransparency=1
        lb.Text=string.upper(o.Title or "")
        lb.TextColor3=Color3.fromRGB(55,55,55)
        lb.Font=Enum.Font.GothamBold; lb.TextSize=9
        lb.TextXAlignment=Enum.TextXAlignment.Left
        lb.LayoutOrder=secCount*1000
        Instance.new("UIPadding",lb).PaddingLeft=UDim.new(0,4)
        return buildSec(secCount)
    end

    return winObj
end

pcall(function()
    for _,b in pairs(workspace.FE.Actions:GetChildren()) do
        if b.Name==" " then b:Destroy() end
    end
end)
pcall(function()
    if LocalPlayer.Character then
        for _,b in pairs(LocalPlayer.Character:GetChildren()) do
            if b.Name==" " then b:Destroy() end
        end
    end
end)
pcall(function()
    local a=workspace.FE.Actions
    if a:FindFirstChild("KeepYourHeadUp_") then
        a.KeepYourHeadUp_:Destroy()
        local r=Instance.new("RemoteEvent"); r.Name="KeepYourHeadUp_"; r.Parent=a
    end
end)
pcall(function()
    local function weird(n) return string.match(n,"^[a-zA-Z]+%-%d+%a*%-%d+%a*$")~=nil end
    local function clean(p)
        for _,c in pairs(p:GetChildren()) do
            if c:IsA("RemoteEvent") and weird(c.Name) then c:Destroy() end
            pcall(clean,c)
        end
    end
    clean(game)
end)

local Window = VxnityUI:CreateWindow({ Title="vxnity hub", Author="0_kenyah" })

local InfoSec  = Window:Section({ Title="Info" })
local InfoTab  = InfoSec:Tab({ Title="Credits" })

InfoTab:Section({ Title="About" })
InfoTab:Paragraph({ Title="vxnity hub - xeno  v1.0", Desc="TPS Street Soccer" })
InfoTab:Paragraph({ Title="Player", Desc=LocalPlayer.Name })
InfoTab:Section({ Title="Credits" })
InfoTab:Paragraph({ Title="0_kenyah", Desc="Owner / developer" })
InfoTab:Paragraph({ Title="vxnity team", Desc="Support & sexo e.e" })

local MainSec   = Window:Section({ Title="Main" })
local ReachTab  = MainSec:Tab({ Title="Reach"   })
local MossTab   = MainSec:Tab({ Title="Mossing" })
local ReactTab  = MainSec:Tab({ Title="Reacts"  })

local reachOn   = false
local reachDist = 1
local reachConn = nil

ReachTab:Section({ Title="[+] Leg Reach" })
ReachTab:Toggle({
    Title="FireTouchInterest",
    Desc="reach ball",
    Callback=function(state)
        reachOn=state
        if reachConn then reachConn:Disconnect(); reachConn=nil end
        if not state then return end
        reachConn=RunService.Heartbeat:Connect(function()
            local char=LocalPlayer.Character
            local root=char and char:FindFirstChild("HumanoidRootPart")
            local hum =char and char:FindFirstChild("Humanoid")
            if not(char and root and hum) then return end
            local sys=Workspace:FindFirstChild("TPSSystem")
            local tps=sys and sys:FindFirstChild("TPS")
            if not tps then return end
            if (root.Position-tps.Position).Magnitude>reachDist then return end
            local pf=Lighting:FindFirstChild(LocalPlayer.Name)
            pf=pf and pf:FindFirstChild("PreferredFoot")
            if not pf then return end
            local r6=hum.RigType==Enum.HumanoidRigType.R6
            local rn=(pf.Value==1) and (r6 and "Right Leg" or "RightLowerLeg") or (r6 and "Left Leg" or "LeftLowerLeg")
            local limb=char:FindFirstChild(rn)
            if limb then firetouchinterest(limb,tps,0); firetouchinterest(limb,tps,1) end
        end)
    end
})
ReachTab:Slider({
    Title="Reach Distance", Desc="Rango",
    Value={Min=1,Max=15,Default=1},
    Callback=function(v) reachDist=v end
})

ReachTab:Section({ Title="[+] Hitbox" })
ReachTab:Input({
    Title="Hitbox R6", Desc="Tamaño piernas R6", Value="1",
    Callback=function(val)
        local v=tonumber(val) or 1
        local c=LocalPlayer.Character; if not c then return end
        for _,n in ipairs({"Right Leg","Left Leg"}) do
            local p=c:FindFirstChild(n)
            if p then p.Size=Vector3.new(v,2,v); p.CanCollide=false end
        end
        local h=c:FindFirstChild("HumanoidRootPart")
        if h then h.Size=Vector3.new(v,2,v); h.CanCollide=false end
    end
})
ReachTab:Input({
    Title="Hitbox R15", Desc="Tamaño piernas R15", Value="1",
    Callback=function(val)
        local v=tonumber(val) or 1
        local c=LocalPlayer.Character; if not c then return end
        for _,n in ipairs({"RightLowerLeg","LeftLowerLeg"}) do
            local p=c:FindFirstChild(n)
            if p then p.Size=Vector3.new(v,2,v); p.CanCollide=false end
        end
        local h=c:FindFirstChild("HumanoidRootPart")
        if h then h.Size=Vector3.new(v,2,v); h.CanCollide=false end
    end
})
ReachTab:Button({
    Title="Fake Legs", Desc="Apariencia normal",
    Callback=function()
        local c=LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hum=c:WaitForChild("Humanoid")
        if hum.RigType~=Enum.HumanoidRigType.R6 then return end
        c["Right Leg"].Transparency=1; c["Right Leg"].Massless=true
        c["Left Leg"].Transparency =1; c["Left Leg"].Massless =true
        local function fake(name,c0,c1)
            local orig=c[name]
            local p=Instance.new("Part",c)
            p.Name=name.." Fake"; p.CanCollide=false
            p.Color=orig.Color; p.Size=Vector3.new(1,2,1); p.Position=orig.Position
            local m=Instance.new("Motor6D",c.Torso)
            m.Part0=c.Torso; m.Part1=p; m.C0=c0; m.C1=c1
        end
        fake("Left Leg",
            CFrame.new(-1,-1,0,0,0,-1,0,1,0,1,0,0),
            CFrame.new(-0.5,1,0,0,0,-1,0,1,0,1,0,0))
        fake("Right Leg",
            CFrame.new(1,-1,0,0,0,1,0,1,0,-1,0,0),
            CFrame.new(0.5,1,0,0,0,1,0,1,0,-1,0,0))
    end
})

local mossOn     = false
local mossSize   = Vector3.new(1,1.5,1)
local mossTransp = 0.5
local mossOff    = Vector3.new(0,0,0)
local mossBox    = nil
local mossConn   = nil

local function rebuildBox()
    if mossBox then mossBox:Destroy() end
    mossBox=Instance.new("Part")
    mossBox.Size=mossSize; mossBox.Transparency=mossTransp
    mossBox.Anchored=true; mossBox.CanCollide=false
    mossBox.Color=Color3.fromHex("#9d56ff")
    mossBox.Material=Enum.Material.Neon
    mossBox.Name="MossBox"; mossBox.Parent=Workspace
end

local function startMoss()
    if mossConn then mossConn:Disconnect() end
    rebuildBox()
    mossConn=RunService.Heartbeat:Connect(function()
        local c=LocalPlayer.Character; if not c then return end
        local head=c:FindFirstChild("Head")
        local sys=Workspace:FindFirstChild("TPSSystem")
        local tps=sys and sys:FindFirstChild("TPS")
        if not(head and tps and mossBox and mossBox.Parent) then return end
        mossBox.CFrame=head.CFrame*CFrame.new(mossOff)
        local rel=mossBox.CFrame:PointToObjectSpace(tps.Position)
        if math.abs(rel.X)<=mossSize.X/2
        and math.abs(rel.Y)<=mossSize.Y/2
        and math.abs(rel.Z)<=mossSize.Z/2 then
            firetouchinterest(head,tps,0)
            firetouchinterest(head,tps,1)
        end
    end)
end

MossTab:Section({ Title="Head Reach" })
MossTab:Toggle({
    Title="Active Moss Reach", Desc="Reach de cabeza",
    Callback=function(state)
        mossOn=state
        if state then startMoss()
        else
            if mossConn then mossConn:Disconnect(); mossConn=nil end
            if mossBox  then mossBox:Destroy();     mossBox=nil  end
        end
    end
})
MossTab:Slider({ Title="Range X", Value={Min=0,Max=50,Default=1},
    Callback=function(v) mossSize=Vector3.new(v,mossSize.Y,mossSize.Z); if mossOn then rebuildBox() end end })
MossTab:Slider({ Title="Range Y", Value={Min=0,Max=50,Default=1.5},
    Callback=function(v)
        mossSize=Vector3.new(mossSize.X,v,mossSize.Z)
        mossOff=Vector3.new(mossOff.X,v/2.5,mossOff.Z)
        if mossOn then rebuildBox() end
    end })
MossTab:Slider({ Title="Range Z", Value={Min=0,Max=50,Default=1},
    Callback=function(v) mossSize=Vector3.new(mossSize.X,mossSize.Y,v); if mossOn then rebuildBox() end end })
MossTab:Toggle({
    Title="Stealth Mode", Desc="Box invisible",
    Callback=function(state)
        mossTransp=state and 1 or 0.5
        if mossBox then mossBox.Transparency=mossTransp end
    end
})

local reactPow  = 0
local hookReady = false

local function enableHook()
    if hookReady then return end
    hookReady=true
    local meta=getrawmetatable(game)
    local old=meta.namecall
    setreadonly(meta,false)
    meta.namecall=newcclosure(function(self,...)
        if getnamecallmethod()=="FireServer" and reactPow>0 then
            local nm=tostring(self)
            if table.find({"Kick","KickC1","Tackle","Header","SaveRA","SaveLA","SaveRL","SaveLL","SaveT"},nm) then
                local char=LocalPlayer.Character
                local hrp=char and char:FindFirstChild("HumanoidRootPart")
                local sys=Workspace:FindFirstChild("TPSSystem")
                local ball=sys and sys:FindFirstChild("TPS")
                if ball and hrp then
                    ball.Velocity=hrp.CFrame.LookVector*reactPow
                end
            end
        end
        return old(self,...)
    end)
    setreadonly(meta,true)
end

ReactTab:Section({ Title="Reacts" })
ReactTab:Button({ Title="✝️  React Kenyah", Desc="El mejor react",
    Callback=function() reactPow=999999999999999; enableHook(); VxnityUI:Notify({Title="React Kenyah",Desc="Activado",Duration=3}) end })
ReactTab:Button({ Title="⚡  No Delay", Desc="0 delay",
    Callback=function() reactPow=99999999999999; enableHook(); VxnityUI:Notify({Title="No Delay",Desc="Activado",Duration=3}) end })
ReactTab:Button({ Title="asolixun react", Desc="W react",
    Callback=function() reactPow=9999999999999; enableHook(); VxnityUI:Notify({Title="asolixun react",Desc="Activado",Duration=3}) end })
ReactTab:Button({ Title="marianito react", Desc="goated react",
    Callback=function() reactPow=99999999999; enableHook(); VxnityUI:Notify({Title="marianito react",Desc="Activado",Duration=3}) end })
ReactTab:Button({ Title="🔴  Desactivar React", Desc="Apaga los reacts",
    Callback=function() reactPow=0; VxnityUI:Notify({Title="Reacts",Desc="Desactivado",Duration=3}) end })

VxnityUI:Notify({ Title="vxnity hub", Desc="Cargado — 0_kenyah", Duration=4 })
