--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local GuiInset = GuiService:GetGuiInset()

--// KEY SYSTEM
local VALID_KEYS = {"ColdWarPoorGame","CW-VIP-2025","CW-PREMIUM-ALPHA"}
local KEY_DISCORD = "https://discord.com/invite/EVqPGdnA6Q"
local KEY_VERIFIED = false

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name="ZovKeySystem"
KeyGui.ResetOnSpawn=false
KeyGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
KeyGui.IgnoreGuiInset=true
if syn and syn.protect_gui then syn.protect_gui(KeyGui) end
KeyGui.Parent = game:GetService("CoreGui")

local DiscordPanel = Instance.new("Frame",KeyGui)
DiscordPanel.Size=UDim2.new(0,280,0,45)
DiscordPanel.Position=UDim2.new(0,15,0.5,-120)
DiscordPanel.BackgroundColor3=Color3.fromRGB(35,35,55)
DiscordPanel.BorderSizePixel=0
DiscordPanel.Active=true
Instance.new("UICorner",DiscordPanel).CornerRadius=UDim.new(0,8)
Instance.new("UIStroke",DiscordPanel).Color=Color3.fromRGB(88,101,242)

local DI=Instance.new("TextLabel",DiscordPanel)
DI.Size=UDim2.new(0,30,1,0)
DI.Position=UDim2.new(0,5,0,0)
DI.BackgroundTransparency=1
DI.Text="💬"
DI.TextSize=18
DI.Font=Enum.Font.GothamBold
DI.TextColor3=Color3.fromRGB(88,101,242)

local DL=Instance.new("TextLabel",DiscordPanel)
DL.Size=UDim2.new(1,-42,0,18)
DL.Position=UDim2.new(0,38,0,4)
DL.BackgroundTransparency=1
DL.Text="Discord - Get Key"
DL.TextColor3=Color3.new(1,1,1)
DL.TextSize=11
DL.Font=Enum.Font.GothamBold
DL.TextXAlignment=Enum.TextXAlignment.Left

local DLk=Instance.new("TextButton",DiscordPanel)
DLk.Size=UDim2.new(1,-42,0,16)
DLk.Position=UDim2.new(0,38,0,23)
DLk.BackgroundTransparency=1
DLk.Text="discord.com/invite/EVqPGdnA6Q 📋"
DLk.TextColor3=Color3.fromRGB(88,101,242)
DLk.TextSize=9
DLk.Font=Enum.Font.GothamMedium
DLk.TextXAlignment=Enum.TextXAlignment.Left
DLk.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(KEY_DISCORD)
        DLk.Text="✅ Copied!"
        DLk.TextColor3=Color3.fromRGB(80,255,80)
        task.wait(2)
        DLk.Text="discord.com/invite/EVqPGdnA6Q 📋"
        DLk.TextColor3=Color3.fromRGB(88,101,242)
    end
end)

do
    local dr,di,ds,sp
    DiscordPanel.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then
            dr=true;ds=i.Position;sp=DiscordPanel.Position
            i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dr=false end end)
        end
    end)
    DiscordPanel.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement then di=i end end)
    UserInputService.InputChanged:Connect(function(i) if i==di and dr then local d=i.Position-ds;DiscordPanel.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y) end end)
end

local KM=Instance.new("Frame",KeyGui)
KM.Size=UDim2.new(0,380,0,280)
KM.AnchorPoint=Vector2.new(0.5,0.5)
KM.Position=UDim2.new(0.5,0,0.5,0)
KM.BackgroundColor3=Color3.fromRGB(20,20,32)
KM.BorderSizePixel=0
KM.ClipsDescendants=true
Instance.new("UICorner",KM).CornerRadius=UDim.new(0,10)
local KMS=Instance.new("UIStroke",KM)
KMS.Color=Color3.fromRGB(130,80,255)
KMS.Thickness=2

local KTB=Instance.new("Frame",KM)
KTB.Size=UDim2.new(1,0,0,45)
KTB.BackgroundColor3=Color3.fromRGB(28,28,42)
KTB.BorderSizePixel=0
Instance.new("UICorner",KTB).CornerRadius=UDim.new(0,10)

local KTBF=Instance.new("Frame",KTB)
KTBF.Size=UDim2.new(1,0,0,10)
KTBF.Position=UDim2.new(0,0,1,-10)
KTBF.BackgroundColor3=Color3.fromRGB(28,28,42)
KTBF.BorderSizePixel=0

local KTA=Instance.new("Frame",KTB)
KTA.Size=UDim2.new(1,0,0,2)
KTA.Position=UDim2.new(0,0,1,0)
KTA.BackgroundColor3=Color3.fromRGB(130,80,255)
KTA.BorderSizePixel=0
Instance.new("UIGradient",KTA).Color=ColorSequence.new{
    ColorSequenceKeypoint.new(0,Color3.fromRGB(130,80,255)),
    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(200,100,255)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(130,80,255))
}

local KTT=Instance.new("TextLabel",KTB)
KTT.Size=UDim2.new(1,0,1,0)
KTT.BackgroundTransparency=1
KTT.Text="🔐 ZovHub - Authentication"
KTT.TextColor3=Color3.new(1,1,1)
KTT.TextSize=16
KTT.Font=Enum.Font.GothamBold

do
    local dr,di,ds,sp
    KTB.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then
            dr=true;ds=i.Position;sp=KM.Position
            i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dr=false end end)
        end
    end)
    KTB.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement then di=i end end)
    UserInputService.InputChanged:Connect(function(i) if i==di and dr then local d=i.Position-ds;KM.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y) end end)
end

local KC=Instance.new("Frame",KM)
KC.Size=UDim2.new(1,-40,1,-55)
KC.Position=UDim2.new(0,20,0,50)
KC.BackgroundTransparency=1

local KS1=Instance.new("TextLabel",KC)
KS1.Size=UDim2.new(1,0,0,20)
KS1.Position=UDim2.new(0,0,0,5)
KS1.BackgroundTransparency=1
KS1.Text="Enter your key to access ZovHub"
KS1.TextColor3=Color3.fromRGB(150,150,180)
KS1.TextSize=12
KS1.Font=Enum.Font.GothamMedium

local KS2=Instance.new("TextLabel",KC)
KS2.Size=UDim2.new(1,0,0,16)
KS2.Position=UDim2.new(0,0,0,28)
KS2.BackgroundTransparency=1
KS2.Text="💬 Get your key from our Discord server"
KS2.TextColor3=Color3.fromRGB(88,101,242)
KS2.TextSize=10
KS2.Font=Enum.Font.GothamMedium

local KIBG=Instance.new("Frame",KC)
KIBG.Size=UDim2.new(1,0,0,40)
KIBG.Position=UDim2.new(0,0,0,55)
KIBG.BackgroundColor3=Color3.fromRGB(35,35,52)
KIBG.BorderSizePixel=0
Instance.new("UICorner",KIBG).CornerRadius=UDim.new(0,8)
local KIS=Instance.new("UIStroke",KIBG)
KIS.Color=Color3.fromRGB(60,60,90)
KIS.Thickness=1

local KI=Instance.new("TextBox",KIBG)
KI.Size=UDim2.new(1,-20,1,0)
KI.Position=UDim2.new(0,10,0,0)
KI.BackgroundTransparency=1
KI.Text=""
KI.PlaceholderText="Enter key here..."
KI.PlaceholderColor3=Color3.fromRGB(80,80,110)
KI.TextColor3=Color3.new(1,1,1)
KI.TextSize=14
KI.Font=Enum.Font.GothamMedium
KI.TextXAlignment=Enum.TextXAlignment.Left
KI.ClearTextOnFocus=false
KI.Focused:Connect(function() TweenService:Create(KIS,TweenInfo.new(0.2),{Color=Color3.fromRGB(130,80,255)}):Play() end)
KI.FocusLost:Connect(function() TweenService:Create(KIS,TweenInfo.new(0.2),{Color=Color3.fromRGB(60,60,90)}):Play() end)

local KST=Instance.new("TextLabel",KC)
KST.Size=UDim2.new(1,0,0,18)
KST.Position=UDim2.new(0,0,0,102)
KST.BackgroundTransparency=1
KST.Text=""
KST.TextColor3=Color3.fromRGB(255,60,60)
KST.TextSize=11
KST.Font=Enum.Font.GothamMedium

local KVB=Instance.new("TextButton",KC)
KVB.Size=UDim2.new(1,0,0,38)
KVB.Position=UDim2.new(0,0,0,125)
KVB.BackgroundColor3=Color3.fromRGB(130,80,255)
KVB.BorderSizePixel=0
KVB.Text="🔓 Verify Key"
KVB.TextColor3=Color3.new(1,1,1)
KVB.TextSize=14
KVB.Font=Enum.Font.GothamBold
KVB.AutoButtonColor=false
Instance.new("UICorner",KVB).CornerRadius=UDim.new(0,8)
Instance.new("UIGradient",KVB).Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(100,60,220)),ColorSequenceKeypoint.new(1,Color3.fromRGB(180,100,255))}
KVB.MouseEnter:Connect(function() TweenService:Create(KVB,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(160,100,255)}):Play() end)
KVB.MouseLeave:Connect(function() TweenService:Create(KVB,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(130,80,255)}):Play() end)

local KCD=Instance.new("TextButton",KC)
KCD.Size=UDim2.new(1,0,0,30)
KCD.Position=UDim2.new(0,0,0,170)
KCD.BackgroundColor3=Color3.fromRGB(88,101,242)
KCD.BorderSizePixel=0
KCD.Text="💬 Copy Discord Invite"
KCD.TextColor3=Color3.new(1,1,1)
KCD.TextSize=12
KCD.Font=Enum.Font.GothamMedium
KCD.AutoButtonColor=false
Instance.new("UICorner",KCD).CornerRadius=UDim.new(0,6)
KCD.MouseEnter:Connect(function() TweenService:Create(KCD,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(110,120,255)}):Play() end)
KCD.MouseLeave:Connect(function() TweenService:Create(KCD,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(88,101,242)}):Play() end)
KCD.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(KEY_DISCORD)
        KCD.Text="✅ Copied!"
        task.wait(2)
        KCD.Text="💬 Copy Discord Invite"
    end
end)

local KAtt=0
local KMAX=5
local KLck=false

local function VKey()
    if KLck then KST.Text="⏳ Too many attempts. Wait 30s.";KST.TextColor3=Color3.fromRGB(255,200,50);return end
    local ik=KI.Text:gsub("^%s+",""):gsub("%s+$","")
    if ik=="" then KST.Text="❌ Please enter a key!";KST.TextColor3=Color3.fromRGB(255,60,60);return end
    KVB.Text="⏳ Verifying...";KVB.BackgroundColor3=Color3.fromRGB(80,80,120);task.wait(0.8)
    local v=false
    for _,k in ipairs(VALID_KEYS) do if ik==k then v=true;break end end
    if v then
        KEY_VERIFIED=true
        KST.Text="✅ Key verified! Loading..."
        KST.TextColor3=Color3.fromRGB(80,255,80)
        KVB.Text="✅ Verified!"
        KVB.BackgroundColor3=Color3.fromRGB(50,180,80)
        TweenService:Create(KMS,TweenInfo.new(0.3),{Color=Color3.fromRGB(80,255,80)}):Play()
        task.wait(1.5)
        TweenService:Create(KM,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Position=UDim2.new(0.5,0,0.5,50)}):Play()
        TweenService:Create(KM,TweenInfo.new(0.4),{BackgroundTransparency=1}):Play()
        TweenService:Create(DiscordPanel,TweenInfo.new(0.4),{BackgroundTransparency=1}):Play()
        task.wait(0.6)
        KeyGui:Destroy()
    else
        KAtt=KAtt+1
        KST.Text="❌ Invalid key! "..(KMAX-KAtt).." attempts left"
        KST.TextColor3=Color3.fromRGB(255,60,60)
        KVB.Text="🔓 Verify Key"
        KVB.BackgroundColor3=Color3.fromRGB(130,80,255)
        local op=KIBG.Position
        for i=1,4 do
            KIBG.Position=UDim2.new(op.X.Scale,op.X.Offset+5,op.Y.Scale,op.Y.Offset);task.wait(0.04)
            KIBG.Position=UDim2.new(op.X.Scale,op.X.Offset-5,op.Y.Scale,op.Y.Offset);task.wait(0.04)
        end
        KIBG.Position=op
        TweenService:Create(KIS,TweenInfo.new(0.3),{Color=Color3.fromRGB(255,60,60)}):Play()
        task.wait(0.5)
        TweenService:Create(KIS,TweenInfo.new(0.3),{Color=Color3.fromRGB(60,60,90)}):Play()
        if KAtt>=KMAX then
            KLck=true;KST.Text="🔒 Locked for 30 seconds";KST.TextColor3=Color3.fromRGB(255,200,50);KVB.BackgroundColor3=Color3.fromRGB(60,60,80)
            task.delay(30,function() KLck=false;KAtt=0;KST.Text="🔓 Unlocked";KST.TextColor3=Color3.fromRGB(80,255,80);KVB.BackgroundColor3=Color3.fromRGB(130,80,255) end)
        end
    end
end

KVB.MouseButton1Click:Connect(VKey)
KI.FocusLost:Connect(function(ep) if ep then VKey() end end)

KM.Position=UDim2.new(0.5,0,0.5,30)
KM.BackgroundTransparency=0.3
TweenService:Create(KM,TweenInfo.new(0.5,Enum.EasingStyle.Back),{Position=UDim2.new(0.5,0,0.5,0),BackgroundTransparency=0}):Play()
DiscordPanel.Position=UDim2.new(0,-300,0.5,-120)
TweenService:Create(DiscordPanel,TweenInfo.new(0.6,Enum.EasingStyle.Back),{Position=UDim2.new(0,15,0.5,-120)}):Play()

repeat task.wait(0.1) until KEY_VERIFIED

--// ═══════════════════════════════════════
--// THEMES
--// ═══════════════════════════════════════

local Themes = {
    Fatality={Name="Fatality",AccentColor=Color3.fromRGB(220,40,40),AccentGradient1=Color3.fromRGB(180,20,20),AccentGradient2=Color3.fromRGB(255,80,40),BG=Color3.fromRGB(15,15,15),SideBG=Color3.fromRGB(22,22,22),CardBG=Color3.fromRGB(30,30,30),HoverBG=Color3.fromRGB(45,25,25),TextColor=Color3.fromRGB(230,230,230),DimText=Color3.fromRGB(100,100,100),TopBarBG=Color3.fromRGB(18,18,18),ToggleOn=Color3.fromRGB(220,40,40),ToggleOff=Color3.fromRGB(50,50,50),SliderFill1=Color3.fromRGB(180,20,20),SliderFill2=Color3.fromRGB(255,80,40),ESPBoxColor=Color3.fromRGB(255,50,50),SkeletonColor=Color3.fromRGB(255,60,60),ChamsFillColor=Color3.fromRGB(255,40,40),ChamsOutlineColor=Color3.fromRGB(255,120,80),FOVEnabled=Color3.fromRGB(80,255,80),FOVDisabled=Color3.fromRGB(255,50,50)},
    Black={Name="Black",AccentColor=Color3.fromRGB(180,180,180),AccentGradient1=Color3.fromRGB(120,120,120),AccentGradient2=Color3.fromRGB(220,220,220),BG=Color3.fromRGB(8,8,8),SideBG=Color3.fromRGB(14,14,14),CardBG=Color3.fromRGB(22,22,22),HoverBG=Color3.fromRGB(35,35,35),TextColor=Color3.fromRGB(200,200,200),DimText=Color3.fromRGB(80,80,80),TopBarBG=Color3.fromRGB(10,10,10),ToggleOn=Color3.fromRGB(180,180,180),ToggleOff=Color3.fromRGB(40,40,40),SliderFill1=Color3.fromRGB(100,100,100),SliderFill2=Color3.fromRGB(200,200,200),ESPBoxColor=Color3.fromRGB(200,200,200),SkeletonColor=Color3.fromRGB(180,180,180),ChamsFillColor=Color3.fromRGB(150,150,150),ChamsOutlineColor=Color3.fromRGB(220,220,220),FOVEnabled=Color3.fromRGB(80,255,80),FOVDisabled=Color3.fromRGB(255,50,50)},
    PurpleHaze={Name="Purple Haze",AccentColor=Color3.fromRGB(130,80,255),AccentGradient1=Color3.fromRGB(100,60,220),AccentGradient2=Color3.fromRGB(180,100,255),BG=Color3.fromRGB(20,20,30),SideBG=Color3.fromRGB(28,28,40),CardBG=Color3.fromRGB(35,35,50),HoverBG=Color3.fromRGB(45,45,65),TextColor=Color3.fromRGB(220,220,230),DimText=Color3.fromRGB(120,120,150),TopBarBG=Color3.fromRGB(25,25,38),ToggleOn=Color3.fromRGB(130,80,255),ToggleOff=Color3.fromRGB(55,55,75),SliderFill1=Color3.fromRGB(100,60,220),SliderFill2=Color3.fromRGB(180,100,255),ESPBoxColor=Color3.fromRGB(130,80,255),SkeletonColor=Color3.fromRGB(130,80,255),ChamsFillColor=Color3.fromRGB(130,80,255),ChamsOutlineColor=Color3.fromRGB(200,130,255),FOVEnabled=Color3.fromRGB(80,255,80),FOVDisabled=Color3.fromRGB(255,50,50)},
    Ocean={Name="Ocean",AccentColor=Color3.fromRGB(40,160,220),AccentGradient1=Color3.fromRGB(20,120,200),AccentGradient2=Color3.fromRGB(80,200,255),BG=Color3.fromRGB(12,20,30),SideBG=Color3.fromRGB(18,28,42),CardBG=Color3.fromRGB(25,38,55),HoverBG=Color3.fromRGB(35,55,75),TextColor=Color3.fromRGB(210,230,245),DimText=Color3.fromRGB(90,120,150),TopBarBG=Color3.fromRGB(14,24,36),ToggleOn=Color3.fromRGB(40,160,220),ToggleOff=Color3.fromRGB(40,55,70),SliderFill1=Color3.fromRGB(20,120,200),SliderFill2=Color3.fromRGB(80,200,255),ESPBoxColor=Color3.fromRGB(40,180,255),SkeletonColor=Color3.fromRGB(40,180,255),ChamsFillColor=Color3.fromRGB(40,160,220),ChamsOutlineColor=Color3.fromRGB(80,200,255),FOVEnabled=Color3.fromRGB(80,255,80),FOVDisabled=Color3.fromRGB(255,50,50)},
    Blood={Name="Blood",AccentColor=Color3.fromRGB(180,0,0),AccentGradient1=Color3.fromRGB(120,0,0),AccentGradient2=Color3.fromRGB(220,30,30),BG=Color3.fromRGB(18,8,8),SideBG=Color3.fromRGB(28,12,12),CardBG=Color3.fromRGB(38,18,18),HoverBG=Color3.fromRGB(55,25,25),TextColor=Color3.fromRGB(240,210,210),DimText=Color3.fromRGB(130,80,80),TopBarBG=Color3.fromRGB(22,10,10),ToggleOn=Color3.fromRGB(180,0,0),ToggleOff=Color3.fromRGB(50,25,25),SliderFill1=Color3.fromRGB(120,0,0),SliderFill2=Color3.fromRGB(220,30,30),ESPBoxColor=Color3.fromRGB(200,0,0),SkeletonColor=Color3.fromRGB(200,30,30),ChamsFillColor=Color3.fromRGB(180,0,0),ChamsOutlineColor=Color3.fromRGB(255,50,50),FOVEnabled=Color3.fromRGB(80,255,80),FOVDisabled=Color3.fromRGB(255,50,50)},
    Mint={Name="Mint",AccentColor=Color3.fromRGB(50,205,130),AccentGradient1=Color3.fromRGB(30,160,100),AccentGradient2=Color3.fromRGB(80,240,160),BG=Color3.fromRGB(14,22,18),SideBG=Color3.fromRGB(20,32,26),CardBG=Color3.fromRGB(28,42,35),HoverBG=Color3.fromRGB(40,60,48),TextColor=Color3.fromRGB(210,240,225),DimText=Color3.fromRGB(90,130,110),TopBarBG=Color3.fromRGB(16,26,20),ToggleOn=Color3.fromRGB(50,205,130),ToggleOff=Color3.fromRGB(35,55,45),SliderFill1=Color3.fromRGB(30,160,100),SliderFill2=Color3.fromRGB(80,240,160),ESPBoxColor=Color3.fromRGB(50,220,130),SkeletonColor=Color3.fromRGB(50,220,130),ChamsFillColor=Color3.fromRGB(50,205,130),ChamsOutlineColor=Color3.fromRGB(80,240,160),FOVEnabled=Color3.fromRGB(80,255,80),FOVDisabled=Color3.fromRGB(255,50,50)},
}

local CurrentThemeName="PurpleHaze"
local function GetTheme() return Themes[CurrentThemeName] or Themes.PurpleHaze end

--// SETTINGS
local function GetMouseViewportPos() return Vector2.new(Mouse.X,Mouse.Y+GuiInset.Y) end

local Settings = {
    Enabled=false,FOV=100,ShowFOV=true,TargetPart="Head",
    Keybind=Enum.KeyCode.X,TeamCheck=true,WallCheck=true,
    NoSpread=false,NoRecoil=false,NoFallDamage=false,NoBulletSpread=false,
    InfAmmo=false,InfRPG=false,InfGP25=false,
    ShowSkeleton=true,SkeletonThickness=1.5,
    ShowESPBox=true,ShowName=true,ShowHealth=true,ShowDistance=true,
    ShowChams=true,ChamsFillTransparency=0.6,ChamsOutlineTransparency=0.3,
    WalkSpeed=16,WalkSpeedEnabled=false,
    InfJump=false,Fly=false,FlySpeed=50,
}

local CachedTargetPosition=nil
local CurrentTarget=nil

local FOVCircle=Drawing.new("Circle")
FOVCircle.Thickness=1.5
FOVCircle.NumSides=64
FOVCircle.Radius=Settings.FOV
FOVCircle.Filled=false
FOVCircle.Visible=Settings.ShowFOV
FOVCircle.ZIndex=999
FOVCircle.Transparency=0.8
FOVCircle.Color=GetTheme().FOVDisabled

--// HELPERS
local function IsEnemy(p)
    if p==LocalPlayer then return false end
    if not Settings.TeamCheck then return true end
    if not LocalPlayer.Team or not p.Team then return true end
    return LocalPlayer.Team~=p.Team
end

local function IsAlive(p)
    local ch=p.Character
    if not ch then return false end
    local h=ch:FindFirstChildOfClass("Humanoid")
    return h and h.Health>0
end

local function IsVisible(part)
    if not Settings.WallCheck then return true end
    local ch=LocalPlayer.Character
    if not ch then return true end
    local head=ch:FindFirstChild("Head")
    if not head then return true end
    local rp=RaycastParams.new()
    rp.FilterType=Enum.RaycastFilterType.Blacklist
    rp.FilterDescendantsInstances={ch,part.Parent}
    return workspace:Raycast(head.Position,part.Position-head.Position,rp)==nil
end

local function IsInsideWeapon(o)
    local c=o
    for i=1,10 do
        if not c then return false end
        if c:IsA("Tool") then return true end
        c=c.Parent
    end
    return false
end

local PRIMARY_AMMO_NAMES={ammo=true,mag=true,clip=true,magazine=true,bullets=true,rounds=true,currentammo=true,magsize=true,clipsize=true,magcount=true,roundcount=true,ammocount=true,cartridge=true}
local RPG_AMMO_NAMES={rocket=true,missile=true,rpg=true,projectile=true,warhead=true,rocketammo=true,rpgammo=true}
local GP25_AMMO_NAMES={grenade=true,gp25=true,["gp-25"]=true,gp30=true,["gp-30"]=true,gl=true,m203=true,ubgl=true,["40mm"]=true,nade=true,grenadeammo=true,glammo=true,grenadecount=true,secondary=true,secondaryammo=true,secondary_ammo=true,altammo=true,alt_ammo=true,altfire=true,alt_fire=true,secondarymag=true,secondary_mag=true,undermag=true,under_mag=true,underbarrel=true,under_barrel=true,underbarrelammo=true,underbarrel_ammo=true,secondarymagslot=true,secondary_mag_slot=true,altmagslot=true,alt_mag_slot=true,glmag=true,gl_mag=true,glmagslot=true,gl_mag_slot=true,grenademag=true,grenade_mag=true,secondaryround=true,secondary_round=true,altround=true,alt_round=true}

local function IsAmmoName(n)
    local nl=n:lower()
    if Settings.InfAmmo and PRIMARY_AMMO_NAMES[nl] then return true end
    if Settings.InfRPG and RPG_AMMO_NAMES[nl] then return true end
    if Settings.InfGP25 and GP25_AMMO_NAMES[nl] then return true end
    if Settings.InfGP25 then
        if nl:find("secondary") or nl:find("altammo") or nl:find("alt_ammo") or nl:find("underbarrel") or nl:find("under_barrel") or nl:find("grenade") or nl:find("gp25") or nl:find("gp_25") or nl:find("gp30") or nl:find("gp_30") or nl:find("ubgl") or nl:find("40mm") or nl:find("m203") or nl:find("glmag") or nl:find("gl_mag") or nl:find("grenademag") or nl:find("altfire") or nl:find("alt_fire") or nl:find("secondarymag") or nl:find("secondary_mag") then return true end
    end
    if Settings.InfRPG then
        if nl:find("rocket") or nl:find("rpg") or nl:find("missile") then return true end
    end
    return false
end

local function IsGP25Part(o)
    local c=o
    for i=1,8 do
        if not c then return false end
        local cn=c.Name:lower()
        if cn:find("secondary") or cn:find("underbarrel") or cn:find("under_barrel") or cn:find("grenade") or cn:find("gp25") or cn:find("gp_25") or cn:find("gp30") or cn:find("gl") or cn:find("m203") or cn:find("ubgl") or cn:find("altfire") or cn:find("alt") then return true end
        c=c.Parent
    end
    return false
end

local function IsModuleBlacklisted(nm)
    return nm:find("damage") or nm:find("hit") or nm:find("health") or nm:find("kill") or nm:find("death") or nm:find("public") or nm:find("trans") or nm:find("network") or nm:find("sync") or nm:find("server") or nm:find("gui") or nm:find("ui") or nm:find("hud") or nm:find("camera") or nm:find("input") or nm:find("control") or nm:find("player") or nm:find("character") or nm:find("team") or nm:find("spawn") or nm:find("sound") or nm:find("anim") or nm:find("effect") or nm:find("particle") or nm:find("view") or nm:find("scope") or nm:find("ads") or nm:find("aim") or nm:find("look") or nm:find("mouse") or nm:find("cursor")
end

--// MODULE PATCHER
local patchedModules={}
local lastPatchTick=0
local hookedWeaponModules={}

local function DeepPatchTable(t,d)
    if d>8 or type(t)~="table" then return end
    for k,v in pairs(t) do
        local kl=type(k)=="string" and k:lower() or ""
        if Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25 then
            if kl=="ammocost" or kl=="ammo_cost" or kl=="ammouse" or kl=="ammo_use" or kl=="ammopershot" or kl=="ammo_per_shot" or kl=="bulletcost" or kl=="ammodrain" or kl=="consumeamount" then
                if type(v)=="number" then pcall(function() t[k]=0 end) end
            end
            if kl=="magsize" or kl=="mag_size" or kl=="clipsize" or kl=="clip_size" or kl=="magazinesize" or kl=="maxammo" or kl=="max_ammo" or kl=="reserveammo" or kl=="reserve_ammo" or kl=="totalammo" or kl=="maxmags" or kl=="sparemags" then
                if type(v)=="number" and v>0 and v<9999 then pcall(function() t[k]=9999 end) end
            end
            if kl=="reloadtime" or kl=="reload_time" or kl=="reloadduration" then
                if type(v)=="number" then pcall(function() t[k]=0.01 end) end
            end
        end
        if Settings.InfGP25 and (kl:find("secondary") or kl:find("altammo") or kl:find("alt_ammo") or kl:find("underbarrel") or kl:find("grenade") or kl:find("gp25") or kl:find("gp30") or kl:find("ubgl") or kl:find("40mm") or kl:find("m203") or kl:find("glmag") or kl:find("gl_mag") or kl:find("altfire") or kl:find("alt_fire")) then
            if type(v)=="number" then
                if kl:find("cost") or kl:find("use") or kl:find("drain") or kl:find("consume") or kl:find("pershot") then pcall(function() t[k]=0 end)
                elseif v>0 and v<9999 then pcall(function() t[k]=math.max(v,999) end) end
            elseif type(v)=="boolean" then
                if kl:find("empty") or kl:find("depleted") or kl:find("needsreload") then pcall(function() t[k]=false end) end
                if kl:find("has") or kl:find("loaded") or kl:find("ready") or kl:find("can") then pcall(function() t[k]=true end) end
            end
        end
        if Settings.InfRPG and (kl:find("rocket") or kl:find("rpg") or kl:find("missile") or kl:find("launcher")) then
            if type(v)=="number" then
                if kl:find("cost") or kl:find("use") or kl:find("drain") or kl:find("consume") then pcall(function() t[k]=0 end)
                elseif v>0 and v<9999 then pcall(function() t[k]=math.max(v,999) end) end
            end
        end
        if type(v)=="table" then DeepPatchTable(v,d+1) end
    end
end

local function HookWeaponFunctions(m,mp)
    if type(m)~="table" or not(Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
    for fn,fv in pairs(m) do
        if type(fv)~="function" then continue end
        local fl=fn:lower()
        local hk=mp.."_"..fn
        if hookedWeaponModules[hk] then continue end
        if fl=="consumeammo" or fl=="useammo" or fl=="removeammo" or fl=="decrementammo" or fl=="spendammo" or fl=="subtractammo" or fl=="drainammo" or fl=="consumesecondary" or fl=="usesecondaryammo" or fl=="consumealtammo" or fl=="usealtammo" or fl=="consumegrenade" or fl=="usegrenade" or fl=="removegrenade" or fl=="consumegl" or fl=="consumesecondaryammo" or fl=="removesecondaryammo" or fl=="decrementgrenade" or fl=="spendgrenade" or fl=="removealtammo" or fl=="subtractsecondary" then
            m[fn]=function() return end;hookedWeaponModules[hk]=true
        end
        if fl=="getammo" or fl=="getmagammo" or fl=="getcurrentammo" or fl=="getmagcount" or fl=="getrounds" or fl=="ammocount" or fl=="getsecondaryammo" or fl=="getaltammo" or fl=="getgrenadecount" or fl=="getgrenadeammo" or fl=="getglcount" or fl=="getglammo" or fl=="getsecondarycount" or fl=="getaltcount" or fl=="getunderbarrelammo" then
            local of=fv;m[fn]=function(...) local r=of(...);if type(r)=="number" then return math.max(r,999) end;return r end;hookedWeaponModules[hk]=true
        end
        if fl=="isempty" or fl=="needsreload" or fl=="outofammo" or fl=="ismagempty" or fl=="nomags" or fl=="issecondaryempty" or fl=="isaltempty" or fl=="isgrenadeempty" or fl=="nogrenades" or fl=="secondaryempty" or fl=="glempty" or fl=="isglroundempty" or fl=="noaltammo" or fl=="issecondarymagempty" or fl=="needssecondaryreload" or fl=="isunderbarrelempty" then
            m[fn]=function() return false end;hookedWeaponModules[hk]=true
        end
        if fl=="canfire" or fl=="canshoot" or fl=="hasammo" or fl=="hasmag" or fl=="isloaded" or fl=="canfiresecondary" or fl=="canfirealt" or fl=="canfiregrenade" or fl=="canfiregl" or fl=="hassecondaryammo" or fl=="hasaltammo" or fl=="hasgrenade" or fl=="hasglround" or fl=="issecondaryloaded" or fl=="isaltloaded" or fl=="isglloaded" or fl=="canshootsecondary" or fl=="hassecondary" or fl=="secondaryready" or fl=="isunderbarrelready" or fl=="isunderbarrelloaded" then
            m[fn]=function() return true end;hookedWeaponModules[hk]=true
        end
    end
end

local function PatchColdWarWeaponSystem()
    if not(Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
    pcall(function()
        local mf=ReplicatedStorage:FindFirstChild("Modules")
        if not mf then return end
        for _,d in ipairs(mf:GetDescendants()) do
            if not d:IsA("ModuleScript") then continue end
            local nm=d.Name:lower()
            if not(nm:find("weapon") or nm:find("gun") or nm:find("fire") or nm:find("ammo") or nm:find("mag") or nm:find("reload") or nm:find("shoot") or nm:find("bullet") or nm:find("rpg") or nm:find("grenade") or nm:find("launcher") or nm:find("gp") or nm:find("explosive") or nm:find("rocket") or nm:find("projectile") or nm:find("core") or nm:find("secondary") or nm:find("alt") or nm:find("underbarrel") or nm:find("ubgl") or nm:find("gl")) then continue end
            if IsModuleBlacklisted(nm) then continue end
            pcall(function() local mod=require(d);if type(mod)=="table" then DeepPatchTable(mod,0);HookWeaponFunctions(mod,d:GetFullName()) end end)
        end
    end)
end

local magConnections={}
local function PatchMagSystem()
    if not(Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
    local ch=LocalPlayer.Character;if not ch then return end
    for _,c in pairs(magConnections) do if typeof(c)=="RBXScriptConnection" and c.Connected then c:Disconnect() end end
    magConnections={}
    for _,tool in ipairs(ch:GetChildren()) do
        if not tool:IsA("Tool") then continue end
        for _,desc in ipairs(tool:GetDescendants()) do
            local name=desc.Name:lower()
            if(desc:IsA("NumberValue") or desc:IsA("IntValue")) then
                local sp=false
                if Settings.InfAmmo and PRIMARY_AMMO_NAMES[name] then sp=true end
                if Settings.InfRPG and(RPG_AMMO_NAMES[name] or name:find("rocket") or name:find("rpg") or name:find("missile")) then sp=true end
                if Settings.InfGP25 then
                    if GP25_AMMO_NAMES[name] then sp=true end
                    if name:find("secondary") or name:find("alt") or name:find("grenade") or name:find("gp25") or name:find("gp30") or name:find("ubgl") or name:find("40mm") or name:find("m203") or name:find("gl") or name:find("underbarrel") then sp=true end
                    if IsGP25Part(desc) and(name:find("ammo") or name:find("mag") or name:find("clip") or name:find("round") or name:find("count") or name:find("shell") or name:find("current") or name:find("remaining") or name:find("loaded")) then sp=true end
                end
                if sp then
                    if desc.Value>=0 and desc.Value<9999 then pcall(function() desc.Value=math.max(desc.Value,999) end) end
                    table.insert(magConnections,desc.Changed:Connect(function(nv)
                        if not(Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
                        if nv<900 then task.defer(function() pcall(function() desc.Value=999 end) end) end
                    end))
                end
            end
            if name:find("magslot") or name:find("currentmagslot") or(Settings.InfGP25 and(name:find("secondarymagslot") or name:find("secondary_mag_slot") or name:find("altmagslot") or name:find("glmagslot") or name:find("grenademagslot") or name:find("underbarrelslot"))) then
                table.insert(magConnections,desc.ChildRemoved:Connect(function(r)
                    if not(Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
                    task.defer(function() task.wait(0.05);pcall(function() if #desc:GetChildren()==0 then r:Clone().Parent=desc end end) end)
                end))
            end
            if Settings.InfGP25 and(name:find("secondary") or name:find("underbarrel") or name:find("grenade") or name:find("gp25") or name:find("gl") or name:find("alt")) and(desc:IsA("Folder") or desc:IsA("Model") or desc:IsA("Configuration")) then
                table.insert(magConnections,desc.ChildRemoved:Connect(function(r)
                    if not Settings.InfGP25 then return end
                    task.defer(function() task.wait(0.05);pcall(function()
                        local rn=r.Name:lower()
                        if rn:find("mag") or rn:find("round") or rn:find("shell") or rn:find("grenade") or rn:find("ammo") or rn:find("projectile") then
                            if #desc:GetChildren()==0 or not desc:FindFirstChild(r.Name) then r:Clone().Parent=desc end
                        end
                    end) end)
                end))
            end
            if desc:IsA("ModuleScript") and not IsModuleBlacklisted(desc.Name:lower()) then
                pcall(function() local mod=require(desc);if type(mod)=="table" then DeepPatchTable(mod,0);HookWeaponFunctions(mod,desc:GetFullName()) end end)
            end
        end
    end
    table.insert(magConnections,ch.ChildAdded:Connect(function(c) if c:IsA("Tool") then task.wait(0.3);PatchMagSystem() end end))
end

local function PatchAllModules()
    if not(Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
    PatchColdWarWeaponSystem()
    PatchMagSystem()
end

local ammoConnections={}
local function MonitorAmmoValues()
    for _,c in pairs(ammoConnections) do if typeof(c)=="RBXScriptConnection" and c.Connected then c:Disconnect() end end
    ammoConnections={}
    local ch=LocalPlayer.Character;if not ch then return end
    local function HV(o)
        if not(o:IsA("NumberValue") or o:IsA("IntValue")) then return end
        if not IsInsideWeapon(o) then return end
        if not IsAmmoName(o.Name) then return end
        local mx=o.Value;if mx<=0 then mx=999 end
        table.insert(ammoConnections,o.Changed:Connect(function(nv)
            if not(Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
            if nv<mx then task.defer(function() pcall(function() o.Value=mx end) end) else mx=nv end
        end))
    end
    for _,d in ipairs(ch:GetDescendants()) do HV(d) end
    table.insert(ammoConnections,ch.DescendantAdded:Connect(function(d) task.wait();HV(d) end))
    PatchMagSystem()
end

local function RefreshAmmoMonitor()
    if Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25 then
        MonitorAmmoValues();patchedModules={};lastPatchTick=0;hookedWeaponModules={}
    end
end

--// NO FALL DAMAGE
local fallDamageConnection=nil
local function SetupNoFallDamage()
    local ch=LocalPlayer.Character;if not ch then return end
    local hum=ch:FindFirstChildOfClass("Humanoid");local root=ch:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end
    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
    if fallDamageConnection then fallDamageConnection:Disconnect() end
    fallDamageConnection=hum.StateChanged:Connect(function(_,ns)
        if not Settings.NoFallDamage then return end
        if ns==Enum.HumanoidStateType.FallingDown or ns==Enum.HumanoidStateType.Ragdoll then
            hum:ChangeState(Enum.HumanoidStateType.Landing)
            task.defer(function() hum:ChangeState(Enum.HumanoidStateType.Running) end)
        end
        if ns==Enum.HumanoidStateType.Landed and root then
            root.Velocity=Vector3.new(root.Velocity.X,0,root.Velocity.Z)
            pcall(function() root.AssemblyLinearVelocity=Vector3.new(root.AssemblyLinearVelocity.X,0,root.AssemblyLinearVelocity.Z) end)
        end
    end)
end

local function UpdateNoFallDamage()
    if not Settings.NoFallDamage then return end
    local ch=LocalPlayer.Character;if not ch then return end
    local hum=ch:FindFirstChildOfClass("Humanoid");local root=ch:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end
    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
    local vel=root.Velocity
    if vel.Y<-80 then root.Velocity=Vector3.new(vel.X,-80,vel.Z);pcall(function() root.AssemblyLinearVelocity=Vector3.new(vel.X,-80,vel.Z) end) end
    if hum:GetState()==Enum.HumanoidStateType.Freefall and vel.Y<-100 then hum:ChangeState(Enum.HumanoidStateType.Running) end
end

LocalPlayer.CharacterAdded:Connect(function(ch)
    ch:WaitForChild("Humanoid");ch:WaitForChild("HumanoidRootPart");task.wait(0.5)
    if Settings.NoFallDamage then SetupNoFallDamage() end
    if Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25 then MonitorAmmoValues() end
    patchedModules={};lastPatchTick=0;hookedWeaponModules={}
end)
if LocalPlayer.Character then task.defer(function() if Settings.NoFallDamage then SetupNoFallDamage() end end) end

--// TELEPORT
local function SmoothTP(tp)
    local ch=LocalPlayer.Character;if not ch then return end
    local root=ch:FindFirstChild("HumanoidRootPart");local hum=ch:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    if typeof(tp)=="CFrame" then tp=tp.Position end
    local rp=RaycastParams.new();rp.FilterType=Enum.RaycastFilterType.Blacklist;rp.FilterDescendantsInstances={ch}
    local fl=workspace:Raycast(tp+Vector3.new(0,10,0),Vector3.new(0,-100,0),rp)
    local fp=fl and(fl.Position+Vector3.new(0,3.5,0)) or(tp+Vector3.new(0,3.5,0))
    root.Velocity=Vector3.new(0,0,0)
    pcall(function() root.AssemblyLinearVelocity=Vector3.new(0,0,0) end)
    pcall(function() root.AssemblyAngularVelocity=Vector3.new(0,0,0) end)
    root.CFrame=CFrame.new(fp)
    hum:ChangeState(Enum.HumanoidStateType.Running)
    for i=1,5 do task.defer(function() task.wait(i*0.03)
        if root and root.Parent then root.Velocity=Vector3.new(0,0,0);pcall(function() root.AssemblyLinearVelocity=Vector3.new(0,0,0) end);hum:ChangeState(Enum.HumanoidStateType.Running) end
    end) end
end

local ColdWarLocations = {
    Church={
        {name="Basement 1",pos=Vector3.new(231.8,109.8,17.5)},
        {name="Basement 2",pos=Vector3.new(205.8,109.8,48.4)},
        {name="Entrance",pos=Vector3.new(237.7,128.3,94.0)},
        {name="Staircase",pos=Vector3.new(236.3,153.5,89.8)},
        {name="Attic",pos=Vector3.new(195.8,171.5,2.4)},
        {name="Roof",pos=Vector3.new(238.1,214.2,91.7)},
    },
    Sniper={
        {name="Church Roof",pos=Vector3.new(238.1,214.2,91.7)},
        {name="Vasily Roof",pos=Vector3.new(833.6,226.3,160.7)},
        {name="Church Attic",pos=Vector3.new(195.8,171.5,2.4)},
        {name="Church Staircase",pos=Vector3.new(236.3,153.5,89.8)},
    },
    General={
        {name="Map Center",pos=Vector3.new(220,130,50)},
        {name="Near Church",pos=Vector3.new(237.7,128.3,94.0)},
    },
}

--// FLY
local flyBody,flyGyro,flying=nil,nil,false

local function StartFly()
    local ch=LocalPlayer.Character;if not ch then return end
    local root=ch:FindFirstChild("HumanoidRootPart");if not root then return end
    flying=true
    flyBody=Instance.new("BodyVelocity");flyBody.MaxForce=Vector3.new(1e6,1e6,1e6);flyBody.Velocity=Vector3.new(0,0,0);flyBody.Parent=root
    flyGyro=Instance.new("BodyGyro");flyGyro.MaxTorque=Vector3.new(1e6,1e6,1e6);flyGyro.D=200;flyGyro.P=40000;flyGyro.Parent=root
    local hum=ch:FindFirstChildOfClass("Humanoid");if hum then hum.PlatformStand=true end
end

local function StopFly()
    flying=false
    if flyBody then flyBody:Destroy();flyBody=nil end
    if flyGyro then flyGyro:Destroy();flyGyro=nil end
    local ch=LocalPlayer.Character;if ch then local hum=ch:FindFirstChildOfClass("Humanoid");if hum then hum.PlatformStand=false end end
end

local function UpdateFly()
    if not flying or not flyBody or not flyGyro then return end
    local ch=LocalPlayer.Character;if not ch then StopFly();return end
    local root=ch:FindFirstChild("HumanoidRootPart");if not root then StopFly();return end
    flyGyro.CFrame=Camera.CFrame
    local dir=Vector3.new(0,0,0)
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir=dir+Camera.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir=dir-Camera.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir=dir-Camera.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir=dir+Camera.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir=dir+Vector3.new(0,1,0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir=dir-Vector3.new(0,1,0) end
    flyBody.Velocity=dir.Magnitude>0 and dir.Unit*Settings.FlySpeed or Vector3.new(0,0,0)
end

UserInputService.JumpRequest:Connect(function()
    if Settings.InfJump then
        local ch=LocalPlayer.Character
        if ch then local hum=ch:FindFirstChildOfClass("Humanoid");if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end end
    end
end)

local function UpdateWalkSpeed()
    if not Settings.WalkSpeedEnabled then return end
    local ch=LocalPlayer.Character;if not ch then return end
    local hum=ch:FindFirstChildOfClass("Humanoid");if hum then hum.WalkSpeed=Settings.WalkSpeed end
end

--// ═══════════════════════════════════════
--// VISUALS
--// ═══════════════════════════════════════

local ChamsObjects={}
local function UpdateChams()
    local t=GetTheme()
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LocalPlayer then continue end
        local ch=p.Character
        if not Settings.ShowChams or not ch or not IsEnemy(p) or not IsAlive(p) then
            if ChamsObjects[p] then ChamsObjects[p]:Destroy();ChamsObjects[p]=nil end
            continue
        end
        if not ChamsObjects[p] then
            local h=Instance.new("Highlight");h.FillColor=t.ChamsFillColor;h.FillTransparency=Settings.ChamsFillTransparency
            h.OutlineColor=t.ChamsOutlineColor;h.OutlineTransparency=Settings.ChamsOutlineTransparency
            h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop;h.Parent=ch;ChamsObjects[p]=h
        else
            local h=ChamsObjects[p];if h.Parent~=ch then h.Parent=ch end
            h.FillColor=t.ChamsFillColor;h.FillTransparency=Settings.ChamsFillTransparency
            h.OutlineColor=t.ChamsOutlineColor;h.OutlineTransparency=Settings.ChamsOutlineTransparency
        end
    end
end

local ESPObjects={}
local function GetESP(p)
    if not ESPObjects[p] then
        ESPObjects[p]={BoxOutline=Drawing.new("Quad"),Box=Drawing.new("Quad"),Name=Drawing.new("Text"),Health=Drawing.new("Text"),Distance=Drawing.new("Text"),HealthBar=Drawing.new("Line"),HealthBarBG=Drawing.new("Line")}
        local e=ESPObjects[p]
        e.BoxOutline.Thickness=3;e.BoxOutline.Color=Color3.new(0,0,0);e.BoxOutline.Filled=false;e.BoxOutline.Visible=false
        e.Box.Thickness=1.2;e.Box.Filled=false;e.Box.Visible=false
        e.Name.Size=13;e.Name.Center=true;e.Name.Outline=true;e.Name.OutlineColor=Color3.new(0,0,0);e.Name.Font=2;e.Name.Visible=false
        e.Health.Size=12;e.Health.Center=false;e.Health.Outline=true;e.Health.OutlineColor=Color3.new(0,0,0);e.Health.Font=2;e.Health.Visible=false
        e.Distance.Size=12;e.Distance.Center=true;e.Distance.Outline=true;e.Distance.OutlineColor=Color3.new(0,0,0);e.Distance.Font=2;e.Distance.Visible=false
        e.HealthBarBG.Thickness=4;e.HealthBarBG.Color=Color3.new(0,0,0);e.HealthBarBG.Visible=false
        e.HealthBar.Thickness=2;e.HealthBar.Visible=false
    end
    return ESPObjects[p]
end
local function HideAllESP(p) if ESPObjects[p] then for _,o in pairs(ESPObjects[p]) do o.Visible=false end end end
local function RemoveESP(p) if ESPObjects[p] then for _,o in pairs(ESPObjects[p]) do o:Remove() end;ESPObjects[p]=nil end end

local function UpdateESP()
    local t=GetTheme()
    local anyOn=Settings.ShowESPBox or Settings.ShowName or Settings.ShowHealth or Settings.ShowDistance
    for _,player in ipairs(Players:GetPlayers()) do
        if player==LocalPlayer then continue end
        if not anyOn or not IsEnemy(player) or not IsAlive(player) then HideAllESP(player);continue end
        local ch=player.Character;if not ch then HideAllESP(player);continue end
        local hum=ch:FindFirstChildOfClass("Humanoid");local root=ch:FindFirstChild("HumanoidRootPart")
        if not hum or not root then HideAllESP(player);continue end
        local esp=GetESP(player)
        local pos,onScreen=Camera:WorldToViewportPoint(root.Position)
        if not onScreen then HideAllESP(player);continue end
        local dist=(Camera.CFrame.Position-root.Position).Magnitude
        local sf=1/(pos.Z*math.tan(math.rad(Camera.FieldOfView/2))*2)*1000
        local bw,bh=4*sf,5.5*sf
        local bx,by=pos.X,pos.Y
        local tl=Vector2.new(bx-bw/2,by-bh/2)
        local tr=Vector2.new(bx+bw/2,by-bh/2)
        local bl=Vector2.new(bx-bw/2,by+bh/2)
        local br=Vector2.new(bx+bw/2,by+bh/2)

        if Settings.ShowESPBox then
            esp.BoxOutline.PointA=tl;esp.BoxOutline.PointB=tr;esp.BoxOutline.PointC=br;esp.BoxOutline.PointD=bl;esp.BoxOutline.Visible=true
            esp.Box.PointA=tl;esp.Box.PointB=tr;esp.Box.PointC=br;esp.Box.PointD=bl;esp.Box.Color=t.ESPBoxColor;esp.Box.Visible=true
        else esp.BoxOutline.Visible=false;esp.Box.Visible=false end

        if Settings.ShowName then
            esp.Name.Text=player.DisplayName;esp.Name.Position=Vector2.new(bx,tl.Y-16);esp.Name.Color=Color3.new(1,1,1);esp.Name.Visible=true
        else esp.Name.Visible=false end

        local hp=hum.Health/hum.MaxHealth
        if Settings.ShowHealth then
            esp.Health.Text=math.floor(hum.Health).." HP";esp.Health.Position=Vector2.new(tr.X+4,tr.Y)
            local r,g=math.floor(255*(1-hp)),math.floor(255*hp)
            esp.Health.Color=Color3.fromRGB(r,g,50);esp.Health.Visible=true
            esp.HealthBarBG.From=Vector2.new(tl.X-5,bl.Y);esp.HealthBarBG.To=Vector2.new(tl.X-5,tl.Y);esp.HealthBarBG.Visible=true
            local barH=(bl.Y-tl.Y)*hp
            esp.HealthBar.From=Vector2.new(tl.X-5,bl.Y);esp.HealthBar.To=Vector2.new(tl.X-5,bl.Y-barH);esp.HealthBar.Color=Color3.fromRGB(r,g,50);esp.HealthBar.Visible=true
        else esp.Health.Visible=false;esp.HealthBar.Visible=false;esp.HealthBarBG.Visible=false end

        if Settings.ShowDistance then
            esp.Distance.Text=math.floor(dist).."m";esp.Distance.Position=Vector2.new(bx,bl.Y+2);esp.Distance.Color=Color3.fromRGB(200,200,200);esp.Distance.Visible=true
        else esp.Distance.Visible=false end
    end
end

local SkConn={{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}}
local SkConnR6={{"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},{"Torso","Left Leg"},{"Torso","Right Leg"}}
local SkLines={}

local function UpdateSkeleton()
    local t=GetTheme()
    for _,player in ipairs(Players:GetPlayers()) do
        if player==LocalPlayer then continue end
        if not SkLines[player] then SkLines[player]={} end
        local lines=SkLines[player]
        local ch=player.Character
        if not Settings.ShowSkeleton or not ch or not IsEnemy(player) or not IsAlive(player) then
            for _,l in pairs(lines) do l.Visible=false end;continue
        end
        local conns=ch:FindFirstChild("UpperTorso") and SkConn or SkConnR6
        while #lines<#conns do local l=Drawing.new("Line");l.Visible=false;l.Transparency=0.9;table.insert(lines,l) end
        for i,c in ipairs(conns) do
            local a,b=ch:FindFirstChild(c[1]),ch:FindFirstChild(c[2])
            local line=lines[i]
            if a and b then
                local pA,oA=Camera:WorldToViewportPoint(a.Position)
                local pB,oB=Camera:WorldToViewportPoint(b.Position)
                if oA and oB then line.From=Vector2.new(pA.X,pA.Y);line.To=Vector2.new(pB.X,pB.Y);line.Color=t.SkeletonColor;line.Thickness=Settings.SkeletonThickness;line.Visible=true
                else line.Visible=false end
            else line.Visible=false end
        end
        for i=#conns+1,#lines do lines[i].Visible=false end
    end
end

Players.PlayerRemoving:Connect(function(p)
    if ChamsObjects[p] then ChamsObjects[p]:Destroy();ChamsObjects[p]=nil end
    RemoveESP(p)
    if SkLines[p] then for _,l in pairs(SkLines[p]) do l:Remove() end;SkLines[p]=nil end
end)

--// ═══════════════════════════════════════
--// GUI
--// ═══════════════════════════════════════

local SG=Instance.new("ScreenGui")
SG.Name="ZovHub"
SG.ResetOnSpawn=false
SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
SG.IgnoreGuiInset=true
if syn and syn.protect_gui then syn.protect_gui(SG) end
SG.Parent=game:GetService("CoreGui")

local AllCards={}
local AllLabels={}
local AllDimLabels={}
local AllToggleBGs={}
local AllSliders={}
local AllAccentTexts={}

local theme=GetTheme()

local MF=Instance.new("Frame",SG)
MF.Size=UDim2.new(0,580,0,440)
MF.AnchorPoint=Vector2.new(0.5,0.5)
MF.Position=UDim2.new(0.5,0,0.5,0)
MF.BackgroundColor3=theme.BG
MF.BorderSizePixel=0
MF.ClipsDescendants=true
Instance.new("UICorner",MF).CornerRadius=UDim.new(0,10)
local MFStroke=Instance.new("UIStroke",MF)
MFStroke.Color=theme.AccentColor
MFStroke.Thickness=2

local TopBar=Instance.new("Frame",MF)
TopBar.Size=UDim2.new(1,0,0,44)
TopBar.BackgroundColor3=theme.TopBarBG
TopBar.BorderSizePixel=0
Instance.new("UICorner",TopBar).CornerRadius=UDim.new(0,10)
local TBF=Instance.new("Frame",TopBar)
TBF.Size=UDim2.new(1,0,0,10)
TBF.Position=UDim2.new(0,0,1,-10)
TBF.BackgroundColor3=theme.TopBarBG
TBF.BorderSizePixel=0

local TL=Instance.new("TextLabel",TopBar)
TL.Size=UDim2.new(0,200,1,0)
TL.Position=UDim2.new(0,16,0,0)
TL.BackgroundTransparency=1
TL.Text="🎯 ZOVHUB"
TL.TextColor3=Color3.new(1,1,1)
TL.TextSize=17
TL.Font=Enum.Font.GothamBlack
TL.TextXAlignment=Enum.TextXAlignment.Left

local VersionLbl=Instance.new("TextLabel",TopBar)
VersionLbl.Size=UDim2.new(0,40,0,16)
VersionLbl.Position=UDim2.new(0,130,0.5,-8)
VersionLbl.BackgroundColor3=theme.AccentColor
VersionLbl.BackgroundTransparency=0.8
VersionLbl.BorderSizePixel=0
VersionLbl.Text="v1.0"
VersionLbl.TextColor3=theme.AccentColor
VersionLbl.TextSize=9
VersionLbl.Font=Enum.Font.GothamBold
Instance.new("UICorner",VersionLbl).CornerRadius=UDim.new(0,4)
table.insert(AllAccentTexts,VersionLbl)

local ThemeInd=Instance.new("TextLabel",TopBar)
ThemeInd.Size=UDim2.new(0,120,0,16)
ThemeInd.AnchorPoint=Vector2.new(1,0.5)
ThemeInd.Position=UDim2.new(1,-14,0.5,0)
ThemeInd.BackgroundTransparency=1
ThemeInd.Text="🎨 "..theme.Name
ThemeInd.TextColor3=theme.DimText
ThemeInd.TextSize=10
ThemeInd.Font=Enum.Font.GothamMedium
ThemeInd.TextXAlignment=Enum.TextXAlignment.Right

local TA=Instance.new("Frame",TopBar)
TA.Size=UDim2.new(1,0,0,2)
TA.Position=UDim2.new(0,0,1,0)
TA.BackgroundColor3=theme.AccentColor
TA.BorderSizePixel=0
local TAGrad=Instance.new("UIGradient",TA)
TAGrad.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,theme.AccentGradient1),ColorSequenceKeypoint.new(0.5,theme.AccentGradient2),ColorSequenceKeypoint.new(1,theme.AccentGradient1)}
spawn(function() local o=0;while SG.Parent do o=(o+0.003)%1;TAGrad.Offset=Vector2.new(o,0);task.wait(0.016) end end)

local SideBar=Instance.new("Frame",MF)
SideBar.Size=UDim2.new(0,130,1,-48)
SideBar.Position=UDim2.new(0,0,0,46)
SideBar.BackgroundColor3=theme.SideBG
SideBar.BorderSizePixel=0
local SBLayout=Instance.new("UIListLayout",SideBar)
SBLayout.SortOrder=Enum.SortOrder.LayoutOrder
SBLayout.Padding=UDim.new(0,2)
local SBP=Instance.new("UIPadding",SideBar)
SBP.PaddingTop=UDim.new(0,8)
SBP.PaddingLeft=UDim.new(0,6)
SBP.PaddingRight=UDim.new(0,6)

local SBSep=Instance.new("Frame",MF)
SBSep.Size=UDim2.new(0,1,1,-48)
SBSep.Position=UDim2.new(0,130,0,46)
SBSep.BackgroundColor3=theme.AccentColor
SBSep.BackgroundTransparency=0.7
SBSep.BorderSizePixel=0

local TC=Instance.new("Frame",MF)
TC.Size=UDim2.new(1,-134,1,-48)
TC.Position=UDim2.new(0,132,0,46)
TC.BackgroundTransparency=1

local AllTabs={}
local ActiveTab=nil

local function MakeTab(icon,name,ord)
    local B=Instance.new("TextButton",SideBar)
    B.Size=UDim2.new(1,0,0,30)
    B.BackgroundColor3=theme.BG
    B.BorderSizePixel=0
    B.Text=icon.." "..name
    B.TextColor3=theme.DimText
    B.TextSize=11
    B.Font=Enum.Font.GothamMedium
    B.TextXAlignment=Enum.TextXAlignment.Left
    B.LayoutOrder=ord
    B.AutoButtonColor=false
    Instance.new("UICorner",B).CornerRadius=UDim.new(0,7)
    Instance.new("UIPadding",B).PaddingLeft=UDim.new(0,10)

    local Ind=Instance.new("Frame",B)
    Ind.Size=UDim2.new(0,3,0,16)
    Ind.Position=UDim2.new(0,-7,0.5,-8)
    Ind.BackgroundColor3=theme.AccentColor
    Ind.BorderSizePixel=0
    Ind.Visible=false
    Instance.new("UICorner",Ind).CornerRadius=UDim.new(0,2)

    local P=Instance.new("ScrollingFrame",TC)
    P.Size=UDim2.new(1,-10,1,-10)
    P.Position=UDim2.new(0,5,0,5)
    P.BackgroundTransparency=1
    P.BorderSizePixel=0
    P.ScrollBarThickness=3
    P.ScrollBarImageColor3=theme.AccentColor
    P.CanvasSize=UDim2.new(0,0,0,0)
    P.AutomaticCanvasSize=Enum.AutomaticSize.Y
    P.Visible=false
    local PL=Instance.new("UIListLayout",P)
    PL.SortOrder=Enum.SortOrder.LayoutOrder
    PL.Padding=UDim.new(0,4)
    PL.HorizontalAlignment=Enum.HorizontalAlignment.Center

    local t={Button=B,Page=P,Indicator=Ind}
    table.insert(AllTabs,t)

    B.MouseButton1Click:Connect(function()
        local th=GetTheme()
        for _,x in pairs(AllTabs) do
            x.Page.Visible=false;x.Button.BackgroundColor3=th.BG;x.Button.TextColor3=th.DimText;x.Indicator.Visible=false
        end
        P.Visible=true;B.BackgroundColor3=th.AccentColor;B.TextColor3=Color3.new(1,1,1);Ind.Visible=true;ActiveTab=t
    end)
    B.MouseEnter:Connect(function() if ActiveTab~=t then TweenService:Create(B,TweenInfo.new(0.15),{BackgroundColor3=GetTheme().HoverBG}):Play() end end)
    B.MouseLeave:Connect(function() if ActiveTab~=t then TweenService:Create(B,TweenInfo.new(0.15),{BackgroundColor3=GetTheme().BG}):Play() end end)
    return P
end

--// UI ELEMENTS
local function Sec(p,n,o)
    local S=Instance.new("Frame",p);S.Size=UDim2.new(1,-8,0,22);S.BackgroundTransparency=1;S.LayoutOrder=o
    local L1=Instance.new("Frame",S);L1.Size=UDim2.new(0,30,0,1);L1.Position=UDim2.new(0,4,0.5,0);L1.BackgroundColor3=theme.DimText;L1.BackgroundTransparency=0.5;L1.BorderSizePixel=0
    local L=Instance.new("TextLabel",S);L.Size=UDim2.new(1,-10,1,0);L.Position=UDim2.new(0,40,0,0);L.BackgroundTransparency=1;L.Text=string.upper(n);L.TextColor3=theme.DimText;L.TextSize=9;L.Font=Enum.Font.GothamBold;L.TextXAlignment=Enum.TextXAlignment.Left
    table.insert(AllDimLabels,L);table.insert(AllDimLabels,L1)
end

local function Tog(p,n,d,o,cb)
    local F=Instance.new("Frame",p);F.Size=UDim2.new(1,-8,0,34);F.BackgroundColor3=theme.CardBG;F.BorderSizePixel=0;F.LayoutOrder=o
    Instance.new("UICorner",F).CornerRadius=UDim.new(0,7)
    local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,12);Pd.PaddingRight=UDim.new(0,12)
    local L=Instance.new("TextLabel",F);L.Size=UDim2.new(1,-50,1,0);L.BackgroundTransparency=1;L.Text=n;L.TextColor3=theme.TextColor;L.TextSize=12;L.Font=Enum.Font.GothamMedium;L.TextXAlignment=Enum.TextXAlignment.Left
    table.insert(AllLabels,L)

    local BG2=Instance.new("Frame",F);BG2.Size=UDim2.new(0,36,0,18);BG2.AnchorPoint=Vector2.new(1,0.5);BG2.Position=UDim2.new(1,0,0.5,0)
    BG2.BackgroundColor3=d and theme.ToggleOn or theme.ToggleOff;BG2.BorderSizePixel=0;Instance.new("UICorner",BG2).CornerRadius=UDim.new(1,0)
    local Ci=Instance.new("Frame",BG2);Ci.Size=UDim2.new(0,12,0,12);Ci.AnchorPoint=Vector2.new(0,0.5)
    Ci.Position=d and UDim2.new(1,-15,0.5,0) or UDim2.new(0,3,0.5,0);Ci.BackgroundColor3=Color3.new(1,1,1);Ci.BorderSizePixel=0
    Instance.new("UICorner",Ci).CornerRadius=UDim.new(1,0)

    local state=d
    table.insert(AllToggleBGs,{bg=BG2,circle=Ci,getState=function() return state end})
    local hov=false
    table.insert(AllCards,{frame=F,getHovered=function() return hov end})

    local Btn=Instance.new("TextButton",F);Btn.Size=UDim2.new(1,24,1,0);Btn.Position=UDim2.new(0,-12,0,0);Btn.BackgroundTransparency=1;Btn.Text="";Btn.ZIndex=2
    Btn.MouseButton1Click:Connect(function()
        state=not state;local th=GetTheme()
        TweenService:Create(Ci,TweenInfo.new(0.15,Enum.EasingStyle.Quad),{Position=state and UDim2.new(1,-15,0.5,0) or UDim2.new(0,3,0.5,0)}):Play()
        TweenService:Create(BG2,TweenInfo.new(0.15),{BackgroundColor3=state and th.ToggleOn or th.ToggleOff}):Play()
        if cb then cb(state) end
    end)
    Btn.MouseEnter:Connect(function() hov=true;TweenService:Create(F,TweenInfo.new(0.1),{BackgroundColor3=GetTheme().HoverBG}):Play() end)
    Btn.MouseLeave:Connect(function() hov=false;TweenService:Create(F,TweenInfo.new(0.1),{BackgroundColor3=GetTheme().CardBG}):Play() end)
end

local function Sld(p,n,mn,mx,df,o,cb)
    local F=Instance.new("Frame",p);F.Size=UDim2.new(1,-8,0,48);F.BackgroundColor3=theme.CardBG;F.BorderSizePixel=0;F.LayoutOrder=o
    Instance.new("UICorner",F).CornerRadius=UDim.new(0,7);table.insert(AllCards,{frame=F,getHovered=function() return false end})
    local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,12);Pd.PaddingRight=UDim.new(0,12);Pd.PaddingTop=UDim.new(0,6);Pd.PaddingBottom=UDim.new(0,8)
    local Top=Instance.new("Frame",F);Top.Size=UDim2.new(1,0,0,16);Top.BackgroundTransparency=1
    local L=Instance.new("TextLabel",Top);L.Size=UDim2.new(0.7,0,1,0);L.BackgroundTransparency=1;L.Text=n;L.TextColor3=theme.TextColor;L.TextSize=12;L.Font=Enum.Font.GothamMedium;L.TextXAlignment=Enum.TextXAlignment.Left;table.insert(AllLabels,L)
    local VLb=Instance.new("TextLabel",Top);VLb.Size=UDim2.new(0.3,0,1,0);VLb.Position=UDim2.new(0.7,0,0,0);VLb.BackgroundTransparency=1;VLb.Text=tostring(df);VLb.TextColor3=theme.AccentColor;VLb.TextSize=12;VLb.Font=Enum.Font.GothamBold;VLb.TextXAlignment=Enum.TextXAlignment.Right;table.insert(AllAccentTexts,VLb)

    local SB2=Instance.new("Frame",F);SB2.Size=UDim2.new(1,0,0,4);SB2.Position=UDim2.new(0,0,1,-4);SB2.AnchorPoint=Vector2.new(0,1);SB2.BackgroundColor3=Color3.fromRGB(50,50,70);SB2.BorderSizePixel=0;Instance.new("UICorner",SB2).CornerRadius=UDim.new(1,0)
    local pct=(df-mn)/(mx-mn)
    local Fill=Instance.new("Frame",SB2);Fill.Size=UDim2.new(pct,0,1,0);Fill.BackgroundColor3=theme.AccentColor;Fill.BorderSizePixel=0;Instance.new("UICorner",Fill).CornerRadius=UDim.new(1,0)
    local FG=Instance.new("UIGradient",Fill);FG.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,theme.SliderFill1),ColorSequenceKeypoint.new(1,theme.SliderFill2)}
    local Knob=Instance.new("Frame",SB2);Knob.Size=UDim2.new(0,14,0,14);Knob.AnchorPoint=Vector2.new(0.5,0.5);Knob.Position=UDim2.new(pct,0,0.5,0);Knob.BackgroundColor3=Color3.new(1,1,1);Knob.BorderSizePixel=0;Knob.ZIndex=3;Instance.new("UICorner",Knob).CornerRadius=UDim.new(1,0)
    local KS=Instance.new("UIStroke",Knob);KS.Color=theme.AccentColor;KS.Thickness=2
    table.insert(AllSliders,{fillGrad=FG,knobStroke=KS,valueLabel=VLb})

    local isDrag=false
    local CA=Instance.new("TextButton",SB2);CA.Size=UDim2.new(1,0,0,20);CA.AnchorPoint=Vector2.new(0,0.5);CA.Position=UDim2.new(0,0,0.5,0);CA.BackgroundTransparency=1;CA.Text="";CA.ZIndex=4
    CA.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then isDrag=true end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then isDrag=false end end)
    RunService.RenderStepped:Connect(function()
        if isDrag then
            local mp=UserInputService:GetMouseLocation();local rel=mp.X-SB2.AbsolutePosition.X;local p2=math.clamp(rel/SB2.AbsoluteSize.X,0,1);local v=math.floor(mn+(mx-mn)*p2)
            Fill.Size=UDim2.new(p2,0,1,0);Knob.Position=UDim2.new(p2,0,0.5,0);VLb.Text=tostring(v);if cb then cb(v) end
        end
    end)
end

local function Drp(p,n,opts,df,o,cb)
    local F=Instance.new("Frame",p);F.Size=UDim2.new(1,-8,0,34);F.BackgroundColor3=theme.CardBG;F.BorderSizePixel=0;F.ClipsDescendants=true;F.LayoutOrder=o
    Instance.new("UICorner",F).CornerRadius=UDim.new(0,7);table.insert(AllCards,{frame=F,getHovered=function() return false end})
    local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,12);Pd.PaddingRight=UDim.new(0,12)
    local L=Instance.new("TextLabel",F);L.Size=UDim2.new(0.5,0,0,34);L.BackgroundTransparency=1;L.Text=n;L.TextColor3=theme.TextColor;L.TextSize=12;L.Font=Enum.Font.GothamMedium;L.TextXAlignment=Enum.TextXAlignment.Left;table.insert(AllLabels,L)
    local SBtn=Instance.new("TextButton",F);SBtn.Size=UDim2.new(0.45,0,0,24);SBtn.AnchorPoint=Vector2.new(1,0.5);SBtn.Position=UDim2.new(1,0,0,17);SBtn.BackgroundColor3=Color3.fromRGB(50,50,70);SBtn.BorderSizePixel=0;SBtn.Text=df.." ▼";SBtn.TextColor3=theme.AccentColor;SBtn.TextSize=10;SBtn.Font=Enum.Font.GothamMedium;SBtn.ZIndex=2;Instance.new("UICorner",SBtn).CornerRadius=UDim.new(0,5);table.insert(AllAccentTexts,SBtn)
    local open=false;local btns={}
    for i,opt in ipairs(opts) do
        local OB=Instance.new("TextButton",F);OB.Size=UDim2.new(0.45,0,0,24);OB.AnchorPoint=Vector2.new(1,0);OB.Position=UDim2.new(1,0,0,30+(i-1)*28);OB.BackgroundColor3=Color3.fromRGB(45,45,65);OB.BorderSizePixel=0;OB.Text=opt;OB.TextColor3=Color3.fromRGB(200,200,210);OB.TextSize=10;OB.Font=Enum.Font.GothamMedium;OB.Visible=false;OB.ZIndex=3;Instance.new("UICorner",OB).CornerRadius=UDim.new(0,5)
        OB.MouseButton1Click:Connect(function() SBtn.Text=opt.." ▼";open=false;F.Size=UDim2.new(1,-8,0,34);for _,b in pairs(btns) do b.Visible=false end;if cb then cb(opt) end end)
        OB.MouseEnter:Connect(function() OB.BackgroundColor3=Color3.fromRGB(60,60,90) end);OB.MouseLeave:Connect(function() OB.BackgroundColor3=Color3.fromRGB(45,45,65) end)
        table.insert(btns,OB)
    end
    SBtn.MouseButton1Click:Connect(function() open=not open;F.Size=open and UDim2.new(1,-8,0,34+#opts*28+4) or UDim2.new(1,-8,0,34);for _,b in pairs(btns) do b.Visible=open end end)
end

local function Kbnd(p,n,df,o)
    local F=Instance.new("Frame",p);F.Size=UDim2.new(1,-8,0,34);F.BackgroundColor3=theme.CardBG;F.BorderSizePixel=0;F.LayoutOrder=o
    Instance.new("UICorner",F).CornerRadius=UDim.new(0,7);table.insert(AllCards,{frame=F,getHovered=function() return false end})
    local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,12);Pd.PaddingRight=UDim.new(0,12)
    local L=Instance.new("TextLabel",F);L.Size=UDim2.new(1,-70,1,0);L.BackgroundTransparency=1;L.Text="⌨ "..n;L.TextColor3=theme.TextColor;L.TextSize=12;L.Font=Enum.Font.GothamMedium;L.TextXAlignment=Enum.TextXAlignment.Left;table.insert(AllLabels,L)
    local KB=Instance.new("TextButton",F);KB.Size=UDim2.new(0,55,0,22);KB.AnchorPoint=Vector2.new(1,0.5);KB.Position=UDim2.new(1,0,0.5,0);KB.BackgroundColor3=Color3.fromRGB(50,50,70);KB.BorderSizePixel=0;KB.Text="["..df.Name.."]";KB.TextColor3=theme.AccentColor;KB.TextSize=10;KB.Font=Enum.Font.GothamBold;Instance.new("UICorner",KB).CornerRadius=UDim.new(0,5);table.insert(AllAccentTexts,KB)
    local listening=false
    KB.MouseButton1Click:Connect(function() listening=true;KB.Text="[...]";KB.TextColor3=Color3.fromRGB(255,200,50) end)
    UserInputService.InputBegan:Connect(function(inp) if listening and inp.UserInputType==Enum.UserInputType.Keyboard then listening=false;Settings.Keybind=inp.KeyCode;KB.Text="["..inp.KeyCode.Name.."]";KB.TextColor3=GetTheme().AccentColor end end)
end

local function TPBtn(p,n,pos,o)
    local B=Instance.new("TextButton",p);B.Size=UDim2.new(1,-8,0,30);B.BackgroundColor3=theme.CardBG;B.BorderSizePixel=0;B.Text="  📍 "..n;B.TextColor3=theme.TextColor;B.TextSize=11;B.Font=Enum.Font.GothamMedium;B.LayoutOrder=o;B.TextXAlignment=Enum.TextXAlignment.Left;B.AutoButtonColor=false
    Instance.new("UICorner",B).CornerRadius=UDim.new(0,7);Instance.new("UIPadding",B).PaddingLeft=UDim.new(0,8)
    table.insert(AllCards,{frame=B,getHovered=function() return false end})
    B.MouseEnter:Connect(function() TweenService:Create(B,TweenInfo.new(0.12),{BackgroundColor3=GetTheme().AccentColor,TextColor3=Color3.new(1,1,1)}):Play() end)
    B.MouseLeave:Connect(function() local th=GetTheme();TweenService:Create(B,TweenInfo.new(0.12),{BackgroundColor3=th.CardBG,TextColor3=th.TextColor}):Play() end)
    B.MouseButton1Click:Connect(function() SmoothTP(pos) end)
end

local function PlayerTPBtn(p,pn,o)
    local B=Instance.new("TextButton",p);B.Size=UDim2.new(1,-8,0,30);B.BackgroundColor3=theme.CardBG;B.BorderSizePixel=0;B.Text="  👤 "..pn;B.TextColor3=theme.TextColor;B.TextSize=11;B.Font=Enum.Font.GothamMedium;B.LayoutOrder=o;B.TextXAlignment=Enum.TextXAlignment.Left;B.AutoButtonColor=false
    Instance.new("UICorner",B).CornerRadius=UDim.new(0,7);Instance.new("UIPadding",B).PaddingLeft=UDim.new(0,8)
    B.MouseEnter:Connect(function() TweenService:Create(B,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(180,80,40),TextColor3=Color3.new(1,1,1)}):Play() end)
    B.MouseLeave:Connect(function() local th=GetTheme();TweenService:Create(B,TweenInfo.new(0.12),{BackgroundColor3=th.CardBG,TextColor3=th.TextColor}):Play() end)
    B.MouseButton1Click:Connect(function()
        local t=Players:FindFirstChild(pn)
        if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then SmoothTP(t.Character.HumanoidRootPart.Position+t.Character.HumanoidRootPart.CFrame.LookVector*-5) end
    end)
    return B
end

local StatusLabel,StatusDot,TargetLabel
local function MkStatus(p,o)
    local F=Instance.new("Frame",p);F.Size=UDim2.new(1,-8,0,44);F.BackgroundColor3=theme.CardBG;F.BorderSizePixel=0;F.LayoutOrder=o
    Instance.new("UICorner",F).CornerRadius=UDim.new(0,7);table.insert(AllCards,{frame=F,getHovered=function() return false end})
    local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,12);Pd.PaddingRight=UDim.new(0,12);Pd.PaddingTop=UDim.new(0,6);Pd.PaddingBottom=UDim.new(0,6)
    StatusDot=Instance.new("Frame",F);StatusDot.Size=UDim2.new(0,8,0,8);StatusDot.Position=UDim2.new(0,0,0,6);StatusDot.BackgroundColor3=Color3.fromRGB(255,60,60);StatusDot.BorderSizePixel=0;Instance.new("UICorner",StatusDot).CornerRadius=UDim.new(1,0)
    StatusLabel=Instance.new("TextLabel",F);StatusLabel.Size=UDim2.new(1,-14,0,14);StatusLabel.Position=UDim2.new(0,14,0,0);StatusLabel.BackgroundTransparency=1;StatusLabel.Text="DISABLED";StatusLabel.TextColor3=Color3.fromRGB(255,60,60);StatusLabel.TextSize=11;StatusLabel.Font=Enum.Font.GothamBold;StatusLabel.TextXAlignment=Enum.TextXAlignment.Left
    TargetLabel=Instance.new("TextLabel",F);TargetLabel.Size=UDim2.new(1,0,0,12);TargetLabel.Position=UDim2.new(0,0,0,18);TargetLabel.BackgroundTransparency=1;TargetLabel.Text="Target: None";TargetLabel.TextColor3=theme.DimText;TargetLabel.TextSize=10;TargetLabel.Font=Enum.Font.GothamMedium;TargetLabel.TextXAlignment=Enum.TextXAlignment.Left
end

--// APPLY THEME
local function ApplyTheme(tn)
    if not Themes[tn] then return end
    CurrentThemeName=tn;theme=GetTheme()
    MF.BackgroundColor3=theme.BG;MFStroke.Color=theme.AccentColor
    TopBar.BackgroundColor3=theme.TopBarBG;TBF.BackgroundColor3=theme.TopBarBG;TA.BackgroundColor3=theme.AccentColor
    TAGrad.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,theme.AccentGradient1),ColorSequenceKeypoint.new(0.5,theme.AccentGradient2),ColorSequenceKeypoint.new(1,theme.AccentGradient1)}
    VersionLbl.BackgroundColor3=theme.AccentColor;VersionLbl.TextColor3=theme.AccentColor
    ThemeInd.Text="🎨 "..theme.Name;ThemeInd.TextColor3=theme.DimText
    SideBar.BackgroundColor3=theme.SideBG;SBSep.BackgroundColor3=theme.AccentColor
    for _,t in pairs(AllTabs) do
        if ActiveTab==t then t.Button.BackgroundColor3=theme.AccentColor;t.Button.TextColor3=Color3.new(1,1,1);t.Indicator.BackgroundColor3=theme.AccentColor
        else t.Button.BackgroundColor3=theme.BG;t.Button.TextColor3=theme.DimText end
        t.Page.ScrollBarImageColor3=theme.AccentColor
    end
    for _,cd in pairs(AllCards) do if not cd.getHovered() then cd.frame.BackgroundColor3=theme.CardBG end end
    for _,l in pairs(AllLabels) do l.TextColor3=theme.TextColor end
    for _,l in pairs(AllDimLabels) do if l:IsA("TextLabel") then l.TextColor3=theme.DimText elseif l:IsA("Frame") then l.BackgroundColor3=theme.DimText end end
    for _,l in pairs(AllAccentTexts) do l.TextColor3=theme.AccentColor;if l:IsA("TextLabel") and l.BackgroundTransparency<1 then l.BackgroundColor3=theme.AccentColor end end
    for _,tg in pairs(AllToggleBGs) do tg.bg.BackgroundColor3=tg.getState() and theme.ToggleOn or theme.ToggleOff end
    for _,sl in pairs(AllSliders) do sl.fillGrad.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,theme.SliderFill1),ColorSequenceKeypoint.new(1,theme.SliderFill2)};sl.knobStroke.Color=theme.AccentColor;sl.valueLabel.TextColor3=theme.AccentColor end
end

--// BUILD TABS
local AP=MakeTab("🎯","Aimbot",1)
local EP=MakeTab("👁","ESP",2)
local CP=MakeTab("⛪","Church",3)
local SP=MakeTab("🔫","Sniper",4)
local TP2=MakeTab("📍","Teleport",5)
local MP=MakeTab("🏃","Player",6)
local StP=MakeTab("⚙","Settings",7)

AllTabs[1].Button.BackgroundColor3=theme.AccentColor
AllTabs[1].Button.TextColor3=Color3.new(1,1,1)
AllTabs[1].Indicator.Visible=true
AllTabs[1].Page.Visible=true
ActiveTab=AllTabs[1]

-- AIMBOT
do local o=0;local function n() o=o+1;return o end
    Sec(AP,"Silent Aim",n())
    Tog(AP,"🎯 Enabled",false,n(),function(s) Settings.Enabled=s end)
    Sld(AP,"⭕ FOV Radius",10,500,Settings.FOV,n(),function(v) Settings.FOV=v;FOVCircle.Radius=v end)
    Tog(AP,"⭕ Show FOV Circle",true,n(),function(s) Settings.ShowFOV=s end)
    Drp(AP,"🎯 Target Part",{"Head","HumanoidRootPart","UpperTorso"},Settings.TargetPart,n(),function(v) Settings.TargetPart=v end)
    Tog(AP,"🧱 Wall Check",true,n(),function(s) Settings.WallCheck=s end)
    Sec(AP,"Weapon Mods",n())
    Tog(AP,"❌ No Recoil (broken)",false,n(),function(s) Settings.NoRecoil=s end)
    Tog(AP,"❌ No Spread (broken)",false,n(),function(s) Settings.NoSpread=s end)
    Tog(AP,"💨 No Bullet Spread",false,n(),function(s) Settings.NoBulletSpread=s;patchedModules={};lastPatchTick=0 end)
    Sec(AP,"Status",n())
    MkStatus(AP,n())
end

-- ESP
do local o=0;local function n() o=o+1;return o end
    Sec(EP,"Box ESP",n())
    Tog(EP,"📦 ESP Boxes",true,n(),function(s) Settings.ShowESPBox=s end)
    Tog(EP,"👤 Player Names",true,n(),function(s) Settings.ShowName=s end)
    Tog(EP,"❤ Health Bar",true,n(),function(s) Settings.ShowHealth=s end)
    Tog(EP,"📏 Distance",true,n(),function(s) Settings.ShowDistance=s end)
    Sec(EP,"Skeleton ESP",n())
    Tog(EP,"🦴 Skeleton",true,n(),function(s) Settings.ShowSkeleton=s end)
    Sld(EP,"Thickness",1,4,2,n(),function(v) Settings.SkeletonThickness=v end)
    Sec(EP,"Chams",n())
    Tog(EP,"✨ Chams",true,n(),function(s) Settings.ShowChams=s end)
end

-- CHURCH
do local o=0;local function n() o=o+1;return o end
    Sec(CP,"Church Locations",n())
    for _,l in ipairs(ColdWarLocations.Church) do TPBtn(CP,l.name,l.pos,n()) end
end

-- SNIPER
do local o=0;local function n() o=o+1;return o end
    Sec(SP,"Sniper Spots",n())
    for _,l in ipairs(ColdWarLocations.Sniper) do TPBtn(SP,l.name,l.pos,n()) end
end

-- TELEPORT
do local o=0;local function n() o=o+1;return o end
    local TPE=Instance.new("TextButton",TP2);TPE.Size=UDim2.new(1,-8,0,30);TPE.BackgroundColor3=Color3.fromRGB(180,50,50);TPE.BorderSizePixel=0;TPE.Text="  💀 TP Nearest Enemy";TPE.TextColor3=Color3.new(1,1,1);TPE.TextSize=11;TPE.Font=Enum.Font.GothamBold;TPE.LayoutOrder=n();TPE.AutoButtonColor=false;TPE.TextXAlignment=Enum.TextXAlignment.Left;Instance.new("UICorner",TPE).CornerRadius=UDim.new(0,7);Instance.new("UIPadding",TPE).PaddingLeft=UDim.new(0,8)
    TPE.MouseEnter:Connect(function() TweenService:Create(TPE,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(220,60,60)}):Play() end)
    TPE.MouseLeave:Connect(function() TweenService:Create(TPE,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(180,50,50)}):Play() end)
    TPE.MouseButton1Click:Connect(function()
        local cl,cd2=nil,math.huge
        for _,pl in ipairs(Players:GetPlayers()) do
            if pl~=LocalPlayer and IsAlive(pl) and IsEnemy(pl) then
                local r=pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
                local mr=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if r and mr then local d=(mr.Position-r.Position).Magnitude;if d<cd2 then cd2=d;cl=pl end end
            end
        end
        if cl and cl.Character then local r=cl.Character:FindFirstChild("HumanoidRootPart");if r then SmoothTP(r.Position+r.CFrame.LookVector*-5) end end
    end)

    Sec(TP2,"General",n())
    for _,l in ipairs(ColdWarLocations.General) do TPBtn(TP2,l.name,l.pos,n()) end

    Sec(TP2,"TP to Player",n())
    local playerButtons={}
    local RefBtn=Instance.new("TextButton",TP2);RefBtn.Size=UDim2.new(1,-8,0,30);RefBtn.BackgroundColor3=Color3.fromRGB(50,120,180);RefBtn.BorderSizePixel=0;RefBtn.Text="  🔄 Refresh Players";RefBtn.TextColor3=Color3.new(1,1,1);RefBtn.TextSize=11;RefBtn.Font=Enum.Font.GothamBold;RefBtn.LayoutOrder=n();RefBtn.AutoButtonColor=false;RefBtn.TextXAlignment=Enum.TextXAlignment.Left;Instance.new("UICorner",RefBtn).CornerRadius=UDim.new(0,7);Instance.new("UIPadding",RefBtn).PaddingLeft=UDim.new(0,8)
    local function RP() for _,b in ipairs(playerButtons) do b:Destroy() end;playerButtons={};local so=200;for _,p in ipairs(Players:GetPlayers()) do if p~=LocalPlayer then so=so+1;table.insert(playerButtons,PlayerTPBtn(TP2,p.Name,so)) end end end
    RefBtn.MouseButton1Click:Connect(function() RefBtn.Text="  🔄 ...";RP();RefBtn.Text="  ✅ Done!";task.wait(1);RefBtn.Text="  🔄 Refresh Players" end)
    RP()
end

-- PLAYER
do local o=0;local function n() o=o+1;return o end
    Sec(MP,"Movement",n())
    Tog(MP,"🏃 WalkSpeed Enabled",false,n(),function(s) Settings.WalkSpeedEnabled=s end)
    Sld(MP,"🏃 WalkSpeed",16,200,16,n(),function(v) Settings.WalkSpeed=v end)
    Tog(MP,"⬆ Infinite Jump",false,n(),function(s) Settings.InfJump=s end)
    Sec(MP,"Fly",n())
    Tog(MP,"🕊 Fly (F key)",false,n(),function(s) Settings.Fly=s;if s then StartFly() else StopFly() end end)
    Sld(MP,"🕊 Fly Speed",10,300,50,n(),function(v) Settings.FlySpeed=v end)
    Sec(MP,"Safety",n())
    Tog(MP,"🛡 No Fall Damage",false,n(),function(s) Settings.NoFallDamage=s;if s then SetupNoFallDamage() end end)
    Sec(MP,"Infinite Ammo",n())
    Tog(MP,"🔫 Inf Ammo (Rifles/SMGs)",false,n(),function(s) Settings.InfAmmo=s;RefreshAmmoMonitor() end)
    Tog(MP,"🚀 Inf RPG / Launchers",false,n(),function(s) Settings.InfRPG=s;RefreshAmmoMonitor() end)
    Tog(MP,"💣 Inf GP-25 / Grenadier",false,n(),function(s) Settings.InfGP25=s;RefreshAmmoMonitor() end)
end

-- SETTINGS
do local o=0;local function n() o=o+1;return o end
    Sec(StP,"Theme",n())
    local tns={"Fatality","Black","PurpleHaze","Ocean","Blood","Mint"}
    local tdn={Fatality="🔴 Fatality",Black="⚫ Black",PurpleHaze="🟣 Purple Haze",Ocean="🔵 Ocean",Blood="🩸 Blood",Mint="🟢 Mint"}
    for _,tn in ipairs(tns) do
        local TB=Instance.new("TextButton",StP);TB.Size=UDim2.new(1,-8,0,30);TB.BackgroundColor3=Themes[tn].CardBG;TB.BorderSizePixel=0;TB.Text="  "..(tdn[tn] or tn);TB.TextColor3=Themes[tn].TextColor;TB.TextSize=11;TB.Font=Enum.Font.GothamBold;TB.LayoutOrder=n();TB.AutoButtonColor=false;TB.TextXAlignment=Enum.TextXAlignment.Left;Instance.new("UICorner",TB).CornerRadius=UDim.new(0,7);Instance.new("UIPadding",TB).PaddingLeft=UDim.new(0,8)
        local PV=Instance.new("Frame",TB);PV.Size=UDim2.new(0,4,0,20);PV.AnchorPoint=Vector2.new(1,0.5);PV.Position=UDim2.new(1,-8,0.5,0);PV.BackgroundColor3=Themes[tn].AccentColor;PV.BorderSizePixel=0;Instance.new("UICorner",PV).CornerRadius=UDim.new(0,2)
        TB.MouseEnter:Connect(function() TweenService:Create(TB,TweenInfo.new(0.12),{BackgroundColor3=Themes[tn].AccentColor}):Play();TB.TextColor3=Color3.new(1,1,1) end)
        TB.MouseLeave:Connect(function() TweenService:Create(TB,TweenInfo.new(0.12),{BackgroundColor3=Themes[tn].CardBG}):Play();TB.TextColor3=Themes[tn].TextColor end)
        TB.MouseButton1Click:Connect(function() ApplyTheme(tn) end)
    end

    Sec(StP,"General",n())
    Tog(StP,"👥 Team Check",true,n(),function(s) Settings.TeamCheck=s end)
    Kbnd(StP,"Aim Toggle",Settings.Keybind,n())

    Sec(StP,"Debug",n())
    local SvB=Instance.new("TextButton",StP);SvB.Size=UDim2.new(1,-8,0,30);SvB.BackgroundColor3=Color3.fromRGB(50,120,80);SvB.BorderSizePixel=0;SvB.Text="  💾 Print Position (F9)";SvB.TextColor3=Color3.new(1,1,1);SvB.TextSize=11;SvB.Font=Enum.Font.GothamBold;SvB.LayoutOrder=n();SvB.AutoButtonColor=false;SvB.TextXAlignment=Enum.TextXAlignment.Left;Instance.new("UICorner",SvB).CornerRadius=UDim.new(0,7);Instance.new("UIPadding",SvB).PaddingLeft=UDim.new(0,8)
    SvB.MouseButton1Click:Connect(function() local ch=LocalPlayer.Character;if ch and ch:FindFirstChild("HumanoidRootPart") then local p=ch.HumanoidRootPart.Position;print(string.format('{name="Spot",pos=Vector3.new(%.1f,%.1f,%.1f)},',p.X,p.Y,p.Z));SvB.Text="  ✅ Printed!";task.wait(1.5);SvB.Text="  💾 Print Position (F9)" end end)

    local WB=Instance.new("TextButton",StP);WB.Size=UDim2.new(1,-8,0,30);WB.BackgroundColor3=Color3.fromRGB(180,120,50);WB.BorderSizePixel=0;WB.Text="  🔧 Weapon Debug (F9)";WB.TextColor3=Color3.new(1,1,1);WB.TextSize=11;WB.Font=Enum.Font.GothamBold;WB.LayoutOrder=n();WB.AutoButtonColor=false;WB.TextXAlignment=Enum.TextXAlignment.Left;Instance.new("UICorner",WB).CornerRadius=UDim.new(0,7);Instance.new("UIPadding",WB).PaddingLeft=UDim.new(0,8)
    WB.MouseButton1Click:Connect(function() print("\n=== WEAPON DEBUG ===");local ch=LocalPlayer.Character;if ch then for _,tool in ipairs(ch:GetChildren()) do if tool:IsA("Tool") then print("--- "..tool.Name.." ---");for _,d in ipairs(tool:GetDescendants()) do local i="  ["..d.ClassName.."] "..d.Name;if d:IsA("ValueBase") then i=i.." = "..tostring(d.Value) end;print(i) end end end end;print("=== END ===\n");WB.Text="  ✅ Done!";task.wait(1.5);WB.Text="  🔧 Weapon Debug (F9)" end)

    Sec(StP,"Danger Zone",n())
    local DB=Instance.new("TextButton",StP);DB.Size=UDim2.new(1,-8,0,30);DB.BackgroundColor3=Color3.fromRGB(180,40,40);DB.BorderSizePixel=0;DB.Text="  🗑 Destroy Script";DB.TextColor3=Color3.new(1,1,1);DB.TextSize=12;DB.Font=Enum.Font.GothamBold;DB.LayoutOrder=n();DB.AutoButtonColor=false;DB.TextXAlignment=Enum.TextXAlignment.Left;Instance.new("UICorner",DB).CornerRadius=UDim.new(0,7);Instance.new("UIPadding",DB).PaddingLeft=UDim.new(0,8)
    DB.MouseButton1Click:Connect(function()
        Settings.Enabled=false;Settings.ShowFOV=false;Settings.ShowESPBox=false;Settings.ShowName=false;Settings.ShowHealth=false;Settings.ShowDistance=false;Settings.ShowSkeleton=false;Settings.ShowChams=false;Settings.InfAmmo=false;Settings.InfRPG=false;Settings.InfGP25=false
        if flying then StopFly() end;FOVCircle:Remove()
        for _,c in pairs(ammoConnections) do if typeof(c)=="RBXScriptConnection" and c.Connected then c:Disconnect() end end
        for _,c in pairs(magConnections) do if typeof(c)=="RBXScriptConnection" and c.Connected then c:Disconnect() end end
        for _,p in ipairs(Players:GetPlayers()) do if ChamsObjects[p] then ChamsObjects[p]:Destroy() end;RemoveESP(p);if SkLines[p] then for _,l in pairs(SkLines[p]) do l:Remove() end end end
        SG:Destroy()
    end)
end

--// DRAGGING
do
    local dr,di,ds,sp
    TopBar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true;ds=i.Position;sp=MF.Position;i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dr=false end end) end end)
    TopBar.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement then di=i end end)
    UserInputService.InputChanged:Connect(function(i) if i==di and dr then local d=i.Position-ds;MF.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y) end end)
end

--// RENDER
local function GetClosestPlayer()
    local cl,cp=nil,nil
    local sh=Settings.FOV
    local mP=GetMouseViewportPos()
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LocalPlayer and IsAlive(p) and IsEnemy(p) then
            local ch=p.Character
            local part=ch:FindFirstChild(Settings.TargetPart) or ch:FindFirstChild("HumanoidRootPart")
            if part then
                if Settings.WallCheck and not IsVisible(part) then continue end
                local sp2,on=Camera:WorldToViewportPoint(part.Position)
                if on then local d=(mP-Vector2.new(sp2.X,sp2.Y)).Magnitude;if d<sh then sh=d;cl=p;cp=part.Position end end
            end
        end
    end
    return cl,cp
end

RunService.RenderStepped:Connect(function()
    Camera=workspace.CurrentCamera
    local mP=GetMouseViewportPos()
    local ct=GetTheme()

    FOVCircle.Position=mP
    FOVCircle.Radius=Settings.FOV
    FOVCircle.Visible=Settings.ShowFOV
    FOVCircle.Color=Settings.Enabled and ct.FOVEnabled or ct.FOVDisabled

    if Settings.Enabled then
        local t,p=GetClosestPlayer();CurrentTarget=t;CachedTargetPosition=p
    else
        CurrentTarget=nil;CachedTargetPosition=nil
    end

    if(Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) and tick()-lastPatchTick>2 then lastPatchTick=tick();task.defer(PatchAllModules) end

    UpdateSkeleton();UpdateESP();UpdateChams();UpdateFly();UpdateWalkSpeed();UpdateNoFallDamage()

    if StatusLabel then
        if Settings.Enabled then StatusLabel.Text="ENABLED";StatusLabel.TextColor3=Color3.fromRGB(80,255,80);StatusDot.BackgroundColor3=Color3.fromRGB(80,255,80)
        else StatusLabel.Text="DISABLED";StatusLabel.TextColor3=Color3.fromRGB(255,60,60);StatusDot.BackgroundColor3=Color3.fromRGB(255,60,60) end
        if CurrentTarget then TargetLabel.Text="Target: "..CurrentTarget.Name;TargetLabel.TextColor3=ct.AccentColor
        else TargetLabel.Text="Target: None";TargetLabel.TextColor3=ct.DimText end
    end
end)

--// HOOKS
local HM={FindPartOnRayWithIgnoreList=true,FindPartOnRay=true,FindPartOnRayWithWhitelist=true,Raycast=true}

local oldNC;oldNC=hookmetamethod(game,"__namecall",newcclosure(function(self,...)
    local m=getnamecallmethod()
    if HM[m] and self==workspace then
        local needAim=Settings.Enabled and CachedTargetPosition
        local needNBS=Settings.NoBulletSpread
        if needAim or needNBS then
            local a={...}
            local origin,direction,magnitude
            if m=="Raycast" then
                if typeof(a[1])=="Vector3" and typeof(a[2])=="Vector3" then origin=a[1];direction=a[2];magnitude=a[2].Magnitude end
            else
                if typeof(a[1])=="Ray" then origin=a[1].Origin;direction=a[1].Direction;magnitude=a[1].Direction.Magnitude end
            end
            if origin and direction then
                local newDir
                if needAim and CachedTargetPosition then newDir=(CachedTargetPosition-origin).Unit*magnitude
                elseif needNBS then local cam=workspace.CurrentCamera;if cam then newDir=cam.CFrame.LookVector*magnitude end end
                if newDir then
                    if m=="Raycast" then a[2]=newDir;return oldNC(self,unpack(a))
                    else a[1]=Ray.new(origin,newDir);return oldNC(self,unpack(a)) end
                end
            end
        end
    end
    if Settings.NoFallDamage and(m=="FireServer" or m=="InvokeServer") then
        local rn="";pcall(function() rn=self.Name:lower() end)
        if rn=="falldamage" or rn=="fall_damage" then return nil end
    end
    return oldNC(self,...)
end))

local oldNI;oldNI=hookmetamethod(game,"__newindex",newcclosure(function(self,key,value)
    if not(Settings.NoBulletSpread or Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25 or Settings.NoFallDamage) then return oldNI(self,key,value) end
    if typeof(self)~="Instance" then return oldNI(self,key,value) end
    local isC=false;pcall(function() isC=(self==workspace.CurrentCamera) or self:IsDescendantOf(workspace.CurrentCamera) end)
    if isC then return oldNI(self,key,value) end
    local isG=false;pcall(function() isG=self:IsA("GuiObject") or self:IsA("GuiBase") or self:IsA("ScreenGui") or self:IsA("LayerCollector") end)
    if isG then return oldNI(self,key,value) end
    local kl=tostring(key):lower()
    if Settings.NoBulletSpread and(kl=="spread" or kl=="bloom" or kl=="deviation" or kl=="cone") then
        if typeof(value)=="number" then return oldNI(self,key,0)
        elseif typeof(value)=="Vector3" then return oldNI(self,key,Vector3.new(0,0,0))
        elseif typeof(value)=="Vector2" then return oldNI(self,key,Vector2.new(0,0)) end
    end
    if Settings.NoFallDamage and(kl=="falldamage" or kl=="fall_damage") then
        if typeof(value)=="number" then return oldNI(self,key,0)
        elseif typeof(value)=="boolean" then return oldNI(self,key,false) end
    end
    if(Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then
        local isW=false;pcall(function() isW=IsInsideWeapon(self) end)
        if isW and IsAmmoName(tostring(key)) and typeof(value)=="number" and value>=0 then
            local cv=999;pcall(function() cv=self[key] end)
            if type(cv)=="number" and value<cv then return oldNI(self,key,cv) end
        end
    end
    return oldNI(self,key,value)
end))

--// INPUT
UserInputService.InputBegan:Connect(function(i,g)
    if g then return end
    if i.KeyCode==Settings.Keybind then Settings.Enabled=not Settings.Enabled end
    if i.KeyCode==Enum.KeyCode.Insert then MF.Visible=not MF.Visible end
    if i.KeyCode==Enum.KeyCode.F and Settings.Fly then if flying then StopFly() else StartFly() end end
end)

--// NOTIFICATION
local N=Instance.new("Frame",SG)
N.Size=UDim2.new(0,380,0,36)
N.AnchorPoint=Vector2.new(0.5,0)
N.Position=UDim2.new(0.5,0,0,-45)
N.BackgroundColor3=theme.SideBG
N.BorderSizePixel=0
Instance.new("UICorner",N).CornerRadius=UDim.new(0,8)
Instance.new("UIStroke",N).Color=theme.AccentColor
local NTx=Instance.new("TextLabel",N)
NTx.Size=UDim2.new(1,0,1,0)
NTx.BackgroundTransparency=1
NTx.Text="🎯 ZovHub loaded | Insert = Menu | X = Aim | ✅"
NTx.TextColor3=Color3.new(1,1,1)
NTx.TextSize=11
NTx.Font=Enum.Font.GothamMedium
TweenService:Create(N,TweenInfo.new(0.5,Enum.EasingStyle.Back),{Position=UDim2.new(0.5,0,0,10)}):Play()
task.delay(4,function() TweenService:Create(N,TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Position=UDim2.new(0.5,0,0,-50)}):Play();task.wait(0.5);N:Destroy() end)

print("[ZovHub] All systems operational!")
