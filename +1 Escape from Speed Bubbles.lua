--[[
═══════════════════════════════════════════════════════════════
                🔥 AUTO TP PRO ULTRA - VERSIÓN PREMIUM 🔥
                    Configuración Visual 1000x Mejorada
═══════════════════════════════════════════════════════════════
    
    🔧 INSTRUCCIONES DE PERSONALIZACIÓN:
    
    📍 POSICIÓN - Busca "POSICIÓN DEL AUTO TP" y cambia los valores
    📌 COLORES - Busca "COLORES" y cambia los valores RGB
    📏 TAMAÑOS - Busca "TAMAÑOS" y cambia los números
    📝 TEXTOS - Busca "TEXTOS" y cambia los strings
    🔤 FUENTES - Busca "FUENTES" y cambia Enum.Font
    ⏱️ ANIMACIONES - Busca "ANIMACIONES" y cambia la duración
    ✨ EFECTOS - Busca "EFECTOS" y cambia los valores
    
    ⚠️ NO TOCAR: Funciones, lógica de teletransporte
═══════════════════════════════════════════════════════════════
--]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================
-- ═══════════════════════════════════════════
--       CONFIGURACIÓN DE OPCIONES ON/OFF
-- ═══════════════════════════════════════════
-- ============================================

local OpcionesDisponibles = {
    AutoTP = true,
}

-- ============================================
-- 📍 POSICIÓN DEL AUTO TP
-- ============================================
local TPPosition = {
    X = -5931.02,
    Y = 373.07,
    Z = -1428.69
}

local HeightOffset = 2

-- ============================================
-- ═══════════════════════════════════════════
--            CONFIGURACIÓN VISUAL PREMIUM
-- ═══════════════════════════════════════════
-- ============================================

-- ============================================
-- 🎨 COLORES PREMIUM (Cambia los valores RGB)
-- ============================================
local Colors = {
    -- Colores principales
    Background = Color3.fromRGB(10, 10, 30),
    Header = Color3.fromRGB(25, 20, 60),
    Title = Color3.fromRGB(255, 200, 100),
    SubTitle = Color3.fromRGB(180, 180, 220),
    Border = Color3.fromRGB(120, 80, 255),
    BorderGlow = Color3.fromRGB(200, 150, 255),
    
    -- Toggles
    ToggleOn = Color3.fromRGB(0, 220, 120),
    ToggleOff = Color3.fromRGB(50, 50, 70),
    ToggleTextOn = Color3.fromRGB(150, 255, 200),
    ToggleTextOff = Color3.fromRGB(200, 100, 100),
    
    -- Frames
    FrameBG = Color3.fromRGB(20, 20, 50),
    FrameBGOn = Color3.fromRGB(20, 50, 35),
    FrameBGBlocked = Color3.fromRGB(40, 20, 20),
    Stroke = Color3.fromRGB(100, 70, 220),
    StrokeOn = Color3.fromRGB(0, 220, 120),
    StrokeBlocked = Color3.fromRGB(220, 50, 50),
    
    -- Botones
    ButtonDestroy = Color3.fromRGB(200, 30, 30),
    ButtonDestroyHover = Color3.fromRGB(255, 50, 50),
    CloseBtn = Color3.fromRGB(40, 30, 70),
    CloseBtnHover = Color3.fromRGB(200, 40, 40),
    
    -- Textos
    IconColor = Color3.fromRGB(255, 255, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    DescColor = Color3.fromRGB(160, 160, 210),
    BlockedText = Color3.fromRGB(255, 80, 80),
    
    -- Efectos especiales
    GlowColor = Color3.fromRGB(150, 100, 255),
    AccentColor = Color3.fromRGB(255, 180, 80),
}

-- ============================================
-- ✨ EFECTOS VISUALES (Cambia los valores)
-- ============================================
local Effects = {
    GlowIntensity = 0.3,      -- Intensidad del brillo (0-1)
    ShadowSize = 20,          -- Tamaño de la sombra
    CornerRadius = 24,        -- Esquinas redondeadas
    BorderGlow = true,        -- Brillo en el borde
    ParticleEffect = true,    -- Efecto de partículas en el botón
    RainbowTitle = false,     -- Título arcoíris
}

-- ============================================
-- 📏 TAMAÑOS PREMIUM (Cambia los números)
-- ============================================
local Sizes = {
    PanelWidth = 420,
    PanelHeight = 250,
    PanelCorner = 24,
    FloatButtonSize = 70,
    FloatButtonCorner = 1,
    HeaderHeight = 65,
    HeaderCorner = 24,
    TitleSize = 22,
    SubTitleSize = 13,
    ToggleHeight = 60,
    ToggleCorner = 12,
    ToggleStroke = 2,
    ToggleBtnWidth = 55,
    ToggleBtnHeight = 32,
    ToggleBtnCorner = 8,
    IconSize = 38,
    IconTextSize = 26,
    LabelSize = 15,
    DescSize = 11,
    DestroyHeight = 38,
    DestroyCorner = 12,
    ScrollThickness = 5,
    ScrollPadding = 25,
    ShadowBlur = 30,
}

-- ============================================
-- 📍 POSICIONES (Cambia las coordenadas)
-- ============================================
local Positions = {
    FloatButton = {X = 1, Y = 0, OffsetX = -85, OffsetY = 20},
    Panel = {X = 0.5, Y = 0.5, OffsetX = -210, OffsetY = -125},
    HeaderText = {X = 20, Y = 0},
    SubHeaderText = {X = 20, Y = 38},
    CloseBtn = {X = 1, Y = 0.5, OffsetX = -45, OffsetY = -18},
}

-- ============================================
-- 📝 TEXTOS PREMIUM (Cambia los strings)
-- ============================================
local Texts = {
    Title = "+1 SCAPE FROM SPEED BUBBLES",
    SubTitle = "✦ TELEPORT PREMIUM ✦",
    FloatButton = "✦",
    DestroyButton = "🗑️ DESTROY GUI",
    CloseButton = "✕",
    
    Option1 = "AUTO TELEPORT",
    Option1Desc = "📍 TP a posición guardada",
    Option1Icon = "📍",
}

-- ============================================
-- 🔤 FUENTES PREMIUM (Cambia Enum.Font)
-- ============================================
local Fonts = {
    Title = Enum.Font.GothamBlack,
    SubTitle = Enum.Font.GothamMedium,
    FloatButton = Enum.Font.GothamBlack,
    Label = Enum.Font.GothamBold,
    Desc = Enum.Font.GothamMedium,
    Toggle = Enum.Font.GothamBold,
    Destroy = Enum.Font.GothamBold,
    Close = Enum.Font.GothamBold,
    Icon = Enum.Font.Gotham,
}

-- ============================================
-- ⏱️ ANIMACIONES PREMIUM (Cambia la duración)
-- ============================================
local Animations = {
    OpenDuration = 0.6,
    CloseDuration = 0.4,
    ToggleDuration = 0.35,
    HoverDuration = 0.2,
    FloatPulse = 2.0,
    GlowPulse = 1.5,
}

-- ============================================
-- ═══════════════════════════════════════════
--           FIN CONFIGURACIÓN VISUAL
-- ═══════════════════════════════════════════
-- ============================================

-- ============================================
-- CONFIGURACIÓN DE OPCIONES
-- ============================================
local Settings = {
    AutoTP = false,
}

local TPLoop = nil
local FloatPulseConnection = nil
local GlowConnection = nil

-- ============================================
-- FUNCIONES DE UTILIDAD
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

-- ============================================
-- 🔥 AUTO TP
-- ============================================
local function GetTargetPosition()
    return Vector3.new(
        TPPosition.X,
        TPPosition.Y + HeightOffset,
        TPPosition.Z
    )
end

local function ToggleAutoTP()
    if not OpcionesDisponibles.AutoTP then
        print("❌ Auto TP DESACTIVADO")
        return
    end
    
    Settings.AutoTP = not Settings.AutoTP
    
    if Settings.AutoTP then
        local targetPos = GetTargetPosition()
        print("📍 Auto TP ACTIVADO")
        
        local hrp = GetHRP()
        if hrp then
            pcall(function()
                hrp.CFrame = CFrame.new(targetPos)
                hrp.Velocity = Vector3.new(0, 0, 0)
            end)
        end
        
        if TPLoop then 
            pcall(function() TPLoop:Disconnect() end)
            TPLoop = nil 
        end
        
        TPLoop = RunService.Heartbeat:Connect(function()
            if not Settings.AutoTP then return end
            local hrp = GetHRP()
            if not hrp then return end
            
            local targetPos2 = GetTargetPosition()
            local distance = (hrp.Position - targetPos2).Magnitude
            
            if distance > 3 then
                pcall(function()
                    hrp.CFrame = CFrame.new(targetPos2)
                    hrp.Velocity = Vector3.new(0, 0, 0)
                end)
            end
        end)
    else
        print("📍 Auto TP DESACTIVADO")
        if TPLoop then 
            pcall(function() TPLoop:Disconnect() end)
            TPLoop = nil 
        end
    end
end

-- ============================================
-- DESTROY GUI
-- ============================================
local function DestroyGUI()
    if TPLoop then pcall(function() TPLoop:Disconnect() end) TPLoop = nil end
    if FloatPulseConnection then pcall(function() FloatPulseConnection:Disconnect() end) FloatPulseConnection = nil end
    if GlowConnection then pcall(function() GlowConnection:Disconnect() end) GlowConnection = nil end
    
    pcall(function()
        local gui = PlayerGui:FindFirstChild("AutoTPProGUI")
        if gui then gui:Destroy() end
    end)
    
    print("🗑️ GUI destruida")
end

-- ============================================
-- CREAR GUI PREMIUM
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
    
    -- ==========================================
    -- BOTÓN FLOTANTE PREMIUM
    -- ==========================================
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, Sizes.FloatButtonSize, 0, Sizes.FloatButtonSize)
    toggleButton.Position = UDim2.new(Positions.FloatButton.X, Positions.FloatButton.OffsetX, Positions.FloatButton.Y, Positions.FloatButton.OffsetY)
    toggleButton.BackgroundColor3 = Colors.Background
    toggleButton.Text = Texts.FloatButton
    toggleButton.TextColor3 = Colors.Title
    toggleButton.Font = Fonts.FloatButton
    toggleButton.TextSize = 34
    toggleButton.Parent = screenGui
    toggleButton.ZIndex = 999
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(Sizes.FloatButtonCorner, 0)
    btnCorner.Parent = toggleButton
    
    -- Sombra del botón
    local btnShadow = Instance.new("ImageLabel")
    btnShadow.Size = UDim2.new(1.3, 0, 1.3, 0)
    btnShadow.Position = UDim2.new(-0.15, 0, -0.15, 0)
    btnShadow.BackgroundTransparency = 1
    btnShadow.Image = "rbxassetid://13130321673"
    btnShadow.ImageTransparency = 0.6
    btnShadow.ZIndex = 998
    btnShadow.Parent = toggleButton
    
    -- Glow del botón
    local btnGlow = Instance.new("ImageLabel")
    btnGlow.Size = UDim2.new(1.8, 0, 1.8, 0)
    btnGlow.Position = UDim2.new(-0.4, 0, -0.4, 0)
    btnGlow.BackgroundTransparency = 1
    btnGlow.Image = "rbxassetid://13130321673"
    btnGlow.ImageColor3 = Colors.BorderGlow
    btnGlow.ImageTransparency = 0.7
    btnGlow.ZIndex = 997
    btnGlow.Parent = toggleButton
    
    -- Borde brillante
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Colors.Border
    btnStroke.Thickness = 2.5
    btnStroke.Transparency = 0.3
    btnStroke.Parent = toggleButton
    
    -- ==========================================
    -- PANEL PRINCIPAL PREMIUM
    -- ==========================================
    local panel = Instance.new("Frame")
    panel.Name = "MainPanel"
    panel.Size = UDim2.new(0, 0, 0, 0)
    panel.Position = UDim2.new(Positions.Panel.X, Positions.Panel.OffsetX, Positions.Panel.Y, Positions.Panel.OffsetY)
    panel.BackgroundColor3 = Colors.Background
    panel.BackgroundTransparency = 0.05
    panel.Visible = false
    panel.ClipsDescendants = true
    panel.Parent = screenGui
    panel.ZIndex = 100
    
    local panelCorner = Instance.new("UICorner")
    panelCorner.CornerRadius = UDim.new(0, Sizes.PanelCorner)
    panelCorner.Parent = panel
    
    -- Panel Shadow
    local panelShadow = Instance.new("ImageLabel")
    panelShadow.Size = UDim2.new(1.1, 20, 1.1, 20)
    panelShadow.Position = UDim2.new(-0.05, -10, -0.05, -10)
    panelShadow.BackgroundTransparency = 1
    panelShadow.Image = "rbxassetid://13130321673"
    panelShadow.ImageTransparency = 0.5
    panelShadow.ZIndex = 99
    panelShadow.Parent = panel
    
    -- Panel Stroke Premium
    local panelStroke = Instance.new("UIStroke")
    panelStroke.Color = Colors.Border
    panelStroke.Thickness = 2.5
    panelStroke.Transparency = 0.3
    panelStroke.Parent = panel
    
    -- Panel Glow
    local panelGlow = Instance.new("UIStroke")
    panelGlow.Color = Colors.BorderGlow
    panelGlow.Thickness = 4
    panelGlow.Transparency = 0.5
    panelGlow.Parent = panel
    
    -- ==========================================
    -- HEADER PREMIUM
    -- ==========================================
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, Sizes.HeaderHeight)
    header.BackgroundColor3 = Colors.Header
    header.Parent = panel
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, Sizes.HeaderCorner)
    headerCorner.Parent = header
    
    -- Línea decorativa
    local headerLine = Instance.new("Frame")
    headerLine.Size = UDim2.new(1, -40, 0, 2.5)
    headerLine.Position = UDim2.new(0, 20, 1, -3)
    headerLine.BackgroundColor3 = Colors.Border
    headerLine.BackgroundTransparency = 0.5
    headerLine.Parent = header
    
    -- Título
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -80, 1, 0)
    titleText.Position = UDim2.new(0, Positions.HeaderText.X, 0, Positions.HeaderText.Y)
    titleText.BackgroundTransparency = 1
    titleText.Text = Texts.Title
    titleText.TextColor3 = Colors.Title
    titleText.Font = Fonts.Title
    titleText.TextSize = Sizes.TitleSize
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = header
    
    -- Subtítulo
    local subText = Instance.new("TextLabel")
    subText.Size = UDim2.new(1, -80, 0, 18)
    subText.Position = UDim2.new(0, Positions.SubHeaderText.X, 0, Positions.SubHeaderText.Y)
    subText.BackgroundTransparency = 1
    subText.Text = Texts.SubTitle
    subText.TextColor3 = Colors.SubTitle
    subText.Font = Fonts.SubTitle
    subText.TextSize = Sizes.SubTitleSize
    subText.TextXAlignment = Enum.TextXAlignment.Left
    subText.Parent = header
    
    -- Botón cerrar
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 36, 0, 36)
    closeBtn.Position = UDim2.new(Positions.CloseBtn.X, Positions.CloseBtn.OffsetX, Positions.CloseBtn.Y, Positions.CloseBtn.OffsetY)
    closeBtn.BackgroundColor3 = Colors.CloseBtn
    closeBtn.Text = Texts.CloseButton
    closeBtn.TextColor3 = Colors.TextColor
    closeBtn.Font = Fonts.Close
    closeBtn.TextSize = 20
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 12)
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
    
    -- ==========================================
    -- SCROLLING FRAME
    -- ==========================================
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
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scrollFrame
    
    -- ==========================================
    -- TOGGLE PREMIUM
    -- ==========================================
    local function CreateToggle(labelText, toggleFunc, icon, desc, isAvailable)
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
        
        -- Icono
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Size = UDim2.new(0, Sizes.IconSize, 0, Sizes.IconSize)
        iconLabel.Position = UDim2.new(0, 12, 0.5, -Sizes.IconSize/2)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = icon
        iconLabel.TextColor3 = Colors.IconColor
        iconLabel.Font = Fonts.Icon
        iconLabel.TextSize = Sizes.IconTextSize
        iconLabel.Parent = frame
        
        -- Label
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -130, 0, 20)
        label.Position = UDim2.new(0, 54, 0, 5)
        label.BackgroundTransparency = 1
        label.Text = labelText
        label.TextColor3 = isAvailable and Colors.TextColor or Colors.BlockedText
        label.Font = Fonts.Label
        label.TextSize = Sizes.LabelSize
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        -- Descripción
        if desc then
            local dLabel = Instance.new("TextLabel")
            dLabel.Size = UDim2.new(1, -130, 0, 16)
            dLabel.Position = UDim2.new(0, 54, 0, 27)
            dLabel.BackgroundTransparency = 1
            dLabel.Text = desc
            dLabel.TextColor3 = isAvailable and Colors.DescColor or Colors.BlockedText
            dLabel.Font = Fonts.Desc
            dLabel.TextSize = Sizes.DescSize
            dLabel.TextXAlignment = Enum.TextXAlignment.Left
            dLabel.Parent = frame
        end
        
        -- Toggle Button Premium
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, Sizes.ToggleBtnWidth, 0, Sizes.ToggleBtnHeight)
        toggleBtn.Position = UDim2.new(1, -(Sizes.ToggleBtnWidth + 10), 0.5, -Sizes.ToggleBtnHeight/2)
        toggleBtn.BackgroundColor3 = isAvailable and Colors.ToggleOff or Color3.fromRGB(40, 40, 50)
        toggleBtn.TextColor3 = isAvailable and Colors.ToggleTextOff or Color3.fromRGB(100, 100, 120)
        toggleBtn.Text = "OFF"
        toggleBtn.Font = Fonts.Toggle
        toggleBtn.TextSize = 12
        toggleBtn.AutoButtonColor = false
        toggleBtn.Parent = frame
        
        local btnCorner2 = Instance.new("UICorner")
        btnCorner2.CornerRadius = UDim.new(0, Sizes.ToggleBtnCorner)
        btnCorner2.Parent = toggleBtn
        
        local isOn = false
        
        toggleBtn.MouseButton1Click:Connect(function()
            if not isAvailable then
                print("❌ Opción DESACTIVADA")
                return
            end
            
            isOn = not isOn
            toggleFunc()
            
            local state = Settings.AutoTP
            
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
        
        return toggleBtn
    end
    
    -- Crear toggle
    CreateToggle(Texts.Option1, ToggleAutoTP, Texts.Option1Icon, Texts.Option1Desc, OpcionesDisponibles.AutoTP)
    
    -- ==========================================
    -- BOTÓN DESTROY PREMIUM
    -- ==========================================
    local destroyBtn = Instance.new("TextButton")
    destroyBtn.Size = UDim2.new(1, 0, 0, Sizes.DestroyHeight)
    destroyBtn.Position = UDim2.new(0, 0, 1, -(Sizes.DestroyHeight + 8))
    destroyBtn.BackgroundColor3 = Colors.ButtonDestroy
    destroyBtn.Text = Texts.DestroyButton
    destroyBtn.TextColor3 = Colors.TextColor
    destroyBtn.Font = Fonts.Destroy
    destroyBtn.TextSize = 13
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
    
    -- ==========================================
    -- ANIMACIONES PREMIUM
    -- ==========================================
    local panelOpen = false
    local openTween = TweenService:Create(panel, TweenInfo.new(Animations.OpenDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, Sizes.PanelWidth, 0, Sizes.PanelHeight),
        BackgroundTransparency = 0.05
    })
    
    local closeTween = TweenService:Create(panel, TweenInfo.new(Animations.CloseDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })
    
    toggleButton.MouseButton1Click:Connect(function()
        panelOpen = not panelOpen
        panel.Visible = true
        
        if panelOpen then
            openTween:Play()
        else
            closeTween:Play()
            closeTween.Completed:Connect(function()
                panel.Visible = false
            end)
        end
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        panelOpen = false
        closeTween:Play()
        closeTween.Completed:Connect(function()
            panel.Visible = false
        end)
    end)
    
    -- ==========================================
    -- ARRASTRABLE
    -- ==========================================
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = panel.Position
        end
    end)
    
    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            panel.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- ==========================================
    -- EFECTO DE PULSACIÓN EN EL BOTÓN
    -- ==========================================
    local pulseDirection = 1
    FloatPulseConnection = RunService.Heartbeat:Connect(function()
        if not toggleButton or not toggleButton.Parent then return end
        
        local scale = 1 + 0.03 * math.sin(tick() * 1.5)
        TweenService:Create(toggleButton, TweenInfo.new(0.1), {
            Size = UDim2.new(0, Sizes.FloatButtonSize * scale, 0, Sizes.FloatButtonSize * scale)
        }):Play()
    end)
    
    -- ==========================================
    -- MENSAJE DE CARGA
    -- ==========================================
    local targetPos = GetTargetPosition()
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🔥 AUTO TP PRO ULTRA CARGADO")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📍 TP a: X=" .. targetPos.X .. ", Y=" .. targetPos.Y .. ", Z=" .. targetPos.Z)
    print("📏 Ajuste de altura: +" .. HeightOffset .. " studs")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📋 Presiona ✦ para abrir el panel")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
end

-- ============================================
-- INICIALIZAR
-- ============================================
task.spawn(function()
    while not LocalPlayer or not LocalPlayer.PlayerGui do
        task.wait(0.5)
    end
    
    CreateGUI()
end)

print("✅ Script cargado exitosamente!")
