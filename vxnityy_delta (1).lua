local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ============================================================
-- DELTA-COMPATIBLE UI LIBRARY (reemplaza WindUI)
-- Implementación propia compatible con Delta executor
-- Soporta: Toggle, Slider, Input, Button, Section, Paragraph
-- ============================================================

local VxnityUI = {}
VxnityUI.__index = VxnityUI

-- Helper para obtener el parent correcto de GUI en Delta
local function getGuiParent()
    if gethui then return gethui() end
    local ok, cg = pcall(function() return game:GetService("CoreGui") end)
    if ok and cg then return cg end
    return LocalPlayer:WaitForChild("PlayerGui")
end

-- Notificaciones (reemplaza WindUI:Notify)
function VxnityUI:Notify(opts)
    local title = opts.Title or ""
    local desc = opts.Desc or ""
    local duration = opts.Duration or 3

    local parent = getGuiParent()

    local existing = parent:FindFirstChild("VxnityNotifGui")
    if existing then existing:Destroy() end

    local NotifGui = Instance.new("ScreenGui")
    NotifGui.Name = "VxnityNotifGui"
    NotifGui.ResetOnSpawn = false
    NotifGui.IgnoreGuiInset = true
    NotifGui.Parent = parent

    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(280, 60)
    frame.Position = UDim2.new(1, -295, 1, -75)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    frame.BorderSizePixel = 0
    frame.Parent = NotifGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromHex("#9d56ff")
    stroke.Thickness = 1.5
    stroke.Parent = frame

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -10, 0.5, 0)
    titleLbl.Position = UDim2.fromOffset(10, 4)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 13
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = frame

    local descLbl = Instance.new("TextLabel")
    descLbl.Size = UDim2.new(1, -10, 0.5, 0)
    descLbl.Position = UDim2.new(0, 10, 0.5, 0)
    descLbl.BackgroundTransparency = 1
    descLbl.Text = desc
    descLbl.TextColor3 = Color3.fromRGB(160, 160, 160)
    descLbl.Font = Enum.Font.Gotham
    descLbl.TextSize = 11
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.Parent = frame

    -- Animación entrada
    frame.Position = UDim2.new(1, 10, 1, -75)
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
        Position = UDim2.new(1, -295, 1, -75)
    }):Play()

    task.delay(duration, function()
        if NotifGui and NotifGui.Parent then
            TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                Position = UDim2.new(1, 10, 1, -75)
            }):Play()
            task.wait(0.35)
            NotifGui:Destroy()
        end
    end)
end

-- ============================================================
-- CONSTRUCCIÓN DE VENTANA PRINCIPAL
-- ============================================================

local ACCENT = Color3.fromHex("#9d56ff")
local BG_DARK = Color3.fromRGB(3, 3, 3)
local BG_FRAME = Color3.fromRGB(10, 10, 10)
local BG_ELEM = Color3.fromRGB(15, 15, 15)
local TEXT_WHITE = Color3.fromRGB(255, 255, 255)
local TEXT_GRAY = Color3.fromRGB(112, 112, 112)
local TEXT_MID = Color3.fromRGB(180, 180, 180)
local OUTLINE = Color3.fromRGB(26, 26, 26)

function VxnityUI:CreateWindow(opts)
    local isMobile = UserInputService.TouchEnabled
    local winW = isMobile and 480 or 600
    local winH = isMobile and 380 or 520

    local guiParent = getGuiParent()

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VxnityHubGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 999
    ScreenGui.Enabled = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = guiParent

    -- Ventana principal
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.fromOffset(winW, winH)
    MainFrame.Position = UDim2.new(0.5, -winW/2, 0.5, -winH/2)
    MainFrame.BackgroundColor3 = BG_DARK
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = MainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = OUTLINE
    mainStroke.Thickness = 1.5
    mainStroke.Parent = MainFrame

    -- Topbar
    local Topbar = Instance.new("Frame")
    Topbar.Name = "Topbar"
    Topbar.Size = UDim2.new(1, 0, 0, isMobile and 40 or 48)
    Topbar.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    Topbar.BorderSizePixel = 0
    Topbar.Parent = MainFrame

    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 10)
    topCorner.Parent = Topbar

    -- Cubre esquinas inferiores del topbar
    local topFix = Instance.new("Frame")
    topFix.Size = UDim2.new(1, 0, 0, 10)
    topFix.Position = UDim2.new(0, 0, 1, -10)
    topFix.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    topFix.BorderSizePixel = 0
    topFix.Parent = Topbar

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(0, 200, 1, 0)
    titleLbl.Position = UDim2.fromOffset(14, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = opts.Title or "vxnity hub"
    titleLbl.TextColor3 = TEXT_WHITE
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = isMobile and 14 or 16
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = Topbar

    local authorLbl = Instance.new("TextLabel")
    authorLbl.Size = UDim2.new(0, 200, 1, 0)
    authorLbl.Position = UDim2.fromOffset(14, 0)
    authorLbl.BackgroundTransparency = 1
    authorLbl.Text = opts.Author or ""
    authorLbl.TextColor3 = ACCENT
    authorLbl.Font = Enum.Font.Gotham
    authorLbl.TextSize = isMobile and 11 or 12
    authorLbl.TextXAlignment = Enum.TextXAlignment.Left
    -- Posicionar debajo del título
    titleLbl.Size = UDim2.new(0, 200, 0.5, 0)
    authorLbl.Size = UDim2.new(0, 200, 0.5, 0)
    authorLbl.Position = UDim2.new(0, 14, 0.5, 0)
    authorLbl.Parent = Topbar

    -- Botón minimizar
    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.fromOffset(18, 18)
    MinBtn.Position = UDim2.new(1, -70, 0.5, -9)
    MinBtn.BackgroundColor3 = Color3.fromRGB(255, 189, 68)
    MinBtn.Text = ""
    MinBtn.BorderSizePixel = 0
    MinBtn.Parent = Topbar
    local minC = Instance.new("UICorner"); minC.CornerRadius = UDim.new(1,0); minC.Parent = MinBtn

    -- Botón cerrar
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.fromOffset(18, 18)
    CloseBtn.Position = UDim2.new(1, -40, 0.5, -9)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 95, 87)
    CloseBtn.Text = ""
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = Topbar
    local clsC = Instance.new("UICorner"); clsC.CornerRadius = UDim.new(1,0); clsC.Parent = CloseBtn

    local minimized = false
    local contentHeight = winH - (isMobile and 40 or 48)

    -- Contenido principal (debajo del topbar)
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, 0, 1, -(isMobile and 40 or 48))
    ContentFrame.Position = UDim2.new(0, 0, 0, isMobile and 40 or 48)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame

    -- Panel izquierdo (tabs)
    local TabPanel = Instance.new("ScrollingFrame")
    TabPanel.Name = "TabPanel"
    TabPanel.Size = UDim2.new(0, 160, 1, 0)
    TabPanel.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    TabPanel.BorderSizePixel = 0
    TabPanel.ScrollBarThickness = 0
    TabPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabPanel.Parent = ContentFrame

    local tabListLayout = Instance.new("UIListLayout")
    tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabListLayout.Padding = UDim.new(0, 2)
    tabListLayout.Parent = TabPanel

    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingTop = UDim.new(0, 6)
    tabPadding.PaddingLeft = UDim.new(0, 6)
    tabPadding.PaddingRight = UDim.new(0, 6)
    tabPadding.Parent = TabPanel

    -- Separador vertical
    local Separator = Instance.new("Frame")
    Separator.Size = UDim2.new(0, 1, 1, 0)
    Separator.Position = UDim2.fromOffset(160, 0)
    Separator.BackgroundColor3 = OUTLINE
    Separator.BorderSizePixel = 0
    Separator.Parent = ContentFrame

    -- Panel derecho (contenido de tabs)
    local PageHolder = Instance.new("Frame")
    PageHolder.Name = "PageHolder"
    PageHolder.Size = UDim2.new(1, -161, 1, 0)
    PageHolder.Position = UDim2.fromOffset(161, 0)
    PageHolder.BackgroundTransparency = 1
    PageHolder.ClipsDescendants = true
    PageHolder.Parent = ContentFrame

    -- Drag
    local dragging, dragStart, startPos = false, nil, nil
    Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        TweenService:Create(MainFrame, TweenInfo.new(0.25), {
            Size = minimized and UDim2.fromOffset(winW, isMobile and 40 or 48) or UDim2.fromOffset(winW, winH)
        }):Play()
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.fromOffset(winW, 0)}):Play()
        task.wait(0.25)
        ScreenGui:Destroy()
    end)

    -- Botón flotante para reabrir (OpenButton)
    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Name = "VxnityOpenBtn"
    OpenBtn.Size = UDim2.fromOffset(80, 30)
    OpenBtn.Position = UDim2.new(0, 10, 0.5, -15)
    OpenBtn.BackgroundColor3 = ACCENT
    OpenBtn.Text = "vxnity"
    OpenBtn.TextColor3 = TEXT_WHITE
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.TextSize = 13
    OpenBtn.BorderSizePixel = 0
    OpenBtn.Visible = false
    OpenBtn.Parent = ScreenGui
    local obC = Instance.new("UICorner"); obC.CornerRadius = UDim.new(0,8); obC.Parent = OpenBtn
    local obStr = Instance.new("UIStroke"); obStr.Color = Color3.fromHex("#7b2eff"); obStr.Thickness = 2; obStr.Parent = OpenBtn

    CloseBtn.MouseButton1Click:Connect(function()
        OpenBtn.Visible = true
    end)
    OpenBtn.MouseButton1Click:Connect(function()
        OpenBtn.Visible = false
        local newGui = Instance.new("ScreenGui")
        -- simplemente re-muestra
        MainFrame.Size = UDim2.fromOffset(winW, winH)
        MainFrame.Parent = ScreenGui
    end)

    -- Drag del OpenBtn
    local obDragging, obDragStart, obStartPos = false, nil, nil
    OpenBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            obDragging = true; obDragStart = input.Position; obStartPos = OpenBtn.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if obDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - obDragStart
            OpenBtn.Position = UDim2.new(obStartPos.X.Scale, obStartPos.X.Offset + d.X, obStartPos.Y.Scale, obStartPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            obDragging = false
        end
    end)

    local windowObj = {}
    local allTabs = {}
    local currentTab = nil
    local tabOrder = 0
    local sectionOrder = 0

    local function setActiveTab(tabPage, tabBtn)
        if currentTab then
            currentTab.Page.Visible = false
            TweenService:Create(currentTab.Btn, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                BackgroundTransparency = 0
            }):Play()
            local prevLbl = currentTab.Btn:FindFirstChildWhichIsA("TextLabel")
            if prevLbl then prevLbl.TextColor3 = TEXT_GRAY end
        end
        tabPage.Visible = true
        TweenService:Create(tabBtn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(25, 12, 40),
            BackgroundTransparency = 0
        }):Play()
        local lbl = tabBtn:FindFirstChildWhichIsA("TextLabel")
        if lbl then lbl.TextColor3 = ACCENT end
        currentTab = {Page = tabPage, Btn = tabBtn}
    end

    -- Función para crear elementos de UI dentro de un tab
    local function makeElementContainer(parent)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -8, 0, 52)
        frame.BackgroundColor3 = BG_ELEM
        frame.BorderSizePixel = 0
        frame.Parent = parent

        local fCorner = Instance.new("UICorner")
        fCorner.CornerRadius = UDim.new(0, 7)
        fCorner.Parent = frame

        local fStroke = Instance.new("UIStroke")
        fStroke.Color = OUTLINE
        fStroke.Thickness = 1
        fStroke.Parent = frame

        return frame
    end

    -- Función para crear el tab builder (Tab API)
    local function buildTabAPI(page)
        local tabAPI = {}

        -- Scroll dentro de la página
        local scroll = Instance.new("ScrollingFrame")
        scroll.Size = UDim2.new(1, 0, 1, 0)
        scroll.BackgroundTransparency = 1
        scroll.BorderSizePixel = 0
        scroll.ScrollBarThickness = 3
        scroll.ScrollBarImageColor3 = ACCENT
        scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        scroll.Parent = page

        local listLayout = Instance.new("UIListLayout")
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Padding = UDim.new(0, 5)
        listLayout.Parent = scroll

        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 6)
        padding.PaddingLeft = UDim.new(0, 6)
        padding.PaddingRight = UDim.new(0, 6)
        padding.PaddingBottom = UDim.new(0, 6)
        padding.Parent = scroll

        local elemOrder = 0
        local function nextOrder() elemOrder = elemOrder + 1 return elemOrder end

        -- SECTION
        function tabAPI:Section(opts2)
            local sFrame = Instance.new("Frame")
            sFrame.Size = UDim2.new(1, -8, 0, 22)
            sFrame.BackgroundTransparency = 1
            sFrame.LayoutOrder = nextOrder()
            sFrame.Parent = scroll

            local sLine = Instance.new("Frame")
            sLine.Size = UDim2.new(1, 0, 0, 1)
            sLine.Position = UDim2.new(0, 0, 0.5, 0)
            sLine.BackgroundColor3 = OUTLINE
            sLine.BorderSizePixel = 0
            sLine.Parent = sFrame

            local sTitle = Instance.new("TextLabel")
            sTitle.Size = UDim2.new(0, 0, 1, 0)
            sTitle.AutomaticSize = Enum.AutomaticSize.X
            sTitle.BackgroundColor3 = BG_DARK
            sTitle.BorderSizePixel = 0
            sTitle.Position = UDim2.new(0, 8, 0, 0)
            sTitle.Text = "  " .. (opts2.Title or "") .. "  "
            sTitle.TextColor3 = TEXT_GRAY
            sTitle.Font = Enum.Font.GothamBold
            sTitle.TextSize = 11
            sTitle.Parent = sFrame
        end

        -- PARAGRAPH
        function tabAPI:Paragraph(opts2)
            local f = makeElementContainer(scroll)
            f.Size = UDim2.new(1, -8, 0, 48)
            f.LayoutOrder = nextOrder()

            local t = Instance.new("TextLabel")
            t.Size = UDim2.new(1, -12, 0.5, 0)
            t.Position = UDim2.fromOffset(10, 4)
            t.BackgroundTransparency = 1
            t.Text = opts2.Title or ""
            t.TextColor3 = TEXT_WHITE
            t.Font = Enum.Font.GothamBold
            t.TextSize = 13
            t.TextXAlignment = Enum.TextXAlignment.Left
            t.Parent = f

            local d = Instance.new("TextLabel")
            d.Size = UDim2.new(1, -12, 0.5, 0)
            d.Position = UDim2.new(0, 10, 0.5, 0)
            d.BackgroundTransparency = 1
            d.Text = opts2.Desc or ""
            d.TextColor3 = TEXT_GRAY
            d.Font = Enum.Font.Gotham
            d.TextSize = 11
            d.TextXAlignment = Enum.TextXAlignment.Left
            d.TextWrapped = true
            d.Parent = f
        end

        -- TOGGLE
        function tabAPI:Toggle(opts2)
            local f = makeElementContainer(scroll)
            f.LayoutOrder = nextOrder()

            local titleLb = Instance.new("TextLabel")
            titleLb.Size = UDim2.new(1, -58, 0.5, 0)
            titleLb.Position = UDim2.fromOffset(10, 5)
            titleLb.BackgroundTransparency = 1
            titleLb.Text = opts2.Title or ""
            titleLb.TextColor3 = TEXT_WHITE
            titleLb.Font = Enum.Font.GothamBold
            titleLb.TextSize = 13
            titleLb.TextXAlignment = Enum.TextXAlignment.Left
            titleLb.Parent = f

            if opts2.Desc and opts2.Desc ~= "" then
                local descLb = Instance.new("TextLabel")
                descLb.Size = UDim2.new(1, -58, 0.5, 0)
                descLb.Position = UDim2.new(0, 10, 0.5, 0)
                descLb.BackgroundTransparency = 1
                descLb.Text = opts2.Desc
                descLb.TextColor3 = TEXT_GRAY
                descLb.Font = Enum.Font.Gotham
                descLb.TextSize = 11
                descLb.TextXAlignment = Enum.TextXAlignment.Left
                descLb.Parent = f
            end

            -- Switch
            local switchBG = Instance.new("Frame")
            switchBG.Size = UDim2.fromOffset(36, 20)
            switchBG.Position = UDim2.new(1, -46, 0.5, -10)
            switchBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            switchBG.BorderSizePixel = 0
            switchBG.Parent = f
            local swC = Instance.new("UICorner"); swC.CornerRadius = UDim.new(1,0); swC.Parent = switchBG

            local knob = Instance.new("Frame")
            knob.Size = UDim2.fromOffset(14, 14)
            knob.Position = UDim2.fromOffset(3, 3)
            knob.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
            knob.BorderSizePixel = 0
            knob.Parent = switchBG
            local kC = Instance.new("UICorner"); kC.CornerRadius = UDim.new(1,0); kC.Parent = knob

            local value = false
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.Parent = f

            local toggleObj = {}
            function toggleObj:Set(v)
                value = v
                TweenService:Create(switchBG, TweenInfo.new(0.15), {
                    BackgroundColor3 = v and ACCENT or Color3.fromRGB(40, 40, 40)
                }):Play()
                TweenService:Create(knob, TweenInfo.new(0.15), {
                    Position = v and UDim2.fromOffset(19, 3) or UDim2.fromOffset(3, 3),
                    BackgroundColor3 = v and TEXT_WHITE or Color3.fromRGB(180, 180, 180)
                }):Play()
                if opts2.Callback then opts2.Callback(v) end
            end

            btn.MouseButton1Click:Connect(function()
                toggleObj:Set(not value)
            end)

            return toggleObj
        end

        -- SLIDER
        function tabAPI:Slider(opts2)
            -- Acepta tanto Value = {Min, Max, Default} como Min/Max/Default directo
            local valData = opts2.Value or {}
            local minV = valData.Min or opts2.Min or 0
            local maxV = valData.Max or opts2.Max or 100
            local defV = valData.Default or opts2.Default or minV
            local currentVal = defV

            local f = makeElementContainer(scroll)
            f.Size = UDim2.new(1, -8, 0, 64)
            f.LayoutOrder = nextOrder()

            local titleLb = Instance.new("TextLabel")
            titleLb.Size = UDim2.new(1, -60, 0.5, 0)
            titleLb.Position = UDim2.fromOffset(10, 4)
            titleLb.BackgroundTransparency = 1
            titleLb.Text = opts2.Title or ""
            titleLb.TextColor3 = TEXT_WHITE
            titleLb.Font = Enum.Font.GothamBold
            titleLb.TextSize = 13
            titleLb.TextXAlignment = Enum.TextXAlignment.Left
            titleLb.Parent = f

            if opts2.Desc and opts2.Desc ~= "" then
                local descLb = Instance.new("TextLabel")
                descLb.Size = UDim2.new(1, -60, 0, 14)
                descLb.Position = UDim2.new(0, 10, 0, 22)
                descLb.BackgroundTransparency = 1
                descLb.Text = opts2.Desc
                descLb.TextColor3 = TEXT_GRAY
                descLb.Font = Enum.Font.Gotham
                descLb.TextSize = 11
                descLb.TextXAlignment = Enum.TextXAlignment.Left
                descLb.Parent = f
            end

            local valLbl = Instance.new("TextLabel")
            valLbl.Size = UDim2.fromOffset(50, 20)
            valLbl.Position = UDim2.new(1, -58, 0, 4)
            valLbl.BackgroundTransparency = 1
            valLbl.Text = tostring(defV)
            valLbl.TextColor3 = ACCENT
            valLbl.Font = Enum.Font.GothamBold
            valLbl.TextSize = 12
            valLbl.TextXAlignment = Enum.TextXAlignment.Right
            valLbl.Parent = f

            local trackBG = Instance.new("Frame")
            trackBG.Size = UDim2.new(1, -20, 0, 5)
            trackBG.Position = UDim2.new(0, 10, 1, -14)
            trackBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            trackBG.BorderSizePixel = 0
            trackBG.Parent = f
            local trC = Instance.new("UICorner"); trC.CornerRadius = UDim.new(1,0); trC.Parent = trackBG

            local fill = Instance.new("Frame")
            fill.Size = UDim2.new((defV - minV) / (maxV - minV), 0, 1, 0)
            fill.BackgroundColor3 = ACCENT
            fill.BorderSizePixel = 0
            fill.Parent = trackBG
            local fC = Instance.new("UICorner"); fC.CornerRadius = UDim.new(1,0); fC.Parent = fill

            local sliderBtn = Instance.new("TextButton")
            sliderBtn.Size = UDim2.new(1, 0, 0, 18)
            sliderBtn.Position = UDim2.new(0, 0, 1, -18)
            sliderBtn.BackgroundTransparency = 1
            sliderBtn.Text = ""
            sliderBtn.Parent = f

            local sliding = false

            local function updateSlider(inputX)
                local absPos = trackBG.AbsolutePosition.X
                local absSize = trackBG.AbsoluteSize.X
                local rel = math.clamp((inputX - absPos) / absSize, 0, 1)
                local rawVal = minV + rel * (maxV - minV)
                local rounded = math.floor(rawVal * 100 + 0.5) / 100
                currentVal = rounded
                fill.Size = UDim2.new(rel, 0, 1, 0)
                valLbl.Text = tostring(math.floor(rounded * 10 + 0.5) / 10)
                if opts2.Callback then opts2.Callback(currentVal) end
            end

            sliderBtn.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sliding = true
                    updateSlider(input.Position.X)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(input.Position.X)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sliding = false
                end
            end)

            if opts2.Callback then opts2.Callback(defV) end
        end

        -- INPUT
        function tabAPI:Input(opts2)
            local f = makeElementContainer(scroll)
            f.Size = UDim2.new(1, -8, 0, 62)
            f.LayoutOrder = nextOrder()

            local titleLb = Instance.new("TextLabel")
            titleLb.Size = UDim2.new(1, -12, 0, 18)
            titleLb.Position = UDim2.fromOffset(10, 5)
            titleLb.BackgroundTransparency = 1
            titleLb.Text = opts2.Title or ""
            titleLb.TextColor3 = TEXT_WHITE
            titleLb.Font = Enum.Font.GothamBold
            titleLb.TextSize = 13
            titleLb.TextXAlignment = Enum.TextXAlignment.Left
            titleLb.Parent = f

            if opts2.Desc and opts2.Desc ~= "" then
                local descLb = Instance.new("TextLabel")
                descLb.Size = UDim2.new(1, -12, 0, 13)
                descLb.Position = UDim2.fromOffset(10, 23)
                descLb.BackgroundTransparency = 1
                descLb.Text = opts2.Desc
                descLb.TextColor3 = TEXT_GRAY
                descLb.Font = Enum.Font.Gotham
                descLb.TextSize = 11
                descLb.TextXAlignment = Enum.TextXAlignment.Left
                descLb.Parent = f
            end

            local inputBG = Instance.new("Frame")
            inputBG.Size = UDim2.new(1, -20, 0, 22)
            inputBG.Position = UDim2.new(0, 10, 1, -26)
            inputBG.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            inputBG.BorderSizePixel = 0
            inputBG.Parent = f
            local inC = Instance.new("UICorner"); inC.CornerRadius = UDim.new(0,5); inC.Parent = inputBG
            local inStr = Instance.new("UIStroke"); inStr.Color = OUTLINE; inStr.Thickness = 1; inStr.Parent = inputBG

            local textBox = Instance.new("TextBox")
            textBox.Size = UDim2.new(1, -10, 1, 0)
            textBox.Position = UDim2.fromOffset(5, 0)
            textBox.BackgroundTransparency = 1
            textBox.Text = opts2.Value or ""
            textBox.PlaceholderText = "Enter value..."
            textBox.TextColor3 = TEXT_WHITE
            textBox.PlaceholderColor3 = TEXT_GRAY
            textBox.Font = Enum.Font.Gotham
            textBox.TextSize = 12
            textBox.TextXAlignment = Enum.TextXAlignment.Left
            textBox.ClearTextOnFocus = false
            textBox.Parent = inputBG

            textBox.FocusLost:Connect(function(enterPressed)
                if opts2.Callback then opts2.Callback(textBox.Text) end
            end)
            textBox:GetPropertyChangedSignal("Text"):Connect(function()
                inStr.Color = ACCENT
            end)
            textBox.FocusLost:Connect(function()
                inStr.Color = OUTLINE
            end)
        end

        -- BUTTON
        function tabAPI:Button(opts2)
            local f = makeElementContainer(scroll)
            f.Size = UDim2.new(1, -8, 0, 40)
            f.LayoutOrder = nextOrder()

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.Parent = f

            local titleLb = Instance.new("TextLabel")
            titleLb.Size = UDim2.new(1, -12, 1, 0)
            titleLb.Position = UDim2.fromOffset(10, 0)
            titleLb.BackgroundTransparency = 1
            titleLb.Text = opts2.Title or ""
            titleLb.TextColor3 = TEXT_WHITE
            titleLb.Font = Enum.Font.GothamBold
            titleLb.TextSize = 13
            titleLb.TextXAlignment = Enum.TextXAlignment.Left
            titleLb.Parent = f

            if opts2.Desc and opts2.Desc ~= "" then
                titleLb.Size = UDim2.new(1, -12, 0.5, 0)
                titleLb.Position = UDim2.fromOffset(10, 4)
                local descLb = Instance.new("TextLabel")
                descLb.Size = UDim2.new(1, -12, 0.5, 0)
                descLb.Position = UDim2.new(0, 10, 0.5, 0)
                descLb.BackgroundTransparency = 1
                descLb.Text = opts2.Desc
                descLb.TextColor3 = TEXT_GRAY
                descLb.Font = Enum.Font.Gotham
                descLb.TextSize = 11
                descLb.TextXAlignment = Enum.TextXAlignment.Left
                descLb.Parent = f
            end

            -- Ícono de flecha derecha
            local arrow = Instance.new("TextLabel")
            arrow.Size = UDim2.fromOffset(20, 20)
            arrow.Position = UDim2.new(1, -28, 0.5, -10)
            arrow.BackgroundTransparency = 1
            arrow.Text = "›"
            arrow.TextColor3 = ACCENT
            arrow.Font = Enum.Font.GothamBold
            arrow.TextSize = 20
            arrow.Parent = f

            btn.MouseButton1Click:Connect(function()
                TweenService:Create(f, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(25, 12, 40)}):Play()
                task.wait(0.1)
                TweenService:Create(f, TweenInfo.new(0.08), {BackgroundColor3 = BG_ELEM}):Play()
                if opts2.Callback then opts2.Callback() end
            end)
        end

        -- KEYBIND (stub para compatibilidad — Keybind se maneja con UserInputService)
        function tabAPI:Keybind(opts2)
            local f = makeElementContainer(scroll)
            f.LayoutOrder = nextOrder()

            local titleLb = Instance.new("TextLabel")
            titleLb.Size = UDim2.new(1, -80, 1, 0)
            titleLb.Position = UDim2.fromOffset(10, 0)
            titleLb.BackgroundTransparency = 1
            titleLb.Text = opts2.Title or ""
            titleLb.TextColor3 = TEXT_WHITE
            titleLb.Font = Enum.Font.GothamBold
            titleLb.TextSize = 13
            titleLb.TextXAlignment = Enum.TextXAlignment.Left
            titleLb.Parent = f

            local keyBG = Instance.new("Frame")
            keyBG.Size = UDim2.fromOffset(54, 26)
            keyBG.Position = UDim2.new(1, -62, 0.5, -13)
            keyBG.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            keyBG.BorderSizePixel = 0
            keyBG.Parent = f
            local kbC = Instance.new("UICorner"); kbC.CornerRadius = UDim.new(0,5); kbC.Parent = keyBG
            local kbStr = Instance.new("UIStroke"); kbStr.Color = OUTLINE; kbStr.Thickness = 1; kbStr.Parent = keyBG

            local currentKey = opts2.Default or Enum.KeyCode.Unknown
            local keyLbl = Instance.new("TextLabel")
            keyLbl.Size = UDim2.new(1, 0, 1, 0)
            keyLbl.BackgroundTransparency = 1
            keyLbl.Text = tostring(currentKey.Name or currentKey)
            keyLbl.TextColor3 = ACCENT
            keyLbl.Font = Enum.Font.GothamBold
            keyLbl.TextSize = 11
            keyLbl.Parent = keyBG

            local listening = false
            local keyBtn = Instance.new("TextButton")
            keyBtn.Size = UDim2.new(1, 0, 1, 0)
            keyBtn.BackgroundTransparency = 1
            keyBtn.Text = ""
            keyBtn.Parent = keyBG

            keyBtn.MouseButton1Click:Connect(function()
                listening = true
                keyLbl.Text = "..."
                kbStr.Color = ACCENT
            end)

            UserInputService.InputBegan:Connect(function(input, gp)
                if listening and not gp then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey = input.KeyCode
                        keyLbl.Text = tostring(input.KeyCode.Name)
                        listening = false
                        kbStr.Color = OUTLINE
                    end
                elseif not gp and input.KeyCode == currentKey then
                    if opts2.Callback then opts2.Callback() end
                end
            end)

            -- Keybind callback global (para el keybind de aimbot)
            if opts2.Default then
                UserInputService.InputBegan:Connect(function(input, gp)
                    if not listening and not gp and input.KeyCode == opts2.Default then
                        if opts2.Callback then opts2.Callback() end
                    end
                end)
            end
        end

        -- AddToggle (alias de Toggle, usado en HelpersTab:AddToggle)
        function tabAPI:AddToggle(opts2)
            return tabAPI:Toggle(opts2)
        end

        return tabAPI
    end

    -- Section builder (agrupa tabs con un título de sección)
    function windowObj:Section(opts2)
        sectionOrder = sectionOrder + 1
        local sectionObj = {}

        -- Label de sección en el panel de tabs
        local sLabel = Instance.new("TextLabel")
        sLabel.Size = UDim2.new(1, 0, 0, 18)
        sLabel.BackgroundTransparency = 1
        sLabel.Text = string.upper(opts2.Title or "")
        sLabel.TextColor3 = Color3.fromRGB(70, 70, 70)
        sLabel.Font = Enum.Font.GothamBold
        sLabel.TextSize = 10
        sLabel.TextXAlignment = Enum.TextXAlignment.Left
        sLabel.LayoutOrder = sectionOrder * 1000
        local sLPad = Instance.new("UIPadding"); sLPad.PaddingLeft = UDim.new(0,4); sLPad.Parent = sLabel
        sLabel.Parent = TabPanel

        local tabOrder2 = 0
        function sectionObj:Tab(tabOpts)
            tabOrder2 = tabOrder2 + 1

            -- Botón del tab en el panel izquierdo
            local tabBtn = Instance.new("Frame")
            tabBtn.Name = tabOpts.Title or "Tab"
            tabBtn.Size = UDim2.new(1, 0, 0, 32)
            tabBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
            tabBtn.BorderSizePixel = 0
            tabBtn.LayoutOrder = sectionOrder * 1000 + tabOrder2
            tabBtn.Parent = TabPanel
            local tbC = Instance.new("UICorner"); tbC.CornerRadius = UDim.new(0,7); tbC.Parent = tabBtn

            -- Accent bar lateral
            local accentBar = Instance.new("Frame")
            accentBar.Size = UDim2.fromOffset(3, 18)
            accentBar.Position = UDim2.new(0, 2, 0.5, -9)
            accentBar.BackgroundColor3 = ACCENT
            accentBar.BorderSizePixel = 0
            accentBar.Visible = false
            accentBar.Parent = tabBtn
            local abC = Instance.new("UICorner"); abC.CornerRadius = UDim.new(1,0); abC.Parent = accentBar

            -- TextLabel del tab
            local tabTitleLbl = Instance.new("TextLabel")
            tabTitleLbl.Name = "TextLabel"
            tabTitleLbl.Size = UDim2.new(1, -10, 1, 0)
            tabTitleLbl.Position = UDim2.fromOffset(10, 0)
            tabTitleLbl.BackgroundTransparency = 1
            tabTitleLbl.Text = tabOpts.Title or "Tab"
            tabTitleLbl.TextColor3 = TEXT_GRAY
            tabTitleLbl.Font = Enum.Font.Gotham
            tabTitleLbl.TextSize = 13
            tabTitleLbl.TextXAlignment = Enum.TextXAlignment.Left
            tabTitleLbl.Parent = tabBtn

            -- Página del tab
            local tabPage = Instance.new("Frame")
            tabPage.Name = (tabOpts.Title or "Tab") .. "Page"
            tabPage.Size = UDim2.new(1, 0, 1, 0)
            tabPage.BackgroundTransparency = 1
            tabPage.Visible = false
            tabPage.Parent = PageHolder

            -- Clickable
            local tabClickBtn = Instance.new("TextButton")
            tabClickBtn.Size = UDim2.new(1, 0, 1, 0)
            tabClickBtn.BackgroundTransparency = 1
            tabClickBtn.Text = ""
            tabClickBtn.Parent = tabBtn

            tabClickBtn.MouseButton1Click:Connect(function()
                accentBar.Visible = true
                setActiveTab(tabPage, tabBtn)
                -- Ocultar accent bars de otros tabs
                for _, child in pairs(TabPanel:GetChildren()) do
                    if child:IsA("Frame") and child ~= tabBtn then
                        local bar = child:FindFirstChild("Frame")
                        -- reuse accentBar reference per-tab via closure
                    end
                end
            end)

            -- Autoactivar el primer tab creado
            if currentTab == nil then
                setActiveTab(tabPage, tabBtn)
                accentBar.Visible = true
            end

            local api = buildTabAPI(tabPage)
            return api
        end

        return sectionObj
    end

    return windowObj
end

-- Stub AddTheme y SetTheme (no hacen nada funcional, solo compatibilidad)
function VxnityUI:AddTheme(opts) end
function VxnityUI:SetTheme(name) end

-- ============================================================
-- FIN DE LA LIBRERÍA UI DELTA-COMPATIBLE
-- ============================================================

-- System Loader UI
local function ShowSystemLoader(onFinished)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "vxnitySystemLoader"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false

    local ok2, coreGui2 = pcall(function() return game:GetService("CoreGui") end)
    ScreenGui.Parent = (gethui and gethui()) or (ok2 and coreGui2) or LocalPlayer:WaitForChild("PlayerGui")

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 0
    bg.Parent = ScreenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0.2, 0)
    title.Position = UDim2.new(0, 0, 0.4, 0)
    title.BackgroundTransparency = 1
    title.Text = "VXNITY"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    title.TextTransparency = 1
    title.Parent = bg

    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0.08, 0)
    subtitle.Position = UDim2.new(0, 0, 0.55, 0)
    subtitle.BackgroundTransparency = 1
    subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextScaled = true
    subtitle.TextTransparency = 1
    subtitle.Parent = bg

    TweenService:Create(title, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    task.wait(0.3)

    local steps = {
        "Initializing",
        "Loading modules",
        "¿Kenyah?",
        "pronto new act."
    }

    for _, text in ipairs(steps) do
        subtitle.Text = text
        TweenService:Create(subtitle, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
        task.wait(0.6)
        TweenService:Create(subtitle, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        task.wait(0.15)
    end

    TweenService:Create(bg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    TweenService:Create(title, TweenInfo.new(0.3), {TextTransparency = 1}):Play()

    task.wait(0.5)
    ScreenGui:Destroy()

    if onFinished then
        onFinished()
    end
end

-- Security/Clean
pcall(function()
    for i,b in pairs(workspace.FE.Actions:GetChildren()) do
        if b.Name == " " then
            b:Destroy()
        end
    end
end)

pcall(function()
    for i,b in pairs(LocalPlayer.Character:GetChildren()) do
        if b.Name == " " then
            b:Destroy()
        end
    end
end)

pcall(function()
    local a = workspace.FE.Actions
    if a:FindFirstChild("KeepYourHeadUp_") then
        a.KeepYourHeadUp_:Destroy()
        local r = Instance.new("RemoteEvent")
        r.Name = "KeepYourHeadUp_"
        r.Parent = a
    else
        LocalPlayer:Kick("Anti-Cheat Updated! Send a photo of this Message in our Discord Server so we can fix it.")
    end
end)

local function isWeirdName(name)
    return string.match(name, "^[a-zA-Z]+%-%d+%a*%-%d+%a*$") ~= nil
end

local function deleteWeirdRemoteEvents(parent)
    pcall(function()
        for _, child in pairs(parent:GetChildren()) do
            if child:IsA("RemoteEvent") and isWeirdName(child.Name) then
                child:Destroy()
            end
            deleteWeirdRemoteEvents(child)
        end
    end)
end

pcall(function() deleteWeirdRemoteEvents(game) end)

local function LoadVxnityHub()
    -- Debug notification
    VxnityUI:Notify({
        Title = "vxnity hub",
        Desc = "Loading main script...",
        Icon = "loader",
        Duration = 2
    })
    
    -- Parche para Celular
    local isMobile = UserInputService.TouchEnabled
    local windowSize = isMobile and UDim2.fromOffset(480, 380) or UDim2.fromOffset(600, 520)
    local topbarHeight = isMobile and 40 or 48
    local iconSize = isMobile and 18 or 22

    local Window = VxnityUI:CreateWindow({
        Title = "vxnity hub",
        Author = "vxnity team",
        Folder = "vxnityHub",
        IconSize = iconSize,
        NewElements = true,
        Size = windowSize,
        HideSearchBar = false,
        OpenButton = {
            Title = "vxnity",
            CornerRadius = UDim.new(0, 8),
            StrokeThickness = 2,
            Enabled = true,
            Draggable = true,
            OnlyMobile = false,
            Scale = 1,
            Color = ColorSequence.new(Color3.fromHex("#9d56ff"), Color3.fromHex("#7b2eff"))
        },
        Topbar = {
            Height = topbarHeight,
            ButtonsType = "Mac",
        },
    })

    do
        VxnityUI:AddTheme({
            Name = "vxnityPremium",
            Accent = Color3.fromHex("#9d56ff"),
            Dialog = Color3.fromHex("#080808"),
            Outline = Color3.fromHex("#1a1a1a"),
            Text = Color3.fromHex("#ffffff"),
            Placeholder = Color3.fromHex("#808080"),
            Button = Color3.fromHex("#101010"),
            Icon = Color3.fromHex("#9d56ff"),
            WindowBackground = Color3.fromHex("#030303"),
            TopbarButtonIcon = Color3.fromHex("#ffffff"),
            TopbarTitle = Color3.fromHex("#ffffff"),
            TopbarAuthor = Color3.fromHex("#9d56ff"),
            TopbarIcon = Color3.fromHex("#9d56ff"),
            TabBackground = Color3.fromHex("#050505"),
            TabTitle = Color3.fromHex("#808080"),
            TabIcon = Color3.fromHex("#9d56ff"),
            ElementBackground = Color3.fromHex("#0a0a0a"),
            ElementTitle = Color3.fromHex("#ffffff"),
            ElementDesc = Color3.fromHex("#707070"),
            ElementIcon = Color3.fromHex("#9d56ff"),
        })
        VxnityUI:SetTheme("vxnityPremium")
    end

    local HomeSection = Window:Section({ Title = "Information" })
    local HomeTab = HomeSection:Tab({ Title = "Home", Icon = "home" })

    HomeTab:Section({ Title = "Welcome to vxnity hub" })
    HomeTab:Paragraph({
        Title = "Script Version: 1.2.0",
        Desc = "Stable build for TPS Street Soccer"
    })
    HomeTab:Paragraph({
        Title = "User: " .. LocalPlayer.Name,
        Desc = "Rank: Premium User"
    })
    HomeTab:Section({ Title = "Updates" })
    HomeTab:Paragraph({
        Title = "Latest Update: 2026-02-01",
        Desc = "- Improved Reach\n- optimized ui\n- Fixed Loader issues"
    })

    local Main = Window:Section({ Title = "main" })
    local ReachTab = Main:Tab({ Title = "Reach", Icon = "target" })
    local MossingTab = Main:Tab({ Title = "Mossing", Icon = "wind" })
    local ReactTab = Main:Tab({ Title = "Reacts", Icon = "zap" })

    local Misc = Window:Section({ Title = "Utility & Extra" })
    local HelpersTab = Misc:Tab({ Title = "Helpers", Icon = "shield-check" })
    local AimbotTab = Misc:Tab({ Title = "Aimbot", Icon = "crosshair" })

    local reachEnabled = false
    local reachDistance = 1
    local reachConnection

    ReachTab:Section({ Title = "Leg Reach (Method A)" })

    ReachTab:Toggle({
        Title = "Active FireTouchInterest",
        Desc = "Triggers ball contact automatically",
        Callback = function(Value)
            reachEnabled = Value
            if not Value and reachConnection then
                reachConnection:Disconnect()
                reachConnection = nil
            end

            if Value then
                if reachConnection then reachConnection:Disconnect() end
                reachConnection = RunService.RenderStepped:Connect(function()
                    local player = LocalPlayer
                    local character = player and player.Character
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                    local humanoid = character and character:FindFirstChild("Humanoid")

                    if not (character and rootPart and humanoid) then return end
                    local tps = Workspace:FindFirstChild("TPSSystem") and Workspace.TPSSystem:FindFirstChild("TPS")
                    if not tps then return end

                    local distance = (rootPart.Position - tps.Position).Magnitude
                    if distance <= reachDistance then
                        local preferredFoot = Lighting:FindFirstChild(player.Name) and Lighting[player.Name]:FindFirstChild("PreferredFoot")
                        if preferredFoot then
                            local limbName = (humanoid.RigType == Enum.HumanoidRigType.R6)
                                and ((preferredFoot.Value == 1) and "Right Leg" or "Left Leg")
                                or ((preferredFoot.Value == 1) and "RightLowerLeg" or "LeftLowerLeg")

                            local limb = character:FindFirstChild(limbName)
                            if limb then
                                firetouchinterest(limb, tps, 0)
                                firetouchinterest(limb, tps, 1)
                            end
                        end
                    end
                end)
            end
        end
    })

    ReachTab:Slider({
        Title = "Reach Distance",
        Desc = "Adjust the activation range",
        Value = { Min = 1, Max = 15, Default = 1 },
        Callback = function(val)
            reachDistance = tonumber(val)
        end
    })

    ReachTab:Section({ Title = "Leg Reach (Method B)" })

    ReachTab:Input({
        Title = "Leg Hitbox (R6)",
        Desc = "Modifies physical size of legs",
        Value = "1",
        Callback = function(Value) 
            local v = tonumber(Value) or 1
            if LocalPlayer.Character then
                if LocalPlayer.Character:FindFirstChild("Right Leg") then
                    LocalPlayer.Character["Right Leg"].Size = Vector3.new(v, 2, v)
                    LocalPlayer.Character["Left Leg"].Size = Vector3.new(v, 2, v)
                    LocalPlayer.Character["Right Leg"].CanCollide = false
                    LocalPlayer.Character["Left Leg"].CanCollide = false
                end
                if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.Size = Vector3.new(v,2,v)
                    LocalPlayer.Character.HumanoidRootPart.CanCollide = false
                end
            end
        end
    })

    ReachTab:Input({
        Title = "Legs Size (R15)",
        Desc = "Minimum Size is 1",
        Value = "1",
        Callback = function(Value) 
            local v = tonumber(Value) or 1
            if LocalPlayer.Character then
                if LocalPlayer.Character:FindFirstChild("RightLowerLeg") then
                    LocalPlayer.Character["RightLowerLeg"].Size = Vector3.new(v, 2, v)
                    LocalPlayer.Character["LeftLowerLeg"].Size = Vector3.new(v, 2, v)
                    LocalPlayer.Character["RightLowerLeg"].CanCollide = false
                    LocalPlayer.Character["LeftLowerLeg"].CanCollide = false
                end
                if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.Size = Vector3.new(v,2,v)
                    LocalPlayer.Character.HumanoidRootPart.CanCollide = false
                end
            end
        end
    })

    ReachTab:Button({
        Title = "Fake legs (Appear Normal)",
        Callback = function()
            local player = LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")

            if humanoid.RigType == Enum.HumanoidRigType.R6 then
                character["Right Leg"].Transparency = 1
                character["Left Leg"].Transparency = 1

                character["Left Leg"].Massless = true
                local LeftLegM = Instance.new("Part", character)
                LeftLegM.Name = "Left Leg Fake"
                LeftLegM.CanCollide = false
                LeftLegM.Color = character["Left Leg"].Color
                LeftLegM.Size = Vector3.new(1, 2, 1)
                LeftLegM.Position = character["Left Leg"].Position
                
                local MotorHip = Instance.new("Motor6D", character.Torso)
                MotorHip.Part0 = character.Torso
                MotorHip.Part1 = LeftLegM
                MotorHip.C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                MotorHip.C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)

                character["Right Leg"].Massless = true
                local RightLegM = Instance.new("Part", character)
                RightLegM.Name = "Right Leg Fake"
                RightLegM.CanCollide = false
                RightLegM.Color = character["Right Leg"].Color
                RightLegM.Size = Vector3.new(1, 2, 1)
                RightLegM.Position = character["Right Leg"].Position

                local MotorHip2 = Instance.new("Motor6D", character.Torso)
                MotorHip2.Part0 = character.Torso
                MotorHip2.Part1 = RightLegM
                MotorHip2.C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                MotorHip2.C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            end
        end
    })

    local headReachEnabled = false
    local headReachSize = Vector3.new(1, 1.5, 1)
    local headTransparency = 0.5
    local headOffset = Vector3.new(0, 0, 0)
    local headBoxPart
    local headConnection

    local function updateHeadBox()
        if headBoxPart then headBoxPart:Destroy() end
        headBoxPart = Instance.new("Part")
        headBoxPart.Size = headReachSize
        headBoxPart.Transparency = headTransparency
        headBoxPart.Anchored = true
        headBoxPart.CanCollide = false
        headBoxPart.Color = Color3.fromHex("#9d56ff")
        headBoxPart.Material = Enum.Material.Neon
        headBoxPart.Name = "HeadReachBox"
        headBoxPart.Parent = Workspace
    end

    local function startHeadReach()
        if not headReachEnabled then return end
        if headConnection then headConnection:Disconnect() end
        updateHeadBox()
        headConnection = RunService.RenderStepped:Connect(function()
            local character = LocalPlayer.Character
            if not character then return end
            local head = character:FindFirstChild("Head")
            local tps = Workspace:FindFirstChild("TPSSystem") and Workspace.TPSSystem:FindFirstChild("TPS")
            if not (head and tps) then return end
            
            headBoxPart.CFrame = head.CFrame * CFrame.new(headOffset)
            
            local relative = headBoxPart.CFrame:PointToObjectSpace(tps.Position)
            if math.abs(relative.X) <= headBoxPart.Size.X / 2 
                and math.abs(relative.Y) <= headBoxPart.Size.Y / 2 
                and math.abs(relative.Z) <= headBoxPart.Size.Z / 2 then
                firetouchinterest(head, tps, 0)
                firetouchinterest(head, tps, 1)
            end
        end)
    end

    MossingTab:Toggle({
        Title = "Active Moss Reach",
        Desc = "Enable head-based interaction range",
        Callback = function(state)
            headReachEnabled = state
            if state then startHeadReach() else 
                if headConnection then headConnection:Disconnect() end
                if headBoxPart then headBoxPart:Destroy() end
            end
        end
    })

    MossingTab:Slider({
        Title = "Range X",
        Value = { Min = 0, Max = 50, Default = 1 },
        Callback = function(val)
            headReachSize = Vector3.new(val, headReachSize.Y, headReachSize.Z)
            if headReachEnabled then updateHeadBox() end
        end
    })

    MossingTab:Slider({
        Title = "Range Y",
        Value = { Min = 0, Max = 50, Default = 1.5 },
        Callback = function(val)
            headReachSize = Vector3.new(headReachSize.X, val, headReachSize.Z)
            headOffset = Vector3.new(headOffset.X, val / 2.5, headOffset.Z)
            if headReachEnabled then updateHeadBox() end
        end
    })

    MossingTab:Slider({
        Title = "Range Z",
        Value = { Min = 0, Max = 50, Default = 1 },
        Callback = function(val)
            headReachSize = Vector3.new(headReachSize.X, headReachSize.Y, val)
            if headReachEnabled then updateHeadBox() end
        end
    })

    MossingTab:Toggle({
        Title = "Stealth Mode",
        Desc = "Makes the reach box invisible",
        Callback = function(v)
            headTransparency = v and 1 or 0.5
            if headReachEnabled and headBoxPart then
                headBoxPart.Transparency = headTransparency
            end
        end
    })

    local currentReactPower = 0
    local reactHookEnabled = false

    local function enableReactHook()
        if reactHookEnabled then return end
        reactHookEnabled = true
        
        local meta = getrawmetatable(game)
        local oldNamecall = meta.namecall
        setreadonly(meta, false)
        
        meta.namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if tostring(method) == "FireServer" and currentReactPower > 0 then
                local name = tostring(self)
                -- Interceptamos todas las acciones de juego para aplicar el react automáticamente
                if table.find({"Kick", "KickC1", "Tackle", "Header", "SaveRA", "SaveLA", "SaveRL", "SaveLL", "SaveT"}, name) then
                    task.spawn(function()
                        local ball = Workspace.TPSSystem:FindFirstChild("TPS")
                        if ball and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            -- Aplicamos la fuerza instantáneamente en la dirección que mira el jugador
                            -- Esto hace que el toque sea fluido y ultra rápido
                            ball.Velocity = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * currentReactPower
                            
                            -- Efecto visual de "impacto"
                            local h = Instance.new("SelectionBox", ball)
                            h.Adornee = ball
                            h.Color3 = Color3.fromHex("#9d56ff")
                            h.LineThickness = 0.15
                            task.delay(0.2, function() h:Destroy() end)
                        end
                    end)
                end
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(meta, true)
    end

    ReactTab:Section({ Title = "Advanced Auto-Reacts" })

    ReactTab:Button({
        Title = "asolixun react ",
        Desc = "W react",
        Callback = function()
            currentReactPower = 9999999999999999999
            enableReactHook()
            VxnityUI:Notify({ Title = "React Active", Desc = "asolixun react enabled", Icon = "zap" })
        end
    })

    ReactTab:Button({
        Title = "marianito react ",
        Desc = "goated react?",
        Callback = function()
            currentReactPower = 99999999999
            enableReactHook()
            VxnityUI:Notify({ Title = "React Active", Desc = "marianito react  enabled", Icon = "zap" })
        end
    })

    -- react kenyah 
    ReactTab:Button({
       Title = "✝️ - React Kenyah",
       Desc = "El mejor react 200 ms",
       Callback = function()
        currentReactPower = 999999999999999999999999
        enableReactHook()
        VxnityUI:Notify({ Title = "React Active", Desc = "React Kenyah enabled", Icon = "zap" })
        -- Additional settings for improved ball control
        setBallStickiness(true)
        setBallDelay(00000000000.01)
        setBallObedience(true)
        setBallVectorSpeed(999999999999999999999999999) -- Increased speed
        -- New settings for enhanced invisibility and speed
        setReachVisibility(false)
        setReachRange(0)
        setBallSpeed(9999999999999999999999999999999999) -- Further increased ball speed
        setBallStickinessToPlayer(true) -- Ensure the ball stays close to the player
        setBallTouchCount(true) -- Count all touches
    end
    })
        ReactTab:Button({
    Title = "⚡ - No delay",
    Desc = "0 Delay",
    Callback = function()
        currentReactPower = 999999999999999999999999
        enableReactHook()
        VxnityUI:Notify({ Title = "no delay react Active", Desc = "/@//@", Icon = "zap" })
        
        -- Configuración de velocidad y control
        setBallDelay(0.0000000000000000000001) -- 0 Delay literal
        setBallStickiness(true)
        setBallObedience(true)
        
        -- Ajuste de velocidad extremo
        setBallVectorSpeed(999999999999999999999999999)
        setReachVisibility(false)
        setsetReachRange(0) -- 0 Reach literal
        setBallSpeed(9999999999999999999999999999999999)
        
        -- Configuración de regateo (Dribble)
        setBallStickinessToPlayer(true)
        setBallTouchCount(true)
        -- Añadido: SetBallTurnSpeed al máximo para agilidad de regateo
        setBallTurnSpeed(9999999999999999999999999999999999999999999999999)
    end
    })
        ReactTab:Button({
    Title = "⚡ - No delay",
    Desc = "0 Delay",
    Callback = function()
        currentReactPower = 999999999999999999999999
        enableReactHook()
        VxnityUI:Notify({ Title = "no delay react Active", Desc = "/@//@", Icon = "zap" })
        
        -- Configuración de velocidad y control
        setBallDelay(0.0000000000000000000001) -- 0 Delay literal
        setBallStickiness(true)
        setBallObedience(true)
        
        -- Ajuste de velocidad extremo
        setBallVectorSpeed(999999999999999999999999999)
        setReachVisibility(false)
        setsetReachRange(0) -- 0 Reach literal
        setBallSpeed(9999999999999999999999999999999999)
        
        -- Configuración de regateo (Dribble)
        setBallStickinessToPlayer(true)
        setBallTouchCount(true)
        -- Añadido: SetBallTurnSpeed al máximo para agilidad de regateo
        setBallTurnSpeed(9999999999999999999999999999999999999999999999999)
    end
    })

    -- Optimización adicional para el balón sin consumo de CPU
    ReactTab:Button({
    Title = "⚡ - Optimización del Balón",
    Desc = "Sin delay, interpolación 0 y velocidad máxima",
    Callback = function()
        -- Configuración de interpolación del balón
        local ball = workspace:WaitForChild("Ball")
        if ball then
            -- Desactivar interpolación
            ball:SetAttribute("NetworkIsSleeping", true)
            ball:SetAttribute("NetworkOwner", game.Players.LocalPlayer)
            
            -- Configuración física optimizada
            ball.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 0)
            
            -- Modificar velocidad y control
            local ballScript = ball:FindFirstChild("BallScript")
            if ballScript then
                ballScript:SetAttribute("InterpolationTime", 0)
                ballScript:SetAttribute("MaxSpeed", 1000)
                ballScript:SetAttribute("Acceleration", 50)
                ballScript:SetAttribute("Friction", 0.1)
            end
            
            -- Ajustes de red para reducir delay
            game:GetService("RunService").Heartbeat:Connect(function()
                if ball and ball.PrimaryPart then
                    ball:SetNetworkOwner(game.Players.LocalPlayer)
                    ball.PrimaryPart.AssemblyLinearVelocity = ball.PrimaryPart.AssemblyLinearVelocity * 1.05
                end
            end)
        end
        
        VxnityUI:Notify({ Title = "Optimización del Balón Activada", Desc = "Interpolación 0 y velocidad máxima", Icon = "zap" })
    end
    })
        ReactTab:Button({
    Title = "⚡ - Ultra Velocity",
    Desc = "Delay negativo y velocidad cuántica",
    Callback = function()
        -- Configuración de interpolación del balón ultra optimizada
        local ball = workspace:WaitForChild("Ball")
        if ball then
            -- Desactivar completamente la interpolación y predicción
            ball:SetAttribute("NetworkIsSleeping", true)
            ball:SetAttribute("NetworkOwner", game.Players.LocalPlayer)
            ball:SetAttribute("Interpolation", false)
            
            -- Configuración física ultra optimizada
            ball.CustomPhysicalProperties = PhysicalProperties.new(0.95, 0.05, 0.1, 0.5, 0)
            
            -- Modificar velocidad y control a niveles extremos
            local ballScript = ball:FindFirstChild("BallScript")
            if ballScript then
                ballScript:SetAttribute("InterpolationTime", -0.01) -- Delay negativo
                ballScript:SetAttribute("MaxSpeed", 5000) -- Velocidad 5x mayor
                ballScript:SetAttribute("Acceleration", 200) -- Aceleración instantánea
                ballScript:SetAttribute("Friction", 0.01) -- Mínima fricción
                ballScript:SetAttribute("Bounciness", 0.95) -- Máximo rebote
                ballScript:SetAttribute("GravityFactor", 0.1) -- Reducción de gravedad
            end
            
            -- Ajustes de red para delay negativo
            game:GetService("RunService").Heartbeat:Connect(function()
                if ball and ball.PrimaryPart then
                    ball:SetNetworkOwner(game.Players.LocalPlayer)
                    -- Velocidad multiplicada por 10 para efecto cuántico
                    ball.PrimaryPart.AssemblyLinearVelocity = ball.PrimaryPart.AssemblyLinearVelocity * 10
                    -- Predicción de movimiento adelantada
                    ball.PrimaryPart.Position = ball.PrimaryPart.Position + ball.PrimaryPart.AssemblyLinearVelocity * 0.02
                end
            end)
            
            -- Optimización de renderizado para reducir lag visual
            game:GetService("RunService").RenderStepped:Connect(function()
                if ball and ball.PrimaryPart then
                    -- Sincronización perfecta con el jugador
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local distance = (ball.PrimaryPart.Position - character.HumanoidRootPart.Position).Magnitude
                        if distance < 15 then
                            -- Atracción magnética al jugador
                            ball.PrimaryPart.Position = ball.PrimaryPart.Position:Lerp(character.HumanoidRootPart.Position, 0.3)
                        end
                    end
                end
            end)
        end
        
        VxnityUI:Notify({ Title = "Ultra Velocity Activado", Desc = "Delay negativo y velocidad cuántica", Icon = "zap" })
    end
    })
        
        ReactTab:Button({
    Title = "🔥 - Lua del Diablo",
    Desc = "MAX POWER + 0 Delay + 0 Reach + DRIBBLE ILEGAL",
    Callback = function()
        currentReactPower = 999999999999999999999999
        enableReactHook()
        VxnityUI:Notify({ Title = "React Kenyah Active", Desc = "Velocidad extrema y control absoluto", originalDesc = "Configuración brutal para Street Soccer", Icon = "zap" })
        
        -- Configuración de velocidad y control
        setBallDelay(0.0000000000000000000001) -- 0 Delay literal
        setBallStickiness(true)
        setBallObedience(true)
        
        -- Ajuste de velocidad extremo
        setBallVectorSpeed(999999999999999999999999999)
        setReachVisibility(false)
        setReachRange(0)
        setBallSpeed(9999999999999999999999999999999999)
        
        -- Configuración de regateo (Dribble)
        setBallStickinessToPlayer(true)
        setBallTouchCount(true)
        setBallTurnSpeed(9999999999999999999999999999999999999999999999999)
    end
    })
    
    ReactTab:Button({
        Title = "Goalkeeper React",
        Callback = function()
            local gkActions = {"SaveRA", "SaveLA", "SaveRL", "SaveLL", "SaveT", "Tackle", "Header"}
            for _, action in ipairs(gkActions) do
                local meta = getrawmetatable(game)
                local oldNamecall = meta.namecall
                setreadonly(meta, false)
                meta.namecall = newcclosure(function(self, ...)
                    local method = tostring(getnamecallmethod())
                    if method == "FireServer" and tostring(self) == action then
                        local args = {...}
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                            args[2] = LocalPlayer.Character.Humanoid.LLCL
                            return oldNamecall(self, unpack(args))
                        end
                    end
                    return oldNamecall(self, ...)
                end)
                setreadonly(meta, true)
            end
        end
    })

    HelpersTab:Section({ Title = "Ball Visuals" })

    HelpersTab:Toggle({
        Title = "ZZZ helper",
        Desc = "Highlights the ball's position",
        Callback = function(state)
            if state then
                local part = Instance.new("Part")
                part.Name = "TPS1"
                part.Size = Vector3.new(9, 0.1, 9)
                part.Anchored = true
                part.BrickColor = BrickColor.new("Bright red")
                part.Transparency = 1 
                part.Parent = Workspace
                
                RunService.RenderStepped:Connect(function()
                    local tpsTarget = Workspace:FindFirstChild("TPSSystem") and Workspace.TPSSystem:FindFirstChild("TPS")
                    if tpsTarget and part.Parent then
                        part.Position = tpsTarget.Position - Vector3.new(0, 1, 0)
                    end
                end)
            else
                if Workspace:FindFirstChild("TPS1") then Workspace.TPS1:Destroy() end
            end
        end
    })
    HelpersTab:Toggle({
    Title = "Kenyah Inf Helper",
    Desc = " aerial inf",
    Callback = function(state)

        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer

        if state then

            _G.AerialInfUltra = RunService.Heartbeat:Connect(function()

                local character = player.Character
                if not character then return end

                local root = character:FindFirstChild("HumanoidRootPart")
                local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")

                if not root then return end

                -- detectar balón
                local ball
                for _,v in pairs(workspace:GetChildren()) do
                    if v:IsA("BasePart") and v.Name:lower():find("ball") then
                        ball = v
                        break
                    end
                end

                if not ball then return end

                -- estabilidad máxima
                ball.CanCollide = false
                ball.Massless = true
                ball.AssemblyLinearVelocity = Vector3.new(0,0,0)
                ball.AssemblyAngularVelocity = Vector3.new(0,0,0)

                -- posición ultra pegada y rápida
                local base = torso or root
                local offset =
                    base.CFrame.LookVector * 0.7 +
                    Vector3.new(0,0.6,0)

                ball.CFrame = CFrame.new(base.Position + offset)

                -- pequeño empuje para que salga rápido
                ball.AssemblyLinearVelocity = base.CFrame.LookVector * 35

            end)

        else
            if _G.AerialInfUltra then
                _G.AerialInfUltra:Disconnect()
                _G.AerialInfUltra = nil
            end
        end

    end
    })
    HelpersTab:AddToggle({
    Title = "Kenyah INF TER/AIR [HELPER]",
    Desc = "Helper que guía el balón a velocidad brutal sin paralizarlo",
    Callback = function(state)
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local Workspace = workspace
        
        if state then
            -- Variable para guardar el balón y no buscarlo cada frame
            local ball
            
            -- Bucle principal optimizado con RenderStepped para máxima fluidez
            _G.KenyahINF = RunService.RenderStepped:Connect(function()
                local char = player.Character
                if not char then return end
                
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then return end
                
                local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
                local base = torso or root
                
                -- Buscar el balón solo si no se ha encontrado antes
                if not ball then
                    for _, v in ipairs(Workspace:GetDescendants()) do
                        if v:IsA("BasePart") and v.Name:lower():find("ball") then
                            ball = v
                            -- Optimización: Desactivar la colisión con el jugador para evitar bugs
                            ball.CanCollide = false
                            break
                        end
                    end
                end
                
                if not ball then return end
                
                -- Calcular la posición objetivo (pegada al torso)
                local magnetPos = base.Position + base.CFrame.LookVector * 0.25 + Vector3.new(0, 0.45, 0)
                
                -- Calcular la dirección hacia el objetivo
                local direction = (magnetPos - ball.Position).Unit
                
                -- APLICAR FUERZA ADITIVA (La clave para no paralizar)
                -- Esto añade una fuerza EN DIRECCIÓN al jugador, sin anular su velocidad actual
                -- La velocidad es muy alta para ser "ilegal" pero sin paralizar
                local currentVelocity = ball.AssemblyLinearVelocity
                local helperForce = direction * 300000000000 -- Fuerza brutal del helper
                
                -- Combinar la velocidad actual con la fuerza del helper
                -- Esto hace que el balón mantenga su movimiento natural pero sea "atraído"
                ball.AssemblyLinearVelocity = currentVelocity + helperForce
                
                -- Para un control más fino, se puede limitar la velocidad máxima
                -- pero para un efecto "ilegal", lo dejamos sin límite
            end)
        else
            -- Desconectar el evento y limpiar la variable
            if _G.KenyahINF then
                _G.KenyahINF:Disconnect()
                _G.KenyahINF = nil
                -- Opcional: Devolver la física normal al balón si se desea
                -- if ball then
                --     ball.CanCollide = true
                -- end
            end
        end
    end
    })
    
                
    
    HelpersTab:Section({ Title = "Air Dribble Assistance" })

    HelpersTab:Toggle({
        Title = "air dribble helper",
        Desc = "Show interaction area for air dribbling",
        Callback = function(state)
            if not state and Workspace:FindFirstChild("TPS_Air") then
                Workspace.TPS_Air:Destroy()
            end
        end
    })

    HelpersTab:Slider({
        Title = "Box Dimension",
        Value = { Min = 1, Max = 15, Default = 1 },
        Callback = function(val)
            local part = Workspace:FindFirstChild("TPS_Air") or Instance.new("Part")
            part.Name = "TPS_Air"
            part.Size = Vector3.new(val, 0.1, val)
            part.Anchored = true
            part.BrickColor = BrickColor.new("Bright red")
            part.Transparency = 1
            part.Parent = Workspace
            
            RunService.RenderStepped:Connect(function()
                local tpsTarget = Workspace:FindFirstChild("TPSSystem") and Workspace.TPSSystem:FindFirstChild("TPS")
                if tpsTarget and part.Parent then
                    part.Position = tpsTarget.Position - Vector3.new(0, 1, 0)
                end
            end)
        end
    })

    HelpersTab:Section({ Title = "Automation" })

    local followBall = true
    local toggleEnabled = false

    HelpersTab:Toggle({
    Title = "inf helper",
    Desc = "Character will move towards the ball automatically",
    Callback = function(state)
        toggleEnabled = state
        if not state then followBall = false end
    end
    })

    UserInputService.InputBegan:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.B and not gp and toggleEnabled then
        followBall = not followBall
    end
    end)

    RunService.RenderStepped:Connect(function()
    if followBall and toggleEnabled then
        local ball = Workspace.TPSSystem.TPS
        local playerChar = LocalPlayer.Character
        local humanoid = playerChar and playerChar:FindFirstChild("Humanoid")

        if humanoid and ball then
            
            

            -- Mueve al personaje hacia el balón de manera agresiva
            humanoid:MoveTo(ball.Position)

        
            local ballHeight = ball.Position.Y
            local charHeight = playerChar.PrimaryPart.Position.Y
            if math.abs(ballHeight - charHeight) > 1 then
                local newPosition = playerChar.PrimaryPart.Position
                newPosition = Vector3.new(newPosition.X, ballHeight, newPosition.Z)
                playerChar:SetPrimaryPartCFrame(CFrame.new(newPosition, playerChar.PrimaryPart.Position + lookVec))
            end

            -- Simula toques al balón para contar todos los toques
            local touch = Instance.new("TouchInterest")
            touch.Parent = ball
            touch.Touched:Connect(function(hit)
                if hit.Parent == playerChar then
                    -- Aquí puedes agregar lógica para contar los toques o aplicar efectos visuales
                    print("Toque contado")
                end
            end)
        end
    end
    end)

 HelpersTab:Section({ Title = "Automation" })

    local toggleEnabled = false
    local helperActive = false
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Workspace = game:GetService("Workspace")

    -- Config
    local FOLLOW_DISTANCE = 0.000000000000000000000000000000001      -- distancia a la que el ball te sigue (sin pegarse)
    local FOLLOW_SPEED = 999999          -- qué tan rápido te sigue
    local DEAD_ZONE = 12             -- si está más cerca que esto, no hace nada (no se pega)
    local MAX_DISTANCE = 0.01           -- si se aleja más de esto, lo jala fuerte
    local STRONG_PULL = 9999999999999999999           -- fuerza cuando se aleja mucho
    local SOFT_PULL = 600000000             -- fuerza suave cuando está en zona de follow

    HelpersTab:Toggle({
    Title = "inf helper",
    Desc = "[B] Toggle | inf control",
    Callback = function(state)
        toggleEnabled = state
        if not state then helperActive = false end
    end
    })

    UserInputService.InputBegan:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.B and not gp and toggleEnabled then
        helperActive = not helperActive
    end
    end)

    local function getBall()
    local tps = Workspace:FindFirstChild("TPSSystem")
    return tps and tps:FindFirstChild("TPS")
    end

    local function getOrCreateAtt(ball)
    local att = ball:FindFirstChild("_infAtt")
    if not att then
        att = Instance.new("Attachment")
        att.Name = "_infAtt"
        att.Parent = ball
    end
    return att
    end

    local function getOrCreateLV(ball, att)
    local lv = ball:FindFirstChild("_infLV")
    if not lv then
        lv = Instance.new("LinearVelocity")
        lv.Name = "_infLV"
        lv.Attachment0 = att
        lv.MaxForce = math.huge
        lv.RelativeTo = Enum.ActuatorRelativeTo.World
        lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        lv.VectorVelocity = Vector3.zero
        lv.Parent = ball
    end
    return lv
    end

    local function cleanupBall(ball)
    if not ball then return end
    pcall(function()
        local lv = ball:FindFirstChild("_infLV")
        if lv then lv.VectorVelocity = Vector3.zero end
    end)
    end

    -- Loop principal
    RunService.RenderStepped:Connect(function()
    if not (helperActive and toggleEnabled) then
        local ball = getBall()
        if ball then cleanupBall(ball) end
        return
    end

    local ball = getBall()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")

    if not (ball and hrp and hum) then return end
    if hum.Health <= 0 then return end
    if not ball:IsA("BasePart") then return end

    -- Network ownership para que el servidor acepte nuestros cambios
    pcall(function() ball:SetNetworkOwner(LocalPlayer) end)

    local ballPos = ball.Position
    local hrpPos = hrp.Position
    local dist = (ballPos - hrpPos).Magnitude

    -- Posición objetivo: detrás/lado del jugador a FOLLOW_DISTANCE, no pegado
    local lookVec = hrp.CFrame.LookVector
    local targetPos = hrpPos + (lookVec * FOLLOW_DISTANCE) + Vector3.new(0, -0.5, 0)
    local toTarget = (targetPos - ballPos)
    local toTargetDist = toTarget.Magnitude

    local att = getOrCreateAtt(ball)
    local lv = getOrCreateLV(ball, att)

    if dist > MAX_DISTANCE then
        -- Ball muy lejos: jala fuerte de vuelta
        local dir = (targetPos - ballPos).Unit
        lv.VectorVelocity = dir * STRONG_PULL
        ball.AssemblyLinearVelocity = dir * STRONG_PULL

    elseif dist > DEAD_ZONE then
        -- Zona de follow: velocidad proporcional a la distancia, suave
        local dir = toTarget.Unit
        local speed = math.clamp(toTargetDist * SOFT_PULL, 20, FOLLOW_SPEED)
        lv.VectorVelocity = dir * speed

    else
        -- Dead zone: ball cerca, no hacer nada, deja que siga su física
        lv.VectorVelocity = Vector3.zero
    end
    end)

    -- Heartbeat: anti-escape backup
    RunService.Heartbeat:Connect(function()
    if not (helperActive and toggleEnabled) then return end

    local ball = getBall()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if not (ball and hrp) then return end
    if not ball:IsA("BasePart") then return end

    local dist = (ball.Position - hrp.Position).Magnitude

    -- Solo actúa si el ball se escapa demasiado lejos
    if dist > MAX_DISTANCE * 0.8 then
        pcall(function() ball:SetNetworkOwner(LocalPlayer) end)
        local lookVec = hrp.CFrame.LookVector
        local targetPos = hrp.Position + (lookVec * FOLLOW_DISTANCE) + Vector3.new(0, -0.5, 0)
        local dir = (targetPos - ball.Position).Unit
        ball.AssemblyLinearVelocity = dir * STRONG_PULL
    end
    end)
    HelpersTab:Section({ Title = "XDD" })

    -- Services
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local LocalPlayer = Players.LocalPlayer
    local Workspace = game:GetService("Workspace")

    -- State
    local toggleEnabled = false
    local helperActive = false
    local magnetMode = true       -- Modo imán: ball se pega instantáneamente
    local predictMode = true      -- Modo predicción: anticipa movimiento del jugador
    local multiLockActive = false  -- Bloquea ball en posición fija en el espacio

    -- Config avanzada
    local CONFIG = {
    FOLLOW_DISTANCE  = 0.0000001,
    FOLLOW_SPEED     = 99999999999999999999999999999999999,
    DEAD_ZONE        = 1000000092,
    MAX_DISTANCE     = 0.01,
    STRONG_PULL      = 99999999,
    SOFT_PULL        = 6000,
    MAGNET_PULL      = 9999999499494949499499494994499949999999999,   -- fuerza modo imán
    PREDICT_OFFSET   = 100000000000,           -- cuántos studs adelante predice
    VERTICAL_OFFSET  = -0.5,        -- altura relativa al HRP
    LOCK_RADIUS      = 0.0000001,       -- radio del lock en espacio fijo
    ANGULAR_KILL     = true,        -- anula rotación del ball
    }

    -- UI Toggles
    HelpersTab:Toggle({
    Title = "Inf Helper",
    Desc = "[B] Toggle | Control infinito del ball",
    Callback = function(state)
        toggleEnabled = state
        if not state then helperActive = false end
    end
    })

    HelpersTab:Toggle({
    Title = "Magnet Mode",
    Desc = "El ball se pega instantáneamente a ti",
    Callback = function(state)
        magnetMode = state
    end
    })

    HelpersTab:Toggle({
    Title = "Predict Mode",
    Desc = "Anticipa tu movimiento, ball siempre adelante",
    Callback = function(state)
        predictMode = state
    end
    })

    HelpersTab:Toggle({
    Title = "Space Lock",
    Desc = "Congela el ball en el espacio (posición fija)",
    Callback = function(state)
        multiLockActive = state
    end
    })

    HelpersTab:Slider({
    Title = "Follow Distance",
    Min = 0,
    Max = 20,
    Default = 12,
    Callback = function(val)
        CONFIG.DEAD_ZONE = val
    end
    })

    HelpersTab:Slider({
    Title = "Vertical Offset",
    Min = -5,
    Max = 5,
    Default = -0.5,
    Callback = function(val)
        CONFIG.VERTICAL_OFFSET = val
    end
    })

    -- Keybind [B]
    UserInputService.InputBegan:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.B and not gp and toggleEnabled then
        helperActive = not helperActive
    end
    end)

    -- Helpers internos
    local function getBall()
    local tps = Workspace:FindFirstChild("TPSSystem")
    return tps and tps:FindFirstChild("TPS")
    end

    local function getOrCreateAtt(ball)
    local att = ball:FindFirstChild("_infAtt")
    if not att then
        att = Instance.new("Attachment")
        att.Name = "_infAtt"
        att.Parent = ball
    end
    return att
    end

    local function getOrCreateLV(ball, att)
    local lv = ball:FindFirstChild("_infLV")
    if not lv then
        lv = Instance.new("LinearVelocity")
        lv.Name = "_infLV"
        lv.Attachment0 = att
        lv.MaxForce = math.huge
        lv.RelativeTo = Enum.ActuatorRelativeTo.World
        lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        lv.VectorVelocity = Vector3.zero
        lv.Parent = ball
    end
    return lv
    end

    local function getOrCreateAV(ball, att)
    -- AngularVelocity para matar la rotación del ball
    local av = ball:FindFirstChild("_infAV")
    if not av then
        av = Instance.new("AngularVelocity")
        av.Name = "_infAV"
        av.Attachment0 = att
        av.MaxTorque = math.huge
        av.RelativeTo = Enum.ActuatorRelativeTo.World
        av.AngularVelocity = Vector3.zero
        av.Parent = ball
    end
    return av
    end

    local function cleanupBall(ball)
    if not ball then return end
    pcall(function()
        local lv = ball:FindFirstChild("_infLV")
        if lv then lv.VectorVelocity = Vector3.zero end
        local av = ball:FindFirstChild("_infAV")
        if av then av.AngularVelocity = Vector3.zero end
    end)
    end

    local lockedPos = nil  -- Para Space Lock

    -- Predicción de movimiento
    local lastHRPPos = nil
    local lastTick = tick()

    local function getPredictedTarget(hrp)
    local now = tick()
    local dt = now - lastTick
    lastTick = now
    local currentPos = hrp.Position

    if lastHRPPos and dt > 0 then
        local velocity = (currentPos - lastHRPPos) / dt
        lastHRPPos = currentPos
        -- Target adelante en la dirección de movimiento
        return currentPos + velocity * CONFIG.PREDICT_OFFSET + Vector3.new(0, CONFIG.VERTICAL_OFFSET, 0)
    end

    lastHRPPos = currentPos
    local lookVec = hrp.CFrame.LookVector
    return currentPos + lookVec * CONFIG.FOLLOW_DISTANCE + Vector3.new(0, CONFIG.VERTICAL_OFFSET, 0)
    end

    -- ============================================================
    -- RENDER STEPPED — lógica principal
    -- ============================================================
    RunService.RenderStepped:Connect(function()
    if not (helperActive and toggleEnabled) then
        local ball = getBall()
        if ball then cleanupBall(ball) end
        lockedPos = nil
        return
    end

    local ball = getBall()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")

    if not (ball and hrp and hum) then return end
    if hum.Health <= 0 then return end
    if not ball:IsA("BasePart") then return end

    pcall(function() ball:SetNetworkOwner(LocalPlayer) end)

    local ballPos = ball.Position
    local hrpPos = hrp.Position
    local dist = (ballPos - hrpPos).Magnitude

    local att = getOrCreateAtt(ball)
    local lv = getOrCreateLV(ball, att)

    -- Matar rotación si está activo
    if CONFIG.ANGULAR_KILL then
        local av = getOrCreateAV(ball, att)
        av.AngularVelocity = Vector3.zero
        ball.AssemblyAngularVelocity = Vector3.zero
    end

    -- ---- SPACE LOCK ----
    if multiLockActive then
        if not lockedPos then
            lockedPos = ballPos  -- congela donde está ahora
        end
        local toLock = (lockedPos - ballPos)
        local lockDist = toLock.Magnitude
        if lockDist > CONFIG.LOCK_RADIUS then
            lv.VectorVelocity = toLock.Unit * CONFIG.MAGNET_PULL
            ball.AssemblyLinearVelocity = toLock.Unit * CONFIG.MAGNET_PULL
        else
            lv.VectorVelocity = Vector3.zero
            ball.AssemblyLinearVelocity = Vector3.zero
        end
        return
    else
        lockedPos = nil
    end

    -- ---- Calcular target ----
    local targetPos
    if predictMode then
        targetPos = getPredictedTarget(hrp)
    else
        local lookVec = hrp.CFrame.LookVector
        targetPos = hrpPos + (lookVec * CONFIG.FOLLOW_DISTANCE) + Vector3.new(0, CONFIG.VERTICAL_OFFSET, 0)
    end

    local toTarget = (targetPos - ballPos)
    local toTargetDist = toTarget.Magnitude

    -- ---- MAGNET MODE ----
    if magnetMode then
        lv.VectorVelocity = toTarget.Unit * CONFIG.MAGNET_PULL
        ball.AssemblyLinearVelocity = toTarget.Unit * CONFIG.MAGNET_PULL
        return
    end

    -- ---- Lógica estándar mejorada ----
    if dist > CONFIG.MAX_DISTANCE then
        local dir = (targetPos - ballPos).Unit
        lv.VectorVelocity = dir * CONFIG.STRONG_PULL
        ball.AssemblyLinearVelocity = dir * CONFIG.STRONG_PULL

    elseif dist > CONFIG.DEAD_ZONE then
        local dir = toTarget.Unit
        local speed = math.clamp(toTargetDist * CONFIG.SOFT_PULL, 20, CONFIG.FOLLOW_SPEED)
        lv.VectorVelocity = dir * speed

    else
        lv.VectorVelocity = Vector3.zero
    end
    end)

    -- ============================================================
    -- HEARTBEAT — backup anti-escape
    -- ============================================================
    RunService.Heartbeat:Connect(function()
    if not (helperActive and toggleEnabled) then return end

    local ball = getBall()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if not (ball and hrp) then return end
    if not ball:IsA("BasePart") then return end

    -- Space Lock heartbeat
    if multiLockActive and lockedPos then
        local d = (ball.Position - lockedPos).Magnitude
        if d > CONFIG.LOCK_RADIUS then
            pcall(function() ball:SetNetworkOwner(LocalPlayer) end)
            ball.AssemblyLinearVelocity = (lockedPos - ball.Position).Unit * CONFIG.MAGNET_PULL
        end
        return
    end

    local dist = (ball.Position - hrp.Position).Magnitude

    if dist > CONFIG.MAX_DISTANCE * 0.8 then
        pcall(function() ball:SetNetworkOwner(LocalPlayer) end)
        local lookVec = hrp.CFrame.LookVector
        local targetPos = hrp.Position + (lookVec * CONFIG.FOLLOW_DISTANCE) + Vector3.new(0, CONFIG.VERTICAL_OFFSET, 0)
        ball.AssemblyLinearVelocity = (targetPos - ball.Position).Unit * CONFIG.STRONG_PULL
    end
    end)
    
    local isAimbotEnabled = false
    local aimbotTargetPos = Vector3.new(0, 14, 157)
    local laser = Instance.new("Part")
    laser.Name = "vxnity hub aimbot"
    laser.Anchored = true
    laser.CanCollide = false
    laser.Material = Enum.Material.Neon
    laser.Color = Color3.fromHex("#9d56ff")
    laser.Transparency = 1 
    laser.Size = Vector3.new(0.05, 0.05, 1) 
    laser.Parent = Workspace

    local function toggleAimbot(state)
        isAimbotEnabled = state
        laser.Transparency = isAimbotEnabled and 0.4 or 1
    end

    RunService:BindToRenderStep("vxnityAimbotLoop", Enum.RenderPriority.Camera.Value + 1, function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local torso = char and (char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"))
        
        if isAimbotEnabled and hrp and torso then
            local hrpPos = hrp.Position
            local lookTarget = Vector3.new(aimbotTargetPos.X, hrpPos.Y, aimbotTargetPos.Z)
            hrp.CFrame = CFrame.lookAt(hrpPos, lookTarget)
            
            local startPos = torso.Position + Vector3.new(0, 0.8, 0) 
            local distance = (aimbotTargetPos - startPos).Magnitude
            laser.Size = Vector3.new(0.05, 0.05, distance)
            laser.CFrame = CFrame.lookAt(startPos, aimbotTargetPos) * CFrame.new(0, 0, -distance/2)
        end
    end)

    AimbotTab:Section({ Title = "Aimbot Settings" })

    local AimbotToggle = AimbotTab:Toggle({
        Title = "Enable / Disable Aimbot",
        Callback = function(state)
            toggleAimbot(state)
        end
    })

    AimbotTab:Keybind({
        Title = "Aimbot Keybind",
        Default = Enum.KeyCode.R,
        Callback = function()
            local newState = not isAimbotEnabled
            AimbotToggle:Set(newState) 
        end
    })

    VxnityUI:Notify({
        Title = "vxnity hub",
        Desc = "Welcome back! Script loaded successfully.",
        Icon = "check",
        Duration = 4
    })
end

-- Execution Entry Point
ShowSystemLoader(function()
    task.wait(0.1) -- Parche de seguridad para asegurar limpieza de UI
    LoadVxnityHub()
end)
