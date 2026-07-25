--[[
    🏄 +1 SCAPE FROM SPEED BUBBLES - CON SPEED MULTIPLIER
    SOLO 5 OPCIONES QUE FUNCIONAN
]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================
-- ═══════════════════════════════════════════
--       CONFIGURACIÓN DE OPCIONES ON/OFF
-- ═══════════════════════════════════════════
-- ============================================

local OpcionesDisponibles = {
    AutoTP = true,
    Invisible = true,
    AutoFarm = true,
    AutoRebirth = true,
    SpeedMultiplier = true,
}

-- ============================================
-- 📍 POSICIÓN DEL AUTO TP (CAMBIA ESTOS VALORES)
-- ============================================
local TPPosition = {
    X = -5931.02,
    Y = 373.07,
    Z = -1428.69
}

local HeightOffset = 2.5

-- ============================================
-- ═══════════════════════════════════════════
--            CONFIGURACIÓN VISUAL
-- ═══════════════════════════════════════════
-- ============================================

-- ============================================
-- 🎨 COLORES (Cambia los valores RGB)
-- ============================================
local Colors = {
    Background = Color3.fromRGB(10, 10, 30),
    Header = Color3.fromRGB(25, 20, 60),
    Title = Color3.fromRGB(255, 200, 100),
    SubTitle = Color3.fromRGB(180, 180, 220),
    Border = Color3.fromRGB(120, 80, 255),
    BorderGlow = Color3.fromRGB(200, 150, 255),
    ToggleOn = Color3.fromRGB(0, 220, 120),
    ToggleOff = Color3.fromRGB(60, 60, 80),
    ToggleTextOn = Color3.fromRGB(150, 255, 200),
    ToggleTextOff = Color3.fromRGB(255, 100, 100),
    FrameBG = Color3.fromRGB(20, 20, 50),
    FrameBGOn = Color3.fromRGB(20, 50, 35),
    Stroke = Color3.fromRGB(100, 70, 220),
    StrokeOn = Color3.fromRGB(0, 220, 120),
    ButtonDestroy = Color3.fromRGB(200, 30, 30),
    ButtonDestroyHover = Color3.fromRGB(255, 50, 50),
    CloseBtn = Color3.fromRGB(40, 30, 70),
    CloseBtnHover = Color3.fromRGB(200, 40, 40),
    IconColor = Color3.fromRGB(255, 255, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    DescColor = Color3.fromRGB(160, 160, 210),
    FloatButtonColor = Color3.fromRGB(255, 200, 50),
    FloatButtonText = Color3.fromRGB(0, 0, 0),
}

-- ============================================
-- 📏 TAMAÑOS (Cambia los números)
-- ============================================
local Sizes = {
    PanelWidth = 380,
    PanelHeight = 320,
    PanelCorner = 24,
    FloatButtonSize = 75,
    FloatButtonCorner = 1,
    HeaderHeight = 50,
    HeaderCorner = 24,
    TitleSize = 18,
    SubTitleSize = 0,
    ToggleHeight = 48,
    ToggleCorner = 8,
    ToggleStroke = 1.5,
    ToggleBtnWidth = 50,
    ToggleBtnHeight = 26,
    ToggleBtnCorner = 5,
    IconSize = 30,
    IconTextSize = 20,
    LabelSize = 13,
    DescSize = 9,
    DestroyHeight = 32,
    DestroyCorner = 8,
    ScrollThickness = 4,
    ScrollPadding = 20,
}

-- ============================================
-- 📍 POSICIONES (Cambia las coordenadas)
-- ============================================
local Positions = {
    FloatButton = {X = 1, Y = 0, OffsetX = -90, OffsetY = 20},
    Panel = {X = 0.5, Y = 0.5, OffsetX = -190, OffsetY = -160},
    HeaderText = {X = 15, Y = 0},
    CloseBtn = {X = 1, Y = 0.5, OffsetX = -42, OffsetY = -17},
}

-- ============================================
-- 📝 TEXTOS (Cambia los strings)
-- ============================================
local Texts = {
    Title = "🏄 +1 SCAPE FROM SPEED BUBBLES",
    FloatButton = "🏄",
    DestroyButton = "🗑️ DESTROY GUI",
    CloseButton = "✕",
    
    Option1 = "AUTO TELEPORT",
    Option1Desc = "📍 TP a posición guardada",
    Option1Icon = "📍",
    
    Option2 = "INVISIBLE",
    Option2Desc = "👻 Invisible para otros jugadores",
    Option2Icon = "👻",
    
    Option3 = "AUTO-FARM SPEED",
    Option3Desc = "⚡ Gana velocidad automáticamente",
    Option3Icon = "⚡",
    
    Option4 = "AUTO-REBIRTH",
    Option4Desc = "🔄 Rebirth automático al nivel requerido",
    Option4Icon = "🔄",
    
    Option5 = "SPEED MULTIPLIER",
    Option5Desc = "💨 Multiplica la velocidad ganada x20",
    Option5Icon = "💨",
}

-- ============================================
-- 🔤 FUENTES (Cambia Enum.Font)
-- ============================================
local Fonts = {
    Title = Enum.Font.GothamBlack,
    FloatButton = Enum.Font.GothamBlack,
    Label = Enum.Font.GothamBold,
    Desc = Enum.Font.GothamMedium,
    Toggle = Enum.Font.GothamBold,
    Destroy = Enum.Font.GothamBold,
    Close = Enum.Font.GothamBold,
    Icon = Enum.Font.Gotham,
}

-- ============================================
-- ⏱️ ANIMACIONES (Cambia la duración en segundos)
-- ============================================
local Animations = {
    OpenDuration = 0.5,
    CloseDuration = 0.4,
    ToggleDuration = 0.3,
    HoverDuration = 0.2,
    FloatPulse = 2.0,
}

-- ============================================
-- ═══════════════════════════════════════════
--           FIN CONFIGURACIÓN VISUAL
-- ═══════════════════════════════════════════
-- ============================================

-- ============================================
-- CONFIGURACIÓN SPEED MULTIPLIER
-- ============================================
local SPEED_MULTIPLIER = 20  -- 🔥 CAMBIA ESTE VALOR (ej: 5, 10, 50, 100)

-- ============================================
-- REMOTES DEL JUEGO (NO TOCAR)
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
    
    print("✅ AddSpeed:", AddSpeed ~= nil)
    print("✅ RequestRebirth:", RequestRebirth ~= nil)
end

-- ============================================
-- FUNCIONES (NO TOCAR)
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
-- ESTADO DE OPCIONES (NO TOCAR)
-- ============================================
local Settings = {
    AutoTP = false,
    Invisible = false,
    AutoFarm = false,
    AutoRebirth = false,
    SpeedMultiplier = false,
}

local TPLoop = nil
local InvisibleLoop = nil
local FarmLoop = nil
local RebirthLoop = nil
local SpeedMultiplierLoop = nil
local FloatPulseConnection = nil
local OriginalTransparency = {}

-- ============================================
-- 🔥 AUTO TP (NO TOCAR)
-- ============================================
local function ToggleAutoTP()
    if not OpcionesDisponibles.AutoTP then return end
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

-- ============================================
-- 🔥 INVISIBLE (NO TOCAR)
-- ============================================
local function ToggleInvisible()
    if not OpcionesDisponibles.Invisible then return end
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

-- ============================================
-- 🔥 AUTO-FARM SPEED (NO TOCAR)
-- ============================================
local function ToggleAutoFarm()
    if not OpcionesDisponibles.AutoFarm then return end
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

-- ============================================
-- 🔥 AUTO-REBIRTH (NO TOCAR)
-- ============================================
local function ToggleAutoRebirth()
    if not OpcionesDisponibles.AutoRebirth then return end
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

-- ============================================
-- 🔥 SPEED MULTIPLIER (NUEVA OPCIÓN)
-- ============================================
local function ToggleSpeedMultiplier()
    if not OpcionesDisponibles.SpeedMultiplier then return end
    Settings.SpeedMultiplier = not Settings.SpeedMultiplier
    
    if Settings.SpeedMultiplier then
        if not AddSpeed then print("❌ AddSpeed no disponible") Settings.SpeedMultiplier = false return end
        print("💨 Speed Multiplier ACTIVADO (x" .. SPEED_MULTIPLIER .. ")")
        
        if SpeedMultiplierLoop then pcall(function() SpeedMultiplierLoop:Disconnect() end) SpeedMultiplierLoop = nil end
        
        SpeedMultiplierLoop = RunService.Heartbeat:Connect(function()
            if not Settings.SpeedMultiplier then return end
            
            -- Disparar AddSpeed múltiples veces para multiplicar la velocidad
            for i = 1, SPEED_MULTIPLIER do
                pcall(function()
                    AddSpeed:FireServer()
                end)
            end
        end)
    else
        print("💨 Speed Multiplier DESACTIVADO")
        if SpeedMultiplierLoop then pcall(function() SpeedMultiplierLoop:Disconnect() end) SpeedMultiplierLoop = nil end
    end
end

-- ============================================
-- DESTROY GUI (NO TOCAR)
-- ============================================
local function DestroyGUI()
    if TPLoop then pcall(function() TPLoop:Disconnect() end) TPLoop = nil end
    if InvisibleLoop then pcall(function() InvisibleLoop:Disconnect() end) InvisibleLoop = nil end
    if FarmLoop then pcall(function() FarmLoop:Disconnect() end) FarmLoop = nil end
    if RebirthLoop then pcall(function() RebirthLoop:Disconnect() end) RebirthLoop = nil end
    if SpeedMultiplierLoop then pcall(function() SpeedMultiplierLoop:Disconnect() end) SpeedMultiplierLoop = nil end
    if FloatPulseConnection then pcall(function() FloatPulseConnection:Disconnect() end) FloatPulseConnection = nil end
    
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
    toggleButton.Size = UDim2.new(0, Sizes.FloatButtonSize, 0, Sizes.FloatButtonSize)
    toggleButton.Position = UDim2.new(Positions.FloatButton.X, Positions.FloatButton.OffsetX, Positions.FloatButton.Y, Positions.FloatButton.OffsetY)
    toggleButton.BackgroundColor3 = Colors.FloatButtonColor
    toggleButton.Text = Texts.FloatButton
    toggleButton.TextColor3 = Colors.FloatButtonText
    toggleButton.Font = Fonts.FloatButton
    toggleButton.TextSize = 34
    toggleButton.Parent = screenGui
    toggleButton.ZIndex = 999
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(Sizes.FloatButtonCorner, 0)
    btnCorner.Parent = toggleButton
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(200, 150, 0)
    btnStroke.Thickness = 3
    btnStroke.Parent = toggleButton
    
    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1.4, 0, 1.4, 0)
    shadow.Position = UDim2.new(-0.2, 0, -0.2, 0)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://13130321673"
    shadow.ImageTransparency = 0.5
    shadow.ZIndex = 998
    shadow.Parent = toggleButton
    
    -- PANEL
    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(0, 0, 0, 0)
    panel.Position = UDim2.new(Positions.Panel.X, Positions.Panel.OffsetX, Positions.Panel.Y, Positions.Panel.OffsetY)
    panel.BackgroundColor3 = Colors.Background
    panel.BackgroundTransparency = 0
    panel.Visible = false
    panel.ClipsDescendants = true
    panel.Parent = screenGui
    panel.ZIndex = 100
    
    local panelCorner = Instance.new("UICorner")
    panelCorner.CornerRadius = UDim.new(0, Sizes.PanelCorner)
    panelCorner.Parent = panel
    
    local panelStroke2 = Instance.new("UIStroke")
    panelStroke2.Color = Colors.Border
    panelStroke2.Thickness = 2
    panelStroke2.Transparency = 0.3
    panelStroke2.Parent = panel
    
    -- TÍTULO
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, Sizes.HeaderHeight)
    header.BackgroundColor3 = Colors.Header
    header.Parent = panel
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, Sizes.HeaderCorner)
    headerCorner.Parent = header
    
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -50, 1, 0)
    titleText.Position = UDim2.new(0, Positions.HeaderText.X, 0, Positions.HeaderText.Y)
    titleText.BackgroundTransparency = 1
    titleText.Text = Texts.Title
    titleText.TextColor3 = Colors.Title
    titleText.Font = Fonts.Title
    titleText.TextSize = Sizes.TitleSize
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = header
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(Positions.CloseBtn.X, Positions.CloseBtn.OffsetX, Positions.CloseBtn.Y, Positions.CloseBtn.OffsetY)
    closeBtn.BackgroundColor3 = Colors.CloseBtn
    closeBtn.Text = Texts.CloseButton
    closeBtn.TextColor3 = Colors.TextColor
    closeBtn.Font = Fonts.Close
    closeBtn.TextSize = 18
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = closeBtn
    
    closeBtn.MouseEnter:Connect(function()
        pcall(function()
            TweenService:Create(closeBtn, TweenInfo.new(Animations.HoverDuration), {
                BackgroundColor3 = Colors.CloseBtnHover
            }):Play()
        end)
    end)
    
    closeBtn.MouseLeave:Connect(function()
        pcall(function()
            TweenService:Create(closeBtn, TweenInfo.new(Animations.HoverDuration), {
                BackgroundColor3 = Colors.CloseBtn
            }):Play()
        end)
    end)
    
    -- SCROLLING FRAME
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -Sizes.ScrollPadding, 1, -Sizes.HeaderHeight - 30)
    scrollFrame.Position = UDim2.new(0, Sizes.ScrollPadding/2, 0, Sizes.HeaderHeight + 15)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = Sizes.ScrollThickness
    scrollFrame.ScrollBarImageColor3 = Colors.Border
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.Parent = panel
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scrollFrame
    
    -- FUNCIÓN PARA CREAR TOGGLE
    local function CreateToggle(text, desc, icon, toggleFunc, getState, isAvailable)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, Sizes.ToggleHeight)
        frame.BackgroundColor3 = isAvailable and Colors.FrameBG or Colors.FrameBGBlocked
        frame.BackgroundTransparency = isAvailable and 0.2 or 0.1
        frame.Parent = scrollFrame
        
        local fCorner = Instance.new("UICorner")
        fCorner.CornerRadius = UDim.new(0, Sizes.ToggleCorner)
        fCorner.Parent = frame
        
        local fStroke = Instance.new("UIStroke")
        fStroke.Color = isAvailable and Colors.Stroke or Colors.StrokeBlocked
        fStroke.Thickness = Sizes.ToggleStroke
        fStroke.Transparency = isAvailable and 0.5 or 0.3
        fStroke.Parent = frame
        
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Size = UDim2.new(0, Sizes.IconSize, 0, Sizes.IconSize)
        iconLabel.Position = UDim2.new(0, 8, 0.5, -Sizes.IconSize/2)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = icon
        iconLabel.TextColor3 = Colors.IconColor
        iconLabel.Font = Fonts.Icon
        iconLabel.TextSize = Sizes.IconTextSize
        iconLabel.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -90, 0, 18)
        label.Position = UDim2.new(0, 44, 0, 3)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = isAvailable and Colors.TextColor or Colors.BlockedText
        label.Font = Fonts.Label
        label.TextSize = Sizes.LabelSize
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local descLabel = Instance.new("TextLabel")
        descLabel.Size = UDim2.new(1, -90, 0, 14)
        descLabel.Position = UDim2.new(0, 44, 0, 22)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = desc
        descLabel.TextColor3 = isAvailable and Colors.DescColor or Colors.BlockedText
        descLabel.Font = Fonts.Desc
        descLabel.TextSize = Sizes.DescSize
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Parent = frame
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, Sizes.ToggleBtnWidth, 0, Sizes.ToggleBtnHeight)
        toggleBtn.Position = UDim2.new(1, -(Sizes.ToggleBtnWidth + 8), 0.5, -Sizes.ToggleBtnHeight/2)
        toggleBtn.BackgroundColor3 = isAvailable and Colors.ToggleOff or Color3.fromRGB(40, 40, 50)
        toggleBtn.TextColor3 = isAvailable and Colors.ToggleTextOff or Color3.fromRGB(100, 100, 120)
        toggleBtn.Text = "OFF"
        toggleBtn.Font = Fonts.Toggle
        toggleBtn.TextSize = 10
        toggleBtn.AutoButtonColor = false
        toggleBtn.Parent = frame
        
        local btnCorner2 = Instance.new("UICorner")
        btnCorner2.CornerRadius = UDim.new(0, Sizes.ToggleBtnCorner)
        btnCorner2.Parent = toggleBtn
        
        toggleBtn.MouseButton1Click:Connect(function()
            if not isAvailable then return end
            toggleFunc()
            local state = getState()
            toggleBtn.BackgroundColor3 = state and Colors.ToggleOn or Colors.ToggleOff
            toggleBtn.Text = state and "ON" or "OFF"
            toggleBtn.TextColor3 = state and Colors.ToggleTextOn or Colors.ToggleTextOff
            
            if state then
                pcall(function()
                    TweenService:Create(frame, TweenInfo.new(Animations.ToggleDuration), {
                        BackgroundColor3 = Colors.FrameBGOn,
                        BackgroundTransparency = 0.1
                    }):Play()
                    TweenService:Create(fStroke, TweenInfo.new(Animations.ToggleDuration), {
                        Color = Colors.StrokeOn,
                        Transparency = 0
                    }):Play()
                end)
            else
                pcall(function()
                    TweenService:Create(frame, TweenInfo.new(Animations.ToggleDuration), {
                        BackgroundColor3 = Colors.FrameBG,
                        BackgroundTransparency = 0.2
                    }):Play()
                    TweenService:Create(fStroke, TweenInfo.new(Animations.ToggleDuration), {
                        Color = Colors.Stroke,
                        Transparency = 0.5
                    }):Play()
                end)
            end
        end)
    end
    
    -- CREAR 5 TOGGLES
    CreateToggle(Texts.Option1, Texts.Option1Desc, Texts.Option1Icon, ToggleAutoTP, function() return Settings.AutoTP end, OpcionesDisponibles.AutoTP)
    CreateToggle(Texts.Option2, Texts.Option2Desc, Texts.Option2Icon, ToggleInvisible, function() return Settings.Invisible end, OpcionesDisponibles.Invisible)
    CreateToggle(Texts.Option3, Texts.Option3Desc, Texts.Option3Icon, ToggleAutoFarm, function() return Settings.AutoFarm end, OpcionesDisponibles.AutoFarm)
    CreateToggle(Texts.Option4, Texts.Option4Desc, Texts.Option4Icon, ToggleAutoRebirth, function() return Settings.AutoRebirth end, OpcionesDisponibles.AutoRebirth)
    CreateToggle(Texts.Option5, Texts.Option5Desc, Texts.Option5Icon, ToggleSpeedMultiplier, function() return Settings.SpeedMultiplier end, OpcionesDisponibles.SpeedMultiplier)
    
    -- BOTÓN DESTROY
    local destroyBtn = Instance.new("TextButton")
    destroyBtn.Size = UDim2.new(1, 0, 0, Sizes.DestroyHeight)
    destroyBtn.Position = UDim2.new(0, 0, 1, -(Sizes.DestroyHeight + 4))
    destroyBtn.BackgroundColor3 = Colors.ButtonDestroy
    destroyBtn.Text = Texts.DestroyButton
    destroyBtn.TextColor3 = Colors.TextColor
    destroyBtn.Font = Fonts.Destroy
    destroyBtn.TextSize = 11
    destroyBtn.Parent = scrollFrame
    
    local destroyCorner = Instance.new("UICorner")
    destroyCorner.CornerRadius = UDim.new(0, Sizes.DestroyCorner)
    destroyCorner.Parent = destroyBtn
    
    destroyBtn.MouseEnter:Connect(function()
        pcall(function()
            TweenService:Create(destroyBtn, TweenInfo.new(Animations.HoverDuration), {
                BackgroundColor3 = Colors.ButtonDestroyHover
            }):Play()
        end)
    end)
    
    destroyBtn.MouseLeave:Connect(function()
        pcall(function()
            TweenService:Create(destroyBtn, TweenInfo.new(Animations.HoverDuration), {
                BackgroundColor3 = Colors.ButtonDestroy
            }):Play()
        end)
    end)
    
    destroyBtn.MouseButton1Click:Connect(function()
        DestroyGUI()
    end)
    
    -- ABRIR/CERRAR
    local panelOpen = false
    toggleButton.MouseButton1Click:Connect(function()
        panelOpen = not panelOpen
        panel.Visible = true
        if panelOpen then
            panel.Size = UDim2.new(0, Sizes.PanelWidth, 0, Sizes.PanelHeight)
            panel.BackgroundTransparency = 0
        else
            panel.Size = UDim2.new(0, 0, 0, 0)
            panel.BackgroundTransparency = 1
            task.wait(0.3)
            panel.Visible = false
        end
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        panelOpen = false
        panel.Size = UDim2.new(0, 0, 0, 0)
        panel.BackgroundTransparency = 1
        task.wait(0.3)
        panel.Visible = false
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
    
    -- EFECTO DE PULSACIÓN
    FloatPulseConnection = RunService.Heartbeat:Connect(function()
        if not toggleButton or not toggleButton.Parent then return end
        local scale = 1 + 0.03 * math.sin(tick() * 1.5)
        pcall(function()
            TweenService:Create(toggleButton, TweenInfo.new(0.1), {
                Size = UDim2.new(0, Sizes.FloatButtonSize * scale, 0, Sizes.FloatButtonSize * scale)
            }):Play()
        end)
    end)
    
    -- MENSAJE
    local targetPos = GetTargetPosition()
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🏄 +1 SCAPE FROM SPEED BUBBLES")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📍 TP a: X=" .. targetPos.X .. ", Y=" .. targetPos.Y .. ", Z=" .. targetPos.Z)
    print("💨 Speed Multiplier: x" .. SPEED_MULTIPLIER)
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📋 Presiona 🏄 para abrir el panel")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
end

-- ============================================
-- INICIALIZAR (NO TOCAR)
-- ============================================
task.spawn(function()
    while not LocalPlayer or not LocalPlayer.PlayerGui do
        task.wait(0.5)
    end
    
    FindRemotes()
    CreateGUI()
end)

print("✅ Script cargado exitosamente!")
