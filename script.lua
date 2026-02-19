--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local GuiInset = GuiService:GetGuiInset()

------------------------------------------------------
--// KEY SYSTEM
------------------------------------------------------

local VALID_KEYS = {
    "ColdWarPoorGame",
    "CW-VIP-2025",
    "CW-PREMIUM-ALPHA",
}

local KEY_DISCORD = "https://discord.com/invite/EVqPGdnA6Q"
local KEY_VERIFIED = false

-- Key System GUI
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "CWKeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
KeyGui.IgnoreGuiInset = true
if syn and syn.protect_gui then syn.protect_gui(KeyGui) end
KeyGui.Parent = game:GetService("CoreGui")

-- Discord Link Panel (маленькое перетаскиваемое)
local DiscordPanel = Instance.new("Frame", KeyGui)
DiscordPanel.Size = UDim2.new(0, 280, 0, 45)
DiscordPanel.Position = UDim2.new(0, 15, 0.5, -120)
DiscordPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
DiscordPanel.BorderSizePixel = 0
DiscordPanel.Active = true
DiscordPanel.Draggable = false
Instance.new("UICorner", DiscordPanel).CornerRadius = UDim.new(0, 8)

local DiscordStroke = Instance.new("UIStroke", DiscordPanel)
DiscordStroke.Color = Color3.fromRGB(88, 101, 242)
DiscordStroke.Thickness = 1.5

local DiscordIcon = Instance.new("TextLabel", DiscordPanel)
DiscordIcon.Size = UDim2.new(0, 35, 1, 0)
DiscordIcon.Position = UDim2.new(0, 5, 0, 0)
DiscordIcon.BackgroundTransparency = 1
DiscordIcon.Text = "💬"
DiscordIcon.TextSize = 20
DiscordIcon.Font = Enum.Font.GothamBold
DiscordIcon.TextColor3 = Color3.fromRGB(88, 101, 242)

local DiscordLabel = Instance.new("TextLabel", DiscordPanel)
DiscordLabel.Size = UDim2.new(1, -45, 0, 18)
DiscordLabel.Position = UDim2.new(0, 40, 0, 4)
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Text = "Discord Server - Get Key"
DiscordLabel.TextColor3 = Color3.new(1, 1, 1)
DiscordLabel.TextSize = 11
DiscordLabel.Font = Enum.Font.GothamBold
DiscordLabel.TextXAlignment = Enum.TextXAlignment.Left

local DiscordLink = Instance.new("TextButton", DiscordPanel)
DiscordLink.Size = UDim2.new(1, -45, 0, 16)
DiscordLink.Position = UDim2.new(0, 40, 0, 23)
DiscordLink.BackgroundTransparency = 1
DiscordLink.Text = "discord.com/invite/EVqPGdnA6Q 📋"
DiscordLink.TextColor3 = Color3.fromRGB(88, 101, 242)
DiscordLink.TextSize = 9
DiscordLink.Font = Enum.Font.GothamMedium
DiscordLink.TextXAlignment = Enum.TextXAlignment.Left

DiscordLink.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(KEY_DISCORD)
        DiscordLink.Text = "✅ Copied to clipboard!"
        DiscordLink.TextColor3 = Color3.fromRGB(80, 255, 80)
        task.wait(2)
        DiscordLink.Text = "discord.com/invite/EVqPGdnA6Q 📋"
        DiscordLink.TextColor3 = Color3.fromRGB(88, 101, 242)
    end
end)

-- Discord Panel Dragging
do
    local dragging, dragInput, dragStart, startPos
    DiscordPanel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = DiscordPanel.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    DiscordPanel.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            DiscordPanel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Main Key Window
local KeyMain = Instance.new("Frame", KeyGui)
KeyMain.Size = UDim2.new(0, 380, 0, 280)
KeyMain.AnchorPoint = Vector2.new(0.5, 0.5)
KeyMain.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyMain.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
KeyMain.BorderSizePixel = 0
KeyMain.ClipsDescendants = true
Instance.new("UICorner", KeyMain).CornerRadius = UDim.new(0, 10)

local KeyMainStroke = Instance.new("UIStroke", KeyMain)
KeyMainStroke.Color = Color3.fromRGB(130, 80, 255)
KeyMainStroke.Thickness = 2

-- Key Top Bar
local KeyTopBar = Instance.new("Frame", KeyMain)
KeyTopBar.Size = UDim2.new(1, 0, 0, 45)
KeyTopBar.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
KeyTopBar.BorderSizePixel = 0
Instance.new("UICorner", KeyTopBar).CornerRadius = UDim.new(0, 10)

local KeyTopFix = Instance.new("Frame", KeyTopBar)
KeyTopFix.Size = UDim2.new(1, 0, 0, 10)
KeyTopFix.Position = UDim2.new(0, 0, 1, -10)
KeyTopFix.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
KeyTopFix.BorderSizePixel = 0

local KeyAccent = Instance.new("Frame", KeyTopBar)
KeyAccent.Size = UDim2.new(1, 0, 0, 2)
KeyAccent.Position = UDim2.new(0, 0, 1, 0)
KeyAccent.BackgroundColor3 = Color3.fromRGB(130, 80, 255)
KeyAccent.BorderSizePixel = 0
local KeyGrad = Instance.new("UIGradient", KeyAccent)
KeyGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 80, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 80, 255))
}

local KeyTitle = Instance.new("TextLabel", KeyTopBar)
KeyTitle.Size = UDim2.new(1, 0, 1, 0)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🔐 Cold War - Authentication"
KeyTitle.TextColor3 = Color3.new(1, 1, 1)
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.GothamBold

-- Key Top Bar Dragging
do
    local dragging, dragInput, dragStart, startPos
    KeyTopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = KeyMain.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    KeyTopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            KeyMain.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Content
local KeyContent = Instance.new("Frame", KeyMain)
KeyContent.Size = UDim2.new(1, -40, 1, -55)
KeyContent.Position = UDim2.new(0, 20, 0, 50)
KeyContent.BackgroundTransparency = 1

-- Subtitle
local KeySub = Instance.new("TextLabel", KeyContent)
KeySub.Size = UDim2.new(1, 0, 0, 20)
KeySub.Position = UDim2.new(0, 0, 0, 5)
KeySub.BackgroundTransparency = 1
KeySub.Text = "Enter your key to access Cold War v12.2"
KeySub.TextColor3 = Color3.fromRGB(150, 150, 180)
KeySub.TextSize = 12
KeySub.Font = Enum.Font.GothamMedium

-- Discord reminder
local KeyDiscordReminder = Instance.new("TextLabel", KeyContent)
KeyDiscordReminder.Size = UDim2.new(1, 0, 0, 16)
KeyDiscordReminder.Position = UDim2.new(0, 0, 0, 28)
KeyDiscordReminder.BackgroundTransparency = 1
KeyDiscordReminder.Text = "💬 Get your key from our Discord server →"
KeyDiscordReminder.TextColor3 = Color3.fromRGB(88, 101, 242)
KeyDiscordReminder.TextSize = 10
KeyDiscordReminder.Font = Enum.Font.GothamMedium

-- Input Box
local KeyInputBG = Instance.new("Frame", KeyContent)
KeyInputBG.Size = UDim2.new(1, 0, 0, 40)
KeyInputBG.Position = UDim2.new(0, 0, 0, 55)
KeyInputBG.BackgroundColor3 = Color3.fromRGB(35, 35, 52)
KeyInputBG.BorderSizePixel = 0
Instance.new("UICorner", KeyInputBG).CornerRadius = UDim.new(0, 8)
local KeyInputStroke = Instance.new("UIStroke", KeyInputBG)
KeyInputStroke.Color = Color3.fromRGB(60, 60, 90)
KeyInputStroke.Thickness = 1

local KeyInput = Instance.new("TextBox", KeyInputBG)
KeyInput.Size = UDim2.new(1, -20, 1, 0)
KeyInput.Position = UDim2.new(0, 10, 0, 0)
KeyInput.BackgroundTransparency = 1
KeyInput.Text = ""
KeyInput.PlaceholderText = "Enter key here..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(80, 80, 110)
KeyInput.TextColor3 = Color3.new(1, 1, 1)
KeyInput.TextSize = 14
KeyInput.Font = Enum.Font.GothamMedium
KeyInput.TextXAlignment = Enum.TextXAlignment.Left
KeyInput.ClearTextOnFocus = false

KeyInput.Focused:Connect(function()
    TweenService:Create(KeyInputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(130, 80, 255)}):Play()
end)
KeyInput.FocusLost:Connect(function()
    TweenService:Create(KeyInputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(60, 60, 90)}):Play()
end)

-- Status Label
local KeyStatus = Instance.new("TextLabel", KeyContent)
KeyStatus.Size = UDim2.new(1, 0, 0, 18)
KeyStatus.Position = UDim2.new(0, 0, 0, 102)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = ""
KeyStatus.TextColor3 = Color3.fromRGB(255, 60, 60)
KeyStatus.TextSize = 11
KeyStatus.Font = Enum.Font.GothamMedium

-- Verify Button
local KeyVerifyBtn = Instance.new("TextButton", KeyContent)
KeyVerifyBtn.Size = UDim2.new(1, 0, 0, 38)
KeyVerifyBtn.Position = UDim2.new(0, 0, 0, 125)
KeyVerifyBtn.BackgroundColor3 = Color3.fromRGB(130, 80, 255)
KeyVerifyBtn.BorderSizePixel = 0
KeyVerifyBtn.Text = "🔓 Verify Key"
KeyVerifyBtn.TextColor3 = Color3.new(1, 1, 1)
KeyVerifyBtn.TextSize = 14
KeyVerifyBtn.Font = Enum.Font.GothamBold
KeyVerifyBtn.AutoButtonColor = false
Instance.new("UICorner", KeyVerifyBtn).CornerRadius = UDim.new(0, 8)

local VerifyGrad = Instance.new("UIGradient", KeyVerifyBtn)
VerifyGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 60, 220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 100, 255))
}

KeyVerifyBtn.MouseEnter:Connect(function()
    TweenService:Create(KeyVerifyBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(160, 100, 255)}):Play()
end)
KeyVerifyBtn.MouseLeave:Connect(function()
    TweenService:Create(KeyVerifyBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(130, 80, 255)}):Play()
end)

-- Copy Discord Button
local KeyCopyDiscord = Instance.new("TextButton", KeyContent)
KeyCopyDiscord.Size = UDim2.new(1, 0, 0, 30)
KeyCopyDiscord.Position = UDim2.new(0, 0, 0, 170)
KeyCopyDiscord.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
KeyCopyDiscord.BorderSizePixel = 0
KeyCopyDiscord.Text = "💬 Copy Discord Invite"
KeyCopyDiscord.TextColor3 = Color3.new(1, 1, 1)
KeyCopyDiscord.TextSize = 12
KeyCopyDiscord.Font = Enum.Font.GothamMedium
KeyCopyDiscord.AutoButtonColor = false
Instance.new("UICorner", KeyCopyDiscord).CornerRadius = UDim.new(0, 6)

KeyCopyDiscord.MouseEnter:Connect(function()
    TweenService:Create(KeyCopyDiscord, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(110, 120, 255)}):Play()
end)
KeyCopyDiscord.MouseLeave:Connect(function()
    TweenService:Create(KeyCopyDiscord, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(88, 101, 242)}):Play()
end)
KeyCopyDiscord.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(KEY_DISCORD)
        KeyCopyDiscord.Text = "✅ Copied!"
        task.wait(2)
        KeyCopyDiscord.Text = "💬 Copy Discord Invite"
    end
end)

-- Attempts counter
local KeyAttempts = 0
local MAX_ATTEMPTS = 5
local KeyLocked = false

-- Verify Logic
local function VerifyKey()
    if KeyLocked then
        KeyStatus.Text = "⏳ Too many attempts. Wait 30 seconds."
        KeyStatus.TextColor3 = Color3.fromRGB(255, 200, 50)
        return
    end

    local inputKey = KeyInput.Text:gsub("^%s+", ""):gsub("%s+$", "")

    if inputKey == "" then
        KeyStatus.Text = "❌ Please enter a key!"
        KeyStatus.TextColor3 = Color3.fromRGB(255, 60, 60)
        return
    end

    KeyVerifyBtn.Text = "⏳ Verifying..."
    KeyVerifyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 120)

    task.wait(0.8)

    local valid = false
    for _, k in ipairs(VALID_KEYS) do
        if inputKey == k then
            valid = true
            break
        end
    end

    if valid then
        KEY_VERIFIED = true
        KeyStatus.Text = "✅ Key verified! Loading..."
        KeyStatus.TextColor3 = Color3.fromRGB(80, 255, 80)
        KeyVerifyBtn.Text = "✅ Verified!"
        KeyVerifyBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 80)

        -- Success animation
        TweenService:Create(KeyMainStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(80, 255, 80)}):Play()

        task.wait(1.5)

        -- Fade out key system
        TweenService:Create(KeyMain, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, 0, 0.5, 50)
        }):Play()
        TweenService:Create(KeyMain, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        TweenService:Create(DiscordPanel, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()

        task.wait(0.6)
        KeyGui:Destroy()
    else
        KeyAttempts = KeyAttempts + 1
        local remaining = MAX_ATTEMPTS - KeyAttempts
        KeyStatus.Text = "❌ Invalid key! " .. remaining .. " attempts remaining"
        KeyStatus.TextColor3 = Color3.fromRGB(255, 60, 60)
        KeyVerifyBtn.Text = "🔓 Verify Key"
        KeyVerifyBtn.BackgroundColor3 = Color3.fromRGB(130, 80, 255)

        -- Shake animation
        local origPos = KeyInputBG.Position
        for i = 1, 4 do
            KeyInputBG.Position = UDim2.new(origPos.X.Scale, origPos.X.Offset + 5, origPos.Y.Scale, origPos.Y.Offset)
            task.wait(0.04)
            KeyInputBG.Position = UDim2.new(origPos.X.Scale, origPos.X.Offset - 5, origPos.Y.Scale, origPos.Y.Offset)
            task.wait(0.04)
        end
        KeyInputBG.Position = origPos

        TweenService:Create(KeyInputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(255, 60, 60)}):Play()
        task.wait(0.5)
        TweenService:Create(KeyInputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(60, 60, 90)}):Play()

        if KeyAttempts >= MAX_ATTEMPTS then
            KeyLocked = true
            KeyStatus.Text = "🔒 Locked for 30 seconds"
            KeyStatus.TextColor3 = Color3.fromRGB(255, 200, 50)
            KeyVerifyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            task.delay(30, function()
                KeyLocked = false
                KeyAttempts = 0
                KeyStatus.Text = "🔓 Unlocked - try again"
                KeyStatus.TextColor3 = Color3.fromRGB(80, 255, 80)
                KeyVerifyBtn.BackgroundColor3 = Color3.fromRGB(130, 80, 255)
            end)
        end
    end
end

KeyVerifyBtn.MouseButton1Click:Connect(VerifyKey)
KeyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then VerifyKey() end
end)

-- Entrance animation
KeyMain.Position = UDim2.new(0.5, 0, 0.5, 30)
KeyMain.BackgroundTransparency = 0.3
TweenService:Create(KeyMain, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundTransparency = 0
}):Play()

DiscordPanel.Position = UDim2.new(0, -300, 0.5, -120)
TweenService:Create(DiscordPanel, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
    Position = UDim2.new(0, 15, 0.5, -120)
}):Play()

-- Wait for verification
print("[Cold War v12.2] Key system loaded. Waiting for authentication...")
repeat task.wait(0.1) until KEY_VERIFIED
print("[Cold War v12.2] Key verified! Loading cheat...")

------------------------------------------------------
--// MAIN SCRIPT STARTS HERE
------------------------------------------------------

local function GetMouseViewportPos()
    return Vector2.new(Mouse.X, Mouse.Y + GuiInset.Y)
end

local Settings = {
    Enabled = false, FOV = 100, ShowFOV = true, TargetPart = "Head",
    Keybind = Enum.KeyCode.X, TeamCheck = true, WallCheck = true,
    NoSpread = false, NoRecoil = false, NoFallDamage = false,
    NoBulletSpread = false,
    InfAmmo = false, InfRPG = false, InfGP25 = false,
    ShowSkeleton = true, SkeletonColor = Color3.fromRGB(130,80,255), SkeletonThickness = 1.5,
    ShowESP = true, ESPBoxColor = Color3.fromRGB(130,80,255),
    ShowName = true, ShowHealth = true, ShowDistance = true,
    ShowChams = true, ChamsFillColor = Color3.fromRGB(130,80,255), ChamsFillTransparency = 0.6,
    ChamsOutlineColor = Color3.fromRGB(200,130,255), ChamsOutlineTransparency = 0.3,
    WalkSpeed = 16, WalkSpeedEnabled = false,
    InfJump = false, Fly = false, FlySpeed = 50,
    AccentColor = Color3.fromRGB(130,80,255), FOVColor = Color3.fromRGB(255,50,50),
    BG = Color3.fromRGB(20,20,30), SideBG = Color3.fromRGB(28,28,40),
    CardBG = Color3.fromRGB(35,35,50), HoverBG = Color3.fromRGB(45,45,65),
    TextColor = Color3.fromRGB(220,220,230), DimText = Color3.fromRGB(120,120,150),
}

local CachedTargetPosition = nil
local CurrentTarget = nil

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness=1.5;FOVCircle.NumSides=64;FOVCircle.Radius=Settings.FOV
FOVCircle.Filled=false;FOVCircle.Visible=Settings.ShowFOV;FOVCircle.ZIndex=999
FOVCircle.Transparency=0.8;FOVCircle.Color=Settings.FOVColor

------------------------------------------------------
--// HELPERS
------------------------------------------------------

local function IsEnemy(p)
    if p==LocalPlayer then return false end
    if not Settings.TeamCheck then return true end
    if not LocalPlayer.Team or not p.Team then return true end
    return LocalPlayer.Team~=p.Team
end

local function IsAlive(p)
    local ch=p.Character;if not ch then return false end
    local hum=ch:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health>0
end

local function IsVisible(part)
    if not Settings.WallCheck then return true end
    local ch=LocalPlayer.Character;if not ch then return true end
    local head=ch:FindFirstChild("Head");if not head then return true end
    local rp=RaycastParams.new();rp.FilterType=Enum.RaycastFilterType.Blacklist
    rp.FilterDescendantsInstances={ch,part.Parent}
    return workspace:Raycast(head.Position,part.Position-head.Position,rp)==nil
end

------------------------------------------------------
--// SAFE CHECKS
------------------------------------------------------

local function IsInsideWeapon(obj)
    local current = obj
    for i = 1, 10 do
        if not current then return false end
        if current:IsA("Tool") then return true end
        current = current.Parent
    end
    return false
end

local PRIMARY_AMMO_NAMES = {
    ammo=true, mag=true, clip=true, magazine=true, bullets=true, rounds=true,
    currentammo=true, magsize=true, clipsize=true, magcount=true,
    roundcount=true, ammocount=true, cartridge=true,
}

local RPG_AMMO_NAMES = {
    rocket=true, missile=true, rpg=true, projectile=true, warhead=true,
    rocketammo=true, rpgammo=true,
}

local GP25_AMMO_NAMES = {
    grenade=true, gp25=true, ["gp-25"]=true, gp30=true, ["gp-30"]=true,
    gl=true, m203=true, ubgl=true, ["40mm"]=true, nade=true,
    grenadeammo=true, glammo=true, grenadecount=true,
    secondary=true, secondaryammo=true, secondary_ammo=true,
    altammo=true, alt_ammo=true, altfire=true, alt_fire=true,
    secondarymag=true, secondary_mag=true,
    undermag=true, under_mag=true,
    underbarrel=true, under_barrel=true,
    underbarrelammo=true, underbarrel_ammo=true,
    secondarymagslot=true, secondary_mag_slot=true,
    altmagslot=true, alt_mag_slot=true,
    glmag=true, gl_mag=true, glmagslot=true, gl_mag_slot=true,
    grenademag=true, grenade_mag=true,
    secondaryround=true, secondary_round=true,
    altround=true, alt_round=true,
}

local function IsAmmoName(name)
    local nl = name:lower()
    if Settings.InfAmmo and PRIMARY_AMMO_NAMES[nl] then return true end
    if Settings.InfRPG and RPG_AMMO_NAMES[nl] then return true end
    if Settings.InfGP25 and GP25_AMMO_NAMES[nl] then return true end
    if Settings.InfGP25 then
        if nl:find("secondary") or nl:find("altammo") or nl:find("alt_ammo")
            or nl:find("underbarrel") or nl:find("under_barrel")
            or nl:find("grenade") or nl:find("gp25") or nl:find("gp_25")
            or nl:find("gp30") or nl:find("gp_30") or nl:find("ubgl")
            or nl:find("40mm") or nl:find("m203") or nl:find("glmag")
            or nl:find("gl_mag") or nl:find("grenademag") or nl:find("altfire")
            or nl:find("alt_fire") or nl:find("secondarymag") or nl:find("secondary_mag") then
            return true
        end
    end
    if Settings.InfRPG then
        if nl:find("rocket") or nl:find("rpg") or nl:find("missile") then return true end
    end
    return false
end

local function IsGP25Part(obj)
    local current = obj
    for i = 1, 8 do
        if not current then return false end
        local cn = current.Name:lower()
        if cn:find("secondary") or cn:find("underbarrel") or cn:find("under_barrel")
            or cn:find("grenade") or cn:find("gp25") or cn:find("gp_25")
            or cn:find("gp30") or cn:find("gl") or cn:find("m203")
            or cn:find("ubgl") or cn:find("altfire") or cn:find("alt") then
            return true
        end
        current = current.Parent
    end
    return false
end

local function IsModuleBlacklisted(nm)
    return nm:find("damage") or nm:find("hit") or nm:find("health")
        or nm:find("kill") or nm:find("death") or nm:find("public")
        or nm:find("trans") or nm:find("network") or nm:find("sync")
        or nm:find("server") or nm:find("gui") or nm:find("ui")
        or nm:find("hud") or nm:find("camera") or nm:find("input")
        or nm:find("control") or nm:find("player") or nm:find("character")
        or nm:find("team") or nm:find("spawn") or nm:find("sound")
        or nm:find("anim") or nm:find("effect") or nm:find("particle")
        or nm:find("view") or nm:find("scope") or nm:find("ads")
        or nm:find("aim") or nm:find("look") or nm:find("mouse")
        or nm:find("cursor")
end

------------------------------------------------------
--// MODULE PATCHER
------------------------------------------------------

local patchedModules = {}
local lastPatchTick = 0
local hookedWeaponModules = {}

local function DeepPatchTable(tbl, depth)
    if depth > 8 or type(tbl) ~= "table" then return end
    for k, v in pairs(tbl) do
        local kl = type(k) == "string" and k:lower() or ""
        if Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25 then
            if kl == "ammocost" or kl == "ammo_cost" or kl == "ammouse" or kl == "ammo_use"
                or kl == "ammopershot" or kl == "ammo_per_shot" or kl == "bulletcost"
                or kl == "ammodrain" or kl == "consumeamount" then
                if type(v) == "number" then pcall(function() tbl[k] = 0 end) end
            end
            if kl == "magsize" or kl == "mag_size" or kl == "clipsize" or kl == "clip_size"
                or kl == "magazinesize" or kl == "maxammo" or kl == "max_ammo"
                or kl == "reserveammo" or kl == "reserve_ammo" or kl == "totalammo"
                or kl == "maxmags" or kl == "sparemags" then
                if type(v) == "number" and v > 0 and v < 9999 then
                    pcall(function() tbl[k] = 9999 end)
                end
            end
            if kl == "reloadtime" or kl == "reload_time" or kl == "reloadduration" then
                if type(v) == "number" then pcall(function() tbl[k] = 0.01 end) end
            end
        end
        if Settings.InfGP25 then
            if kl:find("secondary") or kl:find("altammo") or kl:find("alt_ammo")
                or kl:find("underbarrel") or kl:find("grenade") or kl:find("gp25")
                or kl:find("gp30") or kl:find("ubgl") or kl:find("40mm")
                or kl:find("m203") or kl:find("glmag") or kl:find("gl_mag")
                or kl:find("altfire") or kl:find("alt_fire") then
                if type(v) == "number" then
                    if kl:find("cost") or kl:find("use") or kl:find("drain")
                        or kl:find("consume") or kl:find("pershot") then
                        pcall(function() tbl[k] = 0 end)
                    elseif v > 0 and v < 9999 then
                        pcall(function() tbl[k] = math.max(v, 999) end)
                    end
                elseif type(v) == "boolean" then
                    if kl:find("empty") or kl:find("depleted") or kl:find("needsreload") then
                        pcall(function() tbl[k] = false end)
                    end
                    if kl:find("has") or kl:find("loaded") or kl:find("ready") or kl:find("can") then
                        pcall(function() tbl[k] = true end)
                    end
                end
            end
        end
        if Settings.InfRPG then
            if kl:find("rocket") or kl:find("rpg") or kl:find("missile") or kl:find("launcher") then
                if type(v) == "number" then
                    if kl:find("cost") or kl:find("use") or kl:find("drain") or kl:find("consume") then
                        pcall(function() tbl[k] = 0 end)
                    elseif v > 0 and v < 9999 then
                        pcall(function() tbl[k] = math.max(v, 999) end)
                    end
                end
            end
        end
        if type(v) == "table" then DeepPatchTable(v, depth + 1) end
    end
end

------------------------------------------------------
--// WEAPON FUNCTION HOOKER
------------------------------------------------------

local function HookWeaponFunctions(mod, modPath)
    if type(mod) ~= "table" then return end
    if not (Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
    for funcName, funcVal in pairs(mod) do
        if type(funcVal) ~= "function" then continue end
        local fnl = funcName:lower()
        local hookKey = modPath.."_"..funcName
        if hookedWeaponModules[hookKey] then continue end
        if fnl == "consumeammo" or fnl == "useammo" or fnl == "removeammo"
            or fnl == "decrementammo" or fnl == "spendammo" or fnl == "subtractammo"
            or fnl == "drainammo" or fnl == "consumesecondary" or fnl == "usesecondaryammo"
            or fnl == "consumealtammo" or fnl == "usealtammo" or fnl == "consumegrenade"
            or fnl == "usegrenade" or fnl == "removegrenade" or fnl == "consumegl"
            or fnl == "consumesecondaryammo" or fnl == "removesecondaryammo"
            or fnl == "decrementgrenade" or fnl == "spendgrenade"
            or fnl == "removealtammo" or fnl == "subtractsecondary" then
            mod[funcName] = function() return end
            hookedWeaponModules[hookKey] = true
        end
        if fnl == "getammo" or fnl == "getmagammo" or fnl == "getcurrentammo"
            or fnl == "getmagcount" or fnl == "getrounds" or fnl == "ammocount"
            or fnl == "getsecondaryammo" or fnl == "getaltammo"
            or fnl == "getgrenadecount" or fnl == "getgrenadeammo"
            or fnl == "getglcount" or fnl == "getglammo"
            or fnl == "getsecondarycount" or fnl == "getaltcount"
            or fnl == "getunderbarrelammo" then
            local oldFunc = funcVal
            mod[funcName] = function(...)
                local r = oldFunc(...)
                if type(r) == "number" then return math.max(r, 999) end
                return r
            end
            hookedWeaponModules[hookKey] = true
        end
        if fnl == "isempty" or fnl == "needsreload" or fnl == "outofammo"
            or fnl == "ismagempty" or fnl == "nomags" or fnl == "issecondaryempty"
            or fnl == "isaltempty" or fnl == "isgrenadeempty" or fnl == "nogrenades"
            or fnl == "secondaryempty" or fnl == "glempty" or fnl == "isglroundempty"
            or fnl == "noaltammo" or fnl == "issecondarymagempty"
            or fnl == "needssecondaryreload" or fnl == "isunderbarrelempty" then
            mod[funcName] = function() return false end
            hookedWeaponModules[hookKey] = true
        end
        if fnl == "canfire" or fnl == "canshoot" or fnl == "hasammo"
            or fnl == "hasmag" or fnl == "isloaded" or fnl == "canfiresecondary"
            or fnl == "canfirealt" or fnl == "canfiregrenade" or fnl == "canfiregl"
            or fnl == "hassecondaryammo" or fnl == "hasaltammo" or fnl == "hasgrenade"
            or fnl == "hasglround" or fnl == "issecondaryloaded" or fnl == "isaltloaded"
            or fnl == "isglloaded" or fnl == "canshootsecondary" or fnl == "hassecondary"
            or fnl == "secondaryready" or fnl == "isunderbarrelready"
            or fnl == "isunderbarrelloaded" then
            mod[funcName] = function() return true end
            hookedWeaponModules[hookKey] = true
        end
    end
end

local function PatchColdWarWeaponSystem()
    if not (Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
    pcall(function()
        local modulesFolder = ReplicatedStorage:FindFirstChild("Modules")
        if not modulesFolder then return end
        for _, desc in ipairs(modulesFolder:GetDescendants()) do
            if not desc:IsA("ModuleScript") then continue end
            local nm = desc.Name:lower()
            if not (nm:find("weapon") or nm:find("gun") or nm:find("fire") or nm:find("ammo")
                or nm:find("mag") or nm:find("reload") or nm:find("shoot") or nm:find("bullet")
                or nm:find("rpg") or nm:find("grenade") or nm:find("launcher") or nm:find("gp")
                or nm:find("explosive") or nm:find("rocket") or nm:find("projectile")
                or nm:find("core") or nm:find("secondary") or nm:find("alt")
                or nm:find("underbarrel") or nm:find("ubgl") or nm:find("gl")) then continue end
            if IsModuleBlacklisted(nm) then continue end
            pcall(function()
                local mod = require(desc)
                if type(mod) == "table" then
                    DeepPatchTable(mod, 0)
                    HookWeaponFunctions(mod, desc:GetFullName())
                end
            end)
        end
    end)
end

------------------------------------------------------
--// MAG SYSTEM
------------------------------------------------------

local magConnections = {}

local function PatchMagSystem()
    if not (Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
    local ch = LocalPlayer.Character;if not ch then return end
    for _, conn in pairs(magConnections) do
        if typeof(conn) == "RBXScriptConnection" and conn.Connected then conn:Disconnect() end
    end
    magConnections = {}
    for _, tool in ipairs(ch:GetChildren()) do
        if not tool:IsA("Tool") then continue end
        for _, desc in ipairs(tool:GetDescendants()) do
            local name = desc.Name:lower()
            if (desc:IsA("NumberValue") or desc:IsA("IntValue")) then
                local shouldPatch = false
                if Settings.InfAmmo and PRIMARY_AMMO_NAMES[name] then shouldPatch = true end
                if Settings.InfRPG and (RPG_AMMO_NAMES[name] or name:find("rocket") or name:find("rpg") or name:find("missile")) then shouldPatch = true end
                if Settings.InfGP25 then
                    if GP25_AMMO_NAMES[name] then shouldPatch = true end
                    if name:find("secondary") or name:find("alt") or name:find("grenade")
                        or name:find("gp25") or name:find("gp30") or name:find("ubgl")
                        or name:find("40mm") or name:find("m203") or name:find("gl")
                        or name:find("underbarrel") then shouldPatch = true end
                    if IsGP25Part(desc) and (name:find("ammo") or name:find("mag") or name:find("clip")
                        or name:find("round") or name:find("count") or name:find("shell")
                        or name:find("current") or name:find("remaining") or name:find("loaded")) then
                        shouldPatch = true end
                end
                if shouldPatch then
                    if desc.Value >= 0 and desc.Value < 9999 then
                        pcall(function() desc.Value = math.max(desc.Value, 999) end) end
                    local conn = desc.Changed:Connect(function(newVal)
                        if not (Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
                        if newVal < 900 then task.defer(function() pcall(function() desc.Value = 999 end) end) end
                    end)
                    table.insert(magConnections, conn)
                end
            end
            if name:find("magslot") or name:find("currentmagslot")
                or (Settings.InfGP25 and (name:find("secondarymagslot") or name:find("secondary_mag_slot")
                    or name:find("altmagslot") or name:find("glmagslot") or name:find("grenademagslot")
                    or name:find("underbarrelslot"))) then
                local conn = desc.ChildRemoved:Connect(function(removed)
                    if not (Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
                    task.defer(function() task.wait(0.05)
                        pcall(function() if #desc:GetChildren() == 0 then
                            local clone = removed:Clone();clone.Parent = desc end end) end)
                end)
                table.insert(magConnections, conn)
            end
            if Settings.InfGP25 and (name:find("secondary") or name:find("underbarrel")
                or name:find("grenade") or name:find("gp25") or name:find("gl") or name:find("alt")) then
                if desc:IsA("Folder") or desc:IsA("Model") or desc:IsA("Configuration") then
                    local conn = desc.ChildRemoved:Connect(function(removed)
                        if not Settings.InfGP25 then return end
                        task.defer(function() task.wait(0.05)
                            pcall(function() local rn = removed.Name:lower()
                                if rn:find("mag") or rn:find("round") or rn:find("shell")
                                    or rn:find("grenade") or rn:find("ammo") or rn:find("projectile") then
                                    if #desc:GetChildren() == 0 or not desc:FindFirstChild(removed.Name) then
                                        local clone = removed:Clone();clone.Parent = desc end end end) end)
                    end)
                    table.insert(magConnections, conn)
                end
            end
            if desc:IsA("ModuleScript") then
                local mn = desc.Name:lower()
                if not IsModuleBlacklisted(mn) then
                    pcall(function()
                        local mod = require(desc)
                        if type(mod) == "table" then
                            DeepPatchTable(mod, 0)
                            HookWeaponFunctions(mod, desc:GetFullName())
                        end
                    end)
                end
            end
        end
    end
    local conn = ch.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then task.wait(0.3);PatchMagSystem() end
    end)
    table.insert(magConnections, conn)
end

------------------------------------------------------
--// MAIN PATCHER
------------------------------------------------------

local function PatchAllModules()
    if not (Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
    if Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25 then
        PatchColdWarWeaponSystem()
        PatchMagSystem()
    end
end

------------------------------------------------------
--// AMMO MONITOR
------------------------------------------------------

local ammoConnections = {}

local function MonitorAmmoValues()
    for _, conn in pairs(ammoConnections) do
        if typeof(conn) == "RBXScriptConnection" and conn.Connected then conn:Disconnect() end
    end
    ammoConnections = {}
    local ch = LocalPlayer.Character;if not ch then return end
    local function HookValue(obj)
        if not (obj:IsA("NumberValue") or obj:IsA("IntValue")) then return end
        if not IsInsideWeapon(obj) then return end
        if not IsAmmoName(obj.Name) then return end
        local maxVal = obj.Value;if maxVal <= 0 then maxVal = 999 end
        local conn = obj.Changed:Connect(function(newVal)
            if not (Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) then return end
            if newVal < maxVal then task.defer(function() pcall(function() obj.Value = maxVal end) end)
            else maxVal = newVal end
        end)
        table.insert(ammoConnections, conn)
    end
    for _, desc in ipairs(ch:GetDescendants()) do HookValue(desc) end
    local addedConn = ch.DescendantAdded:Connect(function(desc) task.wait();HookValue(desc) end)
    table.insert(ammoConnections, addedConn)
    PatchMagSystem()
end

local function RefreshAmmoMonitor()
    if Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25 then
        MonitorAmmoValues();patchedModules={};lastPatchTick=0;hookedWeaponModules={}
    end
end

------------------------------------------------------
--// NO FALL DAMAGE
------------------------------------------------------

local fallDamageConnection = nil
local function SetupNoFallDamage()
    local ch = LocalPlayer.Character;if not ch then return end
    local hum = ch:FindFirstChildOfClass("Humanoid");local root = ch:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end
    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    if fallDamageConnection then fallDamageConnection:Disconnect() end
    fallDamageConnection = hum.StateChanged:Connect(function(_, newState)
        if not Settings.NoFallDamage then return end
        if newState == Enum.HumanoidStateType.FallingDown or newState == Enum.HumanoidStateType.Ragdoll then
            hum:ChangeState(Enum.HumanoidStateType.Landing)
            task.defer(function() hum:ChangeState(Enum.HumanoidStateType.Running) end)
        end
        if newState == Enum.HumanoidStateType.Landed and root then
            root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
            pcall(function() root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z) end)
        end
    end)
end

local function UpdateNoFallDamage()
    if not Settings.NoFallDamage then return end
    local ch = LocalPlayer.Character;if not ch then return end
    local hum = ch:FindFirstChildOfClass("Humanoid");local root = ch:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end
    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    local vel = root.Velocity
    if vel.Y < -80 then root.Velocity = Vector3.new(vel.X,-80,vel.Z)
        pcall(function() root.AssemblyLinearVelocity = Vector3.new(vel.X,-80,vel.Z) end) end
    if hum:GetState() == Enum.HumanoidStateType.Freefall and vel.Y < -100 then
        hum:ChangeState(Enum.HumanoidStateType.Running) end
end

LocalPlayer.CharacterAdded:Connect(function(ch)
    ch:WaitForChild("Humanoid");ch:WaitForChild("HumanoidRootPart");task.wait(0.5)
    if Settings.NoFallDamage then SetupNoFallDamage() end
    if Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25 then MonitorAmmoValues() end
    patchedModules={};lastPatchTick=0;hookedWeaponModules={}
end)
if LocalPlayer.Character then task.defer(function() if Settings.NoFallDamage then SetupNoFallDamage() end end) end

------------------------------------------------------
--// TELEPORT + LOCATIONS
------------------------------------------------------

local function SmoothTP(targetPos)
    local ch = LocalPlayer.Character;if not ch then return end
    local root = ch:FindFirstChild("HumanoidRootPart");local hum = ch:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    if typeof(targetPos) == "CFrame" then targetPos = targetPos.Position end
    local rp = RaycastParams.new();rp.FilterType = Enum.RaycastFilterType.Blacklist;rp.FilterDescendantsInstances = {ch}
    local floor = workspace:Raycast(targetPos+Vector3.new(0,10,0),Vector3.new(0,-100,0),rp)
    local finalPos = floor and (floor.Position+Vector3.new(0,3.5,0)) or (targetPos+Vector3.new(0,3.5,0))
    root.Velocity = Vector3.new(0,0,0);pcall(function() root.AssemblyLinearVelocity=Vector3.new(0,0,0) end)
    pcall(function() root.AssemblyAngularVelocity=Vector3.new(0,0,0) end)
    root.CFrame = CFrame.new(finalPos);hum:ChangeState(Enum.HumanoidStateType.Running)
    for i=1,5 do task.defer(function() task.wait(i*0.03)
        if root and root.Parent then root.Velocity=Vector3.new(0,0,0)
            pcall(function() root.AssemblyLinearVelocity=Vector3.new(0,0,0) end)
            hum:ChangeState(Enum.HumanoidStateType.Running) end end) end
end

local ColdWarLocations = {
    Church={{name="Basement 1",pos=Vector3.new(231.8,109.8,17.5)},{name="Basement 2",pos=Vector3.new(205.8,109.8,48.4)},{name="Entrance",pos=Vector3.new(237.7,128.3,94.0)},{name="Staircase",pos=Vector3.new(236.3,153.5,89.8)},{name="Attic",pos=Vector3.new(195.8,171.5,2.4)},{name="Roof",pos=Vector3.new(238.1,214.2,91.7)}},
    Sniper={{name="Church Roof",pos=Vector3.new(238.1,214.2,91.7)},{name="Vasily Roof",pos=Vector3.new(833.6,226.3,160.7)},{name="Church Attic",pos=Vector3.new(195.8,171.5,2.4)},{name="Church Staircase",pos=Vector3.new(236.3,153.5,89.8)}},
    General={{name="Map Center",pos=Vector3.new(220,130,50)},{name="Near Church",pos=Vector3.new(237.7,128.3,94.0)}},
}

------------------------------------------------------
--// FLY + MOVEMENT
------------------------------------------------------

local flyBody,flyGyro,flying=nil,nil,false
local function StartFly() local ch=LocalPlayer.Character;if not ch then return end;local root=ch:FindFirstChild("HumanoidRootPart");if not root then return end;flying=true;flyBody=Instance.new("BodyVelocity");flyBody.MaxForce=Vector3.new(1e6,1e6,1e6);flyBody.Velocity=Vector3.new(0,0,0);flyBody.Parent=root;flyGyro=Instance.new("BodyGyro");flyGyro.MaxTorque=Vector3.new(1e6,1e6,1e6);flyGyro.D=200;flyGyro.P=40000;flyGyro.Parent=root;local hum=ch:FindFirstChildOfClass("Humanoid");if hum then hum.PlatformStand=true end end
local function StopFly() flying=false;if flyBody then flyBody:Destroy();flyBody=nil end;if flyGyro then flyGyro:Destroy();flyGyro=nil end;local ch=LocalPlayer.Character;if ch then local hum=ch:FindFirstChildOfClass("Humanoid");if hum then hum.PlatformStand=false end end end
local function UpdateFly() if not flying or not flyBody or not flyGyro then return end;local ch=LocalPlayer.Character;if not ch then StopFly();return end;local root=ch:FindFirstChild("HumanoidRootPart");if not root then StopFly();return end;flyGyro.CFrame=Camera.CFrame;local dir=Vector3.new(0,0,0);if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir=dir+Camera.CFrame.LookVector end;if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir=dir-Camera.CFrame.LookVector end;if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir=dir-Camera.CFrame.RightVector end;if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir=dir+Camera.CFrame.RightVector end;if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir=dir+Vector3.new(0,1,0) end;if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir=dir-Vector3.new(0,1,0) end;flyBody.Velocity=dir.Magnitude>0 and dir.Unit*Settings.FlySpeed or Vector3.new(0,0,0) end

UserInputService.JumpRequest:Connect(function() if Settings.InfJump then local ch=LocalPlayer.Character;if ch then local hum=ch:FindFirstChildOfClass("Humanoid");if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end end end end)
local function UpdateWalkSpeed() if not Settings.WalkSpeedEnabled then return end;local ch=LocalPlayer.Character;if not ch then return end;local hum=ch:FindFirstChildOfClass("Humanoid");if hum then hum.WalkSpeed=Settings.WalkSpeed end end

------------------------------------------------------
--// VISUALS
------------------------------------------------------

local ChamsObjects={}
local function UpdateChams() for _,player in ipairs(Players:GetPlayers()) do if player==LocalPlayer then continue end;local ch=player.Character;if not Settings.ShowChams or not ch or not IsEnemy(player) or not IsAlive(player) then if ChamsObjects[player] then ChamsObjects[player]:Destroy();ChamsObjects[player]=nil end;continue end;if not ChamsObjects[player] then local h=Instance.new("Highlight");h.FillColor=Settings.ChamsFillColor;h.FillTransparency=Settings.ChamsFillTransparency;h.OutlineColor=Settings.ChamsOutlineColor;h.OutlineTransparency=Settings.ChamsOutlineTransparency;h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop;h.Parent=ch;ChamsObjects[player]=h else local h=ChamsObjects[player];if h.Parent~=ch then h.Parent=ch end;h.FillColor=Settings.ChamsFillColor;h.FillTransparency=Settings.ChamsFillTransparency;h.OutlineColor=Settings.ChamsOutlineColor;h.OutlineTransparency=Settings.ChamsOutlineTransparency end end end

local ESPObjects={}
local function GetESP(p) if not ESPObjects[p] then ESPObjects[p]={BoxOutline=Drawing.new("Quad"),Box=Drawing.new("Quad"),Name=Drawing.new("Text"),Health=Drawing.new("Text"),Distance=Drawing.new("Text"),HealthBar=Drawing.new("Line"),HealthBarBG=Drawing.new("Line")};local e=ESPObjects[p];e.BoxOutline.Thickness=3;e.BoxOutline.Color=Color3.new(0,0,0);e.BoxOutline.Filled=false;e.BoxOutline.Visible=false;e.Box.Thickness=1.2;e.Box.Color=Settings.ESPBoxColor;e.Box.Filled=false;e.Box.Visible=false;e.Name.Size=13;e.Name.Center=true;e.Name.Outline=true;e.Name.OutlineColor=Color3.new(0,0,0);e.Name.Font=2;e.Name.Visible=false;e.Health.Size=12;e.Health.Center=false;e.Health.Outline=true;e.Health.OutlineColor=Color3.new(0,0,0);e.Health.Font=2;e.Health.Visible=false;e.Distance.Size=12;e.Distance.Center=true;e.Distance.Outline=true;e.Distance.OutlineColor=Color3.new(0,0,0);e.Distance.Font=2;e.Distance.Visible=false;e.HealthBarBG.Thickness=4;e.HealthBarBG.Color=Color3.new(0,0,0);e.HealthBarBG.Visible=false;e.HealthBar.Thickness=2;e.HealthBar.Visible=false end;return ESPObjects[p] end
local function HideESP(p) if ESPObjects[p] then for _,o in pairs(ESPObjects[p]) do o.Visible=false end end end
local function RemoveESP(p) if ESPObjects[p] then for _,o in pairs(ESPObjects[p]) do o:Remove() end;ESPObjects[p]=nil end end

local function UpdateESP() for _,player in ipairs(Players:GetPlayers()) do if player==LocalPlayer then continue end;if not Settings.ShowESP or not IsEnemy(player) or not IsAlive(player) then HideESP(player);continue end;local ch=player.Character;if not ch then HideESP(player);continue end;local hum=ch:FindFirstChildOfClass("Humanoid");local root=ch:FindFirstChild("HumanoidRootPart");if not hum or not root then HideESP(player);continue end;local esp=GetESP(player);local pos,onScreen=Camera:WorldToViewportPoint(root.Position);if not onScreen then HideESP(player);continue end;local dist=(Camera.CFrame.Position-root.Position).Magnitude;local sf=1/(pos.Z*math.tan(math.rad(Camera.FieldOfView/2))*2)*1000;local bw,bh=4*sf,5.5*sf;local bx,by=pos.X,pos.Y;local tl=Vector2.new(bx-bw/2,by-bh/2);local tr=Vector2.new(bx+bw/2,by-bh/2);local bl=Vector2.new(bx-bw/2,by+bh/2);local br=Vector2.new(bx+bw/2,by+bh/2);esp.BoxOutline.PointA=tl;esp.BoxOutline.PointB=tr;esp.BoxOutline.PointC=br;esp.BoxOutline.PointD=bl;esp.BoxOutline.Visible=true;esp.Box.PointA=tl;esp.Box.PointB=tr;esp.Box.PointC=br;esp.Box.PointD=bl;esp.Box.Color=Settings.ESPBoxColor;esp.Box.Visible=true;if Settings.ShowName then esp.Name.Text=player.DisplayName;esp.Name.Position=Vector2.new(bx,tl.Y-16);esp.Name.Color=Color3.new(1,1,1);esp.Name.Visible=true else esp.Name.Visible=false end;local hp=hum.Health/hum.MaxHealth;if Settings.ShowHealth then esp.Health.Text=math.floor(hum.Health).." HP";esp.Health.Position=Vector2.new(tr.X+4,tr.Y);local r,g=math.floor(255*(1-hp)),math.floor(255*hp);esp.Health.Color=Color3.fromRGB(r,g,50);esp.Health.Visible=true;esp.HealthBarBG.From=Vector2.new(tl.X-5,bl.Y);esp.HealthBarBG.To=Vector2.new(tl.X-5,tl.Y);esp.HealthBarBG.Visible=true;local barH=(bl.Y-tl.Y)*hp;esp.HealthBar.From=Vector2.new(tl.X-5,bl.Y);esp.HealthBar.To=Vector2.new(tl.X-5,bl.Y-barH);esp.HealthBar.Color=Color3.fromRGB(r,g,50);esp.HealthBar.Visible=true else esp.Health.Visible=false;esp.HealthBar.Visible=false;esp.HealthBarBG.Visible=false end;if Settings.ShowDistance then esp.Distance.Text=math.floor(dist).."m";esp.Distance.Position=Vector2.new(bx,bl.Y+2);esp.Distance.Color=Color3.fromRGB(200,200,200);esp.Distance.Visible=true else esp.Distance.Visible=false end end end

local SkConn={{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}}
local SkConnR6={{"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},{"Torso","Left Leg"},{"Torso","Right Leg"}}
local SkLines={}
local function UpdateSkeleton() for _,player in ipairs(Players:GetPlayers()) do if player==LocalPlayer then continue end;if not SkLines[player] then SkLines[player]={} end;local lines=SkLines[player];local ch=player.Character;if not Settings.ShowSkeleton or not ch or not IsEnemy(player) or not IsAlive(player) then for _,l in pairs(lines) do l.Visible=false end;continue end;local conns=ch:FindFirstChild("UpperTorso") and SkConn or SkConnR6;while #lines<#conns do local l=Drawing.new("Line");l.Visible=false;l.Transparency=0.9;table.insert(lines,l) end;for i,c in ipairs(conns) do local a,b=ch:FindFirstChild(c[1]),ch:FindFirstChild(c[2]);local line=lines[i];if a and b then local pA,oA=Camera:WorldToViewportPoint(a.Position);local pB,oB=Camera:WorldToViewportPoint(b.Position);if oA and oB then line.From=Vector2.new(pA.X,pA.Y);line.To=Vector2.new(pB.X,pB.Y);line.Color=Settings.SkeletonColor;line.Thickness=Settings.SkeletonThickness;line.Visible=true else line.Visible=false end else line.Visible=false end end;for i=#conns+1,#lines do lines[i].Visible=false end end end

Players.PlayerRemoving:Connect(function(p) if ChamsObjects[p] then ChamsObjects[p]:Destroy();ChamsObjects[p]=nil end;RemoveESP(p);if SkLines[p] then for _,l in pairs(SkLines[p]) do l:Remove() end;SkLines[p]=nil end end)

------------------------------------------------------
--// GUI
------------------------------------------------------

local SG=Instance.new("ScreenGui");SG.Name="CW";SG.ResetOnSpawn=false;SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;SG.IgnoreGuiInset=true
if syn and syn.protect_gui then syn.protect_gui(SG) end;SG.Parent=game:GetService("CoreGui")

local MF=Instance.new("Frame",SG);MF.Size=UDim2.new(0,550,0,420);MF.AnchorPoint=Vector2.new(0.5,0.5);MF.Position=UDim2.new(0.5,0,0.5,0);MF.BackgroundColor3=Settings.BG;MF.BorderSizePixel=0;MF.ClipsDescendants=true;Instance.new("UICorner",MF).CornerRadius=UDim.new(0,8);Instance.new("UIStroke",MF).Color=Settings.AccentColor

local TopBar=Instance.new("Frame",MF);TopBar.Size=UDim2.new(1,0,0,40);TopBar.BackgroundColor3=Settings.SideBG;TopBar.BorderSizePixel=0;Instance.new("UICorner",TopBar).CornerRadius=UDim.new(0,8)
local TBF=Instance.new("Frame",TopBar);TBF.Size=UDim2.new(1,0,0,8);TBF.Position=UDim2.new(0,0,1,-8);TBF.BackgroundColor3=Settings.SideBG;TBF.BorderSizePixel=0
local TL=Instance.new("TextLabel",TopBar);TL.Size=UDim2.new(0,220,1,0);TL.Position=UDim2.new(0,14,0,0);TL.BackgroundTransparency=1;TL.Text="🎯 Cold War v12.2";TL.TextColor3=Color3.new(1,1,1);TL.TextSize=16;TL.Font=Enum.Font.GothamBold;TL.TextXAlignment=Enum.TextXAlignment.Left;TL.TextYAlignment=Enum.TextYAlignment.Center
local TA=Instance.new("Frame",TopBar);TA.Size=UDim2.new(1,0,0,2);TA.Position=UDim2.new(0,0,1,0);TA.BackgroundColor3=Settings.AccentColor;TA.BorderSizePixel=0;Instance.new("UIGradient",TA).Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(130,80,255)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(200,100,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(130,80,255))}

local SideBar=Instance.new("Frame",MF);SideBar.Size=UDim2.new(0,120,1,-42);SideBar.Position=UDim2.new(0,0,0,42);SideBar.BackgroundColor3=Settings.SideBG;SideBar.BorderSizePixel=0
local SBLayout=Instance.new("UIListLayout",SideBar);SBLayout.SortOrder=Enum.SortOrder.LayoutOrder;SBLayout.Padding=UDim.new(0,2)
local SBP=Instance.new("UIPadding",SideBar);SBP.PaddingTop=UDim.new(0,6);SBP.PaddingLeft=UDim.new(0,6);SBP.PaddingRight=UDim.new(0,6)

local TC=Instance.new("Frame",MF);TC.Size=UDim2.new(1,-124,1,-44);TC.Position=UDim2.new(0,122,0,42);TC.BackgroundTransparency=1
local AllTabs={};local ActiveTab=nil

local function MakeTab(icon,name,ord) local B=Instance.new("TextButton",SideBar);B.Size=UDim2.new(1,0,0,28);B.BackgroundColor3=Settings.BG;B.BorderSizePixel=0;B.Text=icon.."  "..name;B.TextColor3=Settings.DimText;B.TextSize=11;B.Font=Enum.Font.GothamMedium;B.TextXAlignment=Enum.TextXAlignment.Left;B.LayoutOrder=ord;B.AutoButtonColor=false;Instance.new("UICorner",B).CornerRadius=UDim.new(0,6);Instance.new("UIPadding",B).PaddingLeft=UDim.new(0,8);local P=Instance.new("ScrollingFrame",TC);P.Size=UDim2.new(1,-6,1,-6);P.Position=UDim2.new(0,3,0,3);P.BackgroundTransparency=1;P.BorderSizePixel=0;P.ScrollBarThickness=3;P.ScrollBarImageColor3=Settings.AccentColor;P.CanvasSize=UDim2.new(0,0,0,0);P.AutomaticCanvasSize=Enum.AutomaticSize.Y;P.Visible=false;local PL=Instance.new("UIListLayout",P);PL.SortOrder=Enum.SortOrder.LayoutOrder;PL.Padding=UDim.new(0,5);PL.HorizontalAlignment=Enum.HorizontalAlignment.Center;local t={Button=B,Page=P};table.insert(AllTabs,t);B.MouseButton1Click:Connect(function() for _,x in pairs(AllTabs) do x.Page.Visible=false;x.Button.BackgroundColor3=Settings.BG;x.Button.TextColor3=Settings.DimText end;P.Visible=true;B.BackgroundColor3=Settings.AccentColor;B.TextColor3=Color3.new(1,1,1);ActiveTab=t end);B.MouseEnter:Connect(function() if ActiveTab~=t then TweenService:Create(B,TweenInfo.new(0.12),{BackgroundColor3=Settings.HoverBG}):Play() end end);B.MouseLeave:Connect(function() if ActiveTab~=t then TweenService:Create(B,TweenInfo.new(0.12),{BackgroundColor3=Settings.BG}):Play() end end);return P end

local function Sec(p,n,o) local S=Instance.new("Frame",p);S.Size=UDim2.new(1,0,0,20);S.BackgroundTransparency=1;S.LayoutOrder=o;local L=Instance.new("TextLabel",S);L.Size=UDim2.new(1,0,1,0);L.BackgroundTransparency=1;L.Text=string.upper(n);L.TextColor3=Settings.DimText;L.TextSize=10;L.Font=Enum.Font.GothamBold;L.TextXAlignment=Enum.TextXAlignment.Left;Instance.new("UIPadding",L).PaddingLeft=UDim.new(0,4) end
local function Tog(p,n,d,o,cb) local F=Instance.new("Frame",p);F.Size=UDim2.new(1,0,0,32);F.BackgroundColor3=Settings.CardBG;F.BorderSizePixel=0;F.LayoutOrder=o;Instance.new("UICorner",F).CornerRadius=UDim.new(0,6);local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,10);Pd.PaddingRight=UDim.new(0,10);local L=Instance.new("TextLabel",F);L.Size=UDim2.new(1,-45,1,0);L.BackgroundTransparency=1;L.Text=n;L.TextColor3=Settings.TextColor;L.TextSize=12;L.Font=Enum.Font.GothamMedium;L.TextXAlignment=Enum.TextXAlignment.Left;local BG2=Instance.new("Frame",F);BG2.Size=UDim2.new(0,34,0,18);BG2.AnchorPoint=Vector2.new(1,0.5);BG2.Position=UDim2.new(1,0,0.5,0);BG2.BackgroundColor3=d and Settings.AccentColor or Color3.fromRGB(55,55,75);BG2.BorderSizePixel=0;Instance.new("UICorner",BG2).CornerRadius=UDim.new(1,0);local Ci=Instance.new("Frame",BG2);Ci.Size=UDim2.new(0,12,0,12);Ci.AnchorPoint=Vector2.new(0,0.5);Ci.Position=d and UDim2.new(1,-15,0.5,0) or UDim2.new(0,3,0.5,0);Ci.BackgroundColor3=Color3.new(1,1,1);Ci.BorderSizePixel=0;Instance.new("UICorner",Ci).CornerRadius=UDim.new(1,0);local t=d;local Btn=Instance.new("TextButton",F);Btn.Size=UDim2.new(1,20,1,0);Btn.Position=UDim2.new(0,-10,0,0);Btn.BackgroundTransparency=1;Btn.Text="";Btn.ZIndex=2;Btn.MouseButton1Click:Connect(function() t=not t;TweenService:Create(Ci,TweenInfo.new(0.12),{Position=t and UDim2.new(1,-15,0.5,0) or UDim2.new(0,3,0.5,0)}):Play();TweenService:Create(BG2,TweenInfo.new(0.12),{BackgroundColor3=t and Settings.AccentColor or Color3.fromRGB(55,55,75)}):Play();if cb then cb(t) end end) end
local function Sld(p,n,mn,mx,df,o,cb) local F=Instance.new("Frame",p);F.Size=UDim2.new(1,0,0,44);F.BackgroundColor3=Settings.CardBG;F.BorderSizePixel=0;F.LayoutOrder=o;Instance.new("UICorner",F).CornerRadius=UDim.new(0,6);local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,10);Pd.PaddingRight=UDim.new(0,10);Pd.PaddingTop=UDim.new(0,5);Pd.PaddingBottom=UDim.new(0,7);local Top=Instance.new("Frame",F);Top.Size=UDim2.new(1,0,0,16);Top.BackgroundTransparency=1;local L=Instance.new("TextLabel",Top);L.Size=UDim2.new(0.7,0,1,0);L.BackgroundTransparency=1;L.Text=n;L.TextColor3=Settings.TextColor;L.TextSize=12;L.Font=Enum.Font.GothamMedium;L.TextXAlignment=Enum.TextXAlignment.Left;local VL=Instance.new("TextLabel",Top);VL.Size=UDim2.new(0.3,0,1,0);VL.Position=UDim2.new(0.7,0,0,0);VL.BackgroundTransparency=1;VL.Text=tostring(df);VL.TextColor3=Settings.AccentColor;VL.TextSize=12;VL.Font=Enum.Font.GothamBold;VL.TextXAlignment=Enum.TextXAlignment.Right;local SB2=Instance.new("Frame",F);SB2.Size=UDim2.new(1,0,0,4);SB2.Position=UDim2.new(0,0,1,-4);SB2.AnchorPoint=Vector2.new(0,1);SB2.BackgroundColor3=Color3.fromRGB(50,50,70);SB2.BorderSizePixel=0;Instance.new("UICorner",SB2).CornerRadius=UDim.new(1,0);local pct=(df-mn)/(mx-mn);local Fill=Instance.new("Frame",SB2);Fill.Size=UDim2.new(pct,0,1,0);Fill.BackgroundColor3=Settings.AccentColor;Fill.BorderSizePixel=0;Instance.new("UICorner",Fill).CornerRadius=UDim.new(1,0);Instance.new("UIGradient",Fill).Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(100,60,220)),ColorSequenceKeypoint.new(1,Color3.fromRGB(180,100,255))};local Knob=Instance.new("Frame",SB2);Knob.Size=UDim2.new(0,12,0,12);Knob.AnchorPoint=Vector2.new(0.5,0.5);Knob.Position=UDim2.new(pct,0,0.5,0);Knob.BackgroundColor3=Color3.new(1,1,1);Knob.BorderSizePixel=0;Knob.ZIndex=3;Instance.new("UICorner",Knob).CornerRadius=UDim.new(1,0);Instance.new("UIStroke",Knob).Color=Settings.AccentColor;local isDrag=false;local CA=Instance.new("TextButton",SB2);CA.Size=UDim2.new(1,0,0,18);CA.AnchorPoint=Vector2.new(0,0.5);CA.Position=UDim2.new(0,0,0.5,0);CA.BackgroundTransparency=1;CA.Text="";CA.ZIndex=4;CA.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then isDrag=true end end);UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then isDrag=false end end);RunService.RenderStepped:Connect(function() if isDrag then local mp=UserInputService:GetMouseLocation();local rel=mp.X-SB2.AbsolutePosition.X;local p2=math.clamp(rel/SB2.AbsoluteSize.X,0,1);local v=math.floor(mn+(mx-mn)*p2);Fill.Size=UDim2.new(p2,0,1,0);Knob.Position=UDim2.new(p2,0,0.5,0);VL.Text=tostring(v);if cb then cb(v) end end end) end
local function Drp(p,n,opts,df,o,cb) local F=Instance.new("Frame",p);F.Size=UDim2.new(1,0,0,32);F.BackgroundColor3=Settings.CardBG;F.BorderSizePixel=0;F.ClipsDescendants=true;F.LayoutOrder=o;Instance.new("UICorner",F).CornerRadius=UDim.new(0,6);local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,10);Pd.PaddingRight=UDim.new(0,10);local L=Instance.new("TextLabel",F);L.Size=UDim2.new(0.5,0,0,32);L.BackgroundTransparency=1;L.Text=n;L.TextColor3=Settings.TextColor;L.TextSize=12;L.Font=Enum.Font.GothamMedium;L.TextXAlignment=Enum.TextXAlignment.Left;local SBtn=Instance.new("TextButton",F);SBtn.Size=UDim2.new(0.45,0,0,22);SBtn.AnchorPoint=Vector2.new(1,0.5);SBtn.Position=UDim2.new(1,0,0,16);SBtn.BackgroundColor3=Color3.fromRGB(50,50,70);SBtn.BorderSizePixel=0;SBtn.Text=df.." ▼";SBtn.TextColor3=Settings.AccentColor;SBtn.TextSize=10;SBtn.Font=Enum.Font.GothamMedium;SBtn.ZIndex=2;Instance.new("UICorner",SBtn).CornerRadius=UDim.new(0,4);local open=false;local btns={};for i,opt in ipairs(opts) do local OB=Instance.new("TextButton",F);OB.Size=UDim2.new(0.45,0,0,22);OB.AnchorPoint=Vector2.new(1,0);OB.Position=UDim2.new(1,0,0,28+(i-1)*26);OB.BackgroundColor3=Color3.fromRGB(45,45,65);OB.BorderSizePixel=0;OB.Text=opt;OB.TextColor3=Color3.fromRGB(200,200,210);OB.TextSize=10;OB.Font=Enum.Font.GothamMedium;OB.Visible=false;OB.ZIndex=3;Instance.new("UICorner",OB).CornerRadius=UDim.new(0,4);OB.MouseButton1Click:Connect(function() SBtn.Text=opt.." ▼";open=false;F.Size=UDim2.new(1,0,0,32);for _,b in pairs(btns) do b.Visible=false end;if cb then cb(opt) end end);OB.MouseEnter:Connect(function() OB.BackgroundColor3=Color3.fromRGB(60,60,90) end);OB.MouseLeave:Connect(function() OB.BackgroundColor3=Color3.fromRGB(45,45,65) end);table.insert(btns,OB) end;SBtn.MouseButton1Click:Connect(function() open=not open;F.Size=open and UDim2.new(1,0,0,32+#opts*26+4) or UDim2.new(1,0,0,32);for _,b in pairs(btns) do b.Visible=open end end) end
local function Kbnd(p,n,df,o) local F=Instance.new("Frame",p);F.Size=UDim2.new(1,0,0,32);F.BackgroundColor3=Settings.CardBG;F.BorderSizePixel=0;F.LayoutOrder=o;Instance.new("UICorner",F).CornerRadius=UDim.new(0,6);local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,10);Pd.PaddingRight=UDim.new(0,10);local L=Instance.new("TextLabel",F);L.Size=UDim2.new(1,-70,1,0);L.BackgroundTransparency=1;L.Text=n;L.TextColor3=Settings.TextColor;L.TextSize=12;L.Font=Enum.Font.GothamMedium;L.TextXAlignment=Enum.TextXAlignment.Left;local KB=Instance.new("TextButton",F);KB.Size=UDim2.new(0,55,0,22);KB.AnchorPoint=Vector2.new(1,0.5);KB.Position=UDim2.new(1,0,0.5,0);KB.BackgroundColor3=Color3.fromRGB(50,50,70);KB.BorderSizePixel=0;KB.Text="["..df.Name.."]";KB.TextColor3=Settings.AccentColor;KB.TextSize=10;KB.Font=Enum.Font.GothamBold;Instance.new("UICorner",KB).CornerRadius=UDim.new(0,4);local listening=false;KB.MouseButton1Click:Connect(function() listening=true;KB.Text="[...]";KB.TextColor3=Color3.fromRGB(255,200,50) end);UserInputService.InputBegan:Connect(function(inp) if listening and inp.UserInputType==Enum.UserInputType.Keyboard then listening=false;Settings.Keybind=inp.KeyCode;KB.Text="["..inp.KeyCode.Name.."]";KB.TextColor3=Settings.AccentColor end end) end
local function TPBtn(p,n,pos,o) local B=Instance.new("TextButton",p);B.Size=UDim2.new(1,0,0,28);B.BackgroundColor3=Settings.CardBG;B.BorderSizePixel=0;B.Text="  📍 "..n;B.TextColor3=Settings.TextColor;B.TextSize=11;B.Font=Enum.Font.GothamMedium;B.LayoutOrder=o;B.TextXAlignment=Enum.TextXAlignment.Left;B.AutoButtonColor=false;Instance.new("UICorner",B).CornerRadius=UDim.new(0,6);Instance.new("UIPadding",B).PaddingLeft=UDim.new(0,6);B.MouseEnter:Connect(function() TweenService:Create(B,TweenInfo.new(0.1),{BackgroundColor3=Settings.AccentColor}):Play();B.TextColor3=Color3.new(1,1,1) end);B.MouseLeave:Connect(function() TweenService:Create(B,TweenInfo.new(0.1),{BackgroundColor3=Settings.CardBG}):Play();B.TextColor3=Settings.TextColor end);B.MouseButton1Click:Connect(function() SmoothTP(pos) end) end
local function PlayerTPBtn(p,pn,o) local B=Instance.new("TextButton",p);B.Size=UDim2.new(1,0,0,28);B.BackgroundColor3=Settings.CardBG;B.BorderSizePixel=0;B.Text="  👤 "..pn;B.TextColor3=Settings.TextColor;B.TextSize=11;B.Font=Enum.Font.GothamMedium;B.LayoutOrder=o;B.TextXAlignment=Enum.TextXAlignment.Left;B.AutoButtonColor=false;Instance.new("UICorner",B).CornerRadius=UDim.new(0,6);Instance.new("UIPadding",B).PaddingLeft=UDim.new(0,6);B.MouseEnter:Connect(function() TweenService:Create(B,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(180,80,40)}):Play();B.TextColor3=Color3.new(1,1,1) end);B.MouseLeave:Connect(function() TweenService:Create(B,TweenInfo.new(0.1),{BackgroundColor3=Settings.CardBG}):Play();B.TextColor3=Settings.TextColor end);B.MouseButton1Click:Connect(function() local target=Players:FindFirstChild(pn);if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then SmoothTP(target.Character.HumanoidRootPart.Position+target.Character.HumanoidRootPart.CFrame.LookVector*-5) end end);return B end

local StatusLabel,StatusDot,TargetLabel
local function MkStatus(p,o) local F=Instance.new("Frame",p);F.Size=UDim2.new(1,0,0,40);F.BackgroundColor3=Settings.CardBG;F.BorderSizePixel=0;F.LayoutOrder=o;Instance.new("UICorner",F).CornerRadius=UDim.new(0,6);local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,10);Pd.PaddingRight=UDim.new(0,10);Pd.PaddingTop=UDim.new(0,5);Pd.PaddingBottom=UDim.new(0,5);StatusDot=Instance.new("Frame",F);StatusDot.Size=UDim2.new(0,8,0,8);StatusDot.Position=UDim2.new(0,0,0,5);StatusDot.BackgroundColor3=Color3.fromRGB(255,60,60);StatusDot.BorderSizePixel=0;Instance.new("UICorner",StatusDot).CornerRadius=UDim.new(1,0);StatusLabel=Instance.new("TextLabel",F);StatusLabel.Size=UDim2.new(1,-14,0,14);StatusLabel.Position=UDim2.new(0,14,0,0);StatusLabel.BackgroundTransparency=1;StatusLabel.Text="DISABLED";StatusLabel.TextColor3=Color3.fromRGB(255,60,60);StatusLabel.TextSize=11;StatusLabel.Font=Enum.Font.GothamBold;StatusLabel.TextXAlignment=Enum.TextXAlignment.Left;TargetLabel=Instance.new("TextLabel",F);TargetLabel.Size=UDim2.new(1,0,0,12);TargetLabel.Position=UDim2.new(0,0,0,16);TargetLabel.BackgroundTransparency=1;TargetLabel.Text="Target: None";TargetLabel.TextColor3=Settings.DimText;TargetLabel.TextSize=10;TargetLabel.Font=Enum.Font.GothamMedium;TargetLabel.TextXAlignment=Enum.TextXAlignment.Left end

------------------------------------------------------
--// BUILD TABS
------------------------------------------------------

local AP=MakeTab("🎯","Aimbot",1);local EP=MakeTab("👁","ESP",2);local CP=MakeTab("⛪","Church",3);local SP=MakeTab("🔫","Sniper",4);local TP2=MakeTab("📍","Teleport",5);local MP=MakeTab("🏃","Player",6);local StP=MakeTab("⚙","Settings",7)
AllTabs[1].Button.BackgroundColor3=Settings.AccentColor;AllTabs[1].Button.TextColor3=Color3.new(1,1,1);AllTabs[1].Page.Visible=true;ActiveTab=AllTabs[1]

do local o=0;local function n() o=o+1;return o end
    Sec(AP,"Silent Aim",n())
    Tog(AP,"Enabled",false,n(),function(s) Settings.Enabled=s end)
    Sld(AP,"FOV Radius",10,500,Settings.FOV,n(),function(v) Settings.FOV=v;FOVCircle.Radius=v end)
    Tog(AP,"Show FOV",true,n(),function(s) Settings.ShowFOV=s end)
    Drp(AP,"Target Part",{"Head","HumanoidRootPart","UpperTorso"},Settings.TargetPart,n(),function(v) Settings.TargetPart=v end)
    Tog(AP,"Wall Check",true,n(),function(s) Settings.WallCheck=s end)
    Sec(AP,"Weapon Mods",n())
    Tog(AP,"No Recoil (no work)",false,n(),function(s) Settings.NoRecoil=s end)
    Tog(AP,"No Spread (no work)",false,n(),function(s) Settings.NoSpread=s end)
    Tog(AP,"No Bullet Spread",false,n(),function(s) Settings.NoBulletSpread=s;patchedModules={};lastPatchTick=0 end)
    Sec(AP,"Status",n())
    MkStatus(AP,n())
end
do local o=0;local function n() o=o+1;return o end;Sec(EP,"Box ESP",n());Tog(EP,"ESP Boxes",true,n(),function(s) Settings.ShowESP=s end);Tog(EP,"Names",true,n(),function(s) Settings.ShowName=s end);Tog(EP,"Health",true,n(),function(s) Settings.ShowHealth=s end);Tog(EP,"Distance",true,n(),function(s) Settings.ShowDistance=s end);Sec(EP,"Skeleton",n());Tog(EP,"Skeleton ESP",true,n(),function(s) Settings.ShowSkeleton=s end);Sld(EP,"Thickness",1,4,2,n(),function(v) Settings.SkeletonThickness=v end);Sec(EP,"Chams",n());Tog(EP,"Chams",true,n(),function(s) Settings.ShowChams=s end) end
do local o=0;local function n() o=o+1;return o end;Sec(CP,"Church Locations",n());for _,loc in ipairs(ColdWarLocations.Church) do TPBtn(CP,loc.name,loc.pos,n()) end end
do local o=0;local function n() o=o+1;return o end;Sec(SP,"Sniper Spots",n());for _,loc in ipairs(ColdWarLocations.Sniper) do TPBtn(SP,loc.name,loc.pos,n()) end end

do local o=0;local function n() o=o+1;return o end
    local TPE=Instance.new("TextButton",TP2);TPE.Size=UDim2.new(1,0,0,28);TPE.BackgroundColor3=Color3.fromRGB(180,50,50);TPE.BorderSizePixel=0;TPE.Text="  👤 TP Nearest Enemy";TPE.TextColor3=Color3.new(1,1,1);TPE.TextSize=11;TPE.Font=Enum.Font.GothamBold;TPE.LayoutOrder=n();TPE.AutoButtonColor=false;Instance.new("UICorner",TPE).CornerRadius=UDim.new(0,6)
    TPE.MouseEnter:Connect(function() TweenService:Create(TPE,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(220,60,60)}):Play() end);TPE.MouseLeave:Connect(function() TweenService:Create(TPE,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(180,50,50)}):Play() end)
    TPE.MouseButton1Click:Connect(function() local cl,cd2=nil,math.huge;for _,pl in ipairs(Players:GetPlayers()) do if pl~=LocalPlayer and IsAlive(pl) and IsEnemy(pl) then local r=pl.Character and pl.Character:FindFirstChild("HumanoidRootPart");local mr=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");if r and mr then local d=(mr.Position-r.Position).Magnitude;if d<cd2 then cd2=d;cl=pl end end end end;if cl and cl.Character then local r=cl.Character:FindFirstChild("HumanoidRootPart");if r then SmoothTP(r.Position+r.CFrame.LookVector*-5) end end end)
    Sec(TP2,"General",n());for _,loc in ipairs(ColdWarLocations.General) do TPBtn(TP2,loc.name,loc.pos,n()) end
    Sec(TP2,"TP to Player",n());local playerButtons={};local RefBtn=Instance.new("TextButton",TP2);RefBtn.Size=UDim2.new(1,0,0,28);RefBtn.BackgroundColor3=Color3.fromRGB(50,120,180);RefBtn.BorderSizePixel=0;RefBtn.Text="🔄 Refresh Players";RefBtn.TextColor3=Color3.new(1,1,1);RefBtn.TextSize=11;RefBtn.Font=Enum.Font.GothamBold;RefBtn.LayoutOrder=n();RefBtn.AutoButtonColor=false;Instance.new("UICorner",RefBtn).CornerRadius=UDim.new(0,6)
    local function RP() for _,btn in ipairs(playerButtons) do btn:Destroy() end;playerButtons={};local so=200;for _,player in ipairs(Players:GetPlayers()) do if player~=LocalPlayer then so=so+1;table.insert(playerButtons,PlayerTPBtn(TP2,player.Name,so)) end end end
    RefBtn.MouseButton1Click:Connect(function() RefBtn.Text="🔄 ...";RP();RefBtn.Text="✅ Done!";task.wait(1);RefBtn.Text="🔄 Refresh Players" end);RP()
end

do local o=0;local function n() o=o+1;return o end;Sec(MP,"Movement",n());Tog(MP,"WalkSpeed Enabled",false,n(),function(s) Settings.WalkSpeedEnabled=s end);Sld(MP,"WalkSpeed",16,200,16,n(),function(v) Settings.WalkSpeed=v end);Tog(MP,"Infinite Jump",false,n(),function(s) Settings.InfJump=s end);Sec(MP,"Fly",n());Tog(MP,"Fly (F key)",false,n(),function(s) Settings.Fly=s;if s then StartFly() else StopFly() end end);Sld(MP,"Fly Speed",10,300,50,n(),function(v) Settings.FlySpeed=v end);Sec(MP,"Safety",n());Tog(MP,"No Fall Damage",false,n(),function(s) Settings.NoFallDamage=s;if s then SetupNoFallDamage() end end);Sec(MP,"Infinite Ammo",n());Tog(MP,"Inf Ammo (Rifles/SMGs)",false,n(),function(s) Settings.InfAmmo=s;RefreshAmmoMonitor() end);Tog(MP,"Inf RPG / Launchers",false,n(),function(s) Settings.InfRPG=s;RefreshAmmoMonitor() end);Tog(MP,"Inf GP-25 / Grenadier",false,n(),function(s) Settings.InfGP25=s;RefreshAmmoMonitor() end) end

do local o=0;local function n() o=o+1;return o end;Sec(StP,"General",n());Tog(StP,"Team Check",true,n(),function(s) Settings.TeamCheck=s end);Kbnd(StP,"Aim Toggle",Settings.Keybind,n());Sec(StP,"Debug",n())
    local SvBtn=Instance.new("TextButton",StP);SvBtn.Size=UDim2.new(1,0,0,28);SvBtn.BackgroundColor3=Color3.fromRGB(50,120,80);SvBtn.BorderSizePixel=0;SvBtn.Text="💾 Print Position (F9)";SvBtn.TextColor3=Color3.new(1,1,1);SvBtn.TextSize=11;SvBtn.Font=Enum.Font.GothamBold;SvBtn.LayoutOrder=n();SvBtn.AutoButtonColor=false;Instance.new("UICorner",SvBtn).CornerRadius=UDim.new(0,6);SvBtn.MouseButton1Click:Connect(function() local ch=LocalPlayer.Character;if ch and ch:FindFirstChild("HumanoidRootPart") then local p=ch.HumanoidRootPart.Position;print(string.format('{name="Spot",pos=Vector3.new(%.1f,%.1f,%.1f)},',p.X,p.Y,p.Z));SvBtn.Text="✅ Printed!";task.wait(1.5);SvBtn.Text="💾 Print Position (F9)" end end)
    local WpnDbg=Instance.new("TextButton",StP);WpnDbg.Size=UDim2.new(1,0,0,28);WpnDbg.BackgroundColor3=Color3.fromRGB(180,120,50);WpnDbg.BorderSizePixel=0;WpnDbg.Text="🔫 Weapon Debug (F9)";WpnDbg.TextColor3=Color3.new(1,1,1);WpnDbg.TextSize=11;WpnDbg.Font=Enum.Font.GothamBold;WpnDbg.LayoutOrder=n();WpnDbg.AutoButtonColor=false;Instance.new("UICorner",WpnDbg).CornerRadius=UDim.new(0,6);WpnDbg.MouseButton1Click:Connect(function() print("\n=== WEAPON DEBUG ===");local ch=LocalPlayer.Character;if ch then for _,tool in ipairs(ch:GetChildren()) do if tool:IsA("Tool") then print("--- "..tool.Name.." ---");for _,desc in ipairs(tool:GetDescendants()) do local info="  ["..desc.ClassName.."] "..desc.Name;if desc:IsA("ValueBase") then info=info.." = "..tostring(desc.Value) end;print(info) end end end end;print("=== END ===\n");WpnDbg.Text="✅ F9!";task.wait(1.5);WpnDbg.Text="🔫 Weapon Debug (F9)" end)
    Sec(StP,"Danger Zone",n());local DB=Instance.new("TextButton",StP);DB.Size=UDim2.new(1,0,0,28);DB.BackgroundColor3=Color3.fromRGB(180,40,40);DB.BorderSizePixel=0;DB.Text="🗑 Destroy";DB.TextColor3=Color3.new(1,1,1);DB.TextSize=12;DB.Font=Enum.Font.GothamBold;DB.LayoutOrder=n();DB.AutoButtonColor=false;Instance.new("UICorner",DB).CornerRadius=UDim.new(0,6);DB.MouseButton1Click:Connect(function() Settings.Enabled=false;Settings.ShowFOV=false;Settings.ShowESP=false;Settings.ShowSkeleton=false;Settings.ShowChams=false;Settings.NoRecoil=false;Settings.NoSpread=false;Settings.NoBulletSpread=false;Settings.InfAmmo=false;Settings.InfRPG=false;Settings.InfGP25=false;if flying then StopFly() end;FOVCircle:Remove();for _,conn in pairs(ammoConnections) do if typeof(conn)=="RBXScriptConnection" and conn.Connected then conn:Disconnect() end end;for _,conn in pairs(magConnections) do if typeof(conn)=="RBXScriptConnection" and conn.Connected then conn:Disconnect() end end;for _,p in ipairs(Players:GetPlayers()) do if ChamsObjects[p] then ChamsObjects[p]:Destroy() end;if ESPObjects[p] then for _,obj in pairs(ESPObjects[p]) do obj:Remove() end end;if SkLines[p] then for _,l in pairs(SkLines[p]) do l:Remove() end end end;SG:Destroy() end)
end

------------------------------------------------------
--// DRAGGING
------------------------------------------------------

do local dr,di,ds,sp;TopBar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true;ds=i.Position;sp=MF.Position;i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dr=false end end) end end);TopBar.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement then di=i end end);UserInputService.InputChanged:Connect(function(i) if i==di and dr then local d=i.Position-ds;MF.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y) end end) end

------------------------------------------------------
--// RENDER
------------------------------------------------------

local function GetClosestPlayer() local cl,cp=nil,nil;local sh=Settings.FOV;local mP=GetMouseViewportPos();for _,p in ipairs(Players:GetPlayers()) do if p~=LocalPlayer and IsAlive(p) and IsEnemy(p) then local ch=p.Character;local part=ch:FindFirstChild(Settings.TargetPart) or ch:FindFirstChild("HumanoidRootPart");if part then if Settings.WallCheck and not IsVisible(part) then continue end;local sp2,on=Camera:WorldToViewportPoint(part.Position);if on then local d=(mP-Vector2.new(sp2.X,sp2.Y)).Magnitude;if d<sh then sh=d;cl=p;cp=part.Position end end end end end;return cl,cp end

RunService.RenderStepped:Connect(function()
    Camera=workspace.CurrentCamera;local mP=GetMouseViewportPos()
    FOVCircle.Position=mP;FOVCircle.Radius=Settings.FOV;FOVCircle.Visible=Settings.ShowFOV
    FOVCircle.Color=Settings.Enabled and Settings.AccentColor or Settings.FOVColor
    if Settings.Enabled then local t,p=GetClosestPlayer();CurrentTarget=t;CachedTargetPosition=p
    else CurrentTarget=nil;CachedTargetPosition=nil end
    if (Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25) and tick()-lastPatchTick>2 then lastPatchTick=tick();task.defer(PatchAllModules) end
    UpdateSkeleton();UpdateESP();UpdateChams();UpdateFly();UpdateWalkSpeed();UpdateNoFallDamage()
    if StatusLabel then if Settings.Enabled then StatusLabel.Text="ENABLED";StatusLabel.TextColor3=Color3.fromRGB(80,255,80);StatusDot.BackgroundColor3=Color3.fromRGB(80,255,80) else StatusLabel.Text="DISABLED";StatusLabel.TextColor3=Color3.fromRGB(255,60,60);StatusDot.BackgroundColor3=Color3.fromRGB(255,60,60) end;if CurrentTarget then TargetLabel.Text="Target: "..CurrentTarget.Name;TargetLabel.TextColor3=Settings.AccentColor else TargetLabel.Text="Target: None";TargetLabel.TextColor3=Settings.DimText end end
end)

------------------------------------------------------
--// HOOKS
------------------------------------------------------

local HM={FindPartOnRayWithIgnoreList=true,FindPartOnRay=true,FindPartOnRayWithWhitelist=true,Raycast=true}
local oldNC;oldNC=hookmetamethod(game,"__namecall",newcclosure(function(self,...)
    local m=getnamecallmethod()
    if HM[m] and self==workspace then
        local needAim=Settings.Enabled and CachedTargetPosition;local needNBS=Settings.NoBulletSpread
        if needAim or needNBS then local a={...};local origin,direction,magnitude
            if m=="Raycast" then if typeof(a[1])=="Vector3" and typeof(a[2])=="Vector3" then origin=a[1];direction=a[2];magnitude=a[2].Magnitude end
            else if typeof(a[1])=="Ray" then origin=a[1].Origin;direction=a[1].Direction;magnitude=a[1].Direction.Magnitude end end
            if origin and direction then local newDir
                if needAim and CachedTargetPosition then newDir=(CachedTargetPosition-origin).Unit*magnitude
                elseif needNBS then local cam=workspace.CurrentCamera;if cam then newDir=cam.CFrame.LookVector*magnitude end end
                if newDir then if m=="Raycast" then a[2]=newDir;return oldNC(self,unpack(a)) else a[1]=Ray.new(origin,newDir);return oldNC(self,unpack(a)) end end end end
    end
    if Settings.NoFallDamage and (m=="FireServer" or m=="InvokeServer") then local rn="";pcall(function() rn=self.Name:lower() end);if rn=="falldamage" or rn=="fall_damage" then return nil end end
    return oldNC(self,...)
end))

local oldNI;oldNI=hookmetamethod(game,"__newindex",newcclosure(function(self,key,value)
    if not (Settings.NoBulletSpread or Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25 or Settings.NoFallDamage) then return oldNI(self,key,value) end
    if typeof(self) ~= "Instance" then return oldNI(self,key,value) end
    local isCamera = false
    pcall(function() isCamera = (self == workspace.CurrentCamera) or self:IsDescendantOf(workspace.CurrentCamera) end)
    if isCamera then return oldNI(self,key,value) end
    local isGui = false
    pcall(function() isGui = self:IsA("GuiObject") or self:IsA("GuiBase") or self:IsA("ScreenGui") or self:IsA("LayerCollector") end)
    if isGui then return oldNI(self,key,value) end
    local kl = tostring(key):lower()
    if Settings.NoBulletSpread then
        if kl == "spread" or kl == "bloom" or kl == "deviation" or kl == "cone" then
            if typeof(value) == "number" then return oldNI(self,key,0)
            elseif typeof(value) == "Vector3" then return oldNI(self,key,Vector3.new(0,0,0))
            elseif typeof(value) == "Vector2" then return oldNI(self,key,Vector2.new(0,0)) end
        end
    end
    if Settings.NoFallDamage then
        if kl == "falldamage" or kl == "fall_damage" then
            if typeof(value) == "number" then return oldNI(self,key,0)
            elseif typeof(value) == "boolean" then return oldNI(self,key,false) end
        end
    end
    if Settings.InfAmmo or Settings.InfRPG or Settings.InfGP25 then
        local isWeapon = false
        pcall(function() isWeapon = IsInsideWeapon(self) end)
        if isWeapon and IsAmmoName(tostring(key)) then
            if typeof(value) == "number" and value >= 0 then
                local cv = 999
                pcall(function() cv = self[key] end)
                if type(cv) == "number" and value < cv then
                    return oldNI(self,key,cv)
                end
            end
        end
    end
    return oldNI(self,key,value)
end))

------------------------------------------------------
--// INPUT
------------------------------------------------------

UserInputService.InputBegan:Connect(function(i,g) if g then return end
    if i.KeyCode==Settings.Keybind then Settings.Enabled=not Settings.Enabled end
    if i.KeyCode==Enum.KeyCode.Insert then MF.Visible=not MF.Visible end
    if i.KeyCode==Enum.KeyCode.F and Settings.Fly then if flying then StopFly() else StartFly() end end
end)

------------------------------------------------------
--// NOTIFICATION
------------------------------------------------------

local N=Instance.new("Frame",SG);N.Size=UDim2.new(0,380,0,34);N.AnchorPoint=Vector2.new(0.5,0);N.Position=UDim2.new(0.5,0,0,-40);N.BackgroundColor3=Settings.SideBG;N.BorderSizePixel=0;Instance.new("UICorner",N).CornerRadius=UDim.new(0,6);Instance.new("UIStroke",N).Color=Settings.AccentColor
local NTx=Instance.new("TextLabel",N);NTx.Size=UDim2.new(1,0,1,0);NTx.BackgroundTransparency=1;NTx.Text="🎯 Cold War v12.2 | Insert=Menu | X=Aim | Authenticated ✅";NTx.TextColor3=Color3.new(1,1,1);NTx.TextSize=10;NTx.Font=Enum.Font.GothamMedium;NTx.TextXAlignment=Enum.TextXAlignment.Center
TweenService:Create(N,TweenInfo.new(0.5,Enum.EasingStyle.Back),{Position=UDim2.new(0.5,0,0,10)}):Play()
task.delay(4,function() TweenService:Create(N,TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Position=UDim2.new(0.5,0,0,-45)}):Play();task.wait(0.5);N:Destroy() end)

print("[Cold War v12.2] All systems operational! Key authenticated.")
