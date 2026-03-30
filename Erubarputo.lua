local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/source.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

pcall(function()
    for _, b in pairs(workspace.FE.Actions:GetChildren()) do
        if b.Name == " " then b:Destroy() end
    end
end)

pcall(function()
    for _, b in pairs(LocalPlayer.Character:GetChildren()) do
        if b.Name == " " then b:Destroy() end
    end
end)

pcall(function()
    local a = workspace.FE.Actions
    if a:FindFirstChild("KeepYourHeadUp_") then
        a.KeepYourHeadUp_:Destroy()
        local r = Instance.new("RemoteEvent")
        r.Name = "KeepYourHeadUp_"
        r.Parent = a
    end
end)

pcall(function()
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
    deleteWeirdRemoteEvents(game)
end)

local Window = WindUI:CreateWindow({
    Title = "vxnity hub",
    Icon = "shield",
    Author = "0_kenyah",
    Folder = "vxnityHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    Background = "Default",
    Acrylic = true,
    Blur = true,
    KeySystem = false,
})

WindUI:SetTheme("Dark")

local Tabs = {
    Info    = Window:Tab({ Title = "Info",    Icon = "info"   }),
    Reach   = Window:Tab({ Title = "Reach",   Icon = "target" }),
    Mossing = Window:Tab({ Title = "Mossing", Icon = "wind"   }),
    Reacts  = Window:Tab({ Title = "Reacts",  Icon = "zap"    }),
}

Tabs.Info:Section({ Title = "About" })
Tabs.Info:Paragraph({
    Title = "vxnity hub  |  v1.2",
    Content = "Script para TPS Street Soccer. Compatible con Xeno executor.",
})
Tabs.Info:Paragraph({
    Title = "Usuario",
    Content = LocalPlayer.Name,
})

Tabs.Info:Section({ Title = "Credits" })
Tabs.Info:Paragraph({
    Title = "0_kenyah",
    Content = "Main developer / owner",
})
Tabs.Info:Paragraph({
    Title = "vxnity team",
    Content = "Testing, ideas & support",
})
Tabs.Info:Paragraph({
    Title = "Última actualización",
    Content = "2026 — Reach / Mossing / Reacts refactored",
})

local reachEnabled = false
local reachDistance = 1
local reachConnection

Tabs.Reach:Section({ Title = "Leg Reach (Method A)" })

Tabs.Reach:Toggle({
    Title = "FireTouchInterest",
    Description = "Activa contacto automático con el balón",
    Default = false,
    Callback = function(state)
        reachEnabled = state
        if not state and reachConnection then
            reachConnection:Disconnect()
            reachConnection = nil
            return
        end
        if state then
            if reachConnection then reachConnection:Disconnect() end
            reachConnection = RunService.RenderStepped:Connect(function()
                local character = LocalPlayer and LocalPlayer.Character
                local rootPart  = character and character:FindFirstChild("HumanoidRootPart")
                local humanoid  = character and character:FindFirstChild("Humanoid")
                if not (character and rootPart and humanoid) then return end
                local tps = Workspace:FindFirstChild("TPSSystem") and Workspace.TPSSystem:FindFirstChild("TPS")
                if not tps then return end
                if (rootPart.Position - tps.Position).Magnitude <= reachDistance then
                    local preferredFoot = Lighting:FindFirstChild(LocalPlayer.Name) and Lighting[LocalPlayer.Name]:FindFirstChild("PreferredFoot")
                    if preferredFoot then
                        local limbName = (humanoid.RigType == Enum.HumanoidRigType.R6)
                            and ((preferredFoot.Value == 1) and "Right Leg" or "Left Leg")
                            or  ((preferredFoot.Value == 1) and "RightLowerLeg" or "LeftLowerLeg")
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

Tabs.Reach:Slider({
    Title = "Reach Distance",
    Description = "Rango de activación",
    Min = 1, Max = 15, Default = 1,
    Callback = function(val)
        reachDistance = tonumber(val)
    end
})

Tabs.Reach:Section({ Title = "Leg Hitbox (Method B)" })

Tabs.Reach:Input({
    Title = "Hitbox R6",
    Description = "Tamaño de piernas R6",
    Default = "1",
    Callback = function(val)
        local v = tonumber(val) or 1
        local char = LocalPlayer.Character
        if not char then return end
        if char:FindFirstChild("Right Leg") then
            char["Right Leg"].Size  = Vector3.new(v, 2, v)
            char["Left Leg"].Size   = Vector3.new(v, 2, v)
            char["Right Leg"].CanCollide = false
            char["Left Leg"].CanCollide  = false
        end
        if char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.Size = Vector3.new(v, 2, v)
            char.HumanoidRootPart.CanCollide = false
        end
    end
})

Tabs.Reach:Input({
    Title = "Hitbox R15",
    Description = "Tamaño de piernas R15",
    Default = "1",
    Callback = function(val)
        local v = tonumber(val) or 1
        local char = LocalPlayer.Character
        if not char then return end
        if char:FindFirstChild("RightLowerLeg") then
            char["RightLowerLeg"].Size = Vector3.new(v, 2, v)
            char["LeftLowerLeg"].Size  = Vector3.new(v, 2, v)
            char["RightLowerLeg"].CanCollide = false
            char["LeftLowerLeg"].CanCollide  = false
        end
        if char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.Size = Vector3.new(v, 2, v)
            char.HumanoidRootPart.CanCollide = false
        end
    end
})

Tabs.Reach:Button({
    Title = "Fake Legs (Appear Normal)",
    Description = "Piernas grandes invisibles, apariencia normal",
    Callback = function()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hum  = char:WaitForChild("Humanoid")
        if hum.RigType == Enum.HumanoidRigType.R6 then
            char["Right Leg"].Transparency = 1
            char["Left Leg"].Transparency  = 1
            char["Left Leg"].Massless  = true
            char["Right Leg"].Massless = true
            local function makeFake(name, c0, c1)
                local orig = char[name]
                local fake = Instance.new("Part", char)
                fake.Name       = name .. " Fake"
                fake.CanCollide = false
                fake.Color      = orig.Color
                fake.Size       = Vector3.new(1, 2, 1)
                fake.Position   = orig.Position
                local m = Instance.new("Motor6D", char.Torso)
                m.Part0 = char.Torso
                m.Part1 = fake
                m.C0    = c0
                m.C1    = c1
            end
            makeFake("Left Leg",
                CFrame.new(-1,-1,0, 0,0,-1, 0,1,0, 1,0,0),
                CFrame.new(-0.5,1,0, 0,0,-1, 0,1,0, 1,0,0))
            makeFake("Right Leg",
                CFrame.new(1,-1,0, 0,0,1, 0,1,0, -1,0,0),
                CFrame.new(0.5,1,0, 0,0,1, 0,1,0, -1,0,0))
        end
    end
})

local headReachEnabled  = false
local headReachSize     = Vector3.new(1, 1.5, 1)
local headTransparency  = 0.5
local headOffset        = Vector3.new(0, 0, 0)
local headBoxPart
local headConnection

local function updateHeadBox()
    if headBoxPart then headBoxPart:Destroy() end
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
    if not headReachEnabled then return end
    if headConnection then headConnection:Disconnect() end
    updateHeadBox()
    headConnection = RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        local head = char:FindFirstChild("Head")
        local tps  = Workspace:FindFirstChild("TPSSystem") and Workspace.TPSSystem:FindFirstChild("TPS")
        if not (head and tps) then return end
        headBoxPart.CFrame = head.CFrame * CFrame.new(headOffset)
        local rel = headBoxPart.CFrame:PointToObjectSpace(tps.Position)
        if math.abs(rel.X) <= headBoxPart.Size.X/2
        and math.abs(rel.Y) <= headBoxPart.Size.Y/2
        and math.abs(rel.Z) <= headBoxPart.Size.Z/2 then
            firetouchinterest(head, tps, 0)
            firetouchinterest(head, tps, 1)
        end
    end)
end

Tabs.Mossing:Section({ Title = "Head Reach" })

Tabs.Mossing:Toggle({
    Title = "Active Moss Reach",
    Description = "Rango de cabeza para mossing",
    Default = false,
    Callback = function(state)
        headReachEnabled = state
        if state then
            startHeadReach()
        else
            if headConnection then headConnection:Disconnect() end
            if headBoxPart then headBoxPart:Destroy() end
        end
    end
})

Tabs.Mossing:Slider({
    Title = "Range X",
    Min = 0, Max = 50, Default = 1,
    Callback = function(val)
        headReachSize = Vector3.new(val, headReachSize.Y, headReachSize.Z)
        if headReachEnabled then updateHeadBox() end
    end
})

Tabs.Mossing:Slider({
    Title = "Range Y",
    Min = 0, Max = 50, Default = 1.5,
    Callback = function(val)
        headReachSize = Vector3.new(headReachSize.X, val, headReachSize.Z)
        headOffset    = Vector3.new(headOffset.X, val/2.5, headOffset.Z)
        if headReachEnabled then updateHeadBox() end
    end
})

Tabs.Mossing:Slider({
    Title = "Range Z",
    Min = 0, Max = 50, Default = 1,
    Callback = function(val)
        headReachSize = Vector3.new(headReachSize.X, headReachSize.Y, val)
        if headReachEnabled then updateHeadBox() end
    end
})

Tabs.Mossing:Toggle({
    Title = "Stealth Mode",
    Description = "Hace invisible el box de reach",
    Default = false,
    Callback = function(state)
        headTransparency = state and 1 or 0.5
        if headReachEnabled and headBoxPart then
            headBoxPart.Transparency = headTransparency
        end
    end
})

local currentReactPower = 0
local reactHookEnabled  = false

local function enableReactHook()
    if reactHookEnabled then return end
    reactHookEnabled = true
    local meta        = getrawmetatable(game)
    local oldNamecall = meta.namecall
    setreadonly(meta, false)
    meta.namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if tostring(method) == "FireServer" and currentReactPower > 0 then
            local name = tostring(self)
            if table.find({"Kick","KickC1","Tackle","Header","SaveRA","SaveLA","SaveRL","SaveLL","SaveT"}, name) then
                task.spawn(function()
                    local ball = Workspace.TPSSystem and Workspace.TPSSystem:FindFirstChild("TPS")
                    if ball and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        ball.Velocity = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * currentReactPower
                        local sel = Instance.new("SelectionBox", ball)
                        sel.Adornee      = ball
                        sel.Color3       = Color3.fromHex("#9d56ff")
                        sel.LineThickness = 0.15
                        task.delay(0.2, function() sel:Destroy() end)
                    end
                end)
            end
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(meta, true)
end

Tabs.Reacts:Section({ Title = "Reacts" })

Tabs.Reacts:Button({
    Title = "✝️  React Kenyah",
    Description = "El mejor react — 200ms",
    Callback = function()
        currentReactPower = 999999999999999999
        enableReactHook()
        WindUI:Notify({ Title = "React Kenyah", Content = "Activado", Duration = 3 })
    end
})

Tabs.Reacts:Button({
    Title = "⚡  No Delay",
    Description = "0 delay react",
    Callback = function()
        currentReactPower = 999999999999999999
        enableReactHook()
        WindUI:Notify({ Title = "No Delay", Content = "Activado", Duration = 3 })
    end
})

Tabs.Reacts:Button({
    Title = "asolixun react",
    Description = "W react",
    Callback = function()
        currentReactPower = 9999999999999999
        enableReactHook()
        WindUI:Notify({ Title = "asolixun react", Content = "Activado", Duration = 3 })
    end
})

Tabs.Reacts:Button({
    Title = "marianito react",
    Description = "goated react",
    Callback = function()
        currentReactPower = 99999999999
        enableReactHook()
        WindUI:Notify({ Title = "marianito react", Content = "Activado", Duration = 3 })
    end
})

Tabs.Reacts:Button({
    Title = "🔴  Desactivar React",
    Description = "Apaga todos los reacts",
    Callback = function()
        currentReactPower = 0
        WindUI:Notify({ Title = "React", Content = "Desactivado", Duration = 3 })
    end
})

WindUI:Notify({
    Title = "vxnity hub",
    Content = "Script cargado — 0_kenyah",
    Duration = 4,
})
