local Players=game:GetService("Players")
local Workspace=game:GetService("Workspace")
local RunService=game:GetService("RunService")
local TweenService=game:GetService("TweenService")
local UserInputService=game:GetService("UserInputService")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local Lighting=game:GetService("Lighting")
local Debris=game:GetService("Debris")
local LocalPlayer=Players.LocalPlayer
local PlayerGui=LocalPlayer:WaitForChild("PlayerGui")

local TPPositionMundo1={X=-5931.02,Y=373.07,Z=-1428.69}
local TPPositionMundo2={X=-3249.37,Y=164.89,Z=-104.36}
local TPPosition=TPPositionMundo1
local HeightOffset=2.5
local CurrentMundo=1

local AddSpeed,RequestRebirth
local function FindRemotes()
	local events=ReplicatedStorage:FindFirstChild("Events")
	if events then
		AddSpeed=events:FindFirstChild("AddSpeed")
		RequestRebirth=events:FindFirstChild("RequestRebirth")
	end
	if not AddSpeed then AddSpeed=ReplicatedStorage:FindFirstChild("AddSpeed") end
	if not RequestRebirth then RequestRebirth=ReplicatedStorage:FindFirstChild("RequestRebirth") end
end

local function GetCharacter()
	local char=LocalPlayer.Character
	if not char or not char.Parent then char=LocalPlayer.CharacterAdded:Wait() end
	return char
end
local function GetHRP()
	local char=GetCharacter()
	return char and char:FindFirstChild("HumanoidRootPart")
end
local function GetLeaderstats()
	return LocalPlayer:FindFirstChild("leaderstats")
end
local function GetTargetPosition()
	return Vector3.new(TPPosition.X,TPPosition.Y+HeightOffset,TPPosition.Z)
end

local Settings={AutoTP=false,Invisible=false,AutoFarm=false,AutoRebirth=false,SpeedMultiplier=false,LowPerformance=false}
local TPLoop,InvisibleLoop,FarmLoop,RebirthLoop,SpeedMultiplierLoop,LowPerformanceConnection
local OriginalTransparency={}

local function ToggleAutoTP()
	Settings.AutoTP=not Settings.AutoTP
	if Settings.AutoTP then
		local hrp=GetHRP()
		if hrp then pcall(function() hrp.CFrame=CFrame.new(GetTargetPosition()) hrp.Velocity=Vector3.new(0,0,0) end) end
		if TPLoop then pcall(function() TPLoop:Disconnect() end) TPLoop=nil end
		TPLoop=RunService.Heartbeat:Connect(function()
			if not Settings.AutoTP then return end
			local hrp=GetHRP()
			if not hrp then return end
			local targetPos=GetTargetPosition()
			if (hrp.Position-targetPos).Magnitude>3 then
				pcall(function() hrp.CFrame=CFrame.new(targetPos) hrp.Velocity=Vector3.new(0,0,0) end)
			end
		end)
	else
		if TPLoop then pcall(function() TPLoop:Disconnect() end) TPLoop=nil end
	end
end

local function ToggleInvisible()
	Settings.Invisible=not Settings.Invisible
	if Settings.Invisible then
		if InvisibleLoop then pcall(function() InvisibleLoop:Disconnect() end) InvisibleLoop=nil end
		InvisibleLoop=RunService.Heartbeat:Connect(function()
			if not Settings.Invisible then return end
			local char=GetCharacter()
			if not char then return end
			pcall(function()
				for _,part in pairs(char:GetDescendants()) do
					if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("Texture") then
						if OriginalTransparency[part]==nil then OriginalTransparency[part]=part.Transparency end
						part.LocalTransparencyModifier=1
					end
				end
				local hum=char:FindFirstChild("Humanoid")
				if hum then hum.NameDisplayDistance=0 end
			end)
		end)
	else
		if InvisibleLoop then pcall(function() InvisibleLoop:Disconnect() end) InvisibleLoop=nil end
		local char=GetCharacter()
		if char then
			pcall(function()
				for _,part in pairs(char:GetDescendants()) do
					if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("Texture") then
						part.LocalTransparencyModifier=0
						if OriginalTransparency[part]~=nil then part.Transparency=OriginalTransparency[part] end
					end
				end
				local hum=char:FindFirstChild("Humanoid")
				if hum then hum.NameDisplayDistance=100 end
			end)
		end
		OriginalTransparency={}
	end
end

local function ToggleAutoFarm()
	Settings.AutoFarm=not Settings.AutoFarm
	if Settings.AutoFarm then
		if not AddSpeed then Settings.AutoFarm=false return end
		if FarmLoop then pcall(function() FarmLoop:Disconnect() end) FarmLoop=nil end
		FarmLoop=RunService.Heartbeat:Connect(function()
			if not Settings.AutoFarm then return end
			pcall(function() AddSpeed:FireServer() end)
		end)
	else
		if FarmLoop then pcall(function() FarmLoop:Disconnect() end) FarmLoop=nil end
	end
end

local function ToggleAutoRebirth()
	Settings.AutoRebirth=not Settings.AutoRebirth
	if Settings.AutoRebirth then
		if not RequestRebirth then Settings.AutoRebirth=false return end
		if RebirthLoop then pcall(function() RebirthLoop:Disconnect() end) RebirthLoop=nil end
		RebirthLoop=RunService.Heartbeat:Connect(function()
			if not Settings.AutoRebirth then return end
			local stats=GetLeaderstats()
			if not stats then return end
			local level=stats:FindFirstChild("Level")
			local rebirths=stats:FindFirstChild("Rebirths")
			if not level or not rebirths then return end
			local nextLevel=(rebirths.Value+1)*5
			if level.Value>=nextLevel then pcall(function() RequestRebirth:FireServer() end) end
		end)
	else
		if RebirthLoop then pcall(function() RebirthLoop:Disconnect() end) RebirthLoop=nil end
	end
end

local SPEED_MULTIPLIER=35
local function ToggleSpeedMultiplier()
	Settings.SpeedMultiplier=not Settings.SpeedMultiplier
	if Settings.SpeedMultiplier then
		if not AddSpeed then Settings.SpeedMultiplier=false return end
		if SpeedMultiplierLoop then pcall(function() SpeedMultiplierLoop:Disconnect() end) SpeedMultiplierLoop=nil end
		SpeedMultiplierLoop=RunService.Heartbeat:Connect(function()
			if not Settings.SpeedMultiplier then return end
			local stats=LocalPlayer:FindFirstChild("Stats")
			if stats then
				local peak=stats:FindFirstChild("SpeedPeakMult")
				if peak then peak.Value=SPEED_MULTIPLIER end
			end
			for i=1,SPEED_MULTIPLIER do pcall(function() AddSpeed:FireServer() end) end
		end)
	else
		if SpeedMultiplierLoop then pcall(function() SpeedMultiplierLoop:Disconnect() end) SpeedMultiplierLoop=nil end
		local stats=LocalPlayer:FindFirstChild("Stats")
		if stats then
			local peak=stats:FindFirstChild("SpeedPeakMult")
			if peak then peak.Value=1 end
		end
	end
end

local function ToggleLowPerformance()
	Settings.LowPerformance=not Settings.LowPerformance
	if Settings.LowPerformance then
		pcall(function()
			Lighting.Brightness=.5
			Lighting.Ambient=Color3.fromRGB(128,128,128)
			Lighting.OutdoorAmbient=Color3.fromRGB(128,128,128)
			Lighting.ShadowSoftness=0
			Lighting.GlobalShadows=false
		end)
		pcall(function()
			for _,v in ipairs(Workspace:GetDescendants()) do
				if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
					v.Enabled=false
					Debris:AddItem(v,.1)
				end
				if v:IsA("BasePart") then
					v.Material=Enum.Material.SmoothPlastic
					v.Reflectance=0
					v.CastShadow=false
				end
			end
		end)
		pcall(function()
			for _,v in ipairs(Lighting:GetChildren()) do
				if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
					v.Enabled=false
				end
			end
		end)
		if LowPerformanceConnection then LowPerformanceConnection:Disconnect() LowPerformanceConnection=nil end
		LowPerformanceConnection=RunService.Heartbeat:Connect(function()
			if not Settings.LowPerformance then return end
			pcall(function()
				for _,v in ipairs(Workspace:GetDescendants()) do
					if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then v.Enabled=false end
					if v:IsA("BasePart") and v.CastShadow then v.CastShadow=false end
				end
			end)
		end)
	else
		pcall(function()
			Lighting.Brightness=1
			Lighting.Ambient=Color3.fromRGB(0,0,0)
			Lighting.OutdoorAmbient=Color3.fromRGB(0,0,0)
			Lighting.ShadowSoftness=.5
			Lighting.GlobalShadows=true
		end)
		pcall(function()
			for _,v in ipairs(Workspace:GetDescendants()) do
				if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then v.Enabled=true end
				if v:IsA("BasePart") then
					v.Material=Enum.Material.Plastic
					v.CastShadow=true
				end
			end
		end)
		pcall(function()
			for _,v in ipairs(Lighting:GetChildren()) do
				if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
					v.Enabled=true
				end
			end
		end)
		if LowPerformanceConnection then LowPerformanceConnection:Disconnect() LowPerformanceConnection=nil end
	end
end

local function SetMundo1()
	CurrentMundo=1
	TPPosition=TPPositionMundo1
	if Settings.AutoTP then
		local hrp=GetHRP()
		if hrp then pcall(function() hrp.CFrame=CFrame.new(GetTargetPosition()) hrp.Velocity=Vector3.new(0,0,0) end) end
	end
end
local function SetMundo2()
	CurrentMundo=2
	TPPosition=TPPositionMundo2
	if Settings.AutoTP then
		local hrp=GetHRP()
		if hrp then pcall(function() hrp.CFrame=CFrame.new(GetTargetPosition()) hrp.Velocity=Vector3.new(0,0,0) end) end
	end
end

local function DestroyAll()
	if TPLoop then pcall(function() TPLoop:Disconnect() end) end
	if InvisibleLoop then pcall(function() InvisibleLoop:Disconnect() end) end
	if FarmLoop then pcall(function() FarmLoop:Disconnect() end) end
	if RebirthLoop then pcall(function() RebirthLoop:Disconnect() end) end
	if SpeedMultiplierLoop then pcall(function() SpeedMultiplierLoop:Disconnect() end) end
	if LowPerformanceConnection then pcall(function() LowPerformanceConnection:Disconnect() end) end
	pcall(function()
		Lighting.Brightness=1
		Lighting.Ambient=Color3.fromRGB(0,0,0)
		Lighting.OutdoorAmbient=Color3.fromRGB(0,0,0)
		Lighting.ShadowSoftness=.5
		Lighting.GlobalShadows=true
	end)
	pcall(function()
		local g=PlayerGui:FindFirstChild("PotentUI")
		if g then g:Destroy() end
	end)
end

-- GUI
local sg=Instance.new("ScreenGui")
sg.Name="PotentUI"
sg.ResetOnSpawn=false
sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
sg.Parent=PlayerGui

local m=Instance.new("Frame")
m.Size=UDim2.new(0,480,0,420)
m.Position=UDim2.new(.5,-240,.5,-210)
m.BackgroundColor3=Color3.fromRGB(20,20,26)
m.BorderSizePixel=0
m.ClipsDescendants=true
m.Parent=sg
Instance.new("UICorner",m).CornerRadius=UDim.new(0,10)
local st=Instance.new("UIStroke",m)
st.Color=Color3.fromRGB(180,100,255)
st.Thickness=1.5
st.Transparency=.3
local g=Instance.new("UIGradient",st)
g.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(200,90,255)),ColorSequenceKeypoint.new(.33,Color3.fromRGB(90,140,255)),ColorSequenceKeypoint.new(.66,Color3.fromRGB(255,100,180)),ColorSequenceKeypoint.new(1,Color3.fromRGB(200,90,255))}
task.spawn(function() while st.Parent do g.Rotation=(g.Rotation+1)%360 task.wait() end end)

local top=Instance.new("Frame",m)
top.Size=UDim2.new(1,0,0,40)
top.BackgroundColor3=Color3.fromRGB(28,20,42)
top.BorderSizePixel=0
local tg=Instance.new("UIGradient",top)
tg.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(140,60,220)),ColorSequenceKeypoint.new(.5,Color3.fromRGB(90,70,230)),ColorSequenceKeypoint.new(1,Color3.fromRGB(60,140,230))}
Instance.new("UICorner",top).CornerRadius=UDim.new(0,10)
local fx=Instance.new("Frame",top)
fx.Size=UDim2.new(1,0,0,12)
fx.Position=UDim2.new(0,0,1,-12)
fx.BackgroundColor3=Color3.fromRGB(28,20,42)
fx.BorderSizePixel=0

local ti=Instance.new("TextLabel",top)
ti.Size=UDim2.new(1,-80,1,0)
ti.Position=UDim2.new(0,14,0,0)
ti.BackgroundTransparency=1
ti.Text="Potassium"
ti.TextColor3=Color3.fromRGB(240,240,245)
ti.Font=Enum.Font.GothamBold
ti.TextSize=16
ti.TextXAlignment=Enum.TextXAlignment.Left
ti.Active=false

local mb=Instance.new("TextButton",top)
mb.Size=UDim2.new(0,30,0,30)
mb.Position=UDim2.new(1,-70,0,5)
mb.BackgroundColor3=Color3.fromRGB(90,60,150)
mb.Text="-"
mb.TextColor3=Color3.fromRGB(255,255,255)
mb.Font=Enum.Font.GothamBold
mb.TextSize=18
Instance.new("UICorner",mb).CornerRadius=UDim.new(0,6)

local cb=Instance.new("TextButton",top)
cb.Size=UDim2.new(0,30,0,30)
cb.Position=UDim2.new(1,-35,0,5)
cb.BackgroundColor3=Color3.fromRGB(200,60,60)
cb.Text="X"
cb.TextColor3=Color3.fromRGB(255,255,255)
cb.Font=Enum.Font.GothamBold
cb.TextSize=14
Instance.new("UICorner",cb).CornerRadius=UDim.new(0,6)

local content=Instance.new("ScrollingFrame",m)
content.Size=UDim2.new(1,-20,1,-50)
content.Position=UDim2.new(0,10,0,45)
content.BackgroundTransparency=1
content.BorderSizePixel=0
content.ScrollBarThickness=3
content.ScrollBarImageColor3=Color3.fromRGB(150,90,255)
content.CanvasSize=UDim2.new(0,0,0,0)
content.AutomaticCanvasSize=Enum.AutomaticSize.Y

local layout=Instance.new("UIListLayout",content)
layout.Padding=UDim.new(0,8)
layout.SortOrder=Enum.SortOrder.LayoutOrder

local function createSwitch(name,callback)
	local h=Instance.new("Frame")
	h.Size=UDim2.new(1,0,0,38)
	h.BackgroundColor3=Color3.fromRGB(30,26,40)
	h.BorderSizePixel=0
	h.Parent=content
	Instance.new("UICorner",h).CornerRadius=UDim.new(0,6)
	local hs=Instance.new("UIStroke",h)
	hs.Color=Color3.fromRGB(150,90,255)
	hs.Thickness=1
	hs.Transparency=.5

	local lb=Instance.new("TextLabel",h)
	lb.Size=UDim2.new(1,-70,1,0)
	lb.Position=UDim2.new(0,12,0,0)
	lb.BackgroundTransparency=1
	lb.Text=name
	lb.TextColor3=Color3.fromRGB(230,220,255)
	lb.Font=Enum.Font.GothamMedium
	lb.TextSize=14
	lb.TextXAlignment=Enum.TextXAlignment.Left

	local sb=Instance.new("Frame",h)
	sb.Size=UDim2.new(0,44,0,22)
	sb.Position=UDim2.new(1,-54,.5,-11)
	sb.BackgroundColor3=Color3.fromRGB(50,50,58)
	sb.BorderSizePixel=0
	Instance.new("UICorner",sb).CornerRadius=UDim.new(1,0)

	local sd=Instance.new("Frame",sb)
	sd.Size=UDim2.new(0,18,0,18)
	sd.Position=UDim2.new(0,2,.5,-9)
	sd.BackgroundColor3=Color3.fromRGB(200,200,200)
	sd.BorderSizePixel=0
	Instance.new("UICorner",sd).CornerRadius=UDim.new(1,0)

	local sg2=Instance.new("UIGradient",sb)
	sg2.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(200,90,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(90,140,255))}
	sg2.Enabled=false

	local sbt=Instance.new("TextButton",sb)
	sbt.Size=UDim2.new(1,0,1,0)
	sbt.BackgroundTransparency=1
	sbt.Text=""

	local on=false
	sbt.MouseButton1Click:Connect(function()
		on=not on
		callback()
		if on then
			sg2.Enabled=true
			TweenService:Create(sd,TweenInfo.new(.2),{Position=UDim2.new(1,-20,.5,-9),BackgroundColor3=Color3.fromRGB(255,255,255)}):Play()
		else
			sg2.Enabled=false
			TweenService:Create(sb,TweenInfo.new(.2),{BackgroundColor3=Color3.fromRGB(50,50,58)}):Play()
			TweenService:Create(sd,TweenInfo.new(.2),{Position=UDim2.new(0,2,.5,-9),BackgroundColor3=Color3.fromRGB(200,200,200)}):Play()
		end
	end)
end

local mundoFrame=Instance.new("Frame")
mundoFrame.Size=UDim2.new(1,0,0,40)
mundoFrame.BackgroundTransparency=1
mundoFrame.Parent=content

local m1=Instance.new("TextButton",mundoFrame)
m1.Size=UDim2.new(.48,0,0,32)
m1.Position=UDim2.new(0,0,.5,-16)
m1.BackgroundColor3=Color3.fromRGB(0,180,100)
m1.Text="MUNDO 1"
m1.TextColor3=Color3.fromRGB(255,255,255)
m1.Font=Enum.Font.GothamBold
m1.TextSize=13
Instance.new("UICorner",m1).CornerRadius=UDim.new(0,6)
m1.MouseButton1Click:Connect(function()
	SetMundo1()
	m1.BackgroundColor3=Color3.fromRGB(0,180,100)
	m2.BackgroundColor3=Color3.fromRGB(60,50,150)
end)

local m2=Instance.new("TextButton",mundoFrame)
m2.Size=UDim2.new(.48,0,0,32)
m2.Position=UDim2.new(.52,0,.5,-16)
m2.BackgroundColor3=Color3.fromRGB(60,50,150)
m2.Text="MUNDO 2"
m2.TextColor3=Color3.fromRGB(255,255,255)
m2.Font=Enum.Font.GothamBold
m2.TextSize=13
Instance.new("UICorner",m2).CornerRadius=UDim.new(0,6)
m2.MouseButton1Click:Connect(function()
	SetMundo2()
	m2.BackgroundColor3=Color3.fromRGB(0,180,100)
	m1.BackgroundColor3=Color3.fromRGB(60,50,150)
end)

createSwitch("AUTO TELEPORT",ToggleAutoTP)
createSwitch("INVISIBLE",ToggleInvisible)
createSwitch("AUTO-FARM SPEED",ToggleAutoFarm)
createSwitch("AUTO-REBIRTH",ToggleAutoRebirth)
createSwitch("SPEED MULTIPLIER x"..SPEED_MULTIPLIER,ToggleSpeedMultiplier)
createSwitch("LOW PERFORMANCE",ToggleLowPerformance)

local origSize,minimized=m.Size,false
local dragging,dragStart,startPos

local function tw(o,p,t) TweenService:Create(o,TweenInfo.new(t or .25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),p):Play() end

m.Size=UDim2.new(0,480,0,0)
m.BackgroundTransparency=1
tw(m,{Size=origSize,BackgroundTransparency=0},.3)

mb.MouseButton1Click:Connect(function()
	minimized=not minimized
	content.Visible=not minimized
	mb.Text=minimized and "+" or "-"
	tw(m,{Size=minimized and UDim2.new(0,480,0,40) or origSize})
end)

local function startDrag(i)
	if (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) and minimized then
		dragging=true
		dragStart=i.Position
		startPos=m.AbsolutePosition
	end
end
top.InputBegan:Connect(startDrag)
ti.InputBegan:Connect(startDrag)
top.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
UserInputService.InputChanged:Connect(function(i)
	if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
		local d=i.Position-dragStart
		m.Position=UDim2.new(0,startPos.X+d.X,0,startPos.Y+d.Y)
	end
end)

cb.MouseButton1Click:Connect(function()
	tw(m,{Size=UDim2.new(0,480,0,0),BackgroundTransparency=1})
	task.wait(.25)
	DestroyAll()
end)

FindRemotes()
