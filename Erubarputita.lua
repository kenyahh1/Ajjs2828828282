local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace        = game:GetService("Workspace")
local Lighting         = game:GetService("Lighting")
local TweenService     = game:GetService("TweenService")
local LocalPlayer      = Players.LocalPlayer

local ACCENT      = Color3.fromHex("#9d56ff")
local BG_DARK     = Color3.fromRGB(3, 3, 3)
local BG_ELEM     = Color3.fromRGB(15, 15, 15)
local TEXT_WHITE  = Color3.fromRGB(255, 255, 255)
local TEXT_GRAY   = Color3.fromRGB(112, 112, 112)
local OUTLINE     = Color3.fromRGB(26, 26, 26)

local function getGuiParent()
    if gethui then return gethui() end
    local ok, cg = pcall(function() return game:GetService("CoreGui") end)
    if ok and cg then return cg end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local VxnityUI = {}
VxnityUI.__index = VxnityUI

function VxnityUI:Notify(opts)
    local title    = opts.Title or ""
    local desc     = opts.Desc or ""
    local duration = opts.Duration or 3
    local parent   = getGuiParent()
    pcall(function()
        local ex = parent:FindFirstChild("VxnityNotifGui")
        if ex then ex:Destroy() end
    end)
    local gui = Instance.new("ScreenGui")
    gui.Name           = "VxnityNotifGui"
    gui.ResetOnSpawn   = false
    gui.IgnoreGuiInset = true
    gui.Parent         = parent

    local frame = Instance.new("Frame", gui)
    frame.Size             = UDim2.fromOffset(280, 60)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    frame.BorderSizePixel  = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    local st = Instance.new("UIStroke", frame)
    st.Color = ACCENT; st.Thickness = 1.5

    local tl = Instance.new("TextLabel", frame)
    tl.Size = UDim2.new(1,-10,0.5,0); tl.Position = UDim2.fromOffset(10,4)
    tl.BackgroundTransparency = 1; tl.Text = title
    tl.TextColor3 = TEXT_WHITE; tl.Font = Enum.Font.GothamBold
    tl.TextSize = 13; tl.TextXAlignment = Enum.TextXAlignment.Left

    local dl = Instance.new("TextLabel", frame)
    dl.Size = UDim2.new(1,-10,0.5,0); dl.Position = UDim2.new(0,10,0.5,0)
    dl.BackgroundTransparency = 1; dl.Text = desc
    dl.TextColor3 = Color3.fromRGB(160,160,160); dl.Font = Enum.Font.Gotham
    dl.TextSize = 11; dl.TextXAlignment = Enum.TextXAlignment.Left

    frame.Position = UDim2.new(1, 10, 1, -75)
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart),
        {Position = UDim2.new(1,-295,1,-75)}):Play()

    task.delay(duration, function()
        if gui and gui.Parent then
            TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart),
                {Position = UDim2.new(1,10,1,-75)}):Play()
            task.wait(0.35)
            pcall(function() gui:Destroy() end)
        end
    end)
end

function VxnityUI:CreateWindow(opts)
    local isMobile = UserInputService.TouchEnabled
    local topH     = isMobile and 40 or 48
    local SZ       = 350

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name           = "VxnityHubGui"
    ScreenGui.ResetOnSpawn   = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder   = 999
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent         = getGuiParent()

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name             = "MainFrame"
    MainFrame.Size             = UDim2.fromOffset(SZ, SZ)
    MainFrame.Position         = UDim2.new(0.5,-SZ/2,0.5,-SZ/2)
    MainFrame.BackgroundColor3 = BG_DARK
    MainFrame.BorderSizePixel  = 0
    MainFrame.ClipsDescendants = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,10)
    local mst = Instance.new("UIStroke", MainFrame)
    mst.Color = OUTLINE; mst.Thickness = 1.5

    local Topbar = Instance.new("Frame", MainFrame)
    Topbar.Name             = "Topbar"
    Topbar.Size             = UDim2.new(1,0,0,topH)
    Topbar.BackgroundColor3 = Color3.fromRGB(5,5,5)
    Topbar.BorderSizePixel  = 0
    Instance.new("UICorner", Topbar).CornerRadius = UDim.new(0,10)
    local topFix = Instance.new("Frame", Topbar)
    topFix.Size             = UDim2.new(1,0,0,10)
    topFix.Position         = UDim2.new(0,0,1,-10)
    topFix.BackgroundColor3 = Color3.fromRGB(5,5,5)
    topFix.BorderSizePixel  = 0

    local titleLbl = Instance.new("TextLabel", Topbar)
    titleLbl.Size              = UDim2.new(0,200,0.5,0)
    titleLbl.Position          = UDim2.fromOffset(14,0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text              = opts.Title or "vxnity hub"
    titleLbl.TextColor3        = TEXT_WHITE
    titleLbl.Font              = Enum.Font.GothamBold
    titleLbl.TextSize          = isMobile and 14 or 16
    titleLbl.TextXAlignment    = Enum.TextXAlignment.Left

    local authorLbl = Instance.new("TextLabel", Topbar)
    authorLbl.Size              = UDim2.new(0,200,0.5,0)
    authorLbl.Position          = UDim2.new(0,14,0.5,0)
    authorLbl.BackgroundTransparency = 1
    authorLbl.Text              = opts.Author or ""
    authorLbl.TextColor3        = ACCENT
    authorLbl.Font              = Enum.Font.Gotham
    authorLbl.TextSize          = isMobile and 11 or 12
    authorLbl.TextXAlignment    = Enum.TextXAlignment.Left

    local MinBtn = Instance.new("TextButton", Topbar)
    MinBtn.Size             = UDim2.fromOffset(18,18)
    MinBtn.Position         = UDim2.new(1,-70,0.5,-9)
    MinBtn.BackgroundColor3 = Color3.fromRGB(255,189,68)
    MinBtn.Text             = ""; MinBtn.BorderSizePixel = 0
    Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1,0)

    local CloseBtn = Instance.new("TextButton", Topbar)
    CloseBtn.Size             = UDim2.fromOffset(18,18)
    CloseBtn.Position         = UDim2.new(1,-40,0.5,-9)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255,95,87)
    CloseBtn.Text             = ""; CloseBtn.BorderSizePixel = 0
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1,0)

    local ContentFrame = Instance.new("Frame", MainFrame)
    ContentFrame.Name                = "ContentFrame"
    ContentFrame.Size                = UDim2.new(1,0,1,-topH)
    ContentFrame.Position            = UDim2.new(0,0,0,topH)
    ContentFrame.BackgroundTransparency = 1

    local TabPanel = Instance.new("ScrollingFrame", ContentFrame)
    TabPanel.Size                  = UDim2.new(0,160,1,0)
    TabPanel.BackgroundColor3      = Color3.fromRGB(5,5,5)
    TabPanel.BorderSizePixel       = 0
    TabPanel.ScrollBarThickness    = 0
    TabPanel.CanvasSize            = UDim2.new(0,0,0,0)
    TabPanel.AutomaticCanvasSize   = Enum.AutomaticSize.Y
    local tll = Instance.new("UIListLayout", TabPanel)
    tll.SortOrder = Enum.SortOrder.LayoutOrder; tll.Padding = UDim.new(0,2)
    local tpad = Instance.new("UIPadding", TabPanel)
    tpad.PaddingTop = UDim.new(0,6); tpad.PaddingLeft = UDim.new(0,6); tpad.PaddingRight = UDim.new(0,6)

    local Sep = Instance.new("Frame", ContentFrame)
    Sep.Size             = UDim2.new(0,1,1,0)
    Sep.Position         = UDim2.fromOffset(160,0)
    Sep.BackgroundColor3 = OUTLINE; Sep.BorderSizePixel = 0

    local PageHolder = Instance.new("Frame", ContentFrame)
    PageHolder.Name                  = "PageHolder"
    PageHolder.Size                  = UDim2.new(1,-161,1,0)
    PageHolder.Position              = UDim2.fromOffset(161,0)
    PageHolder.BackgroundTransparency = 1
    PageHolder.ClipsDescendants      = true

    local dragging, dragStart, startPos = false, nil, nil
    Topbar.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = inp.Position; startPos = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    local minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        TweenService:Create(MainFrame, TweenInfo.new(0.25),
            {Size = minimized and UDim2.fromOffset(SZ,topH) or UDim2.fromOffset(SZ,SZ)}):Play()
    end)

    local OpenBtn = Instance.new("TextButton", ScreenGui)
    OpenBtn.Name             = "VxnityOpenBtn"
    OpenBtn.Size             = UDim2.fromOffset(80,30)
    OpenBtn.Position         = UDim2.new(0,10,0.5,-15)
    OpenBtn.BackgroundColor3 = ACCENT
    OpenBtn.Text             = "vxnity"
    OpenBtn.TextColor3       = TEXT_WHITE
    OpenBtn.Font             = Enum.Font.GothamBold
    OpenBtn.TextSize         = 13; OpenBtn.BorderSizePixel = 0; OpenBtn.Visible = false
    Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0,8)
    local obStr = Instance.new("UIStroke", OpenBtn)
    obStr.Color = Color3.fromHex("#7b2eff"); obStr.Thickness = 2

    CloseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.fromOffset(SZ,0)}):Play()
        task.wait(0.25)
        MainFrame.Visible = false
        OpenBtn.Visible   = true
    end)
    OpenBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        MainFrame.Size    = UDim2.fromOffset(SZ,SZ)
        OpenBtn.Visible   = false
    end)

    local obDrag, obDragStart, obStartPos = false, nil, nil
    OpenBtn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            obDrag = true; obDragStart = inp.Position; obStartPos = OpenBtn.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if obDrag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - obDragStart
            OpenBtn.Position = UDim2.new(obStartPos.X.Scale, obStartPos.X.Offset+d.X, obStartPos.Y.Scale, obStartPos.Y.Offset+d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            obDrag = false
        end
    end)

    local windowObj  = {}
    local currentTab = nil
    local sectionOrder = 0

    local function setActiveTab(tabPage, tabBtn)
        if currentTab then
            currentTab.Page.Visible = false
            TweenService:Create(currentTab.Btn, TweenInfo.new(0.15),
                {BackgroundColor3 = Color3.fromRGB(12,12,12)}):Play()
            local lbl = currentTab.Btn:FindFirstChildWhichIsA("TextLabel")
            if lbl then lbl.TextColor3 = TEXT_GRAY end
        end
        tabPage.Visible = true
        TweenService:Create(tabBtn, TweenInfo.new(0.15),
            {BackgroundColor3 = Color3.fromRGB(25,12,40)}):Play()
        local lbl = tabBtn:FindFirstChildWhichIsA("TextLabel")
        if lbl then lbl.TextColor3 = ACCENT end
        currentTab = {Page = tabPage, Btn = tabBtn}
    end

    local function makeElementContainer(parent)
        local f = Instance.new("Frame", parent)
        f.Size             = UDim2.new(1,-8,0,52)
        f.BackgroundColor3 = BG_ELEM
        f.BorderSizePixel  = 0
        Instance.new("UICorner", f).CornerRadius = UDim.new(0,7)
        local st = Instance.new("UIStroke", f); st.Color = OUTLINE; st.Thickness = 1
        return f
    end

    local function buildTabAPI(page)
        local tabAPI = {}
        local scroll = Instance.new("ScrollingFrame", page)
        scroll.Size                = UDim2.new(1,0,1,0)
        scroll.BackgroundTransparency = 1
        scroll.BorderSizePixel     = 0
        scroll.ScrollBarThickness  = 3
        scroll.ScrollBarImageColor3 = ACCENT
        scroll.CanvasSize          = UDim2.new(0,0,0,0)
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        local ll = Instance.new("UIListLayout", scroll)
        ll.SortOrder = Enum.SortOrder.LayoutOrder; ll.Padding = UDim.new(0,5)
        local pd = Instance.new("UIPadding", scroll)
        pd.PaddingTop = UDim.new(0,6); pd.PaddingLeft = UDim.new(0,6)
        pd.PaddingRight = UDim.new(0,6); pd.PaddingBottom = UDim.new(0,6)

        local elemOrder = 0
        local function nextOrder() elemOrder = elemOrder+1; return elemOrder end

        function tabAPI:Section(o)
            local sf = Instance.new("Frame", scroll)
            sf.Size = UDim2.new(1,-8,0,22); sf.BackgroundTransparency = 1; sf.LayoutOrder = nextOrder()
            local line = Instance.new("Frame", sf)
            line.Size = UDim2.new(1,0,0,1); line.Position = UDim2.new(0,0,0.5,0)
            line.BackgroundColor3 = OUTLINE; line.BorderSizePixel = 0
            local lb = Instance.new("TextLabel", sf)
            lb.Size = UDim2.new(0,0,1,0); lb.AutomaticSize = Enum.AutomaticSize.X
            lb.BackgroundColor3 = BG_DARK; lb.BorderSizePixel = 0
            lb.Position = UDim2.new(0,8,0,0)
            lb.Text = "  "..(o.Title or "").."  "
            lb.TextColor3 = TEXT_GRAY; lb.Font = Enum.Font.GothamBold; lb.TextSize = 11
        end

        function tabAPI:Paragraph(o)
            local f = makeElementContainer(scroll); f.LayoutOrder = nextOrder()
            local t = Instance.new("TextLabel", f)
            t.Size = UDim2.new(1,-12,0.5,0); t.Position = UDim2.fromOffset(10,4)
            t.BackgroundTransparency = 1; t.Text = o.Title or ""
            t.TextColor3 = TEXT_WHITE; t.Font = Enum.Font.GothamBold
            t.TextSize = 13; t.TextXAlignment = Enum.TextXAlignment.Left
            local d = Instance.new("TextLabel", f)
            d.Size = UDim2.new(1,-12,0.5,0); d.Position = UDim2.new(0,10,0.5,0)
            d.BackgroundTransparency = 1; d.Text = o.Desc or ""
            d.TextColor3 = TEXT_GRAY; d.Font = Enum.Font.Gotham
            d.TextSize = 11; d.TextXAlignment = Enum.TextXAlignment.Left; d.TextWrapped = true
        end

        function tabAPI:Toggle(o)
            local f = makeElementContainer(scroll); f.LayoutOrder = nextOrder()
            local tl = Instance.new("TextLabel", f)
            tl.Size = UDim2.new(1,-58,0.5,0); tl.Position = UDim2.fromOffset(10,5)
            tl.BackgroundTransparency = 1; tl.Text = o.Title or ""
            tl.TextColor3 = TEXT_WHITE; tl.Font = Enum.Font.GothamBold
            tl.TextSize = 13; tl.TextXAlignment = Enum.TextXAlignment.Left
            if o.Desc and o.Desc ~= "" then
                local dl = Instance.new("TextLabel", f)
                dl.Size = UDim2.new(1,-58,0.5,0); dl.Position = UDim2.new(0,10,0.5,0)
                dl.BackgroundTransparency = 1; dl.Text = o.Desc
                dl.TextColor3 = TEXT_GRAY; dl.Font = Enum.Font.Gotham
                dl.TextSize = 11; dl.TextXAlignment = Enum.TextXAlignment.Left
            end
            local switchBG = Instance.new("Frame", f)
            switchBG.Size             = UDim2.fromOffset(36,20)
            switchBG.Position         = UDim2.new(1,-46,0.5,-10)
            switchBG.BackgroundColor3 = Color3.fromRGB(40,40,40)
            switchBG.BorderSizePixel  = 0
            Instance.new("UICorner", switchBG).CornerRadius = UDim.new(1,0)
            local knob = Instance.new("Frame", switchBG)
            knob.Size             = UDim2.fromOffset(14,14)
            knob.Position         = UDim2.fromOffset(3,3)
            knob.BackgroundColor3 = Color3.fromRGB(180,180,180)
            knob.BorderSizePixel  = 0
            Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)
            local value = false
            local toggleObj = {}
            function toggleObj:Set(v)
                value = v
                TweenService:Create(switchBG, TweenInfo.new(0.15),
                    {BackgroundColor3 = v and ACCENT or Color3.fromRGB(40,40,40)}):Play()
                TweenService:Create(knob, TweenInfo.new(0.15),
                    {Position = v and UDim2.fromOffset(19,3) or UDim2.fromOffset(3,3),
                     BackgroundColor3 = v and TEXT_WHITE or Color3.fromRGB(180,180,180)}):Play()
                if o.Callback then pcall(o.Callback, v) end
            end
            local btn = Instance.new("TextButton", f)
            btn.Size = UDim2.new(1,0,1,0); btn.BackgroundTransparency = 1; btn.Text = ""
            btn.MouseButton1Click:Connect(function() toggleObj:Set(not value) end)
            return toggleObj
        end

        function tabAPI:AddToggle(o) return tabAPI:Toggle(o) end

        function tabAPI:Slider(o)
            local vd   = o.Value or {}
            local minV = vd.Min or o.Min or 0
            local maxV = vd.Max or o.Max or 100
            local defV = vd.Default or o.Default or minV
            local cur  = defV
            local f = makeElementContainer(scroll)
            f.Size = UDim2.new(1,-8,0,64); f.LayoutOrder = nextOrder()
            local tl = Instance.new("TextLabel", f)
            tl.Size = UDim2.new(1,-60,0.5,0); tl.Position = UDim2.fromOffset(10,4)
            tl.BackgroundTransparency = 1; tl.Text = o.Title or ""
            tl.TextColor3 = TEXT_WHITE; tl.Font = Enum.Font.GothamBold
            tl.TextSize = 13; tl.TextXAlignment = Enum.TextXAlignment.Left
            if o.Desc and o.Desc ~= "" then
                local dl = Instance.new("TextLabel", f)
                dl.Size = UDim2.new(1,-60,0,14); dl.Position = UDim2.new(0,10,0,22)
                dl.BackgroundTransparency = 1; dl.Text = o.Desc
                dl.TextColor3 = TEXT_GRAY; dl.Font = Enum.Font.Gotham
                dl.TextSize = 11; dl.TextXAlignment = Enum.TextXAlignment.Left
            end
            local valLbl = Instance.new("TextLabel", f)
            valLbl.Size = UDim2.fromOffset(50,20); valLbl.Position = UDim2.new(1,-58,0,4)
            valLbl.BackgroundTransparency = 1; valLbl.Text = tostring(defV)
            valLbl.TextColor3 = ACCENT; valLbl.Font = Enum.Font.GothamBold
            valLbl.TextSize = 12; valLbl.TextXAlignment = Enum.TextXAlignment.Right
            local trackBG = Instance.new("Frame", f)
            trackBG.Size = UDim2.new(1,-20,0,5); trackBG.Position = UDim2.new(0,10,1,-14)
            trackBG.BackgroundColor3 = Color3.fromRGB(30,30,30); trackBG.BorderSizePixel = 0
            Instance.new("UICorner", trackBG).CornerRadius = UDim.new(1,0)
            local fill = Instance.new("Frame", trackBG)
            fill.Size = UDim2.new((defV-minV)/math.max(maxV-minV,1),0,1,0)
            fill.BackgroundColor3 = ACCENT; fill.BorderSizePixel = 0
            Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
            local sliderBtn = Instance.new("TextButton", f)
            sliderBtn.Size = UDim2.new(1,0,0,18); sliderBtn.Position = UDim2.new(0,0,1,-18)
            sliderBtn.BackgroundTransparency = 1; sliderBtn.Text = ""
            local sliding = false
            local function updateSlider(ix)
                local rel = math.clamp((ix - trackBG.AbsolutePosition.X) / math.max(trackBG.AbsoluteSize.X,1), 0, 1)
                cur = math.floor((minV + rel*(maxV-minV))*100+0.5)/100
                fill.Size = UDim2.new(rel,0,1,0)
                valLbl.Text = tostring(math.floor(cur*10+0.5)/10)
                if o.Callback then pcall(o.Callback, cur) end
            end
            sliderBtn.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    sliding = true; updateSlider(inp.Position.X)
                end
            end)
            UserInputService.InputChanged:Connect(function(inp)
                if sliding and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(inp.Position.X)
                end
            end)
            UserInputService.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    sliding = false
                end
            end)
            if o.Callback then pcall(o.Callback, defV) end
        end

        function tabAPI:Input(o)
            local f = makeElementContainer(scroll)
            f.Size = UDim2.new(1,-8,0,62); f.LayoutOrder = nextOrder()
            local tl = Instance.new("TextLabel", f)
            tl.Size = UDim2.new(1,-12,0,18); tl.Position = UDim2.fromOffset(10,5)
            tl.BackgroundTransparency = 1; tl.Text = o.Title or ""
            tl.TextColor3 = TEXT_WHITE; tl.Font = Enum.Font.GothamBold
            tl.TextSize = 13; tl.TextXAlignment = Enum.TextXAlignment.Left
            if o.Desc and o.Desc ~= "" then
                local dl = Instance.new("TextLabel", f)
                dl.Size = UDim2.new(1,-12,0,13); dl.Position = UDim2.fromOffset(10,23)
                dl.BackgroundTransparency = 1; dl.Text = o.Desc
                dl.TextColor3 = TEXT_GRAY; dl.Font = Enum.Font.Gotham
                dl.TextSize = 11; dl.TextXAlignment = Enum.TextXAlignment.Left
            end
            local ibg = Instance.new("Frame", f)
            ibg.Size = UDim2.new(1,-20,0,22); ibg.Position = UDim2.new(0,10,1,-26)
            ibg.BackgroundColor3 = Color3.fromRGB(20,20,20); ibg.BorderSizePixel = 0
            Instance.new("UICorner", ibg).CornerRadius = UDim.new(0,5)
            local ist = Instance.new("UIStroke", ibg); ist.Color = OUTLINE; ist.Thickness = 1
            local tb = Instance.new("TextBox", ibg)
            tb.Size = UDim2.new(1,-10,1,0); tb.Position = UDim2.fromOffset(5,0)
            tb.BackgroundTransparency = 1; tb.Text = o.Value or ""
            tb.PlaceholderText = "Enter value..."; tb.TextColor3 = TEXT_WHITE
            tb.PlaceholderColor3 = TEXT_GRAY; tb.Font = Enum.Font.Gotham
            tb.TextSize = 12; tb.TextXAlignment = Enum.TextXAlignment.Left
            tb.ClearTextOnFocus = false
            tb.FocusLost:Connect(function()
                ist.Color = OUTLINE
                if o.Callback then pcall(o.Callback, tb.Text) end
            end)
            tb:GetPropertyChangedSignal("Text"):Connect(function() ist.Color = ACCENT end)
        end

        function tabAPI:Button(o)
            local f = makeElementContainer(scroll)
            f.Size = UDim2.new(1,-8,0,40); f.LayoutOrder = nextOrder()
            local tl = Instance.new("TextLabel", f)
            tl.Size = UDim2.new(1,-12,1,0); tl.Position = UDim2.fromOffset(10,0)
            tl.BackgroundTransparency = 1; tl.Text = o.Title or ""
            tl.TextColor3 = TEXT_WHITE; tl.Font = Enum.Font.GothamBold
            tl.TextSize = 13; tl.TextXAlignment = Enum.TextXAlignment.Left
            if o.Desc and o.Desc ~= "" then
                tl.Size = UDim2.new(1,-12,0.5,0); tl.Position = UDim2.fromOffset(10,4)
                local dl = Instance.new("TextLabel", f)
                dl.Size = UDim2.new(1,-12,0.5,0); dl.Position = UDim2.new(0,10,0.5,0)
                dl.BackgroundTransparency = 1; dl.Text = o.Desc
                dl.TextColor3 = TEXT_GRAY; dl.Font = Enum.Font.Gotham
                dl.TextSize = 11; dl.TextXAlignment = Enum.TextXAlignment.Left
            end
            local arrow = Instance.new("TextLabel", f)
            arrow.Size = UDim2.fromOffset(20,20); arrow.Position = UDim2.new(1,-28,0.5,-10)
            arrow.BackgroundTransparency = 1; arrow.Text = "›"
            arrow.TextColor3 = ACCENT; arrow.Font = Enum.Font.GothamBold; arrow.TextSize = 20
            local btn = Instance.new("TextButton", f)
            btn.Size = UDim2.new(1,0,1,0); btn.BackgroundTransparency = 1; btn.Text = ""
            btn.MouseButton1Click:Connect(function()
                TweenService:Create(f, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(25,12,40)}):Play()
                task.wait(0.1)
                TweenService:Create(f, TweenInfo.new(0.08), {BackgroundColor3 = BG_ELEM}):Play()
                if o.Callback then pcall(o.Callback) end
            end)
        end

        function tabAPI:Keybind(o)
            local f = makeElementContainer(scroll); f.LayoutOrder = nextOrder()
            local tl = Instance.new("TextLabel", f)
            tl.Size = UDim2.new(1,-80,1,0); tl.Position = UDim2.fromOffset(10,0)
            tl.BackgroundTransparency = 1; tl.Text = o.Title or ""
            tl.TextColor3 = TEXT_WHITE; tl.Font = Enum.Font.GothamBold
            tl.TextSize = 13; tl.TextXAlignment = Enum.TextXAlignment.Left
            local keyBG = Instance.new("Frame", f)
            keyBG.Size = UDim2.fromOffset(54,26); keyBG.Position = UDim2.new(1,-62,0.5,-13)
            keyBG.BackgroundColor3 = Color3.fromRGB(20,20,20); keyBG.BorderSizePixel = 0
            Instance.new("UICorner", keyBG).CornerRadius = UDim.new(0,5)
            local kbStr = Instance.new("UIStroke", keyBG); kbStr.Color = OUTLINE; kbStr.Thickness = 1
            local currentKey = o.Default or Enum.KeyCode.Unknown
            local keyLbl = Instance.new("TextLabel", keyBG)
            keyLbl.Size = UDim2.new(1,0,1,0); keyLbl.BackgroundTransparency = 1
            keyLbl.Text = tostring(currentKey.Name or currentKey)
            keyLbl.TextColor3 = ACCENT; keyLbl.Font = Enum.Font.GothamBold; keyLbl.TextSize = 11
            local listening = false
            local keyBtn = Instance.new("TextButton", keyBG)
            keyBtn.Size = UDim2.new(1,0,1,0); keyBtn.BackgroundTransparency = 1; keyBtn.Text = ""
            keyBtn.MouseButton1Click:Connect(function()
                listening = true; keyLbl.Text = "..."; kbStr.Color = ACCENT
            end)
            UserInputService.InputBegan:Connect(function(inp, gp)
                if listening and not gp then
                    if inp.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey = inp.KeyCode
                        keyLbl.Text = tostring(inp.KeyCode.Name)
                        listening = false; kbStr.Color = OUTLINE
                    end
                elseif not gp and inp.KeyCode == currentKey then
                    if o.Callback then pcall(o.Callback) end
                end
            end)
            if o.Default then
                UserInputService.InputBegan:Connect(function(inp, gp)
                    if not listening and not gp and inp.KeyCode == o.Default then
                        if o.Callback then pcall(o.Callback) end
                    end
                end)
            end
        end

        return tabAPI
    end

    function windowObj:Section(o)
        sectionOrder = sectionOrder + 1
        local sLabel = Instance.new("TextLabel", TabPanel)
        sLabel.Size = UDim2.new(1,0,0,18); sLabel.BackgroundTransparency = 1
        sLabel.Text = string.upper(o.Title or "")
        sLabel.TextColor3 = Color3.fromRGB(70,70,70)
        sLabel.Font = Enum.Font.GothamBold; sLabel.TextSize = 10
        sLabel.TextXAlignment = Enum.TextXAlignment.Left
        sLabel.LayoutOrder = sectionOrder * 1000
        Instance.new("UIPadding", sLabel).PaddingLeft = UDim.new(0,4)

        local sectionObj = {}
        local tabOrder2  = 0
        function sectionObj:Tab(tabOpts)
            tabOrder2 = tabOrder2 + 1
            local tabBtn = Instance.new("Frame", TabPanel)
            tabBtn.Name             = tabOpts.Title or "Tab"
            tabBtn.Size             = UDim2.new(1,0,0,32)
            tabBtn.BackgroundColor3 = Color3.fromRGB(12,12,12)
            tabBtn.BorderSizePixel  = 0
            tabBtn.LayoutOrder      = sectionOrder*1000 + tabOrder2
            Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0,7)
            local accentBar = Instance.new("Frame", tabBtn)
            accentBar.Size             = UDim2.fromOffset(3,18)
            accentBar.Position         = UDim2.new(0,2,0.5,-9)
            accentBar.BackgroundColor3 = ACCENT
            accentBar.BorderSizePixel  = 0; accentBar.Visible = false
            Instance.new("UICorner", accentBar).CornerRadius = UDim.new(1,0)
            local tabTitleLbl = Instance.new("TextLabel", tabBtn)
            tabTitleLbl.Name               = "TextLabel"
            tabTitleLbl.Size               = UDim2.new(1,-10,1,0)
            tabTitleLbl.Position           = UDim2.fromOffset(10,0)
            tabTitleLbl.BackgroundTransparency = 1
            tabTitleLbl.Text               = tabOpts.Title or "Tab"
            tabTitleLbl.TextColor3         = TEXT_GRAY
            tabTitleLbl.Font               = Enum.Font.Gotham
            tabTitleLbl.TextSize           = 13
            tabTitleLbl.TextXAlignment     = Enum.TextXAlignment.Left
            local tabPage = Instance.new("Frame", PageHolder)
            tabPage.Name                  = (tabOpts.Title or "Tab").."Page"
            tabPage.Size                  = UDim2.new(1,0,1,0)
            tabPage.BackgroundTransparency = 1; tabPage.Visible = false
            local tabClickBtn = Instance.new("TextButton", tabBtn)
            tabClickBtn.Size = UDim2.new(1,0,1,0); tabClickBtn.BackgroundTransparency = 1; tabClickBtn.Text = ""
            tabClickBtn.MouseButton1Click:Connect(function()
                accentBar.Visible = true
                setActiveTab(tabPage, tabBtn)
            end)
            if currentTab == nil then
                setActiveTab(tabPage, tabBtn); accentBar.Visible = true
            end
            return buildTabAPI(tabPage)
        end
        return sectionObj
    end

    return windowObj
end

function VxnityUI:AddTheme() end
function VxnityUI:SetTheme() end

local function ShowSystemLoader(onFinished)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name           = "vxnitySystemLoader"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn   = false
    ScreenGui.Parent         = getGuiParent()

    local bg = Instance.new("Frame", ScreenGui)
    bg.Size             = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
    bg.BackgroundTransparency = 0

    local title = Instance.new("TextLabel", bg)
    title.Size              = UDim2.new(1,0,0.2,0)
    title.Position          = UDim2.new(0,0,0.4,0)
    title.BackgroundTransparency = 1
    title.Text              = "VXNITY"
    title.TextColor3        = TEXT_WHITE
    title.Font              = Enum.Font.GothamBold
    title.TextScaled        = true
    title.TextTransparency  = 1

    local subtitle = Instance.new("TextLabel", bg)
    subtitle.Size              = UDim2.new(1,0,0.08,0)
    subtitle.Position          = UDim2.new(0,0,0.55,0)
    subtitle.BackgroundTransparency = 1
    subtitle.TextColor3        = Color3.fromRGB(180,180,180)
    subtitle.Font              = Enum.Font.Gotham
    subtitle.TextScaled        = true
    subtitle.TextTransparency  = 1

    TweenService:Create(title, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    task.wait(0.3)

    local steps = {"Initializing", "Loading modules", "¿Kenyah?", "pronto new act."}
    for _, text in ipairs(steps) do
        subtitle.Text = text
        TweenService:Create(subtitle, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
        task.wait(0.6)
        TweenService:Create(subtitle, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        task.wait(0.15)
    end

    TweenService:Create(bg,    TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    TweenService:Create(title, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    task.wait(0.5)
    pcall(function() ScreenGui:Destroy() end)
    if onFinished then onFinished() end
end

pcall(function()
    for _, b in pairs(workspace.FE.Actions:GetChildren()) do
        if b.Name == " " then b:Destroy() end
    end
end)
pcall(function()
    if LocalPlayer.Character then
        for _, b in pairs(LocalPlayer.Character:GetChildren()) do
            if b.Name == " " then b:Destroy() end
        end
    end
end)
pcall(function()
    local a = workspace.FE.Actions
    if a:FindFirstChild("KeepYourHeadUp_") then
        a.KeepYourHeadUp_:Destroy()
        local r = Instance.new("RemoteEvent")
        r.Name = "KeepYourHeadUp_"; r.Parent = a
    end
end)
pcall(function()
    local function isWeirdName(n)
        return string.match(n, "^[a-zA-Z]+%-%d+%a*%-%d+%a*$") ~= nil
    end
    local function deleteWeird(parent)
        pcall(function()
            for _, c in pairs(parent:GetChildren()) do
                if c:IsA("RemoteEvent") and isWeirdName(c.Name) then c:Destroy() end
                deleteWeird(c)
            end
        end)
    end
    deleteWeird(game)
end)

local function LoadVxnityHub()
    VxnityUI:Notify({Title="vxnity hub", Desc="Loading main script...", Duration=2})

    local Window = VxnityUI:CreateWindow({Title="vxnity hub", Author="0_kenyah"})

    local HomeSection = Window:Section({Title="Information"})
    local HomeTab     = HomeSection:Tab({Title="Home"})

    HomeTab:Section({Title="Welcome to vxnity hub"})
    HomeTab:Paragraph({Title="Script Version: 1.2.0", Desc="Stable build for TPS Street Soccer"})
    HomeTab:Paragraph({Title="User: "..LocalPlayer.Name, Desc="Rank: Premium User"})
    HomeTab:Section({Title="Updates"})
    HomeTab:Paragraph({Title="Latest Update: 2026", Desc="- Improved Reach\n- Optimized UI\n- Xeno compatible"})
    HomeTab:Section({Title="Credits"})
    HomeTab:Paragraph({Title="0_kenyah", Desc="Owner / Developer"})
    HomeTab:Paragraph({Title="vxnity team", Desc="Support & Testing"})

    local Main       = Window:Section({Title="main"})
    local ReachTab   = Main:Tab({Title="Reach"})
    local MossingTab = Main:Tab({Title="Mossing"})
    local ReactTab   = Main:Tab({Title="Reacts"})

    local Misc       = Window:Section({Title="Utility & Extra"})
    local HelpersTab = Misc:Tab({Title="Helpers"})
    local AimbotTab  = Misc:Tab({Title="Aimbot"})

    local reachEnabled  = false
    local reachDistance = 1
    local reachConn     = nil

    ReachTab:Section({Title="Leg Reach (Method A)"})
    ReachTab:Toggle({
        Title = "Active FireTouchInterest",
        Desc  = "Triggers ball contact automatically",
        Callback = function(state)
            reachEnabled = state
            if reachConn then reachConn:Disconnect(); reachConn = nil end
            if not state then return end
            reachConn = RunService.Heartbeat:Connect(function()
                local char = LocalPlayer.Character
                if not char then return end
                local root = char:FindFirstChild("HumanoidRootPart")
                local hum  = char:FindFirstChild("Humanoid")
                if not (root and hum) then return end
                local sys = Workspace:FindFirstChild("TPSSystem")
                local tps = sys and sys:FindFirstChild("TPS")
                if not tps then return end
                if (root.Position - tps.Position).Magnitude > reachDistance then return end
                local pf = Lighting:FindFirstChild(LocalPlayer.Name)
                pf = pf and pf:FindFirstChild("PreferredFoot")
                if not pf then return end
                local isR6 = hum.RigType == Enum.HumanoidRigType.R6
                local limbName = (pf.Value == 1)
                    and (isR6 and "Right Leg" or "RightLowerLeg")
                    or  (isR6 and "Left Leg"  or "LeftLowerLeg")
                local limb = char:FindFirstChild(limbName)
                if limb then
                    pcall(function() firetouchinterest(limb, tps, 0) end)
                    pcall(function() firetouchinterest(limb, tps, 1) end)
                end
            end)
        end
    })

    ReachTab:Slider({
        Title = "Reach Distance",
        Desc  = "Adjust the activation range",
        Value = {Min=1, Max=15, Default=1},
        Callback = function(val) reachDistance = tonumber(val) or 1 end
    })

    ReachTab:Section({Title="Leg Hitbox (Method B)"})
    ReachTab:Input({
        Title = "Leg Hitbox (R6)",
        Desc  = "Modifies physical size of legs",
        Value = "1",
        Callback = function(val)
            local v = tonumber(val) or 1
            local char = LocalPlayer.Character; if not char then return end
            pcall(function()
                if char:FindFirstChild("Right Leg") then
                    char["Right Leg"].Size = Vector3.new(v,2,v); char["Right Leg"].CanCollide = false
                    char["Left Leg"].Size  = Vector3.new(v,2,v); char["Left Leg"].CanCollide  = false
                end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.Size = Vector3.new(v,2,v); hrp.CanCollide = false end
            end)
        end
    })

    ReachTab:Input({
        Title = "Legs Size (R15)",
        Desc  = "Minimum Size is 1",
        Value = "1",
        Callback = function(val)
            local v = tonumber(val) or 1
            local char = LocalPlayer.Character; if not char then return end
            pcall(function()
                if char:FindFirstChild("RightLowerLeg") then
                    char["RightLowerLeg"].Size = Vector3.new(v,2,v); char["RightLowerLeg"].CanCollide = false
                    char["LeftLowerLeg"].Size  = Vector3.new(v,2,v); char["LeftLowerLeg"].CanCollide  = false
                end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.Size = Vector3.new(v,2,v); hrp.CanCollide = false end
            end)
        end
    })

    ReachTab:Button({
        Title = "Fake legs (Appear Normal)",
        Callback = function()
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local hum  = char:WaitForChild("Humanoid")
            if hum.RigType ~= Enum.HumanoidRigType.R6 then return end
            pcall(function()
                char["Right Leg"].Transparency = 1; char["Right Leg"].Massless = true
                char["Left Leg"].Transparency  = 1; char["Left Leg"].Massless  = true
                local function makeFake(name, c0, c1)
                    local orig = char[name]
                    local p = Instance.new("Part", char)
                    p.Name = name.." Fake"; p.CanCollide = false
                    p.Color = orig.Color; p.Size = Vector3.new(1,2,1); p.Position = orig.Position
                    local m = Instance.new("Motor6D", char.Torso)
                    m.Part0=char.Torso; m.Part1=p; m.C0=c0; m.C1=c1
                end
                makeFake("Left Leg",
                    CFrame.new(-1,-1,0,0,0,-1,0,1,0,1,0,0),
                    CFrame.new(-0.5,1,0,0,0,-1,0,1,0,1,0,0))
                makeFake("Right Leg",
                    CFrame.new(1,-1,0,0,0,1,0,1,0,-1,0,0),
                    CFrame.new(0.5,1,0,0,0,1,0,1,0,-1,0,0))
            end)
        end
    })

    local headReachEnabled = false
    local headReachSize    = Vector3.new(1,1.5,1)
    local headTransparency = 0.5
    local headOffset       = Vector3.new(0,0,0)
    local headBoxPart      = nil
    local headConnection   = nil

    local function updateHeadBox()
        pcall(function() if headBoxPart then headBoxPart:Destroy() end end)
        headBoxPart              = Instance.new("Part")
        headBoxPart.Size         = headReachSize
        headBoxPart.Transparency = headTransparency
        headBoxPart.Anchored     = true
        headBoxPart.CanCollide   = false
        headBoxPart.Color        = Color3.fromHex("#9d56ff")
        headBoxPart.Material     = Enum.Material.Neon
        headBoxPart.Name         = "HeadReachBox"
        headBoxPart.Parent       = Workspace
    end

    local function startHeadReach()
        if headConnection then headConnection:Disconnect() end
        updateHeadBox()
        headConnection = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character; if not char then return end
            local head = char:FindFirstChild("Head")
            local sys  = Workspace:FindFirstChild("TPSSystem")
            local tps  = sys and sys:FindFirstChild("TPS")
            if not (head and tps and headBoxPart and headBoxPart.Parent) then return end
            headBoxPart.CFrame = head.CFrame * CFrame.new(headOffset)
            local rel = headBoxPart.CFrame:PointToObjectSpace(tps.Position)
            if math.abs(rel.X) <= headReachSize.X/2
            and math.abs(rel.Y) <= headReachSize.Y/2
            and math.abs(rel.Z) <= headReachSize.Z/2 then
                pcall(function() firetouchinterest(head, tps, 0) end)
                pcall(function() firetouchinterest(head, tps, 1) end)
            end
        end)
    end

    MossingTab:Toggle({
        Title = "Active Moss Reach",
        Desc  = "Enable head-based interaction range",
        Callback = function(state)
            headReachEnabled = state
            if state then
                startHeadReach()
            else
                if headConnection then headConnection:Disconnect(); headConnection = nil end
                pcall(function() if headBoxPart then headBoxPart:Destroy(); headBoxPart = nil end end)
            end
        end
    })

    MossingTab:Slider({
        Title = "Range X", Value = {Min=0,Max=50,Default=1},
        Callback = function(val)
            headReachSize = Vector3.new(val, headReachSize.Y, headReachSize.Z)
            if headReachEnabled then updateHeadBox() end
        end
    })
    MossingTab:Slider({
        Title = "Range Y", Value = {Min=0,Max=50,Default=1.5},
        Callback = function(val)
            headReachSize = Vector3.new(headReachSize.X, val, headReachSize.Z)
            headOffset    = Vector3.new(headOffset.X, val/2.5, headOffset.Z)
            if headReachEnabled then updateHeadBox() end
        end
    })
    MossingTab:Slider({
        Title = "Range Z", Value = {Min=0,Max=50,Default=1},
        Callback = function(val)
            headReachSize = Vector3.new(headReachSize.X, headReachSize.Y, val)
            if headReachEnabled then updateHeadBox() end
        end
    })
    MossingTab:Toggle({
        Title = "Stealth Mode",
        Desc  = "Makes the reach box invisible",
        Callback = function(v)
            headTransparency = v and 1 or 0.5
            if headReachEnabled and headBoxPart then
                headBoxPart.Transparency = headTransparency
            end
        end
    })

    local currentReactPower = 0
    local reactConn         = nil

    local function applyReactForce()
        if currentReactPower <= 0 then return end
        pcall(function()
            local char = LocalPlayer.Character; if not char then return end
            local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
            local sys  = Workspace:FindFirstChild("TPSSystem"); if not sys then return end
            local ball = sys:FindFirstChild("TPS"); if not ball then return end
            ball.AssemblyLinearVelocity = hrp.CFrame.LookVector * currentReactPower
        end)
    end

    local function enableReactLoop()
        if reactConn then return end
        reactConn = RunService.Heartbeat:Connect(function()
            if currentReactPower <= 0 then return end
            pcall(function()
                local char = LocalPlayer.Character; if not char then return end
                local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
                local sys  = Workspace:FindFirstChild("TPSSystem"); if not sys then return end
                local ball = sys:FindFirstChild("TPS"); if not ball then return end
                local dist = (ball.Position - hrp.Position).Magnitude
                if dist < 3 then
                    ball.AssemblyLinearVelocity = hrp.CFrame.LookVector * currentReactPower
                end
            end)
        end)
    end

    ReactTab:Section({Title="Advanced Auto-Reacts"})

    ReactTab:Button({
        Title = "asolixun react",
        Desc  = "W react",
        Callback = function()
            currentReactPower = 9999999
            enableReactLoop()
            applyReactForce()
            VxnityUI:Notify({Title="React Active", Desc="asolixun react enabled", Duration=3})
        end
    })

    ReactTab:Button({
        Title = "marianito react",
        Desc  = "goated react?",
        Callback = function()
            currentReactPower = 5000000
            enableReactLoop()
            applyReactForce()
            VxnityUI:Notify({Title="React Active", Desc="marianito react enabled", Duration=3})
        end
    })

    ReactTab:Button({
        Title = "✝️ - React Kenyah",
        Desc  = "El mejor react 200 ms",
        Callback = function()
            currentReactPower = 15000000
            enableReactLoop()
            applyReactForce()
            VxnityUI:Notify({Title="React Active", Desc="React Kenyah enabled", Duration=3})
        end
    })

    ReactTab:Button({
        Title = "⚡ - No delay",
        Desc  = "0 Delay",
        Callback = function()
            currentReactPower = 12000000
            enableReactLoop()
            applyReactForce()
            VxnityUI:Notify({Title="no delay react Active", Desc="Activado", Duration=3})
        end
    })

    ReactTab:Button({
        Title = "🔥 - Lua del Diablo",
        Desc  = "MAX POWER + 0 Delay",
        Callback = function()
            currentReactPower = 20000000
            enableReactLoop()
            applyReactForce()
            VxnityUI:Notify({Title="Lua del Diablo", Desc="Velocidad extrema activada", Duration=3})
        end
    })

    ReactTab:Button({
        Title = "Goalkeeper React",
        Desc  = "GK saves optimized",
        Callback = function()
            currentReactPower = 8000000
            enableReactLoop()
            applyReactForce()
            VxnityUI:Notify({Title="GK React", Desc="Goalkeeper react enabled", Duration=3})
        end
    })

    ReactTab:Button({
        Title = "🔴 Disable React",
        Desc  = "Apaga el react",
        Callback = function()
            currentReactPower = 0
            VxnityUI:Notify({Title="React", Desc="Desactivado", Duration=3})
        end
    })

    HelpersTab:Section({Title="Ball Visuals"})

    local ballHighlightConn = nil
    HelpersTab:Toggle({
        Title = "ZZZ helper",
        Desc  = "Highlights the ball's position",
        Callback = function(state)
            if state then
                local part = Workspace:FindFirstChild("TPS1") or Instance.new("Part")
                part.Name         = "TPS1"
                part.Size         = Vector3.new(9,0.1,9)
                part.Anchored     = true
                part.BrickColor   = BrickColor.new("Bright red")
                part.Transparency = 1
                part.Parent       = Workspace
                if ballHighlightConn then ballHighlightConn:Disconnect() end
                ballHighlightConn = RunService.Heartbeat:Connect(function()
                    pcall(function()
                        local sys = Workspace:FindFirstChild("TPSSystem")
                        local tps = sys and sys:FindFirstChild("TPS")
                        if tps and part.Parent then
                            part.Position = tps.Position - Vector3.new(0,1,0)
                        end
                    end)
                end)
            else
                if ballHighlightConn then ballHighlightConn:Disconnect(); ballHighlightConn = nil end
                pcall(function() if Workspace:FindFirstChild("TPS1") then Workspace.TPS1:Destroy() end end)
            end
        end
    })

    HelpersTab:Toggle({
        Title = "Kenyah Inf Helper",
        Desc  = "aerial inf",
        Callback = function(state)
            if _G.AerialInfUltra then _G.AerialInfUltra:Disconnect(); _G.AerialInfUltra = nil end
            if not state then return end
            local cachedBall = nil
            _G.AerialInfUltra = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local char  = LocalPlayer.Character; if not char then return end
                    local root  = char:FindFirstChild("HumanoidRootPart"); if not root then return end
                    local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
                    if not cachedBall or not cachedBall.Parent then
                        cachedBall = nil
                        local sys = Workspace:FindFirstChild("TPSSystem")
                        local tps = sys and sys:FindFirstChild("TPS")
                        if tps then cachedBall = tps end
                    end
                    if not cachedBall then return end
                    cachedBall.CanCollide = false
                    cachedBall.Massless   = true
                    local base   = torso or root
                    local offset = base.CFrame.LookVector * 0.7 + Vector3.new(0,0.6,0)
                    cachedBall.CFrame = CFrame.new(base.Position + offset)
                    cachedBall.AssemblyLinearVelocity = base.CFrame.LookVector * 35
                end)
            end)
        end
    })

    HelpersTab:AddToggle({
        Title = "Kenyah INF TER/AIR [HELPER]",
        Desc  = "Guia el balón a velocidad brutal sin paralizarlo",
        Callback = function(state)
            if _G.KenyahINF then _G.KenyahINF:Disconnect(); _G.KenyahINF = nil end
            if not state then return end
            local cachedBall = nil
            _G.KenyahINF = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local char  = LocalPlayer.Character; if not char then return end
                    local root  = char:FindFirstChild("HumanoidRootPart"); if not root then return end
                    local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
                    local base  = torso or root
                    if not cachedBall or not cachedBall.Parent then
                        cachedBall = nil
                        local sys = Workspace:FindFirstChild("TPSSystem")
                        local tps = sys and sys:FindFirstChild("TPS")
                        if tps then cachedBall = tps; cachedBall.CanCollide = false end
                    end
                    if not cachedBall then return end
                    local magnetPos = base.Position + base.CFrame.LookVector * 0.25 + Vector3.new(0,0.45,0)
                    local direction = (magnetPos - cachedBall.Position).Unit
                    cachedBall.AssemblyLinearVelocity = cachedBall.AssemblyLinearVelocity + direction * 9999999
                end)
            end)
        end
    })

    HelpersTab:Section({Title="Air Dribble Assistance"})

    local airDribbleConn = nil
    HelpersTab:Toggle({
        Title = "air dribble helper",
        Desc  = "Show interaction area for air dribbling",
        Callback = function(state)
            if not state then
                if airDribbleConn then airDribbleConn:Disconnect(); airDribbleConn = nil end
                pcall(function() if Workspace:FindFirstChild("TPS_Air") then Workspace.TPS_Air:Destroy() end end)
            end
        end
    })

    HelpersTab:Slider({
        Title = "Box Dimension",
        Value = {Min=1,Max=15,Default=1},
        Callback = function(val)
            pcall(function()
                local part = Workspace:FindFirstChild("TPS_Air") or Instance.new("Part")
                part.Name         = "TPS_Air"
                part.Size         = Vector3.new(val,0.1,val)
                part.Anchored     = true
                part.BrickColor   = BrickColor.new("Bright red")
                part.Transparency = 1
                part.Parent       = Workspace
                if airDribbleConn then airDribbleConn:Disconnect() end
                airDribbleConn = RunService.Heartbeat:Connect(function()
                    pcall(function()
                        local sys = Workspace:FindFirstChild("TPSSystem")
                        local tps = sys and sys:FindFirstChild("TPS")
                        if tps and part.Parent then
                            part.Position = tps.Position - Vector3.new(0,1,0)
                        end
                    end)
                end)
            end)
        end
    })

    HelpersTab:Section({Title="Automation"})

    local infToggle  = false
    local infActive  = false
    local infBallRef = nil

    local function getBall()
        if infBallRef and infBallRef.Parent then return infBallRef end
        local sys = Workspace:FindFirstChild("TPSSystem")
        local tps = sys and sys:FindFirstChild("TPS")
        infBallRef = tps
        return tps
    end

    local function getOrCreateAtt(ball)
        local att = ball:FindFirstChild("_infAtt")
        if not att then
            att = Instance.new("Attachment"); att.Name = "_infAtt"; att.Parent = ball
        end
        return att
    end

    local function getOrCreateLV(ball, att)
        local lv = ball:FindFirstChild("_infLV")
        if not lv then
            lv = Instance.new("LinearVelocity"); lv.Name = "_infLV"
            lv.Attachment0 = att; lv.MaxForce = math.huge
            lv.RelativeTo  = Enum.ActuatorRelativeTo.World
            lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
            lv.VectorVelocity = Vector3.zero; lv.Parent = ball
        end
        return lv
    end

    local function getOrCreateAV(ball, att)
        local av = ball:FindFirstChild("_infAV")
        if not av then
            av = Instance.new("AngularVelocity"); av.Name = "_infAV"
            av.Attachment0 = att; av.MaxTorque = math.huge
            av.RelativeTo  = Enum.ActuatorRelativeTo.World
            av.AngularVelocity = Vector3.zero; av.Parent = ball
        end
        return av
    end

    local function cleanupBall(ball)
        if not ball then return end
        pcall(function()
            local lv = ball:FindFirstChild("_infLV"); if lv then lv.VectorVelocity = Vector3.zero end
            local av = ball:FindFirstChild("_infAV"); if av then av.AngularVelocity = Vector3.zero end
        end)
    end

    local magnetMode    = true
    local predictMode   = true
    local spaceLock     = false
    local lockedPos     = nil
    local lastHRPPos    = nil
    local lastTick      = tick()

    local CONFIG = {
        FOLLOW_DISTANCE = 0.5,
        FOLLOW_SPEED    = 999999,
        DEAD_ZONE       = 12,
        MAX_DISTANCE    = 50,
        STRONG_PULL     = 9999999,
        SOFT_PULL       = 6000,
        MAGNET_PULL     = 9999999,
        PREDICT_OFFSET  = 1.5,
        VERTICAL_OFFSET = -0.5,
        LOCK_RADIUS     = 0.5,
        ANGULAR_KILL    = true,
    }

    HelpersTab:Toggle({
        Title = "Inf Helper",
        Desc  = "[B] Toggle | Control infinito del ball",
        Callback = function(state)
            infToggle = state
            if not state then infActive = false end
        end
    })

    HelpersTab:Toggle({
        Title = "Magnet Mode",
        Desc  = "El ball se pega instantáneamente a ti",
        Callback = function(state) magnetMode = state end
    })

    HelpersTab:Toggle({
        Title = "Predict Mode",
        Desc  = "Anticipa tu movimiento, ball siempre adelante",
        Callback = function(state) predictMode = state end
    })

    HelpersTab:Toggle({
        Title = "Space Lock",
        Desc  = "Congela el ball en el espacio",
        Callback = function(state) spaceLock = state; if not state then lockedPos = nil end end
    })

    HelpersTab:Slider({
        Title = "Follow Distance", Min = 0, Max = 20, Default = 12,
        Callback = function(val) CONFIG.DEAD_ZONE = val end
    })

    HelpersTab:Slider({
        Title = "Vertical Offset", Min = -5, Max = 5, Default = -0.5,
        Callback = function(val) CONFIG.VERTICAL_OFFSET = val end
    })

    UserInputService.InputBegan:Connect(function(inp, gp)
        if inp.KeyCode == Enum.KeyCode.B and not gp and infToggle then
            infActive = not infActive
        end
    end)

    local function getPredictedTarget(hrp)
        local now = tick()
        local dt  = now - lastTick
        lastTick  = now
        local cur = hrp.Position
        if lastHRPPos and dt > 0 then
            local vel = (cur - lastHRPPos) / dt
            lastHRPPos = cur
            return cur + vel * CONFIG.PREDICT_OFFSET + Vector3.new(0, CONFIG.VERTICAL_OFFSET, 0)
        end
        lastHRPPos = cur
        return cur + hrp.CFrame.LookVector * CONFIG.FOLLOW_DISTANCE + Vector3.new(0, CONFIG.VERTICAL_OFFSET, 0)
    end

    RunService.Heartbeat:Connect(function()
        if not (infActive and infToggle) then
            pcall(function()
                local b = getBall(); if b then cleanupBall(b) end
            end)
            lockedPos = nil
            return
        end
        pcall(function()
            local ball = getBall()
            local char = LocalPlayer.Character
            local hrp  = char and char:FindFirstChild("HumanoidRootPart")
            local hum  = char and char:FindFirstChild("Humanoid")
            if not (ball and hrp and hum) then return end
            if hum.Health <= 0 then return end
            if not ball:IsA("BasePart") then return end

            pcall(function() ball:SetNetworkOwner(LocalPlayer) end)

            local ballPos = ball.Position
            local hrpPos  = hrp.Position
            local dist    = (ballPos - hrpPos).Magnitude

            local att = getOrCreateAtt(ball)
            local lv  = getOrCreateLV(ball, att)

            if CONFIG.ANGULAR_KILL then
                pcall(function()
                    local av = getOrCreateAV(ball, att)
                    av.AngularVelocity = Vector3.zero
                    ball.AssemblyAngularVelocity = Vector3.zero
                end)
            end

            if spaceLock then
                if not lockedPos then lockedPos = ballPos end
                local toLock   = lockedPos - ballPos
                local lockDist = toLock.Magnitude
                if lockDist > CONFIG.LOCK_RADIUS then
                    lv.VectorVelocity            = toLock.Unit * CONFIG.MAGNET_PULL
                    ball.AssemblyLinearVelocity  = toLock.Unit * CONFIG.MAGNET_PULL
                else
                    lv.VectorVelocity           = Vector3.zero
                    ball.AssemblyLinearVelocity = Vector3.zero
                end
                return
            else
                lockedPos = nil
            end

            local targetPos = predictMode
                and getPredictedTarget(hrp)
                or  hrpPos + hrp.CFrame.LookVector * CONFIG.FOLLOW_DISTANCE + Vector3.new(0, CONFIG.VERTICAL_OFFSET, 0)

            local toTarget     = targetPos - ballPos
            local toTargetDist = toTarget.Magnitude

            if magnetMode then
                lv.VectorVelocity           = toTarget.Unit * CONFIG.MAGNET_PULL
                ball.AssemblyLinearVelocity = toTarget.Unit * CONFIG.MAGNET_PULL
                return
            end

            if dist > CONFIG.MAX_DISTANCE then
                local dir = (targetPos - ballPos).Unit
                lv.VectorVelocity           = dir * CONFIG.STRONG_PULL
                ball.AssemblyLinearVelocity = dir * CONFIG.STRONG_PULL
            elseif dist > CONFIG.DEAD_ZONE then
                local dir   = toTarget.Unit
                local speed = math.clamp(toTargetDist * CONFIG.SOFT_PULL, 20, CONFIG.FOLLOW_SPEED)
                lv.VectorVelocity = dir * speed
            else
                lv.VectorVelocity = Vector3.zero
            end
        end)
    end)

    local isAimbotEnabled = false
    local aimbotTargetPos = Vector3.new(0, 14, 157)

    local laser = Instance.new("Part", Workspace)
    laser.Name        = "vxnity_aimbot_laser"
    laser.Anchored    = true
    laser.CanCollide  = false
    laser.Material    = Enum.Material.Neon
    laser.Color       = Color3.fromHex("#9d56ff")
    laser.Transparency = 1
    laser.Size        = Vector3.new(0.05,0.05,1)

    RunService.Heartbeat:Connect(function()
        if not isAimbotEnabled then return end
        pcall(function()
            local char  = LocalPlayer.Character; if not char then return end
            local hrp   = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
            local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"); if not torso then return end
            local hrpPos     = hrp.Position
            local lookTarget = Vector3.new(aimbotTargetPos.X, hrpPos.Y, aimbotTargetPos.Z)
            hrp.CFrame = CFrame.lookAt(hrpPos, lookTarget)
            local startPos = torso.Position + Vector3.new(0,0.8,0)
            local distance = (aimbotTargetPos - startPos).Magnitude
            laser.Size  = Vector3.new(0.05,0.05,distance)
            laser.CFrame = CFrame.lookAt(startPos, aimbotTargetPos) * CFrame.new(0,0,-distance/2)
        end)
    end)

    AimbotTab:Section({Title="Aimbot Settings"})

    local AimbotToggle = AimbotTab:Toggle({
        Title = "Enable / Disable Aimbot",
        Callback = function(state)
            isAimbotEnabled      = state
            laser.Transparency   = state and 0.4 or 1
        end
    })

    AimbotTab:Keybind({
        Title   = "Aimbot Keybind",
        Default = Enum.KeyCode.R,
        Callback = function()
            AimbotToggle:Set(not isAimbotEnabled)
        end
    })

    VxnityUI:Notify({
        Title    = "vxnity hub",
        Desc     = "Welcome back! Script loaded successfully.",
        Duration = 4
    })
end

ShowSystemLoader(function()
    task.wait(0.1)
    LoadVxnityHub()
end)
