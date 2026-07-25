--[[
═══════════════════════════════════════════════════════════════
            🔥 AUTO TP PRO ULTRA - VERSIÓN COMPLETA 🔥
              + SPEED MULTIPLIER EDIT (0.01) + AUTO-REBIRTH FIX
═══════════════════════════════════════════════════════════════
    
    🔧 INSTRUCCIONES DE PERSONALIZACIÓN:
    (Mantén tus cambios visuales)
    
    ⚠️ NO TOCAR: Funciones, lógica de teletransporte y farm
═══════════════════════════════════════════════════════════════
--]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
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
    AutoFarm = true,
    AutoRebirth = true,
    AutoClaim = true,
    AutoTreadmill = true,
    AntiFall = true,
    AutoGetUp = true,
    AutoJumpFix = true,
    MultiplierDisplay = true,
    FreeTrail = true,
    SpeedMultiplierEdit = true,
    AutoWin = true,
    WinMultiplier = true,
    WinStreakHack = true,
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
-- 🎨 COLORES PREMIUM
-- ============================================
local Colors = {
    Background = Color3.fromRGB(10, 10, 30),
    Header = Color3.fromRGB(25, 20, 60),
    Title = Color3.fromRGB(255, 200, 100),
    SubTitle = Color3.fromRGB(180, 180, 220),
    Border = Color3.fromRGB(120, 80, 255),
    BorderGlow = Color3.fromRGB(200, 150, 255),
    
    ToggleOn = Color3.fromRGB(0, 220, 120),
    ToggleOff = Color3.fromRGB(50, 50, 70),
    ToggleTextOn = Color3.fromRGB(150, 255, 200),
    ToggleTextOff = Color3.fromRGB(200, 100, 100),
    
    FrameBG = Color3.fromRGB(20, 20, 50),
    FrameBGOn = Color3.fromRGB(20, 50, 35),
    FrameBGBlocked = Color3.fromRGB(40, 20, 20),
    Stroke = Color3.fromRGB(100, 70, 220),
    StrokeOn = Color3.fromRGB(0, 220, 120),
    StrokeBlocked = Color3.fromRGB(220, 50, 50),
    
    ButtonDestroy = Color3.fromRGB(200, 30, 30),
    ButtonDestroyHover = Color3.fromRGB(255, 50, 50),
    CloseBtn = Color3.fromRGB(40, 30, 70),
    CloseBtnHover = Color3.fromRGB(200, 40, 40),
    
    IconColor = Color3.fromRGB(255, 255, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    DescColor = Color3.fromRGB(160, 160, 210),
    BlockedText = Color3.fromRGB(255, 80, 80),
    
    GlowColor = Color3.fromRGB(150, 100, 255),
    AccentColor = Color3.fromRGB(255, 180, 80),
}

-- ============================================
-- ✨ EFECTOS VISUALES
-- ============================================
local Effects = {
    GlowIntensity = 0.3,
    ShadowSize = 20,
    CornerRadius = 24,
    BorderGlow = true,
    ParticleEffect = true,
    RainbowTitle = false,
}

-- ============================================
-- 📏 TAMAÑOS PREMIUM
-- ============================================
local Sizes = {
    PanelWidth = 420,
    PanelHeight = 520,
    PanelCorner = 24,
    FloatButtonSize = 70,
    FloatButtonCorner = 1,
    HeaderHeight = 65,
    HeaderCorner = 24,
    TitleSize = 22,
    SubTitleSize = 13,
    ToggleHeight = 46,
    ToggleCorner = 12,
    ToggleStroke = 2,
    ToggleBtnWidth = 55,
    ToggleBtnHeight = 28,
    ToggleBtnCorner = 8,
    IconSize = 28,
    IconTextSize = 18,
    LabelSize = 12,
    DescSize = 9,
    DestroyHeight = 38,
    DestroyCorner = 12,
    ScrollThickness = 5,
    ScrollPadding = 25,
    ShadowBlur = 30,
}

-- ============================================
-- 📍 POSICIONES
-- ============================================
local Positions = {
    FloatButton = {X = 1, Y = 0, OffsetX = -85, OffsetY = 20},
    Panel = {X = 0.5, Y = 0.5, OffsetX = -210, OffsetY = -260},
    HeaderText = {X = 20, Y = 0},
    SubHeaderText = {X = 20, Y = 38},
    CloseBtn = {X = 1, Y = 0.5, OffsetX = -45, OffsetY = -18},
}

-- ============================================
-- 📝 TEXTOS PREMIUM
-- ============================================
local Texts = {
    Title = "+1 SCAPE FROM SPEED BUBBLES",
    SubTitle = "✦ EL MEJOR SCRIPT V 2.1.2 ✦",
    FloatButton = "✦",
    DestroyButton = "🗑️ DESTROY GUI",
    CloseButton = "✕",
    
    Option1 = "AUTO TELEPORT",
    Option1Desc = "📍 TP A LA ULTIMA ETAPA",
    Option1Icon = "📍",
    
    Option2 = "AUTO-FARM SPEED",
    Option2Desc = "⚡ GANA VELOCIDAD AUTOMATICAMENTE",
    Option2Icon = "⚡",
    
    Option3 = "AUTO-REBIRTH",
    Option3Desc = "🔄 REBIRTH AUTOMATICO AL NIVEL REQUERIDO",
    Option3Icon = "🔄",
    
    Option4 = "AUTO-CLAIM REWARD",
    Option4Desc = "🎁 RECLAMA RECOMPENSA DEL GRUPO",
    Option4Icon = "🎁",
    
    Option5 = "AUTO-TREADMILL",
    Option5Desc = "🏃 ACTIVA TU MEJOR TREADMILL",
    Option5Icon = "🏃",
    
    Option6 = "ANTI-FALL",
    Option6Desc = "🛡️ EVITA CAIDAS Y RAGDOLL",
    Option6Icon = "🛡️",
    
    Option7 = "AUTO-GETUP",
    Option7Desc = "⬆️ LEVANTATE AUTOMATICAMENTE",
    Option7Icon = "⬆️",
    
    Option8 = "AUTO-JUMP FIX",
    Option8Desc = "🦘 CORRIGE EL SALTO EN MOVIL",
    Option8Icon = "🦘",
    
    Option9 = "MULTIPLIER DISPLAY",
    Option9Desc = "📊 MUESTRA MULTIPLICADORES",
    Option9Icon = "📊",
    
    Option10 = "FREE BEST TRAIL",
    Option10Desc = "🌈 EQUIPA EL MEJOR TRAIL GRATIS",
    Option10Icon = "🌈",
    
    Option11 = "SPEED MULTIPLIER EDIT",
    Option11Desc = "⚡ VELOCIDAD INSTANTANEA (QUIETO Y MOVIENDOSE)",
    Option11Icon = "⚡",
    
    Option12 = "AUTO-WIN SIMULATOR",
    Option12Desc = "🏆 SIMULA WINS AUTOMATICAMENTE",
    Option12Icon = "🏆",
    
    Option13 = "WIN MULTIPLIER VISUAL",
    Option13Desc = "📈 MODIFICA VISUALMENTE TUS WINS",
    Option13Icon = "📈",
    
    Option14 = "WIN STREAK HACK",
    Option14Desc = "🔥 RACHA DE WINS FALSA (VISUAL)",
    Option14Icon = "🔥",
}

-- ============================================
-- 🔤 FUENTES PREMIUM
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
-- ⏱️ ANIMACIONES PREMIUM
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
-- CONFIGURACIÓN DE OPCIONES (NO TOCAR)
-- ============================================
local Settings = {
    AutoTP = false,
    AutoFarm = false,
    AutoRebirth = false,
    AutoClaim = false,
    AutoTreadmill = false,
    AntiFall = false,
    AutoGetUp = false,
    AutoJumpFix = false,
    MultiplierDisplay = false,
    FreeTrail = false,
    SpeedMultiplierEdit = false,
    AutoWin = false,
    WinMultiplier = false,
    WinStreakHack = false,
}

local TPLoop = nil
local FarmLoop = nil
local RebirthLoop = nil
local ClaimLoop = nil
local TreadmillLoop = nil
local FallLoop = nil
local GetUpLoop = nil
local JumpFixLoop = nil
local SpeedMultiplierLoop = nil
local AutoWinLoop = nil
local WinMultiplierLoop = nil
local WinStreakLoop = nil
local FloatPulseConnection = nil
local RebirthFixLoop = nil

-- ============================================
-- REMOTES (NO TOCAR)
-- ============================================
local AddSpeed = nil
local RequestRebirth = nil
local ClaimGroupReward = nil
local PersonalTreadmillRemote = nil
local WinStreakRemote = nil

local function FindRemotes()
    local events = ReplicatedStorage:FindFirstChild("Events")
    if not events then
        print("❌ No se encontró Events en ReplicatedStorage")
        return
    end
    
    AddSpeed = events:FindFirstChild("AddSpeed")
    RequestRebirth = events:FindFirstChild("RequestRebirth")
    ClaimGroupReward = events:FindFirstChild("ClaimGroupReward")
    PersonalTreadmillRemote = events:FindFirstChild("PersonalTreadmillRemote")
    WinStreakRemote = events:FindFirstChild("WinStreakRemote")
    
    if AddSpeed then print("✅ AddSpeed encontrado") else print("❌ AddSpeed no encontrado") end
    if RequestRebirth then print("✅ RequestRebirth encontrado") else print("❌ RequestRebirth no encontrado") end
    if ClaimGroupReward then print("✅ ClaimGroupReward encontrado") else print("❌ ClaimGroupReward no encontrado") end
    if PersonalTreadmillRemote then print("✅ PersonalTreadmillRemote encontrado") else print("❌ PersonalTreadmillRemote no encontrado") end
    if WinStreakRemote then print("✅ WinStreakRemote encontrado") else print("❌ WinStreakRemote no encontrado") end
end

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

local function GetHumanoid()
    local char = GetCharacter()
    return char and char:FindFirstChild("Humanoid")
end

local function GetHRP()
    local char = GetCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function GetLeaderstats()
    return LocalPlayer:FindFirstChild("leaderstats")
end

-- ============================================
-- 🔥 AUTO TP (NO TOCAR)
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
        print("📍 Auto TP ACTIVADO")
        
        local hrp = GetHRP()
        if hrp then
            local targetPos = GetTargetPosition()
            pcall(function()
                hrp.CFrame = CFrame.new(targetPos)
                hrp.Velocity = Vector3.new(0, 0, 0)
            end)
        end
        
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
-- 🔥 AUTO-FARM SPEED (AddSpeed)
-- ============================================
local function ToggleAutoFarm()
    if not OpcionesDisponibles.AutoFarm then
        print("❌ Auto-Farm DESACTIVADO")
        return
    end
    
    Settings.AutoFarm = not Settings.AutoFarm
    
    if Settings.AutoFarm then
        if not AddSpeed then
            print("❌ AddSpeed no disponible")
            Settings.AutoFarm = false
            return
        end
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
-- 🔥 AUTO-REBIRTH FIX (RequestRebirth)
-- ============================================
local function ToggleAutoRebirth()
    if not OpcionesDisponibles.AutoRebirth then
        print("❌ Auto-Rebirth DESACTIVADO")
        return
    end
    
    Settings.AutoRebirth = not Settings.AutoRebirth
    
    if Settings.AutoRebirth then
        if not RequestRebirth then
            print("❌ RequestRebirth no disponible")
            Settings.AutoRebirth = false
            return
        end
        print("🔄 Auto-Rebirth ACTIVADO")
        
        if RebirthLoop then pcall(function() RebirthLoop:Disconnect() end) RebirthLoop = nil end
        if RebirthFixLoop then pcall(function() RebirthFixLoop:Disconnect() end) RebirthFixLoop = nil end
        
        -- Bucle principal de rebirth
        RebirthLoop = RunService.Heartbeat:Connect(function()
            if not Settings.AutoRebirth then return end
            
            local stats = GetLeaderstats()
            if not stats then return end
            
            local level = stats:FindFirstChild("Level")
            local rebirths = stats:FindFirstChild("Rebirths")
            if not level or not rebirths then return end
            
            -- Fórmula: cada 5 niveles se puede hacer rebirth
            local nextLevel = (rebirths.Value + 1) * 5
            if level.Value >= nextLevel then
                pcall(function()
                    RequestRebirth:FireServer()
                    print("🔄 Rebirth automático! Nivel:", level.Value)
                end)
            end
        end)
        
        -- Bucle de respaldo (por si el evento no se dispara)
        RebirthFixLoop = RunService.Heartbeat:Connect(function()
            if not Settings.AutoRebirth then return end
            
            local stats = GetLeaderstats()
            if not stats then return end
            
            local level = stats:FindFirstChild("Level")
            local rebirths = stats:FindFirstChild("Rebirths")
            if not level or not rebirths then return end
            
            local nextLevel = (rebirths.Value + 1) * 5
            if level.Value >= nextLevel then
                -- Intentar con otros métodos
                pcall(function()
                    -- Buscar evento alternativo
                    local altEvent = ReplicatedStorage:FindFirstChild("Events")
                    if altEvent then
                        altEvent = altEvent:FindFirstChild("Rebirth")
                        if altEvent then
                            altEvent:FireServer()
                        end
                    end
                end)
            end
        end)
    else
        print("🔄 Auto-Rebirth DESACTIVADO")
        if RebirthLoop then pcall(function() RebirthLoop:Disconnect() end) RebirthLoop = nil end
        if RebirthFixLoop then pcall(function() RebirthFixLoop:Disconnect() end) RebirthFixLoop = nil end
    end
end

-- ============================================
-- 🔥 AUTO-CLAIM REWARD (ClaimGroupReward)
-- ============================================
local function ToggleAutoClaim()
    if not OpcionesDisponibles.AutoClaim then
        print("❌ Auto-Claim DESACTIVADO")
        return
    end
    
    Settings.AutoClaim = not Settings.AutoClaim
    
    if Settings.AutoClaim then
        if not ClaimGroupReward then
            print("❌ ClaimGroupReward no disponible")
            Settings.AutoClaim = false
            return
        end
        print("🎁 Auto-Claim Reward ACTIVADO")
        
        if ClaimLoop then pcall(function() ClaimLoop:Disconnect() end) ClaimLoop = nil end
        
        ClaimLoop = RunService.Heartbeat:Connect(function()
            if not Settings.AutoClaim then return end
            
            pcall(function()
                ClaimGroupReward:FireServer()
                print("🎁 Recompensa reclamada")
            end)
        end)
    else
        print("🎁 Auto-Claim Reward DESACTIVADO")
        if ClaimLoop then pcall(function() ClaimLoop:Disconnect() end) ClaimLoop = nil end
    end
end

-- ============================================
-- 🔥 AUTO-TREADMILL (PersonalTreadmillRemote)
-- ============================================
local function ToggleAutoTreadmill()
    if not OpcionesDisponibles.AutoTreadmill then
        print("❌ Auto-Treadmill DESACTIVADO")
        return
    end
    
    Settings.AutoTreadmill = not Settings.AutoTreadmill
    
    if Settings.AutoTreadmill then
        if not PersonalTreadmillRemote then
            print("❌ PersonalTreadmillRemote no disponible")
            Settings.AutoTreadmill = false
            return
        end
        print("🏃 Auto-Treadmill ACTIVADO")
        
        if TreadmillLoop then pcall(function() TreadmillLoop:Disconnect() end) TreadmillLoop = nil end
        
        pcall(function() PersonalTreadmillRemote:FireServer("Toggle") end)
        
        TreadmillLoop = RunService.Heartbeat:Connect(function()
            if not Settings.AutoTreadmill then return end
            pcall(function() PersonalTreadmillRemote:FireServer("Toggle") end)
        end)
    else
        print("🏃 Auto-Treadmill DESACTIVADO")
        if TreadmillLoop then pcall(function() TreadmillLoop:Disconnect() end) TreadmillLoop = nil end
    end
end

-- ============================================
-- 🔥 ANTI-FALL (Evita caídas y ragdoll)
-- ============================================
local function ToggleAntiFall()
    if not OpcionesDisponibles.AntiFall then
        print("❌ Anti-Fall DESACTIVADO")
        return
    end
    
    Settings.AntiFall = not Settings.AntiFall
    
    if Settings.AntiFall then
        print("🛡️ Anti-Fall ACTIVADO")
        
        if FallLoop then pcall(function() FallLoop:Disconnect() end) FallLoop = nil end
        
        FallLoop = RunService.Heartbeat:Connect(function()
            if not Settings.AntiFall then return end
            
            local hum = GetHumanoid()
            if not hum then return end
            
            pcall(function()
                hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            end)
            
            local hrp = GetHRP()
            if hrp and hrp.AssemblyAngularVelocity.Magnitude > 25 then
                pcall(function()
                    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end)
            end
        end)
    else
        print("🛡️ Anti-Fall DESACTIVADO")
        if FallLoop then pcall(function() FallLoop:Disconnect() end) FallLoop = nil end
    end
end

-- ============================================
-- 🔥 AUTO-GETUP (Se levanta automáticamente)
-- ============================================
local function ToggleAutoGetUp()
    if not OpcionesDisponibles.AutoGetUp then
        print("❌ Auto-GetUp DESACTIVADO")
        return
    end
    
    Settings.AutoGetUp = not Settings.AutoGetUp
    
    if Settings.AutoGetUp then
        print("⬆️ Auto-GetUp ACTIVADO")
        
        if GetUpLoop then pcall(function() GetUpLoop:Disconnect() end) GetUpLoop = nil end
        
        GetUpLoop = RunService.Heartbeat:Connect(function()
            if not Settings.AutoGetUp then return end
            
            local hum = GetHumanoid()
            if not hum or hum.Health <= 0 then return end
            
            local state = hum:GetState()
            if state == Enum.HumanoidStateType.FallingDown or state == Enum.HumanoidStateType.Ragdoll then
                pcall(function()
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                    task.defer(function()
                        if hum.Health > 0 then
                            hum:ChangeState(Enum.HumanoidStateType.Running)
                        end
                    end)
                end)
            end
        end)
    else
        print("⬆️ Auto-GetUp DESACTIVADO")
        if GetUpLoop then pcall(function() GetUpLoop:Disconnect() end) GetUpLoop = nil end
    end
end

-- ============================================
-- 🔥 AUTO-JUMP FIX (Corrige saltos en móvil)
-- ============================================
local function ToggleAutoJumpFix()
    if not OpcionesDisponibles.AutoJumpFix then
        print("❌ Auto-Jump Fix DESACTIVADO")
        return
    end
    
    Settings.AutoJumpFix = not Settings.AutoJumpFix
    
    if Settings.AutoJumpFix then
        print("🦘 Auto-Jump Fix ACTIVADO")
        
        if JumpFixLoop then pcall(function() JumpFixLoop:Disconnect() end) JumpFixLoop = nil end
        
        JumpFixLoop = RunService.PostSimulation:Connect(function(delta)
            if not Settings.AutoJumpFix then return end
            
            local hum = GetHumanoid()
            if not hum or hum.Health <= 0 then return end
            
            local hrp = GetHRP()
            if not hrp then return end
            
            local state = hum:GetState()
            if (state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.RunningNoPhysics) and hum.FloorMaterial ~= Enum.Material.Air then
                if hum.WalkSpeed >= 50 then
                    local vel = hrp.AssemblyLinearVelocity
                    local horizontal = Vector3.new(vel.X, 0, vel.Z)
                    if horizontal.Magnitude > 10 then
                        local correction = -50 * delta
                        pcall(function()
                            hrp.AssemblyLinearVelocity = vel + Vector3.new(0, correction, 0)
                        end)
                    end
                end
            end
        end)
    else
        print("🦘 Auto-Jump Fix DESACTIVADO")
        if JumpFixLoop then pcall(function() JumpFixLoop:Disconnect() end) JumpFixLoop = nil end
    end
end

-- ============================================
-- 🔥 MULTIPLIER DISPLAY (Muestra multiplicadores)
-- ============================================
local MultiplierFrame = nil
local RebirthMultLabel = nil
local SpeedPeakMultLabel = nil

local function CreateMultiplierDisplay()
    if MultiplierFrame then
        MultiplierFrame:Destroy()
        MultiplierFrame = nil
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MultiplierDisplay"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = PlayerGui
    
    MultiplierFrame = Instance.new("Frame")
    MultiplierFrame.Size = UDim2.new(0, 300, 0, 80)
    MultiplierFrame.Position = UDim2.new(0, 10, 0, 10)
    MultiplierFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MultiplierFrame.BackgroundTransparency = 0.6
    MultiplierFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = MultiplierFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 80, 200)
    stroke.Thickness = 2
    stroke.Parent = MultiplierFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 25)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "📊 MULTIPLICADORES"
    title.TextColor3 = Color3.fromRGB(255, 200, 100)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.Parent = MultiplierFrame
    
    RebirthMultLabel = Instance.new("TextLabel")
    RebirthMultLabel.Size = UDim2.new(1, -10, 0, 25)
    RebirthMultLabel.Position = UDim2.new(0, 5, 0, 27)
    RebirthMultLabel.BackgroundTransparency = 1
    RebirthMultLabel.Text = "🔄 Rebirth: x1.0"
    RebirthMultLabel.TextColor3 = Color3.fromRGB(100, 255, 200)
    RebirthMultLabel.Font = Enum.Font.Gotham
    RebirthMultLabel.TextSize = 13
    RebirthMultLabel.TextXAlignment = Enum.TextXAlignment.Left
    RebirthMultLabel.Parent = MultiplierFrame
    
    SpeedPeakMultLabel = Instance.new("TextLabel")
    SpeedPeakMultLabel.Size = UDim2.new(1, -10, 0, 25)
    SpeedPeakMultLabel.Position = UDim2.new(0, 5, 0, 52)
    SpeedPeakMultLabel.BackgroundTransparency = 1
    SpeedPeakMultLabel.Text = "⚡ Speed Peak: x1"
    SpeedPeakMultLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    SpeedPeakMultLabel.Font = Enum.Font.Gotham
    SpeedPeakMultLabel.TextSize = 13
    SpeedPeakMultLabel.TextXAlignment = Enum.TextXAlignment.Left
    SpeedPeakMultLabel.Parent = MultiplierFrame
    
    task.spawn(function()
        while MultiplierFrame and Settings.MultiplierDisplay do
            local stats = GetLeaderstats()
            if stats then
                local rebirths = stats:FindFirstChild("Rebirths")
                if rebirths and RebirthMultLabel then
                    local mult = 1 + rebirths.Value * 0.5
                    local text = mult % 1 == 0 and tostring(mult) or string.format("%.1f", mult)
                    RebirthMultLabel.Text = "🔄 Rebirth: x" .. text
                end
                
                if SpeedPeakMultLabel then
                    local peakMult = 1
                    local speedPeakConfig = ReplicatedStorage:FindFirstChild("Modules")
                    if speedPeakConfig then
                        speedPeakConfig = speedPeakConfig:FindFirstChild("SpeedPeakConfig")
                        if speedPeakConfig then
                            local success, config = pcall(function() return require(speedPeakConfig) end)
                            if success and type(config) == "table" then
                                for _, item in ipairs(config) do
                                    if item.Mult and item.Mult > peakMult then
                                        peakMult = item.Mult
                                    end
                                end
                            end
                        end
                    end
                    SpeedPeakMultLabel.Text = "⚡ Speed Peak: x" .. tostring(peakMult)
                end
            end
            task.wait(0.5)
        end
    end)
end

local function ToggleMultiplierDisplay()
    if not OpcionesDisponibles.MultiplierDisplay then
        print("❌ Multiplier Display DESACTIVADO")
        return
    end
    
    Settings.MultiplierDisplay = not Settings.MultiplierDisplay
    
    if Settings.MultiplierDisplay then
        print("📊 Multiplier Display ACTIVADO")
        CreateMultiplierDisplay()
    else
        print("📊 Multiplier Display DESACTIVADO")
        if MultiplierFrame then
            MultiplierFrame:Destroy()
            MultiplierFrame = nil
        end
        RebirthMultLabel = nil
        SpeedPeakMultLabel = nil
    end
end

-- ============================================
-- 🔥 FREE BEST TRAIL (Equipa el mejor trail GRATIS)
-- ============================================
local function ToggleFreeTrail()
    if not OpcionesDisponibles.FreeTrail then
        print("❌ Free Trail DESACTIVADO")
        return
    end
    
    Settings.FreeTrail = not Settings.FreeTrail
    
    if Settings.FreeTrail then
        print("🌈 Free Best Trail ACTIVADO")
        
        local trailConfig = ReplicatedStorage:FindFirstChild("Modules")
        if trailConfig then
            trailConfig = trailConfig:FindFirstChild("TrailConfigurations")
            if trailConfig then
                local success, config = pcall(function() return require(trailConfig) end)
                if success and config and config.Trails then
                    local bestTrail = nil
                    local bestBoost = 0
                    for _, trail in ipairs(config.Trails) do
                        if trail.SpeedBoost and trail.SpeedBoost > bestBoost then
                            bestBoost = trail.SpeedBoost
                            bestTrail = trail.ID
                        end
                    end
                    
                    if bestTrail then
                        local trails = LocalPlayer:FindFirstChild("Trails")
                        if trails then
                            local equipped = trails:FindFirstChild("Equipped")
                            if equipped then
                                pcall(function()
                                    equipped.Value = bestTrail
                                    print("🌈 Trail equipado:", bestTrail)
                                end)
                            else
                                local newEquipped = Instance.new("StringValue")
                                newEquipped.Name = "Equipped"
                                newEquipped.Value = bestTrail
                                newEquipped.Parent = trails
                                print("🌈 Trail equipado (creado):", bestTrail)
                            end
                        else
                            local newTrails = Instance.new("Folder")
                            newTrails.Name = "Trails"
                            newTrails.Parent = LocalPlayer
                            local newEquipped = Instance.new("StringValue")
                            newEquipped.Name = "Equipped"
                            newEquipped.Value = bestTrail
                            newEquipped.Parent = newTrails
                            print("🌈 Trail equipado (carpeta creada):", bestTrail)
                        end
                    else
                        print("❌ No se encontraron trails disponibles")
                    end
                end
            end
        end
    else
        print("🌈 Free Best Trail DESACTIVADO")
    end
end

-- ============================================
-- 🔥 SPEED MULTIPLIER EDIT (0.01 + FUNCIONA QUIETO Y MOVIENDOSE)
-- ============================================
local function ToggleSpeedMultiplierEdit()
    if not OpcionesDisponibles.SpeedMultiplierEdit then
        print("❌ Speed Multiplier Edit DESACTIVADO")
        return
    end
    
    Settings.SpeedMultiplierEdit = not Settings.SpeedMultiplierEdit
    
    if Settings.SpeedMultiplierEdit then
        print("⚡ Speed Multiplier Edit ACTIVADO (0.01 - Quieto y moviéndose)")
        
        -- Modificar el módulo GameBalance
        local gameBalance = ReplicatedStorage:FindFirstChild("Modules")
        if gameBalance then
            gameBalance = gameBalance:FindFirstChild("GameBalance")
            if gameBalance then
                local success, module = pcall(function() return require(gameBalance) end)
                if success and module then
                    -- Cambiar STUDS_REQUIRED a 0.01 (casi instantáneo)
                    module.STUDS_REQUIRED = 0.01
                    print("✅ STUDS_REQUIRED = 0.01")
                    
                    -- También modificar STUDS_REQUIRED en el script SpeedClient
                    local speedClient = LocalPlayer:FindFirstChild("PlayerScripts")
                    if speedClient then
                        speedClient = speedClient:FindFirstChild("SpeedClient")
                        if speedClient then
                            pcall(function()
                                -- Intentar modificar la variable en el script
                                local newScript = speedClient:Clone()
                                -- Esto es un intento, puede no funcionar en todos los casos
                                print("✅ Intentando modificar SpeedClient...")
                            end)
                        end
                    end
                else
                    print("❌ No se pudo cargar GameBalance")
                end
            else
                print("❌ No se encontró GameBalance")
            end
        else
            print("❌ No se encontró Modules")
        end
        
        -- Bucle para mantener el valor modificado
        if SpeedMultiplierLoop then pcall(function() SpeedMultiplierLoop:Disconnect() end) SpeedMultiplierLoop = nil end
        
        SpeedMultiplierLoop = RunService.Heartbeat:Connect(function()
            if not Settings.SpeedMultiplierEdit then return end
            
            local gameBalance2 = ReplicatedStorage:FindFirstChild("Modules")
            if gameBalance2 then
                gameBalance2 = gameBalance2:FindFirstChild("GameBalance")
                if gameBalance2 then
                    local success2, module2 = pcall(function() return require(gameBalance2) end)
                    if success2 and module2 and module2.STUDS_REQUIRED ~= 0.01 then
                        module2.STUDS_REQUIRED = 0.01
                    end
                end
            end
        end)
        
        -- SIMULAR MOVIMIENTO PARA DAR VELOCIDAD (ESTANDO QUIETO)
        task.spawn(function()
            while Settings.SpeedMultiplierEdit do
                if Settings.SpeedMultiplierEdit then
                    -- Disparar AddSpeed directamente cada 0.05 segundos
                    if AddSpeed then
                        pcall(function()
                            AddSpeed:FireServer()
                        end)
                    end
                    
                    -- También simular movimiento falso
                    local hrp = GetHRP()
                    if hrp then
                        pcall(function()
                            -- Mover ligeramente el personaje para activar el sistema
                            local pos = hrp.Position
                            local offset = Vector3.new(
                                math.random(-1, 1) * 0.1,
                                0,
                                math.random(-1, 1) * 0.1
                            )
                            hrp.CFrame = CFrame.new(pos + offset)
                            task.wait(0.01)
                            hrp.CFrame = CFrame.new(pos)
                        end)
                    end
                end
                task.wait(0.05)
            end
        end)
    else
        print("⚡ Speed Multiplier Edit DESACTIVADO")
        
        -- Restaurar STUDS_REQUIRED a 8
        local gameBalance3 = ReplicatedStorage:FindFirstChild("Modules")
        if gameBalance3 then
            gameBalance3 = gameBalance3:FindFirstChild("GameBalance")
            if gameBalance3 then
                local success3, module3 = pcall(function() return require(gameBalance3) end)
                if success3 and module3 then
                    module3.STUDS_REQUIRED = 8
                    print("✅ STUDS_REQUIRED restaurado a 8")
                end
            end
        end
        
        if SpeedMultiplierLoop then
            pcall(function() SpeedMultiplierLoop:Disconnect() end)
            SpeedMultiplierLoop = nil
        end
    end
end

-- ============================================
-- 🔥 AUTO-WIN SIMULATOR (Simula wins automáticamente)
-- ============================================
local function ToggleAutoWin()
    if not OpcionesDisponibles.AutoWin then
        print("❌ Auto-Win DESACTIVADO")
        return
    end
    
    Settings.AutoWin = not Settings.AutoWin
    
    if Settings.AutoWin then
        print("🏆 Auto-Win Simulator ACTIVADO")
        
        if AutoWinLoop then pcall(function() AutoWinLoop:Disconnect() end) AutoWinLoop = nil end
        
        local winEvent = nil
        local events = ReplicatedStorage:FindFirstChild("Events")
        if events then
            winEvent = events:FindFirstChild("AddWin") or events:FindFirstChild("WinStreakRemote")
        end
        
        if not winEvent then
            winEvent = WinStreakRemote
        end
        
        AutoWinLoop = RunService.Heartbeat:Connect(function()
            if not Settings.AutoWin then return end
            
            if winEvent then
                pcall(function()
                    winEvent:FireServer()
                    print("🏆 Win simulada")
                end)
            else
                local stats = GetLeaderstats()
                if stats then
                    local wins = stats:FindFirstChild("Wins")
                    if wins then
                        pcall(function()
                            wins.Value = wins.Value + 1
                            print("🏆 Win visual añadida")
                        end)
                    end
                end
            end
        end)
    else
        print("🏆 Auto-Win Simulator DESACTIVADO")
        if AutoWinLoop then pcall(function() AutoWinLoop:Disconnect() end) AutoWinLoop = nil end
    end
end

-- ============================================
-- 🔥 WIN MULTIPLIER VISUAL (Modifica wins visualmente)
-- ============================================
local function ToggleWinMultiplier()
    if not OpcionesDisponibles.WinMultiplier then
        print("❌ Win Multiplier DESACTIVADO")
        return
    end
    
    Settings.WinMultiplier = not Settings.WinMultiplier
    
    if Settings.WinMultiplier then
        print("📈 Win Multiplier Visual ACTIVADO")
        
        if WinMultiplierLoop then pcall(function() WinMultiplierLoop:Disconnect() end) WinMultiplierLoop = nil end
        
        local multiplier = 10
        
        WinMultiplierLoop = RunService.Heartbeat:Connect(function()
            if not Settings.WinMultiplier then return end
            
            local stats = GetLeaderstats()
            if stats then
                local wins = stats:FindFirstChild("Wins")
                if wins then
                    pcall(function()
                        wins:SetAttribute("DisplayWins", wins.Value * multiplier)
                    end)
                end
            end
        end)
    else
        print("📈 Win Multiplier Visual DESACTIVADO")
        if WinMultiplierLoop then pcall(function() WinMultiplierLoop:Disconnect() end) WinMultiplierLoop = nil end
    end
end

-- ============================================
-- 🔥 WIN STREAK HACK (Racha de wins falsa)
-- ============================================
local function ToggleWinStreakHack()
    if not OpcionesDisponibles.WinStreakHack then
        print("❌ Win Streak Hack DESACTIVADO")
        return
    end
    
    Settings.WinStreakHack = not Settings.WinStreakHack
    
    if Settings.WinStreakHack then
        print("🔥 Win Streak Hack ACTIVADO")
        
        if WinStreakLoop then pcall(function() WinStreakLoop:Disconnect() end) WinStreakLoop = nil end
        
        local streakValue = 999
        
        WinStreakLoop = RunService.Heartbeat:Connect(function()
            if not Settings.WinStreakHack then return end
            
            pcall(function()
                LocalPlayer:SetAttribute("WinStreak", streakValue)
                LocalPlayer:SetAttribute("BestStreak", streakValue)
            end)
            
            local stats = GetLeaderstats()
            if stats then
                local streak = stats:FindFirstChild("WinStreak")
                if streak then
                    pcall(function()
                        streak.Value = streakValue
                    end)
                end
            end
        end)
    else
        print("🔥 Win Streak Hack DESACTIVADO")
        if WinStreakLoop then pcall(function() WinStreakLoop:Disconnect() end) WinStreakLoop = nil end
        
        pcall(function()
            LocalPlayer:SetAttribute("WinStreak", 0)
            LocalPlayer:SetAttribute("BestStreak", 0)
        end)
    end
end

-- ============================================
-- DESTROY GUI (NO TOCAR)
-- ============================================
local function DestroyGUI()
    if TPLoop then pcall(function() TPLoop:Disconnect() end) TPLoop = nil end
    if FarmLoop then pcall(function() FarmLoop:Disconnect() end) FarmLoop = nil end
    if RebirthLoop then pcall(function() RebirthLoop:Disconnect() end) RebirthLoop = nil end
    if RebirthFixLoop then pcall(function() RebirthFixLoop:Disconnect() end) RebirthFixLoop = nil end
    if ClaimLoop then pcall(function() ClaimLoop:Disconnect() end) ClaimLoop = nil end
    if TreadmillLoop then pcall(function() TreadmillLoop:Disconnect() end) TreadmillLoop = nil end
    if FallLoop then pcall(function() FallLoop:Disconnect() end) FallLoop = nil end
    if GetUpLoop then pcall(function() GetUpLoop:Disconnect() end) GetUpLoop = nil end
    if JumpFixLoop then pcall(function() JumpFixLoop:Disconnect() end) JumpFixLoop = nil end
    if SpeedMultiplierLoop then pcall(function() SpeedMultiplierLoop:Disconnect() end) SpeedMultiplierLoop = nil end
    if AutoWinLoop then pcall(function() AutoWinLoop:Disconnect() end) AutoWinLoop = nil end
    if WinMultiplierLoop then pcall(function() WinMultiplierLoop:Disconnect() end) WinMultiplierLoop = nil end
    if WinStreakLoop then pcall(function() WinStreakLoop:Disconnect() end) WinStreakLoop = nil end
    if FloatPulseConnection then pcall(function() FloatPulseConnection:Disconnect() end) FloatPulseConnection = nil end
    
    -- Restaurar STUDS_REQUIRED
    local gameBalance4 = ReplicatedStorage:FindFirstChild("Modules")
    if gameBalance4 then
        gameBalance4 = gameBalance4:FindFirstChild("GameBalance")
        if gameBalance4 then
            local success4, module4 = pcall(function() return require(gameBalance4) end)
            if success4 and module4 then
                module4.STUDS_REQUIRED = 8
            end
        end
    end
    
    -- Restaurar racha
    pcall(function()
        LocalPlayer:SetAttribute("WinStreak", 0)
        LocalPlayer:SetAttribute("BestStreak", 0)
    end)
    
    if MultiplierFrame then
        MultiplierFrame:Destroy()
        MultiplierFrame = nil
    end
    
    pcall(function()
        local gui = PlayerGui:FindFirstChild("AutoTPProGUI")
        if gui then gui:Destroy() end
    end)
    
    print("🗑️ GUI destruida")
end

-- ============================================
-- CREAR GUI PREMIUM (CON 14 OPCIONES)
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
    
    local btnShadow = Instance.new("ImageLabel")
    btnShadow.Size = UDim2.new(1.3, 0, 1.3, 0)
    btnShadow.Position = UDim2.new(-0.15, 0, -0.15, 0)
    btnShadow.BackgroundTransparency = 1
    btnShadow.Image = "rbxassetid://13130321673"
    btnShadow.ImageTransparency = 0.6
    btnShadow.ZIndex = 998
    btnShadow.Parent = toggleButton
    
    local btnGlow = Instance.new("ImageLabel")
    btnGlow.Size = UDim2.new(1.8, 0, 1.8, 0)
    btnGlow.Position = UDim2.new(-0.4, 0, -0.4, 0)
    btnGlow.BackgroundTransparency = 1
    btnGlow.Image = "rbxassetid://13130321673"
    btnGlow.ImageColor3 = Colors.BorderGlow
    btnGlow.ImageTransparency = 0.7
    btnGlow.ZIndex = 997
    btnGlow.Parent = toggleButton
    
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
    
    local panelShadow = Instance.new("ImageLabel")
    panelShadow.Size = UDim2.new(1.1, 20, 1.1, 20)
    panelShadow.Position = UDim2.new(-0.05, -10, -0.05, -10)
    panelShadow.BackgroundTransparency = 1
    panelShadow.Image = "rbxassetid://13130321673"
    panelShadow.ImageTransparency = 0.5
    panelShadow.ZIndex = 99
    panelShadow.Parent = panel
    
    local panelStroke = Instance.new("UIStroke")
    panelStroke.Color = Colors.Border
    panelStroke.Thickness = 2.5
    panelStroke.Transparency = 0.3
    panelStroke.Parent = panel
    
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
    
    local headerLine = Instance.new("Frame")
    headerLine.Size = UDim2.new(1, -40, 0, 2.5)
    headerLine.Position = UDim2.new(0, 20, 1, -3)
    headerLine.BackgroundColor3 = Colors.Border
    headerLine.BackgroundTransparency = 0.5
    headerLine.Parent = header
    
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
    layout.Padding = UDim.new(0, 4)
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
        
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Size = UDim2.new(0, Sizes.IconSize, 0, Sizes.IconSize)
        iconLabel.Position = UDim2.new(0, 6, 0.5, -Sizes.IconSize/2)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = icon
        iconLabel.TextColor3 = Colors.IconColor
        iconLabel.Font = Fonts.Icon
        iconLabel.TextSize = Sizes.IconTextSize
        iconLabel.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -120, 0, 15)
        label.Position = UDim2.new(0, 40, 0, 3)
        label.BackgroundTransparency = 1
        label.Text = labelText
        label.TextColor3 = isAvailable and Colors.TextColor or Colors.BlockedText
        label.Font = Fonts.Label
        label.TextSize = Sizes.LabelSize
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        if desc then
            local dLabel = Instance.new("TextLabel")
            dLabel.Size = UDim2.new(1, -120, 0, 12)
            dLabel.Position = UDim2.new(0, 40, 0, 20)
            dLabel.BackgroundTransparency = 1
            dLabel.Text = desc
            dLabel.TextColor3 = isAvailable and Colors.DescColor or Colors.BlockedText
            dLabel.Font = Fonts.Desc
            dLabel.TextSize = Sizes.DescSize
            dLabel.TextXAlignment = Enum.TextXAlignment.Left
            dLabel.Parent = frame
        end
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, Sizes.ToggleBtnWidth, 0, Sizes.ToggleBtnHeight)
        toggleBtn.Position = UDim2.new(1, -(Sizes.ToggleBtnWidth + 6), 0.5, -Sizes.ToggleBtnHeight/2)
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
                print("❌ Opción DESACTIVADA")
                return
            end
            
            isOn = not isOn
            toggleFunc()
            
            local state = false
            if labelText == Texts.Option1 then state = Settings.AutoTP
            elseif labelText == Texts.Option2 then state = Settings.AutoFarm
            elseif labelText == Texts.Option3 then state = Settings.AutoRebirth
            elseif labelText == Texts.Option4 then state = Settings.AutoClaim
            elseif labelText == Texts.Option5 then state = Settings.AutoTreadmill
            elseif labelText == Texts.Option6 then state = Settings.AntiFall
            elseif labelText == Texts.Option7 then state = Settings.AutoGetUp
            elseif labelText == Texts.Option8 then state = Settings.AutoJumpFix
            elseif labelText == Texts.Option9 then state = Settings.MultiplierDisplay
            elseif labelText == Texts.Option10 then state = Settings.FreeTrail
            elseif labelText == Texts.Option11 then state = Settings.SpeedMultiplierEdit
            elseif labelText == Texts.Option12 then state = Settings.AutoWin
            elseif labelText == Texts.Option13 then state = Settings.WinMultiplier
            elseif labelText == Texts.Option14 then state = Settings.WinStreakHack
            end
            
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
    
    -- Crear 14 toggles
    CreateToggle(Texts.Option1, ToggleAutoTP, Texts.Option1Icon, Texts.Option1Desc, OpcionesDisponibles.AutoTP)
    CreateToggle(Texts.Option2, ToggleAutoFarm, Texts.Option2Icon, Texts.Option2Desc, OpcionesDisponibles.AutoFarm)
    CreateToggle(Texts.Option3, ToggleAutoRebirth, Texts.Option3Icon, Texts.Option3Desc, OpcionesDisponibles.AutoRebirth)
    CreateToggle(Texts.Option4, ToggleAutoClaim, Texts.Option4Icon, Texts.Option4Desc, OpcionesDisponibles.AutoClaim)
    CreateToggle(Texts.Option5, ToggleAutoTreadmill, Texts.Option5Icon, Texts.Option5Desc, OpcionesDisponibles.AutoTreadmill)
    CreateToggle(Texts.Option6, ToggleAntiFall, Texts.Option6Icon, Texts.Option6Desc, OpcionesDisponibles.AntiFall)
    CreateToggle(Texts.Option7, ToggleAutoGetUp, Texts.Option7Icon, Texts.Option7Desc, OpcionesDisponibles.AutoGetUp)
    CreateToggle(Texts.Option8, ToggleAutoJumpFix, Texts.Option8Icon, Texts.Option8Desc, OpcionesDisponibles.AutoJumpFix)
    CreateToggle(Texts.Option9, ToggleMultiplierDisplay, Texts.Option9Icon, Texts.Option9Desc, OpcionesDisponibles.MultiplierDisplay)
    CreateToggle(Texts.Option10, ToggleFreeTrail, Texts.Option10Icon, Texts.Option10Desc, OpcionesDisponibles.FreeTrail)
    CreateToggle(Texts.Option11, ToggleSpeedMultiplierEdit, Texts.Option11Icon, Texts.Option11Desc, OpcionesDisponibles.SpeedMultiplierEdit)
    CreateToggle(Texts.Option12, ToggleAutoWin, Texts.Option12Icon, Texts.Option12Desc, OpcionesDisponibles.AutoWin)
    CreateToggle(Texts.Option13, ToggleWinMultiplier, Texts.Option13Icon, Texts.Option13Desc, OpcionesDisponibles.WinMultiplier)
    CreateToggle(Texts.Option14, ToggleWinStreakHack, Texts.Option14Icon, Texts.Option14Desc, OpcionesDisponibles.WinStreakHack)
    
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
    print("🔥 AUTO TP PRO ULTRA - COMPLETO")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📍 Auto TP a: X=" .. targetPos.X .. ", Y=" .. targetPos.Y .. ", Z=" .. targetPos.Z)
    print("⚡ Speed Multiplier Edit (0.01): FUNCIONA QUIETO Y MOVIENDOSE")
    print("🔄 Auto-Rebirth: " .. (OpcionesDisponibles.AutoRebirth and "✅ ON" or "❌ OFF"))
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
    
    FindRemotes()
    CreateGUI()
end)

print("✅ Script cargado exitosamente!")
