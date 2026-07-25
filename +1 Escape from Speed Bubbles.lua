--[[
═══════════════════════════════════════════════════════════════
                    SCRIPT AUTO TP - NUEVO JUEGO
                    Configuración Visual Personalizable
═══════════════════════════════════════════════════════════════
    
    🔧 INSTRUCCIONES DE PERSONALIZACIÓN:
    
    📍 POSICIÓN - Busca "POSICIÓN DEL AUTO TP" y cambia los valores
    📌 COLORES - Busca "COLORES" y cambia los valores RGB
    📏 TAMAÑOS - Busca "TAMAÑOS" y cambia los números
    📝 TEXTOS - Busca "TEXTOS" y cambia los strings
    🔤 FUENTES - Busca "FUENTES" y cambia Enum.Font
    ⏱️ ANIMACIONES - Busca "ANIMACIONES" y cambia la duración
    
    ⚠️ NO TOCAR: Funciones, lógica de teletransporte
═══════════════════════════════════════════════════════════════
--]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================
-- ═══════════════════════════════════════════
--       CONFIGURACIÓN DE OPCIONES ON/OFF
-- ═══════════════════════════════════════════
-- ============================================

-- 🔥 AQUÍ CONTROLAS QUÉ OPCIONES ESTÁN ACTIVADAS (ON) O DESACTIVADAS (OFF)
local OpcionesDisponibles = {
    AutoTP = true,  -- true = disponible, false = bloqueada
}

-- ============================================
-- 📍 POSICIÓN DEL AUTO TP (CAMBIA ESTOS VALORES)
-- 🔥 La Y se ajusta automáticamente con HeightOffset
-- ============================================
local TPPosition = {
    X = -5931.02,
    Y = 373.07,   -- Se le sumará HeightOffset automáticamente
    Z = -1428.69
}

-- 🔥 Ajuste de altura (subir/bajar el TP)
-- Valor positivo = sube, valor negativo = baja
local HeightOffset = 2  -- Cambia este valor para ajustar la altura

-- ============================================
-- ═══════════════════════════════════════════
--            CONFIGURACIÓN VISUAL
-- ═══════════════════════════════════════════
-- ============================================

-- ============================================
-- 🎨 COLORES (Cambia los valores RGB)
-- ============================================
local Colors = {
    Background = Color3.fromRGB(20, 20, 45),
    Header = Color3.fromRGB(35, 30, 70),
    Title = Color3.fromRGB(255, 200, 100),
    SubTitle = Color3.fromRGB(160, 160, 210),
    Border = Color3.fromRGB(80, 60, 200),
    ToggleOn = Color3.fromRGB(0, 200, 100),
    ToggleOff = Color3.fromRGB(60, 60, 80),
    ToggleTextOn = Color3.fromRGB(100, 255, 100),
    ToggleTextOff = Color3.fromRGB(255, 100, 100),
    FrameBG = Color3.fromRGB(30, 30, 60),
    FrameBGOn = Color3.fromRGB(30, 55, 40),
    Stroke = Color3.fromRGB(80, 60, 200),
    StrokeOn = Color3.fromRGB(0, 200, 100),
    ButtonDestroy = Color3.fromRGB(200, 40, 40),
    ButtonDestroyHover = Color3.fromRGB(255, 50, 50),
    CloseBtn = Color3.fromRGB(50, 40, 80),
    CloseBtnHover = Color3.fromRGB(200, 40, 40),
    IconColor = Color3.fromRGB(255, 255, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    DescColor = Color3.fromRGB(150, 150, 200),
}

-- ============================================
-- 📏 TAMAÑOS (Cambia los números)
-- ============================================
local Sizes = {
    PanelWidth = 350,
    PanelHeight = 200,
    PanelCorner = 20,
    FloatButtonSize = 60,
    FloatButtonCorner = 1,
    HeaderHeight = 55,
    HeaderCorner = 20,
    TitleSize = 18,
    SubTitleSize = 11,
    ToggleHeight = 55,
    ToggleCorner = 10,
    ToggleStroke = 1.5,
    ToggleBtnWidth = 50,
    ToggleBtnHeight = 28,
    ToggleBtnCorner = 6,
    IconSize = 32,
    IconTextSize = 22,
    LabelSize = 13,
    DescSize = 10,
    DestroyHeight = 32,
    DestroyCorner = 10,
    ScrollThickness = 4,
    ScrollPadding = 20,
}

-- ============================================
-- 📍 POSICIONES (Cambia las coordenadas)
-- ============================================
local Positions = {
    FloatButton = {X = 1, Y = 0, OffsetX = -75, OffsetY = 15},
    Panel = {X = 0.5, Y = 0.5, OffsetX = -175, OffsetY = -100},
    HeaderText = {X = 15, Y = 0},
    SubHeaderText = {X = 15, Y = 32},
    CloseBtn = {X = 1, Y = 0.5, OffsetX = -40, OffsetY = -17},
}

-- ============================================
-- 📝 TEXTOS (Cambia los strings)
-- ============================================
local Texts = {
    Title = "+1 PEED FROM SPEED BUBBLES",
    SubTitle = "EL MEJOR SCRIPR AUTO FARM",
    FloatButton = "📍",
    DestroyButton = "🗑️ DESTRUIR GUI",
    CloseButton = "✕",
    
    Option1 = "AUTO TELEPORT",
    Option1Desc = "TP a X: -5931.02, Y: 373.07, Z: -1428.69",
    Option1Icon = "📍",
}

-- ============================================
-- 🔤 FUENTES (Cambia Enum.Font)
-- ============================================
local Fonts = {
    Title = Enum.Font.GothamBold,
    SubTitle = Enum.Font.Gotham,
    FloatButton = Enum.Font.GothamBold,
    Label = Enum.Font.GothamBold,
    Desc = Enum.Font.Gotham,
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
}

-- ============================================
-- ═══════════════════════════════════════════
--           FIN CONFIGURACIÓN VISUAL
-- ═══════════════════════════════════════════
-- ============================================

-- ============================================
-- CONFIGURACIÓN DE OPCIONES (NO TOCAR)
-- ============================================
local Settings = {
    AutoTP = false,
}

local TPLoop = nil

-- ============================================
-- FUNCIONES DE UTILIDAD (NO TOCAR)
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
-- 🔥 AUTO TP A POSICIÓN CON AJUSTE DE ALTURA
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
        print("❌ Auto TP está DESACTIVADO en la configuración")
        return
    end
    
    Settings.AutoTP = not Settings.AutoTP
    
    if Settings.AutoTP then
        local targetPos = GetTargetPosition()
        print("📍 Auto TP ACTIVADO")
        print("📍 Posición: X=" .. targetPos.X .. ", Y=" .. targetPos.Y .. ", Z=" .. targetPos.Z)
        
        local hrp = GetHRP()
        if hrp then
            pcall(function()
                hrp.CFrame = CFrame.new(targetPos)
                hrp.Velocity = Vector3.new(0, 0, 0)
                print("✅ Teletransportado")
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
            local currentPos = hrp.Position
            local distance = (currentPos - targetPos2).Magnitude
            
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
-- DESTROY GUI (NO TOCAR)
-- ============================================
local function DestroyGUI()
    if TPLoop then pcall(function() TPLoop:Disconnect() end) TPLoop = nil end
    
    pcall(function()
        local gui = PlayerGui:FindFirstChild("AutoTPProGUI")
        if gui then gui:Destroy() end
    end)
    
    print("🗑️ GUI destruida")
end

-- ============================================
-- CREAR GUI (NO TOCAR)
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
    
    -- Botón flotante
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, Sizes.FloatButtonSize, 0, Sizes.FloatButtonSize)
    toggleButton.Position = UDim2.new(Positions.FloatButton.X, Positions.FloatButton.OffsetX, Positions.FloatButton.Y, Positions.FloatButton.OffsetY)
    toggleButton.BackgroundColor3 = Colors.Background
    toggleButton.Text = Texts.FloatButton
    toggleButton.TextColor3 = Colors.TextColor
    toggleButton.Font = Fonts.FloatButton
    toggleButton.TextSize = 28
    toggleButton.Parent = screenGui
    toggleButton.ZIndex = 999
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(Sizes.FloatButtonCorner, 0)
    btnCorner.Parent = toggleButton
    
    -- Panel
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
    
    local panelStroke = Instance.new("UIStroke")
    panelStroke.Color = Colors.Border
    panelStroke.Thickness = 2
    panelStroke.Transparency = 0.4
    panelStroke.Parent = panel
    
    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, Sizes.HeaderHeight)
    header.BackgroundColor3 = Colors.Header
    header.Parent = panel
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, Sizes.HeaderCorner)
    headerCorner.Parent = header
    
    -- Título
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -70, 1, 0)
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
    subText.Size = UDim2.new(1, -70, 0, 16)
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
    
    -- Scrolling Frame
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -Sizes.ScrollPadding, 1, -Sizes.HeaderHeight - 25)
    scrollFrame.Position = UDim2.new(0, Sizes.ScrollPadding/2, 0, Sizes.HeaderHeight + 10)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = Sizes.ScrollThickness
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.Parent = panel
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scrollFrame
    
    -- Función para crear toggle
    local function CreateToggle(labelText, toggleFunc, icon, desc, isAvailable)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, Sizes.ToggleHeight)
        frame.BackgroundColor3 = isAvailable and Colors.FrameBG or Color3.fromRGB(40, 30, 30)
        frame.BackgroundTransparency = isAvailable and 0.2 or 0.1
        frame.Parent = scrollFrame
        
        local fCorner = Instance.new("UICorner")
        fCorner.CornerRadius = UDim.new(0, Sizes.ToggleCorner)
        fCorner.Parent = frame
        
        local fStroke = Instance.new("UIStroke")
        fStroke.Color = isAvailable and Colors.Stroke or Color3.fromRGB(200, 50, 50)
        fStroke.Thickness = Sizes.ToggleStroke
        fStroke.Transparency = isAvailable and 0.5 or 0.3
        fStroke.Parent = frame
        
        -- Icono
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Size = UDim2.new(0, Sizes.IconSize, 0, Sizes.IconSize)
        iconLabel.Position = UDim2.new(0, 10, 0.5, -Sizes.IconSize/2)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = icon
        iconLabel.TextColor3 = Colors.IconColor
        iconLabel.Font = Fonts.Icon
        iconLabel.TextSize = Sizes.IconTextSize
        iconLabel.Parent = frame
        
        -- Label
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -120, 0, 18)
        label.Position = UDim2.new(0, 48, 0, 4)
        label.BackgroundTransparency = 1
        label.Text = labelText
        label.TextColor3 = isAvailable and Colors.TextColor or Color3.fromRGB(255, 80, 80)
        label.Font = Fonts.Label
        label.TextSize = Sizes.LabelSize
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        -- Descripción
        if desc then
            local dLabel = Instance.new("TextLabel")
            dLabel.Size = UDim2.new(1, -120, 0, 14)
            dLabel.Position = UDim2.new(0, 48, 0, 24)
            dLabel.BackgroundTransparency = 1
            dLabel.Text = desc
            dLabel.TextColor3 = isAvailable and Colors.DescColor or Color3.fromRGB(255, 80, 80)
            dLabel.Font = Fonts.Desc
            dLabel.TextSize = Sizes.DescSize
            dLabel.TextXAlignment = Enum.TextXAlignment.Left
            dLabel.Parent = frame
        end
        
        -- Toggle Button
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, Sizes.ToggleBtnWidth, 0, Sizes.ToggleBtnHeight)
        toggleBtn.Position = UDim2.new(1, -(Sizes.ToggleBtnWidth + 8), 0.5, -Sizes.ToggleBtnHeight/2)
        toggleBtn.BackgroundColor3 = isAvailable and Colors.ToggleOff or Color3.fromRGB(40, 40, 50)
        toggleBtn.TextColor3 = isAvailable and Colors.ToggleTextOff or Color3.fromRGB(100, 100, 120)
        toggleBtn.Text = "OFF"
        toggleBtn.Font = Fonts.Toggle
        toggleBtn.TextSize = 11
        toggleBtn.AutoButtonColor = false
        toggleBtn.Parent = frame
        
        local btnCorner2 = Instance.new("UICorner")
        btnCorner2.CornerRadius = UDim.new(0, Sizes.ToggleBtnCorner)
        btnCorner2.Parent = toggleBtn
        
        local isOn = false
        
        toggleBtn.MouseButton1Click:Connect(function()
            if not isAvailable then
                print("❌ Esta opción está DESACTIVADA en la configuración")
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
    
    -- Botón Destroy
    local destroyBtn = Instance.new("TextButton")
    destroyBtn.Size = UDim2.new(1, 0, 0, Sizes.DestroyHeight)
    destroyBtn.Position = UDim2.new(0, 0, 1, -(Sizes.DestroyHeight + 5))
    destroyBtn.BackgroundColor3 = Colors.ButtonDestroy
    destroyBtn.Text = Texts.DestroyButton
    destroyBtn.TextColor3 = Colors.TextColor
    destroyBtn.Font = Fonts.Destroy
    destroyBtn.TextSize = 12
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
    
    -- Animaciones del panel
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
    
    -- Arrastrable
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
    
    local targetPos = GetTargetPosition()
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📍 AUTO TP PRO CARGADO")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📍 TP a: X=" .. targetPos.X .. ", Y=" .. targetPos.Y .. ", Z=" .. targetPos.Z)
    print("📏 Ajuste de altura: +" .. HeightOffset .. " studs")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📋 Presiona 📍 para abrir el panel")
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
