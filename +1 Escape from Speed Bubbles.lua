--[[
    🏄 +1 SCAPE FROM SPEED BUBBLES - CON SPEED MULTIPLIER
    SOLO 6 OPCIONES QUE FUNCIONAN
]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================
-- 📍 POSICIONES DE AUTO TP
-- ============================================

local TPPositionMundo1 = {
    X = -5931.02,
    Y = 373.07,
    Z = -1428.69
}

local TPPositionMundo2 = {
    X = -3249.37,
    Y = 164.89,
    Z = -104.36
}

local TPPosition = TPPositionMundo1
local HeightOffset = 2.5
local CurrentMundo = 1

-- ============================================
-- REMOTES
-- ============================================
local AddSpeed = nil
local RequestRebirth = nil

local function FindRemotes()
    local events = ReplicatedStorage:FindFirstChild("Events")
    if events then
        AddSpeed = events:FindFirstChild("AddSpeed")
        RequestRebirth = events:FindFirstChild("RequestRebirth")
    end
    if not AddSpeed then AddSpeed = ReplicatedStorage:FindFirstChild("AddSpeed") end
    if not RequestRebirth then RequestRebirth = ReplicatedStorage:FindFirstChild("RequestRebirth") end
end

-- ============================================
-- FUNCIONES
-- ============================================
local function GetCharacter()
    local char = LocalPlayer.Character
    if not char or not char.Parent then
        char = LocalPlayer.CharacterAdded:Wait()
    end
    return char
end

local function GetHRP()
    local char = GetCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function GetHumanoid()
    local char = GetCharacter()
    return char and char:FindFirstChild("Humanoid")
end

local function GetLeaderstats()
    return LocalPlayer:FindFirstChild("leaderstats")
end

local function GetTargetPosition()
    return Vector3.new(TPPosition.X, TPPosition.Y + HeightOffset, TPPosition.Z)
end

-- ============================================
-- ESTADO
-- ============================================
local Settings = {
    AutoTP = false,
    Invisible = false,
    AutoFarm = false,
    AutoRebirth = false,
    SpeedMultiplier = false,
    LowPerformance = false,
}

local TPLoop = nil
local InvisibleLoop = nil
local FarmLoop = nil
local RebirthLoop = nil
local SpeedMultiplierLoop = nil
local FloatPulseConnection = nil
local OriginalTransparency = {}
local LowPerformanceConnection = nil

-- ============================================
-- TOGGLES
-- ============================================
local function ToggleAutoTP()
    Settings.AutoTP = not Settings.AutoTP
    if Settings.AutoTP then
        print("📍 Auto TP ACTIVADO")
        local hrp = GetHRP()
        if hrp then pcall(function()
            hrp.CFrame = CFrame.new(GetTargetPosition())
            hrp.Velocity = Vector3.new(0, 0, 0)
        end) end
        if TPLoop then pcall(function() TPLoop:Disconnect() end) TPLoop = nil end
        TPLoop = RunService.Heartbeat:Connect(function()
            if not Settings.AutoTP then return end
            local hrp = GetHRP()
            if not hrp then return end
            local targetPos = GetTargetPosition()
            if (hrp.Position - targetPos).Magnitude > 3 then
                pcall(function()
                    hrp.CFrame = CFrame.new(targetPos)
                    hrp.Velocity = Vector3.new(0, 0, 0)
                end)
            end
        end)
    else
        print("📍 Auto TP DESACTIVADO")
        if TPLoop then pcall(function() TPLoop:Disconnect() end) TPLoop = nil end
    end
end

local function ToggleInvisible()
    Settings.Invisible = not Settings.Invisible
    if Settings.Invisible then
        print("👻 Invisible ACTIVADO")
        if InvisibleLoop then pcall(function() InvisibleLoop:Disconnect() end) InvisibleLoop = nil end
        InvisibleLoop = RunService.Heartbeat:Connect(function()
            if not Settings.Invisible then return end
            local char = GetCharacter()
            if not char then return end
            pcall(function()
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("Texture") then
                        if OriginalTransparency[part] == nil then
                            OriginalTransparency[part] = part.Transparency
                        end
                        part.LocalTransparencyModifier = 1
                    end
                end
                local hum = char:FindFirstChild("Humanoid")
                if hum then hum.NameDisplayDistance = 0 end
            end)
        end)
    else
        print("👻 Invisible DESACTIVADO")
        if InvisibleLoop then pcall(function() InvisibleLoop:Disconnect() end) InvisibleLoop = nil end
        local char = GetCharacter()
        if char then
            pcall(function()
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("Texture") then
                        part.LocalTransparencyModifier = 0
                        if OriginalTransparency[part] ~= nil then
                            part.Transparency = OriginalTransparency[part]
                        end
                    end
                end
                local hum = char:FindFirstChild("Humanoid")
                if hum then hum.NameDisplayDistance = 100 end
            end)
        end
        OriginalTransparency = {}
    end
end

local function ToggleAutoFarm()
    Settings.AutoFarm = not Settings.AutoFarm
    if Settings.AutoFarm then
        if not AddSpeed then print("❌ AddSpeed no disponible") Settings.AutoFarm = false return end
        print("⚡ Auto-Farm Speed ACTIVADO")
        if FarmLoop then pcall(function() FarmLoop:Disconnect() end) FarmLoop = nil end
        FarmLoop = RunService.Heartbeat:Connect(function()
            if not Settings.AutoFarm then return end
            pcall(function() AddSpeed:FireServer() end)
        end)
    else
        print("⚡ Auto-Farm Speed DESACTIVADO")
        if FarmLoop then pcall(function() FarmLoop:Disconnect() end) FarmLoop = nil end
    end
end

local function ToggleAutoRebirth()
    Settings.AutoRebirth = not Settings.AutoRebirth
    if Settings.AutoRebirth then
        if not RequestRebirth then print("❌ RequestRebirth no disponible") Settings.AutoRebirth = false return end
        print("🔄 Auto-Rebirth ACTIVADO")
        if RebirthLoop then pcall(function() RebirthLoop:Disconnect() end) RebirthLoop = nil end
        RebirthLoop = RunService.Heartbeat:Connect(function()
            if not Settings.AutoRebirth then return end
            local stats = GetLeaderstats()
            if not stats then return end
            local level = stats:FindFirstChild("Level")
            local rebirths = stats:FindFirstChild("Rebirths")
            if not level or not rebirths then return end
            local nextLevel = (rebirths.Value + 1) * 5
            if level.Value >= nextLevel then
                pcall(function() RequestRebirth:FireServer() end)
                print("🔄 Rebirth automático! Nivel:", level.Value)
            end
        end)
    else
        print("🔄 Auto-Rebirth DESACTIVADO")
        if RebirthLoop then pcall(function() RebirthLoop:Disconnect() end) RebirthLoop = nil end
    end
end

local function ToggleSpeedMultiplier()
    Settings.SpeedMultiplier = not Settings.SpeedMultiplier
    if Settings.SpeedMultiplier then
        if not AddSpeed then print("❌ AddSpeed no disponible") Settings.SpeedMultiplier = false return end
        print("💨 Speed Multiplier ACTIVADO (x20)")
        if SpeedMultiplierLoop then pcall(function() SpeedMultiplierLoop:Disconnect() end) SpeedMultiplierLoop = nil end
        SpeedMultiplierLoop = RunService.Heartbeat:Connect(function()
            if not Settings.SpeedMultiplier then return end
            for i = 1, 20 do
                pcall(function() AddSpeed:FireServer() end)
            end
        end)
    else
        print("💨 Speed Multiplier DESACTIVADO")
        if SpeedMultiplierLoop then pcall(function() SpeedMultiplierLoop:Disconnect() end) SpeedMultiplierLoop = nil end
    end
end

-- ============================================
-- LOW PERFORMANCE MODE
-- ============================================
local function ToggleLowPerformance()
    Settings.LowPerformance = not Settings.LowPerformance
    
    if Settings.LowPerformance then
        print("⚡ Low Performance Mode ACTIVADO")
        
        pcall(function()
            Lighting.Brightness = 0.5
            Lighting.Ambient = Color3.fromRGB(128, 128, 128)
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            Lighting.ShadowSoftness = 0
            Lighting.GlobalShadows = false
        end)
        
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                    v.Enabled = false
                    Debris:AddItem(v, 0.1)
                end
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                end
            end
        end)
        
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CastShadow = false
                end
            end
        end)
        
        pcall(function()
            for _, v in ipairs(Lighting:GetChildren()) do
                if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                    v.Enabled = false
                end
            end
        end)
        
        if LowPerformanceConnection then
            LowPerformanceConnection:Disconnect()
            LowPerformanceConnection = nil
        end
        
        LowPerformanceConnection = RunService.Heartbeat:Connect(function()
            if not Settings.LowPerformance then return end
            pcall(function()
                for _, v in ipairs(Workspace:GetDescendants()) do
                    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                        v.Enabled = false
                    end
                    if v:IsA("BasePart") and v.CastShadow == true then
                        v.CastShadow = false
                    end
                end
            end)
        end)
        
    else
        print("⚡ Low Performance Mode DESACTIVADO")
        
        pcall(function()
            Lighting.Brightness = 1
            Lighting.Ambient = Color3.fromRGB(0, 0, 0)
            Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
            Lighting.ShadowSoftness = 0.5
            Lighting.GlobalShadows = true
        end)
        
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                    v.Enabled = true
                end
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.Plastic
                    v.CastShadow = true
                end
            end
        end)
        
        pcall(function()
            for _, v in ipairs(Lighting:GetChildren()) do
                if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                    v.Enabled = true
                end
            end
        end)
        
        if LowPerformanceConnection then
            LowPerformanceConnection:Disconnect()
            LowPerformanceConnection = nil
        end
    end
end

-- ============================================
-- CAMBIAR MUNDO
-- ============================================
local function SetMundo1()
    CurrentMundo = 1
    TPPosition = TPPositionMundo1
    print("🌍 Cambiado a MUNDO 1")
    if Settings.AutoTP then
        local hrp = GetHRP()
        if hrp then
            pcall(function()
                hrp.CFrame = CFrame.new(GetTargetPosition())
                hrp.Velocity = Vector3.new(0, 0, 0)
            end)
        end
    end
end

local function SetMundo2()
    CurrentMundo = 2
    TPPosition = TPPositionMundo2
    print("🌊 Cambiado a MUNDO 2")
    if Settings.AutoTP then
        local hrp = GetHRP()
        if hrp then
            pcall(function()
                hrp.CFrame = CFrame.new(GetTargetPosition())
                hrp.Velocity = Vector3.new(0, 0, 0)
            end)
        end
    end
end

-- ============================================
-- DESTROY GUI
-- ============================================
local function DestroyGUI()
    if TPLoop then pcall(function() TPLoop:Disconnect() end) TPLoop = nil end
    if InvisibleLoop then pcall(function() InvisibleLoop:Disconnect() end) InvisibleLoop = nil end
    if FarmLoop then pcall(function() FarmLoop:Disconnect() end) FarmLoop = nil end
    if RebirthLoop then pcall(function() RebirthLoop:Disconnect() end) RebirthLoop = nil end
    if SpeedMultiplierLoop then pcall(function() SpeedMultiplierLoop:Disconnect() end) SpeedMultiplierLoop = nil end
    if FloatPulseConnection then pcall(function() FloatPulseConnection:Disconnect() end) FloatPulseConnection = nil end
    if LowPerformanceConnection then pcall(function() LowPerformanceConnection:Disconnect() end) LowPerformanceConnection = nil end
    
    pcall(function()
        Lighting.Brightness = 1
        Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
        Lighting.ShadowSoftness = 0.5
        Lighting.GlobalShadows = true
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                v.Enabled = true
            end
            if v:IsA("BasePart") then
                v.CastShadow = true
            end
        end
    end)
    
    pcall(function()
        local gui = PlayerGui:FindFirstChild("AutoTPProGUI")
        if gui then gui:Destroy() end
    end)
    print("🗑️ GUI destruida")
end

-- ============================================
-- CREAR GUI
-- ============================================
local function CreateGUI()
    pcall(function()
        local old = PlayerGui:FindFirstChild("AutoTPProGUI")
        if old then old:Destroy() end
    end)
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AutoTPProGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = PlayerGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- BOTÓN FLOTANTE
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 85, 0, 85)
    toggleButton.Position = UDim2.new(1, -100, 0, 25)
    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    toggleButton.Text = "🏄"
    toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    toggleButton.Font = Enum.Font.GothamBlack
    toggleButton.TextSize = 38
    toggleButton.Parent = screenGui
    toggleButton.ZIndex = 999
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = toggleButton
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(200, 150, 0)
    btnStroke.Thickness = 3
    btnStroke.Parent = toggleButton
    
    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(1.6, 0, 1.6, 0)
    glow.Position = UDim2.new(-0.3, 0, -0.3, 0)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://13130321673"
    glow.ImageTransparency = 0.6
    glow.ZIndex = 998
    glow.Parent = toggleButton
    
    -- PANEL
    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(0, 0, 0, 0)
    panel.Position = UDim2.new(0.5, -220, 0.5, -230)
    panel.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
    panel.BackgroundTransparency = 0
    panel.Visible = false
    panel.ClipsDescendants = true
    panel.Parent = screenGui
    panel.ZIndex = 100
    
    local panelCorner = Instance.new("UICorner")
    panelCorner.CornerRadius = UDim.new(0, 24)
    panelCorner.Parent = panel
    
    local panelStroke2 = Instance.new("UIStroke")
    panelStroke2.Color = Color3.fromRGB(120, 80, 255)
    panelStroke2.Thickness = 2
    panelStroke2.Transparency = 0.3
    panelStroke2.Parent = panel
    
    -- TÍTULO
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 55)
    header.BackgroundColor3 = Color3.fromRGB(25, 20, 60)
    header.Parent = panel
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 24)
    headerCorner.Parent = header
    
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -50, 1, 0)
    titleText.Position = UDim2.new(0, 15, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "🏄 +1 SCAPE FROM SPEED BUBBLES"
    titleText.TextColor3 = Color3.fromRGB(255, 200, 100)
    titleText.Font = Enum.Font.GothamBlack
    titleText.TextSize = 20
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = header
    
    -- Animación de título
    task.spawn(function()
        while titleText and titleText.Parent do
            TweenService:Create(titleText, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                TextColor3 = Color3.fromRGB(255, 200, 100)
            }):Play()
            task.wait(2)
            TweenService:Create(titleText, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                TextColor3 = Color3.fromRGB(255, 220, 150)
            }):Play()
            task.wait(2)
        end
    end)
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.Position = UDim2.new(1, -45, 0.5, -18)
    closeBtn.BackgroundColor3 = Color3.fromRGB(40, 30, 70)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = closeBtn
    
    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(200, 40, 40),
            Size = UDim2.new(0, 38, 0, 38)
        }):Play()
    end)
    
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(40, 30, 70),
            Size = UDim2.new(0, 35, 0, 35)
        }):Play()
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        panelOpen = false
        TweenService:Create(panel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        }):Play()
        task.wait(0.3)
        panel.Visible = false
    end)
    
    -- BOTONES MUNDO 1 Y MUNDO 2
    local mundoContainer = Instance.new("Frame")
    mundoContainer.Size = UDim2.new(1, 0, 0, 45)
    mundoContainer.Position = UDim2.new(0, 0, 0, 55)
    mundoContainer.BackgroundTransparency = 1
    mundoContainer.Parent = panel
    
    -- Mundo 1
    local mundo1Btn = Instance.new("TextButton")
    mundo1Btn.Size = UDim2.new(0, 110, 0, 32)
    mundo1Btn.Position = UDim2.new(0.1, 0, 0.5, -16)
    mundo1Btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    mundo1Btn.Text = "🌍 MUNDO 1"
    mundo1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    mundo1Btn.Font = Enum.Font.GothamBold
    mundo1Btn.TextSize = 14
    mundo1Btn.BorderSizePixel = 0
    mundo1Btn.Parent = mundoContainer
    
    local mundo1Corner = Instance.new("UICorner")
    mundo1Corner.CornerRadius = UDim.new(0, 8)
    mundo1Corner.Parent = mundo1Btn
    
    mundo1Btn.MouseEnter:Connect(function()
        TweenService:Create(mundo1Btn, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 115, 0, 36)
        }):Play()
    end)
    
    mundo1Btn.MouseLeave:Connect(function()
        TweenService:Create(mundo1Btn, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 110, 0, 32)
        }):Play()
    end)
    
    mundo1Btn.MouseButton1Click:Connect(function()
        SetMundo1()
        mundo1Btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        mundo2Btn.BackgroundColor3 = Color3.fromRGB(60, 50, 150)
        TweenService:Create(mundo1Btn, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 100, 0, 28)
        }):Play()
        task.wait(0.1)
        TweenService:Create(mundo1Btn, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 110, 0, 32)
        }):Play()
    end)
    
    -- Mundo 2
    local mundo2Btn = Instance.new("TextButton")
    mundo2Btn.Size = UDim2.new(0, 110, 0, 32)
    mundo2Btn.Position = UDim2.new(0.55, 0, 0.5, -16)
    mundo2Btn.BackgroundColor3 = Color3.fromRGB(60, 50, 150)
    mundo2Btn.Text = "🌊 MUNDO 2"
    mundo2Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    mundo2Btn.Font = Enum.Font.GothamBold
    mundo2Btn.TextSize = 14
    mundo2Btn.BorderSizePixel = 0
    mundo2Btn.Parent = mundoContainer
    
    local mundo2Corner = Instance.new("UICorner")
    mundo2Corner.CornerRadius = UDim.new(0, 8)
    mundo2Corner.Parent = mundo2Btn
    
    mundo2Btn.MouseEnter:Connect(function()
        TweenService:Create(mundo2Btn, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 115, 0, 36)
        }):Play()
    end)
    
    mundo2Btn.MouseLeave:Connect(function()
        TweenService:Create(mundo2Btn, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 110, 0, 32)
        }):Play()
    end)
    
    mundo2Btn.MouseButton1Click:Connect(function()
        SetMundo2()
        mundo2Btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        mundo1Btn.BackgroundColor3 = Color3.fromRGB(60, 50, 150)
        TweenService:Create(mundo2Btn, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 100, 0, 28)
        }):Play()
        task.wait(0.1)
        TweenService:Create(mundo2Btn, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 110, 0, 32)
        }):Play()
    end)
    
    -- NOTA
    local nota = Instance.new("TextLabel")
    nota.Size = UDim2.new(1, 0, 0, 22)
    nota.Position = UDim2.new(0, 0, 0, 102)
    nota.BackgroundTransparency = 1
    nota.Text = "📍 Selecciona un mundo para cambiar la posición del TP"
    nota.TextColor3 = Color3.fromRGB(150, 150, 200)
    nota.TextSize = 12
    nota.Font = Enum.Font.Gotham
    nota.TextXAlignment = Enum.TextXAlignment.Center
    nota.Parent = panel
    
    -- SCROLLING FRAME
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -55 - 75 - 35)
    scrollFrame.Position = UDim2.new(0, 10, 0, 55 + 75 + 15)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 80, 255)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.Parent = panel
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scrollFrame
    
    -- FUNCIÓN PARA CREAR TOGGLE CON ANIMACIÓN
    local function CreateToggle(text, desc, icon, toggleFunc, getState, isAvailable)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 48)
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
        frame.BackgroundTransparency = 0.2
        frame.Parent = scrollFrame
        
        local fCorner = Instance.new("UICorner")
        fCorner.CornerRadius = UDim.new(0, 8)
        fCorner.Parent = frame
        
        local fStroke = Instance.new("UIStroke")
        fStroke.Color = Color3.fromRGB(100, 70, 220)
        fStroke.Thickness = 1.5
        fStroke.Transparency = 0.5
        fStroke.Parent = frame
        
        -- Animación de entrada del frame
        frame.Size = UDim2.new(0, 0, 0, 48)
        task.spawn(function()
            TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(1, 0, 0, 48)
            }):Play()
        end)
        
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Size = UDim2.new(0, 32, 0, 32)
        iconLabel.Position = UDim2.new(0, 8, 0.5, -16)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = icon
        iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        iconLabel.Font = Enum.Font.Gotham
        iconLabel.TextSize = 20
        iconLabel.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -90, 0, 20)
        label.Position = UDim2.new(0, 44, 0, 3)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local descLabel = Instance.new("TextLabel")
        descLabel.Size = UDim2.new(1, -90, 0, 16)
        descLabel.Position = UDim2.new(0, 44, 0, 24)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = desc
        descLabel.TextColor3 = Color3.fromRGB(160, 160, 210)
        descLabel.Font = Enum.Font.GothamMedium
        descLabel.TextSize = 10
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Parent = frame
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, 55, 0, 28)
        toggleBtn.Position = UDim2.new(1, -60, 0.5, -14)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        toggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        toggleBtn.Text = "OFF"
        toggleBtn.Font = Enum.Font.GothamBold
        toggleBtn.TextSize = 11
        toggleBtn.AutoButtonColor = false
        toggleBtn.Parent = frame
        
        local btnCorner2 = Instance.new("UICorner")
        btnCorner2.CornerRadius = UDim.new(0, 5)
        btnCorner2.Parent = toggleBtn
        
        toggleBtn.MouseEnter:Connect(function()
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 58, 0, 30)
            }):Play()
        end)
        
        toggleBtn.MouseLeave:Connect(function()
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 55, 0, 28)
            }):Play()
        end)
        
        toggleBtn.MouseButton1Click:Connect(function()
            if not isAvailable then return end
            toggleFunc()
            local state = getState()
            toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 220, 120) or Color3.fromRGB(60, 60, 80)
            toggleBtn.Text = state and "ON" or "OFF"
            toggleBtn.TextColor3 = state and Color3.fromRGB(150, 255, 200) or Color3.fromRGB(255, 100, 100)
            
            TweenService:Create(toggleBtn, TweenInfo.new(0.1), {
                Size = UDim2.new(0, 50, 0, 24)
            }):Play()
            task.wait(0.1)
            TweenService:Create(toggleBtn, TweenInfo.new(0.1), {
                Size = UDim2.new(0, 55, 0, 28)
            }):Play()
            
            if state then
                TweenService:Create(frame, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(20, 50, 35),
                    BackgroundTransparency = 0.1
                }):Play()
                TweenService:Create(fStroke, TweenInfo.new(0.3), {
                    Color = Color3.fromRGB(0, 220, 120),
                    Transparency = 0
                }):Play()
            else
                TweenService:Create(frame, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(20, 20, 50),
                    BackgroundTransparency = 0.2
                }):Play()
                TweenService:Create(fStroke, TweenInfo.new(0.3), {
                    Color = Color3.fromRGB(100, 70, 220),
                    Transparency = 0.5
                }):Play()
            end
        end)
    end
    
    -- CREAR 6 TOGGLES
    CreateToggle("AUTO TELEPORT", "📍 TP a posición guardada", "📍", ToggleAutoTP, function() return Settings.AutoTP end, true)
    CreateToggle("INVISIBLE", "👻 Invisible para otros jugadores", "👻", ToggleInvisible, function() return Settings.Invisible end, true)
    CreateToggle("AUTO-FARM SPEED", "⚡ Gana velocidad automáticamente", "⚡", ToggleAutoFarm, function() return Settings.AutoFarm end, true)
    CreateToggle("AUTO-REBIRTH", "🔄 Rebirth automático al nivel requerido", "🔄", ToggleAutoRebirth, function() return Settings.AutoRebirth end, true)
    CreateToggle("SPEED MULTIPLIER", "💨 Multiplica la velocidad ganada x20", "💨", ToggleSpeedMultiplier, function() return Settings.SpeedMultiplier end, true)
    CreateToggle("LOW PERFORMANCE", "⚡ Elimina gráficos y mejora FPS", "⚡", ToggleLowPerformance, function() return Settings.LowPerformance end, true)
    
    -- BOTÓN DESTROY
    local destroyBtn = Instance.new("TextButton")
    destroyBtn.Size = UDim2.new(1, 0, 0, 35)
    destroyBtn.Position = UDim2.new(0, 0, 1, -40)
    destroyBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    destroyBtn.Text = "🗑️ DESTROY GUI"
    destroyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    destroyBtn.Font = Enum.Font.GothamBold
    destroyBtn.TextSize = 12
    destroyBtn.Parent = scrollFrame
    
    local destroyCorner = Instance.new("UICorner")
    destroyCorner.CornerRadius = UDim.new(0, 8)
    destroyCorner.Parent = destroyBtn
    
    destroyBtn.MouseEnter:Connect(function()
        TweenService:Create(destroyBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 50, 50),
            Size = UDim2.new(1.02, 0, 0, 38)
        }):Play()
    end)
    
    destroyBtn.MouseLeave:Connect(function()
        TweenService:Create(destroyBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(200, 30, 30),
            Size = UDim2.new(1, 0, 0, 35)
        }):Play()
    end)
    
    destroyBtn.MouseButton1Click:Connect(function()
        DestroyGUI()
    end)
    
    -- ABRIR/CERRAR CON ANIMACIÓN
    local panelOpen = false
    toggleButton.MouseButton1Click:Connect(function()
        panelOpen = not panelOpen
        panel.Visible = true
        if panelOpen then
            panel.Size = UDim2.new(0, 0, 0, 0)
            panel.BackgroundTransparency = 1
            TweenService:Create(panel, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 440, 0, 460),
                BackgroundTransparency = 0
            }):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3), {
                Rotation = 45
            }):Play()
        else
            TweenService:Create(panel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1
            }):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3), {
                Rotation = 0
            }):Play()
            task.wait(0.3)
            panel.Visible = false
        end
    end)
    
    -- ARRASTRE BOTÓN
    local isDragging = false
    local dragStart = nil
    local startPos = nil
    
    toggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            dragStart = input.Position
            startPos = toggleButton.Position
        end
    end)
    
    toggleButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            toggleButton.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- ARRASTRE PANEL
    local panelDragging = false
    local panelDragStart = nil
    local panelStartPos = nil
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            panelDragging = true
            panelDragStart = input.Position
            panelStartPos = panel.Position
        end
    end)
    
    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            panelDragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if panelDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - panelDragStart
            panel.Position = UDim2.new(
                panelStartPos.X.Scale,
                panelStartPos.X.Offset + delta.X,
                panelStartPos.Y.Scale,
                panelStartPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- EFECTO DE PULSACIÓN EN EL BOTÓN
    FloatPulseConnection = RunService.Heartbeat:Connect(function()
        if not toggleButton or not toggleButton.Parent then return end
        local scale = 1 + 0.03 * math.sin(tick() * 1.5)
        TweenService:Create(toggleButton, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 85 * scale, 0, 85 * scale)
        }):Play()
        
        if glow then
            local glowScale = 1.6 + 0.2 * math.sin(tick() * 1.5)
            glow.Size = UDim2.new(glowScale, 0, glowScale, 0)
            glow.ImageTransparency = 0.5 + 0.2 * math.sin(tick() * 1.5)
        end
    end)
    
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🏄 +1 SCAPE FROM SPEED BUBBLES")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📍 Mundo 1: X=" .. TPPositionMundo1.X .. ", Y=" .. TPPositionMundo1.Y .. ", Z=" .. TPPositionMundo1.Z)
    print("📍 Mundo 2: X=" .. TPPositionMundo2.X .. ", Y=" .. TPPositionMundo2.Y .. ", Z=" .. TPPositionMundo2.Z)
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📋 Presiona 🏄 para abrir el panel")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
end

-- ============================================
-- INICIALIZAR
-- ============================================
task.spawn(function()
    while not LocalPlayer or not LocalPlayer.PlayerGui do
        task.wait(0.5)
    end
    FindRemotes()
    CreateGUI()
end)

print("✅ Script cargado exitosamente!")
