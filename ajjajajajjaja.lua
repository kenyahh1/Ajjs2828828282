local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local function ShowSystemLoader(onFinished)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui

    local bg = Instance.new("Frame", ScreenGui)
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.new(0,0,0)

    local title = Instance.new("TextLabel", bg)
    title.Size = UDim2.new(1,0,0.2,0)
    title.Position = UDim2.new(0,0,0.4,0)
    title.Text = "VXNITY"
    title.TextScaled = true
    title.BackgroundTransparency = 1
    title.TextTransparency = 1

    TweenService:Create(title,TweenInfo.new(0.5),{TextTransparency=0}):Play()
    task.wait(1.5)

    ScreenGui:Destroy()
    if onFinished then onFinished() end
end
local function LoadVxnityHub()

    OrionLib:MakeNotification({
        Name = "vxnity hub",
        Content = "Loading main script...",
        Time = 2
    })

    local Window = OrionLib:MakeWindow({
        Name = "vxnity hub",
        SaveConfig = true,
        ConfigFolder = "vxnityHub"
    })

    local HomeTab = Window:MakeTab({Name = "Home"})
    local ReachTab = Window:MakeTab({Name = "Reach"})
    local MossingTab = Window:MakeTab({Name = "Mossing"})
    local ReactTab = Window:MakeTab({Name = "Reacts"})
    local HelpersTab = Window:MakeTab({Name = "Helpers"})
    local AimbotTab = Window:MakeTab({Name = "Aimbot"})
  HomeTab:AddParagraph("Script paid", "1.0.1")
    HomeTab:AddParagraph("User", LocalPlayer.Name)
    HomeTab:AddParagraph("Status", "Loaded successfully")
  local reachEnabled = false
    local reachDistance = 1

    ReachTab:AddToggle({
        Name = "Active FireTouchInterest",
        Default = false,
        Callback = function(Value)
            reachEnabled = Value
        end
    })

    ReachTab:AddSlider({
        Name = "Reach Distance",
        Min = 1,
        Max = 15,
        Default = 1,
        Callback = function(val)
            reachDistance = val
        end
    })

    RunService.RenderStepped:Connect(function()
        if not reachEnabled then return end

        local char = LocalPlayer.Character
        if not char then return end

        local root = char:FindFirstChild("HumanoidRootPart")
        local tps = Workspace:FindFirstChild("TPSSystem") and Workspace.TPSSystem:FindFirstChild("TPS")

        if root and tps then
            if (root.Position - tps.Position).Magnitude <= reachDistance then
                firetouchinterest(root, tps, 0)
                firetouchinterest(root, tps, 1)
            end
        end
    end)
  local currentReactPower = 0

    ReactTab:AddButton({
        Name = "Kenyah React",
        Callback = function()
            currentReactPower = 999999999999999999
            OrionLib:MakeNotification({
                Name = "React",
                Content = "Kenyah Activated",
                Time = 2
            })
        end
    })

    local meta = getrawmetatable(game)
    local old = meta.__namecall
    setreadonly(meta, false)

    meta.__namecall = newcclosure(function(self,...)
        local method = getnamecallmethod()
        if method == "FireServer" and currentReactPower > 0 then
            local ball = Workspace:FindFirstChild("TPSSystem") and Workspace.TPSSystem:FindFirstChild("TPS")
            if ball and LocalPlayer.Character then
                ball.Velocity = LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * currentReactPower
            end
        end
        return old(self,...)
    end)

    setreadonly(meta, true)
  HelpersTab:AddToggle({
        Name = "Ball Magnet",
        Default = false,
        Callback = function(state)
            if state then
                RunService.RenderStepped:Connect(function()
                    local ball = Workspace:FindFirstChild("TPSSystem") and Workspace.TPSSystem:FindFirstChild("TPS")
                    local char = LocalPlayer.Character
                    if ball and char and char:FindFirstChild("HumanoidRootPart") then
                        ball.CFrame = char.HumanoidRootPart.CFrame
                    end
                end)
            end
        end
    })
  local aimbot = false
    local target = Vector3.new(0,10,100)

    AimbotTab:AddToggle({
        Name = "Enable Aimbot",
        Default = false,
        Callback = function(v)
            aimbot = v
        end
    })

    RunService.RenderStepped:Connect(function()
        if not aimbot then return end
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.lookAt(
                char.HumanoidRootPart.Position,
                target
            )
        end
    end)
  OrionLib:MakeNotification({
        Name = "vxnity hub",
        Content = "Loaded successfully",
        Time = 3
    })
end

ShowSystemLoader(function()
    LoadVxnityHub()
end)
