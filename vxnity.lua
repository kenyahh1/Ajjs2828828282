local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Load WindUI at the start to ensure it's available globally
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)

if not success or not WindUI then
    warn("vxnity hub: Failed to load WindUI library.")
    return
end

-- System Loader UI
local function ShowSystemLoader(onFinished)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "vxnitySystemLoader"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false

    local ok, coreGui = pcall(function()
        return game:GetService("CoreGui")
    end)
    ScreenGui.Parent = ok and coreGui or LocalPlayer:WaitForChild("PlayerGui")

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
for i,b in pairs(workspace.FE.Actions:GetChildren()) do
    if b.Name == " " then
        b:Destroy()
    end
end

for i,b in pairs(LocalPlayer.Character:GetChildren()) do
    if b.Name == " " then
        b:Destroy()
    end
end

local a = workspace.FE.Actions
if a:FindFirstChild("KeepYourHeadUp_") then
    a.KeepYourHeadUp_:Destroy()
    local r = Instance.new("RemoteEvent")
    r.Name = "KeepYourHeadUp_"
    r.Parent = a
else
    LocalPlayer:Kick("Anti-Cheat Updated! Send a photo of this Message in our Discord Server so we can fix it.")
end

local function isWeirdName(name)
    return string.match(name, "^[a-zA-Z]+%-%d+%a*%-%d+%a*$") ~= nil
end

local function deleteWeirdRemoteEvents(parent)
    for _, child in pairs(parent:GetChildren()) do
        if child:IsA("RemoteEvent") and isWeirdName(child.Name) then
            child:Destroy()
        end
        deleteWeirdRemoteEvents(child)
    end
end

deleteWeirdRemoteEvents(game)

local function LoadVxnityHub()
    -- Debug notification
    WindUI:Notify({
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

    local Window = WindUI:CreateWindow({
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
        WindUI:AddTheme({
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
        WindUI:SetTheme("vxnityPremium")
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
        Color = Color3.fromRGB(170,0,0),
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
        Color = Color3.fromRGB(170,0,0),
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
        Color = Color3.fromRGB(170,0,0),
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
        Color = Color3.fromRGB(170,0,0),
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
        Color = Color3.fromRGB(170,0,0),
        Desc = "W react",
        Callback = function()
            currentReactPower = 9999999999999999999
            enableReactHook()
            WindUI:Notify({ Title = "React Active", Desc = "asolixun react enabled", Icon = "zap" })
        end
    })

    ReactTab:Button({
        Title = "marianito react ",
        Color = Color3.fromRGB(170,0,0),
        Desc = "goated react?",
        Callback = function()
            currentReactPower = 99999999999
            enableReactHook()
            WindUI:Notify({ Title = "React Active", Desc = "marianito react  enabled", Icon = "zap" })
        end
    })

    -- react kenyah 
    ReactTab:Button({
       Title = "✝️ - React Kenyah",
       Color = Color3.fromRGB(170,0,0),
       Desc = "El mejor react 200 ms",
       Callback = function()
        currentReactPower = 999999999999999999999999
        enableReactHook()
        WindUI:Notify({ Title = "React Active", Desc = "React Kenyah enabled", Icon = "zap" })
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
    Color = Color3.fromRGB(170,0,0),
    Desc = "0 Delay",
    Callback = function()
        currentReactPower = 999999999999999999999999
        enableReactHook()
        WindUI:Notify({ Title = "no delay react Active", Desc = "/@//@", Icon = "zap" })
        
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
    Title = "🔥 - Lua del Diablo",
    Color = Color3.fromRGB(170,0,0),
    Desc = "MAX POWER + 0 Delay + 0 Reach + DRIBBLE ILEGAL",
    Callback = function()
        currentReactPower = 999999999999999999999999
        enableReactHook()
        WindUI:Notify({ Title = "React Kenyah Active", Desc = "Velocidad extrema y control absoluto", originalDesc = "Configuración brutal para Street Soccer", Icon = "zap" })
        
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
        Color = Color3.fromRGB(170,0,0),
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
        Color = Color3.fromRGB(170,0,0),
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
    Color = Color3.fromRGB(170,0,0),
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
    Color = Color3.fromRGB(170,0,0),
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
        Color = Color3.fromRGB(170,0,0),
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

    WindUI:Notify({
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
task.spawn(function()
    local TweenService = game:GetService("TweenService")

    for _,v in pairs(game.CoreGui:GetDescendants()) do
        if v:IsA("TextButton") then

            v.MouseEnter:Connect(function()
                TweenService:Create(v, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(255,60,60)
                }):Play()
            end)

            v.MouseLeave:Connect(function()
                TweenService:Create(v, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(20,20,20)
                }):Play()
            end)

        end
    end
end)
