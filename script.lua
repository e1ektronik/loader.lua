--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local GuiInset = GuiService:GetGuiInset()

local function GetMouseViewportPos()
    return Vector2.new(Mouse.X, Mouse.Y + GuiInset.Y)
end

--// Settings
local Settings = {
    Enabled = false,
    FOV = 100,
    ShowFOV = true,
    TargetPart = "Head",
    Keybind = Enum.KeyCode.X,
    TeamCheck = true,
    WallCheck = true,

    ShowSkeleton = true,
    SkeletonColor = Color3.fromRGB(130, 80, 255),
    SkeletonThickness = 1.5,

    ShowESP = true,
    ESPBoxColor = Color3.fromRGB(130, 80, 255),
    ShowName = true,
    ShowHealth = true,
    ShowDistance = true,

    ShowChams = true,
    ChamsFillColor = Color3.fromRGB(130, 80, 255),
    ChamsFillTransparency = 0.6,
    ChamsOutlineColor = Color3.fromRGB(200, 130, 255),
    ChamsOutlineTransparency = 0.3,

    AccentColor = Color3.fromRGB(130, 80, 255),
    FOVColor = Color3.fromRGB(255, 50, 50),
    BG = Color3.fromRGB(20, 20, 30),
    SideBG = Color3.fromRGB(28, 28, 40),
    CardBG = Color3.fromRGB(35, 35, 50),
    HoverBG = Color3.fromRGB(45, 45, 65),
    TextColor = Color3.fromRGB(220, 220, 230),
    DimText = Color3.fromRGB(120, 120, 150),
}

local CachedTargetPosition = nil
local CurrentTarget = nil

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5; FOVCircle.NumSides = 64; FOVCircle.Radius = Settings.FOV
FOVCircle.Filled = false; FOVCircle.Visible = Settings.ShowFOV; FOVCircle.ZIndex = 999
FOVCircle.Transparency = 0.8; FOVCircle.Color = Settings.FOVColor

------------------------------------------------------
--// HELPERS
------------------------------------------------------

local function IsEnemy(player)
    if player == LocalPlayer then return false end
    if not Settings.TeamCheck then return true end
    if not LocalPlayer.Team or not player.Team then return true end
    return LocalPlayer.Team ~= player.Team
end

local function IsAlive(player)
    local ch = player.Character
    if not ch then return false end
    local hum = ch:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0
end

local function IsVisible(targetPart)
    if not Settings.WallCheck then return true end
    local ch = LocalPlayer.Character
    if not ch then return true end
    local head = ch:FindFirstChild("Head")
    if not head then return true end
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Blacklist
    rp.FilterDescendantsInstances = {ch, targetPart.Parent}
    local result = workspace:Raycast(head.Position, targetPart.Position - head.Position, rp)
    return result == nil
end

------------------------------------------------------
--// SAFE TELEPORT
------------------------------------------------------

local function SafeTeleport(pos)
    local ch = LocalPlayer.Character
    if not ch then return end
    local root = ch:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local targetPos = typeof(pos) == "CFrame" and pos.Position or pos

    root.CFrame = CFrame.new(targetPos + Vector3.new(0, 50, 0))
    root.Velocity = Vector3.new(0, 0, 0)
    if root.AssemblyLinearVelocity then
        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end

    task.wait(0.2)

    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Blacklist
    rp.FilterDescendantsInstances = {ch}

    local result = workspace:Raycast(targetPos + Vector3.new(0, 50, 0), Vector3.new(0, -300, 0), rp)
    if result then
        root.CFrame = CFrame.new(result.Position + Vector3.new(0, 4, 0))
    else
        root.CFrame = CFrame.new(targetPos + Vector3.new(0, 5, 0))
    end
    root.Velocity = Vector3.new(0, 0, 0)
    if root.AssemblyLinearVelocity then
        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end
end

------------------------------------------------------
--// SMART LOCATION FINDER
------------------------------------------------------

local function FindPartByName(searchName)
    searchName = searchName:lower()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name:lower():find(searchName) then
            if obj:IsA("BasePart") then
                return obj.Position + Vector3.new(0, 5, 0)
            elseif obj:IsA("Model") then
                local p = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if p then return p.Position + Vector3.new(0, 5, 0) end
            end
        end
    end
    return nil
end

local function FindHighPoint(centerPos, radius)
    local highest = nil
    local highestY = -math.huge
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Size.X > 2 and obj.Size.Z > 2 then
            local dist = (Vector2.new(obj.Position.X, obj.Position.Z) - Vector2.new(centerPos.X, centerPos.Z)).Magnitude
            if dist < radius and obj.Position.Y > highestY then
                highestY = obj.Position.Y
                highest = obj.Position + Vector3.new(0, 5, 0)
            end
        end
    end
    return highest
end

local function FindSpawns()
    local spawns = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("SpawnLocation") then
            table.insert(spawns, obj.Position)
        end
    end
    return spawns
end

local function GetMapCenter()
    local parts = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Size.Magnitude > 5 then
            table.insert(parts, obj.Position)
            if #parts > 200 then break end
        end
    end
    if #parts == 0 then return Vector3.new(0, 50, 0) end
    local avg = Vector3.new(0,0,0)
    for _, p in ipairs(parts) do avg = avg + p end
    return avg / #parts
end

------------------------------------------------------
--// COLD WAR TELEPORT LOCATIONS
------------------------------------------------------
-- Позиции определяются автоматически через поиск объектов на карте
-- Если не находит — использует умный поиск высоких точек

local function BuildColdWarLocations()
    local mapCenter = GetMapCenter()
    local spawns = FindSpawns()

    -- Группируем спавны по командам
    local spawnGroups = {}
    for _, sp in ipairs(spawns) do
        local added = false
        for _, g in ipairs(spawnGroups) do
            if (sp - g[1]).Magnitude < 60 then
                table.insert(g, sp); added = true; break
            end
        end
        if not added then table.insert(spawnGroups, {sp}) end
    end

    local function AvgPos(group)
        local a = Vector3.new(0,0,0)
        for _, p in ipairs(group) do a = a + p end
        return a / #group
    end

    -- Определяем стороны Boris и Vasily по спавнам
    local borisCenter, vasilyCenter

    if #spawnGroups >= 2 then
        local g1 = AvgPos(spawnGroups[1])
        local g2 = AvgPos(spawnGroups[2])
        borisCenter = g1
        vasilyCenter = g2
    else
        borisCenter = mapCenter + Vector3.new(150, 0, 0)
        vasilyCenter = mapCenter - Vector3.new(150, 0, 0)
    end

    local locations = {
        Boris = {},
        Vasily = {},
        Church = {},
        Sniper = {},
        General = {},
    }

    -- ===== BORIS SIDE =====
    table.insert(locations.Boris, {
        name = "Boris Spawn",
        pos = borisCenter + Vector3.new(0, 5, 0)
    })

    local borisHigh = FindHighPoint(borisCenter, 80)
    if borisHigh then
        table.insert(locations.Boris, {name = "Boris Rooftop", pos = borisHigh})
    end

    local borisNames = {"boris", "teamb", "team_b", "team2"}
    for _, search in ipairs(borisNames) do
        local found = FindPartByName(search)
        if found then
            table.insert(locations.Boris, {name = "Boris Area", pos = found})
            break
        end
    end

    -- Точки вокруг Boris спавна
    table.insert(locations.Boris, {
        name = "Boris Left Flank",
        pos = borisCenter + Vector3.new(0, 5, 50)
    })
    table.insert(locations.Boris, {
        name = "Boris Right Flank",
        pos = borisCenter + Vector3.new(0, 5, -50)
    })
    table.insert(locations.Boris, {
        name = "Boris Forward",
        pos = borisCenter + Vector3.new(-40, 5, 0)
    })

    -- ===== VASILY SIDE =====
    table.insert(locations.Vasily, {
        name = "Vasily Spawn",
        pos = vasilyCenter + Vector3.new(0, 5, 0)
    })

    local vasilyHigh = FindHighPoint(vasilyCenter, 80)
    if vasilyHigh then
        table.insert(locations.Vasily, {name = "Vasily Rooftop", pos = vasilyHigh})
    end

    local vasilyNames = {"vasily", "teama", "team_a", "team1"}
    for _, search in ipairs(vasilyNames) do
        local found = FindPartByName(search)
        if found then
            table.insert(locations.Vasily, {name = "Vasily Area", pos = found})
            break
        end
    end

    table.insert(locations.Vasily, {
        name = "Vasily Left Flank",
        pos = vasilyCenter + Vector3.new(0, 5, 50)
    })
    table.insert(locations.Vasily, {
        name = "Vasily Right Flank",
        pos = vasilyCenter + Vector3.new(0, 5, -50)
    })
    table.insert(locations.Vasily, {
        name = "Vasily Forward",
        pos = vasilyCenter + Vector3.new(40, 5, 0)
    })

    -- ===== CHURCH =====
    local churchNames = {"church", "chapel", "cathedral", "bell", "steeple"}
    local churchFound = false
    for _, search in ipairs(churchNames) do
        local found = FindPartByName(search)
        if found then
            table.insert(locations.Church, {name = "Church Ground", pos = found})
            table.insert(locations.Church, {name = "Church Tower", pos = found + Vector3.new(0, 30, 0)})
            table.insert(locations.Church, {name = "Church Roof", pos = found + Vector3.new(0, 20, 0)})
            table.insert(locations.Church, {name = "Church Back", pos = found + Vector3.new(-15, 0, 0)})
            table.insert(locations.Church, {name = "Church Front", pos = found + Vector3.new(15, 0, 0)})
            table.insert(locations.Church, {name = "Church Left", pos = found + Vector3.new(0, 0, 15)})
            table.insert(locations.Church, {name = "Church Right", pos = found + Vector3.new(0, 0, -15)})
            churchFound = true
            break
        end
    end

    if not churchFound then
        local churchGuess = mapCenter + Vector3.new(0, 0, 0)
        local highestMid = FindHighPoint(mapCenter, 50)
        if highestMid then
            table.insert(locations.Church, {name = "Church (Est.)", pos = highestMid})
            table.insert(locations.Church, {name = "Church Tower (Est.)", pos = highestMid + Vector3.new(0, 25, 0)})
        end
        table.insert(locations.Church, {name = "Mid Building", pos = churchGuess + Vector3.new(0, 15, 0)})
    end

    -- ===== SNIPER SPOTS =====
    local sniperNames = {"sniper", "tower", "watchtower", "lookout", "scope"}
    for _, search in ipairs(sniperNames) do
        local found = FindPartByName(search)
        if found then
            table.insert(locations.Sniper, {name = "Sniper: " .. search, pos = found})
        end
    end

    -- Находим 5 самых высоких платформ как снайперские позиции
    local allPlatforms = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Size.X > 3 and obj.Size.Z > 3 and obj.Position.Y > 30 then
            table.insert(allPlatforms, obj)
        end
    end
    table.sort(allPlatforms, function(a,b) return a.Position.Y > b.Position.Y end)

    local usedSniper = {}
    local sniperIdx = 1
    for _, part in ipairs(allPlatforms) do
        if sniperIdx > 5 then break end
        local tooClose = false
        for _, used in ipairs(usedSniper) do
            if (part.Position - used).Magnitude < 40 then tooClose = true; break end
        end
        if not tooClose then
            table.insert(usedSniper, part.Position)
            table.insert(locations.Sniper, {
                name = "Sniper Spot " .. sniperIdx,
                pos = part.Position + Vector3.new(0, 5, 0)
            })
            sniperIdx = sniperIdx + 1
        end
    end

    -- ===== GENERAL =====
    table.insert(locations.General, {name = "Map Center", pos = mapCenter + Vector3.new(0, 10, 0)})

    local generalNames = {
        {"bridge", "Bridge"}, {"bunker", "Bunker"}, {"warehouse", "Warehouse"},
        {"garage", "Garage"}, {"house", "House"}, {"building", "Building"},
        {"truck", "Truck"}, {"tank", "Tank"}, {"gate", "Gate"},
        {"wall", "Wall Cover"}, {"stairs", "Stairs"}, {"window", "Window"},
        {"crate", "Crate Spot"}, {"barrel", "Barrel"}, {"sandbag", "Sandbag"},
    }

    local generalFound = {}
    for _, data in ipairs(generalNames) do
        if #locations.General > 12 then break end
        local found = FindPartByName(data[1])
        if found and not generalFound[data[2]] then
            generalFound[data[2]] = true
            table.insert(locations.General, {name = data[2], pos = found})
        end
    end

    return locations
end

local ColdWarLocations = BuildColdWarLocations()

------------------------------------------------------
--// CHAMS
------------------------------------------------------

local ChamsObjects = {}
local function UpdateChams()
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local ch = player.Character
        if not Settings.ShowChams or not ch or not IsEnemy(player) or not IsAlive(player) then
            if ChamsObjects[player] then ChamsObjects[player]:Destroy(); ChamsObjects[player] = nil end
            continue
        end
        if not ChamsObjects[player] then
            local h = Instance.new("Highlight")
            h.FillColor = Settings.ChamsFillColor; h.FillTransparency = Settings.ChamsFillTransparency
            h.OutlineColor = Settings.ChamsOutlineColor; h.OutlineTransparency = Settings.ChamsOutlineTransparency
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; h.Parent = ch
            ChamsObjects[player] = h
        else
            local h = ChamsObjects[player]
            if h.Parent ~= ch then h.Parent = ch end
            h.FillColor = Settings.ChamsFillColor; h.FillTransparency = Settings.ChamsFillTransparency
            h.OutlineColor = Settings.ChamsOutlineColor; h.OutlineTransparency = Settings.ChamsOutlineTransparency
        end
    end
end

------------------------------------------------------
--// ESP
------------------------------------------------------

local ESPObjects = {}
local function GetESP(player)
    if not ESPObjects[player] then
        ESPObjects[player] = {
            BoxOutline = Drawing.new("Quad"), Box = Drawing.new("Quad"),
            Name = Drawing.new("Text"), Health = Drawing.new("Text"),
            Distance = Drawing.new("Text"), HealthBar = Drawing.new("Line"),
            HealthBarBG = Drawing.new("Line"),
        }
        local e = ESPObjects[player]
        e.BoxOutline.Thickness=3;e.BoxOutline.Color=Color3.new(0,0,0);e.BoxOutline.Filled=false;e.BoxOutline.Visible=false
        e.Box.Thickness=1.2;e.Box.Color=Settings.ESPBoxColor;e.Box.Filled=false;e.Box.Visible=false
        e.Name.Size=13;e.Name.Center=true;e.Name.Outline=true;e.Name.OutlineColor=Color3.new(0,0,0);e.Name.Font=2;e.Name.Visible=false
        e.Health.Size=12;e.Health.Center=false;e.Health.Outline=true;e.Health.OutlineColor=Color3.new(0,0,0);e.Health.Font=2;e.Health.Visible=false
        e.Distance.Size=12;e.Distance.Center=true;e.Distance.Outline=true;e.Distance.OutlineColor=Color3.new(0,0,0);e.Distance.Font=2;e.Distance.Visible=false
        e.HealthBarBG.Thickness=4;e.HealthBarBG.Color=Color3.new(0,0,0);e.HealthBarBG.Visible=false
        e.HealthBar.Thickness=2;e.HealthBar.Visible=false
    end
    return ESPObjects[player]
end
local function HideESP(p) if ESPObjects[p] then for _,o in pairs(ESPObjects[p]) do o.Visible=false end end end
local function RemoveESP(p) if ESPObjects[p] then for _,o in pairs(ESPObjects[p]) do o:Remove() end;ESPObjects[p]=nil end end

local function UpdateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if not Settings.ShowESP or not IsEnemy(player) or not IsAlive(player) then HideESP(player);continue end
        local ch = player.Character; if not ch then HideESP(player);continue end
        local hum = ch:FindFirstChildOfClass("Humanoid")
        local root = ch:FindFirstChild("HumanoidRootPart")
        if not hum or not root then HideESP(player);continue end
        local esp = GetESP(player)
        local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
        if not onScreen then HideESP(player);continue end
        local dist = (Camera.CFrame.Position - root.Position).Magnitude
        local sf = 1/(pos.Z*math.tan(math.rad(Camera.FieldOfView/2))*2)*1000
        local bw,bh = 4*sf, 5.5*sf
        local bx,by = pos.X, pos.Y
        local tl=Vector2.new(bx-bw/2,by-bh/2);local tr=Vector2.new(bx+bw/2,by-bh/2)
        local bl=Vector2.new(bx-bw/2,by+bh/2);local br=Vector2.new(bx+bw/2,by+bh/2)
        esp.BoxOutline.PointA=tl;esp.BoxOutline.PointB=tr;esp.BoxOutline.PointC=br;esp.BoxOutline.PointD=bl;esp.BoxOutline.Visible=true
        esp.Box.PointA=tl;esp.Box.PointB=tr;esp.Box.PointC=br;esp.Box.PointD=bl;esp.Box.Color=Settings.ESPBoxColor;esp.Box.Visible=true
        if Settings.ShowName then esp.Name.Text=player.DisplayName;esp.Name.Position=Vector2.new(bx,tl.Y-16);esp.Name.Color=Color3.new(1,1,1);esp.Name.Visible=true
        else esp.Name.Visible=false end
        local hp = hum.Health/hum.MaxHealth
        if Settings.ShowHealth then
            esp.Health.Text=math.floor(hum.Health).." HP";esp.Health.Position=Vector2.new(tr.X+4,tr.Y)
            local r,g=math.floor(255*(1-hp)),math.floor(255*hp)
            esp.Health.Color=Color3.fromRGB(r,g,50);esp.Health.Visible=true
            esp.HealthBarBG.From=Vector2.new(tl.X-5,bl.Y);esp.HealthBarBG.To=Vector2.new(tl.X-5,tl.Y);esp.HealthBarBG.Visible=true
            local barH=(bl.Y-tl.Y)*hp
            esp.HealthBar.From=Vector2.new(tl.X-5,bl.Y);esp.HealthBar.To=Vector2.new(tl.X-5,bl.Y-barH)
            esp.HealthBar.Color=Color3.fromRGB(r,g,50);esp.HealthBar.Visible=true
        else esp.Health.Visible=false;esp.HealthBar.Visible=false;esp.HealthBarBG.Visible=false end
        if Settings.ShowDistance then
            esp.Distance.Text=math.floor(dist).."m";esp.Distance.Position=Vector2.new(bx,bl.Y+2)
            esp.Distance.Color=Color3.fromRGB(200,200,200);esp.Distance.Visible=true
        else esp.Distance.Visible=false end
    end
end

------------------------------------------------------
--// SKELETON
------------------------------------------------------

local SkConn={{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}}
local SkConnR6={{"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},{"Torso","Left Leg"},{"Torso","Right Leg"}}
local SkLines={}

local function UpdateSkeleton()
    for _,player in ipairs(Players:GetPlayers()) do
        if player==LocalPlayer then continue end
        if not SkLines[player] then SkLines[player]={} end
        local lines=SkLines[player];local ch=player.Character
        if not Settings.ShowSkeleton or not ch or not IsEnemy(player) or not IsAlive(player) then
            for _,l in pairs(lines) do l.Visible=false end;continue end
        local conns=ch:FindFirstChild("UpperTorso") and SkConn or SkConnR6
        while #lines<#conns do local l=Drawing.new("Line");l.Visible=false;l.Transparency=0.9;table.insert(lines,l) end
        for i,c in ipairs(conns) do
            local a,b=ch:FindFirstChild(c[1]),ch:FindFirstChild(c[2]);local line=lines[i]
            if a and b then
                local pA,oA=Camera:WorldToViewportPoint(a.Position);local pB,oB=Camera:WorldToViewportPoint(b.Position)
                if oA and oB then line.From=Vector2.new(pA.X,pA.Y);line.To=Vector2.new(pB.X,pB.Y);line.Color=Settings.SkeletonColor;line.Thickness=Settings.SkeletonThickness;line.Visible=true
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

------------------------------------------------------
--// GUI SETUP
------------------------------------------------------

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name="SilentAimGUI";ScreenGui.ResetOnSpawn=false
ScreenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;ScreenGui.IgnoreGuiInset=true
if syn and syn.protect_gui then syn.protect_gui(ScreenGui) end
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame",ScreenGui)
MainFrame.Size=UDim2.new(0,550,0,420);MainFrame.AnchorPoint=Vector2.new(0.5,0.5)
MainFrame.Position=UDim2.new(0.5,0,0.5,0);MainFrame.BackgroundColor3=Settings.BG
MainFrame.BorderSizePixel=0;MainFrame.ClipsDescendants=true
Instance.new("UICorner",MainFrame).CornerRadius=UDim.new(0,8)
Instance.new("UIStroke",MainFrame).Color=Settings.AccentColor

local TopBar = Instance.new("Frame",MainFrame)
TopBar.Size=UDim2.new(1,0,0,40);TopBar.BackgroundColor3=Settings.SideBG;TopBar.BorderSizePixel=0
Instance.new("UICorner",TopBar).CornerRadius=UDim.new(0,8)
local TopFix=Instance.new("Frame",TopBar);TopFix.Size=UDim2.new(1,0,0,8);TopFix.Position=UDim2.new(0,0,1,-8)
TopFix.BackgroundColor3=Settings.SideBG;TopFix.BorderSizePixel=0

local TitleLbl=Instance.new("TextLabel",TopBar)
TitleLbl.Size=UDim2.new(0,220,1,0);TitleLbl.Position=UDim2.new(0,14,0,0);TitleLbl.BackgroundTransparency=1
TitleLbl.Text="🎯 Silent Aim v5.0";TitleLbl.TextColor3=Color3.new(1,1,1);TitleLbl.TextSize=16
TitleLbl.Font=Enum.Font.GothamBold;TitleLbl.TextXAlignment=Enum.TextXAlignment.Left
TitleLbl.TextYAlignment=Enum.TextYAlignment.Center

local TopAccent=Instance.new("Frame",TopBar)
TopAccent.Size=UDim2.new(1,0,0,2);TopAccent.Position=UDim2.new(0,0,1,0)
TopAccent.BackgroundColor3=Settings.AccentColor;TopAccent.BorderSizePixel=0
Instance.new("UIGradient",TopAccent).Color=ColorSequence.new{
    ColorSequenceKeypoint.new(0,Color3.fromRGB(130,80,255)),
    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(200,100,255)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(130,80,255))
}

local TabBar=Instance.new("Frame",MainFrame)
TabBar.Size=UDim2.new(0,120,1,-42);TabBar.Position=UDim2.new(0,0,0,42)
TabBar.BackgroundColor3=Settings.SideBG;TabBar.BorderSizePixel=0
local TBLayout=Instance.new("UIListLayout",TabBar);TBLayout.SortOrder=Enum.SortOrder.LayoutOrder;TBLayout.Padding=UDim.new(0,2)
local TBPad=Instance.new("UIPadding",TabBar);TBPad.PaddingTop=UDim.new(0,6);TBPad.PaddingLeft=UDim.new(0,6);TBPad.PaddingRight=UDim.new(0,6)

local TabContent=Instance.new("Frame",MainFrame)
TabContent.Size=UDim2.new(1,-124,1,-44);TabContent.Position=UDim2.new(0,122,0,42)
TabContent.BackgroundTransparency=1;TabContent.BorderSizePixel=0

local Tabs={};local ActiveTab=nil

local function CreateTab(icon,name,order)
    local TB=Instance.new("TextButton",TabBar)
    TB.Size=UDim2.new(1,0,0,32);TB.BackgroundColor3=Settings.BG;TB.BorderSizePixel=0
    TB.Text=icon.."  "..name;TB.TextColor3=Settings.DimText;TB.TextSize=11
    TB.Font=Enum.Font.GothamMedium;TB.TextXAlignment=Enum.TextXAlignment.Left
    TB.LayoutOrder=order;TB.AutoButtonColor=false
    Instance.new("UICorner",TB).CornerRadius=UDim.new(0,6)
    Instance.new("UIPadding",TB).PaddingLeft=UDim.new(0,8)

    local Page=Instance.new("ScrollingFrame",TabContent)
    Page.Size=UDim2.new(1,-8,1,-8);Page.Position=UDim2.new(0,4,0,4)
    Page.BackgroundTransparency=1;Page.BorderSizePixel=0;Page.ScrollBarThickness=3
    Page.ScrollBarImageColor3=Settings.AccentColor;Page.CanvasSize=UDim2.new(0,0,0,0)
    Page.AutomaticCanvasSize=Enum.AutomaticSize.Y;Page.Visible=false
    local PL=Instance.new("UIListLayout",Page);PL.SortOrder=Enum.SortOrder.LayoutOrder
    PL.Padding=UDim.new(0,5);PL.HorizontalAlignment=Enum.HorizontalAlignment.Center

    local tab={Button=TB,Page=Page,Name=name}
    table.insert(Tabs,tab)

    TB.MouseButton1Click:Connect(function()
        for _,t in pairs(Tabs) do t.Page.Visible=false;t.Button.BackgroundColor3=Settings.BG;t.Button.TextColor3=Settings.DimText end
        Page.Visible=true;TB.BackgroundColor3=Settings.AccentColor;TB.TextColor3=Color3.new(1,1,1);ActiveTab=tab
    end)
    TB.MouseEnter:Connect(function() if ActiveTab~=tab then TweenService:Create(TB,TweenInfo.new(0.15),{BackgroundColor3=Settings.HoverBG}):Play() end end)
    TB.MouseLeave:Connect(function() if ActiveTab~=tab then TweenService:Create(TB,TweenInfo.new(0.15),{BackgroundColor3=Settings.BG}):Play() end end)
    return Page
end

------------------------------------------------------
--// COMPONENTS
------------------------------------------------------

local function Sec(p,n,o) local S=Instance.new("Frame",p);S.Size=UDim2.new(1,0,0,22);S.BackgroundTransparency=1;S.LayoutOrder=o;local L=Instance.new("TextLabel",S);L.Size=UDim2.new(1,0,1,0);L.BackgroundTransparency=1;L.Text=string.upper(n);L.TextColor3=Settings.DimText;L.TextSize=10;L.Font=Enum.Font.GothamBold;L.TextXAlignment=Enum.TextXAlignment.Left;L.TextYAlignment=Enum.TextYAlignment.Center;Instance.new("UIPadding",L).PaddingLeft=UDim.new(0,4) end

local function Tog(p,n,d,o,cb)
    local F=Instance.new("Frame",p);F.Size=UDim2.new(1,0,0,34);F.BackgroundColor3=Settings.CardBG;F.BorderSizePixel=0;F.LayoutOrder=o
    Instance.new("UICorner",F).CornerRadius=UDim.new(0,6)
    local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,10);Pd.PaddingRight=UDim.new(0,10)
    local L=Instance.new("TextLabel",F);L.Size=UDim2.new(1,-50,1,0);L.BackgroundTransparency=1;L.Text=n;L.TextColor3=Settings.TextColor;L.TextSize=12;L.Font=Enum.Font.GothamMedium;L.TextXAlignment=Enum.TextXAlignment.Left;L.TextYAlignment=Enum.TextYAlignment.Center
    local BG=Instance.new("Frame",F);BG.Size=UDim2.new(0,36,0,18);BG.AnchorPoint=Vector2.new(1,0.5);BG.Position=UDim2.new(1,0,0.5,0);BG.BackgroundColor3=d and Settings.AccentColor or Color3.fromRGB(55,55,75);BG.BorderSizePixel=0;Instance.new("UICorner",BG).CornerRadius=UDim.new(1,0)
    local Ci=Instance.new("Frame",BG);Ci.Size=UDim2.new(0,12,0,12);Ci.AnchorPoint=Vector2.new(0,0.5);Ci.Position=d and UDim2.new(1,-15,0.5,0) or UDim2.new(0,3,0.5,0);Ci.BackgroundColor3=Color3.new(1,1,1);Ci.BorderSizePixel=0;Instance.new("UICorner",Ci).CornerRadius=UDim.new(1,0)
    local t=d;local Btn=Instance.new("TextButton",F);Btn.Size=UDim2.new(1,20,1,0);Btn.Position=UDim2.new(0,-10,0,0);Btn.BackgroundTransparency=1;Btn.Text="";Btn.ZIndex=2
    Btn.MouseButton1Click:Connect(function() t=not t
        TweenService:Create(Ci,TweenInfo.new(0.15),{Position=t and UDim2.new(1,-15,0.5,0) or UDim2.new(0,3,0.5,0)}):Play()
        TweenService:Create(BG,TweenInfo.new(0.15),{BackgroundColor3=t and Settings.AccentColor or Color3.fromRGB(55,55,75)}):Play()
        if cb then cb(t) end
    end)
end

local function Sld(p,n,mn,mx,df,o,cb)
    local F=Instance.new("Frame",p);F.Size=UDim2.new(1,0,0,46);F.BackgroundColor3=Settings.CardBG;F.BorderSizePixel=0;F.LayoutOrder=o
    Instance.new("UICorner",F).CornerRadius=UDim.new(0,6)
    local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,10);Pd.PaddingRight=UDim.new(0,10);Pd.PaddingTop=UDim.new(0,5);Pd.PaddingBottom=UDim.new(0,8)
    local Top=Instance.new("Frame",F);Top.Size=UDim2.new(1,0,0,16);Top.BackgroundTransparency=1
    local L=Instance.new("TextLabel",Top);L.Size=UDim2.new(0.7,0,1,0);L.BackgroundTransparency=1;L.Text=n;L.TextColor3=Settings.TextColor;L.TextSize=12;L.Font=Enum.Font.GothamMedium;L.TextXAlignment=Enum.TextXAlignment.Left;L.TextYAlignment=Enum.TextYAlignment.Center
    local VL=Instance.new("TextLabel",Top);VL.Size=UDim2.new(0.3,0,1,0);VL.Position=UDim2.new(0.7,0,0,0);VL.BackgroundTransparency=1;VL.Text=tostring(df);VL.TextColor3=Settings.AccentColor;VL.TextSize=12;VL.Font=Enum.Font.GothamBold;VL.TextXAlignment=Enum.TextXAlignment.Right;VL.TextYAlignment=Enum.TextYAlignment.Center
    local SBG=Instance.new("Frame",F);SBG.Size=UDim2.new(1,0,0,4);SBG.Position=UDim2.new(0,0,1,-4);SBG.AnchorPoint=Vector2.new(0,1);SBG.BackgroundColor3=Color3.fromRGB(50,50,70);SBG.BorderSizePixel=0;Instance.new("UICorner",SBG).CornerRadius=UDim.new(1,0)
    local pct=(df-mn)/(mx-mn)
    local Fill=Instance.new("Frame",SBG);Fill.Size=UDim2.new(pct,0,1,0);Fill.BackgroundColor3=Settings.AccentColor;Fill.BorderSizePixel=0;Instance.new("UICorner",Fill).CornerRadius=UDim.new(1,0)
    Instance.new("UIGradient",Fill).Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(100,60,220)),ColorSequenceKeypoint.new(1,Color3.fromRGB(180,100,255))}
    local Knob=Instance.new("Frame",SBG);Knob.Size=UDim2.new(0,12,0,12);Knob.AnchorPoint=Vector2.new(0.5,0.5);Knob.Position=UDim2.new(pct,0,0.5,0);Knob.BackgroundColor3=Color3.new(1,1,1);Knob.BorderSizePixel=0;Knob.ZIndex=3;Instance.new("UICorner",Knob).CornerRadius=UDim.new(1,0);Instance.new("UIStroke",Knob).Color=Settings.AccentColor
    local isDrag=false
    local CA=Instance.new("TextButton",SBG);CA.Size=UDim2.new(1,0,0,18);CA.AnchorPoint=Vector2.new(0,0.5);CA.Position=UDim2.new(0,0,0.5,0);CA.BackgroundTransparency=1;CA.Text="";CA.ZIndex=4
    CA.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then isDrag=true end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then isDrag=false end end)
    RunService.RenderStepped:Connect(function() if isDrag then
        local mp=UserInputService:GetMouseLocation();local rel=mp.X-SBG.AbsolutePosition.X
        local p2=math.clamp(rel/SBG.AbsoluteSize.X,0,1);local v=math.floor(mn+(mx-mn)*p2)
        Fill.Size=UDim2.new(p2,0,1,0);Knob.Position=UDim2.new(p2,0,0.5,0);VL.Text=tostring(v)
        if cb then cb(v) end
    end end)
end

local function Drp(p,n,opts,df,o,cb)
    local F=Instance.new("Frame",p);F.Size=UDim2.new(1,0,0,34);F.BackgroundColor3=Settings.CardBG;F.BorderSizePixel=0;F.ClipsDescendants=true;F.LayoutOrder=o;Instance.new("UICorner",F).CornerRadius=UDim.new(0,6)
    local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,10);Pd.PaddingRight=UDim.new(0,10)
    local L=Instance.new("TextLabel",F);L.Size=UDim2.new(0.5,0,0,34);L.BackgroundTransparency=1;L.Text=n;L.TextColor3=Settings.TextColor;L.TextSize=12;L.Font=Enum.Font.GothamMedium;L.TextXAlignment=Enum.TextXAlignment.Left;L.TextYAlignment=Enum.TextYAlignment.Center
    local SB=Instance.new("TextButton",F);SB.Size=UDim2.new(0.45,0,0,22);SB.AnchorPoint=Vector2.new(1,0.5);SB.Position=UDim2.new(1,0,0,17);SB.BackgroundColor3=Color3.fromRGB(50,50,70);SB.BorderSizePixel=0;SB.Text=df.." ▼";SB.TextColor3=Settings.AccentColor;SB.TextSize=10;SB.Font=Enum.Font.GothamMedium;SB.ZIndex=2;Instance.new("UICorner",SB).CornerRadius=UDim.new(0,4)
    local open=false;local btns={}
    for i,opt in ipairs(opts) do
        local OB=Instance.new("TextButton",F);OB.Size=UDim2.new(0.45,0,0,22);OB.AnchorPoint=Vector2.new(1,0);OB.Position=UDim2.new(1,0,0,30+(i-1)*26);OB.BackgroundColor3=Color3.fromRGB(45,45,65);OB.BorderSizePixel=0;OB.Text=opt;OB.TextColor3=Color3.fromRGB(200,200,210);OB.TextSize=10;OB.Font=Enum.Font.GothamMedium;OB.Visible=false;OB.ZIndex=3;Instance.new("UICorner",OB).CornerRadius=UDim.new(0,4)
        OB.MouseButton1Click:Connect(function() SB.Text=opt.." ▼";open=false;F.Size=UDim2.new(1,0,0,34);for _,b in pairs(btns) do b.Visible=false end;if cb then cb(opt) end end)
        OB.MouseEnter:Connect(function() OB.BackgroundColor3=Color3.fromRGB(60,60,90) end)
        OB.MouseLeave:Connect(function() OB.BackgroundColor3=Color3.fromRGB(45,45,65) end)
        table.insert(btns,OB)
    end
    SB.MouseButton1Click:Connect(function() open=not open;F.Size=open and UDim2.new(1,0,0,34+#opts*26+4) or UDim2.new(1,0,0,34);for _,b in pairs(btns) do b.Visible=open end end)
end

local function Kbnd(p,n,df,o)
    local F=Instance.new("Frame",p);F.Size=UDim2.new(1,0,0,34);F.BackgroundColor3=Settings.CardBG;F.BorderSizePixel=0;F.LayoutOrder=o;Instance.new("UICorner",F).CornerRadius=UDim.new(0,6)
    local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,10);Pd.PaddingRight=UDim.new(0,10)
    local L=Instance.new("TextLabel",F);L.Size=UDim2.new(1,-75,1,0);L.BackgroundTransparency=1;L.Text=n;L.TextColor3=Settings.TextColor;L.TextSize=12;L.Font=Enum.Font.GothamMedium;L.TextXAlignment=Enum.TextXAlignment.Left;L.TextYAlignment=Enum.TextYAlignment.Center
    local KB=Instance.new("TextButton",F);KB.Size=UDim2.new(0,60,0,22);KB.AnchorPoint=Vector2.new(1,0.5);KB.Position=UDim2.new(1,0,0.5,0);KB.BackgroundColor3=Color3.fromRGB(50,50,70);KB.BorderSizePixel=0;KB.Text="["..df.Name.."]";KB.TextColor3=Settings.AccentColor;KB.TextSize=10;KB.Font=Enum.Font.GothamBold;Instance.new("UICorner",KB).CornerRadius=UDim.new(0,4)
    local listening=false
    KB.MouseButton1Click:Connect(function() listening=true;KB.Text="[...]";KB.TextColor3=Color3.fromRGB(255,200,50) end)
    UserInputService.InputBegan:Connect(function(input) if listening and input.UserInputType==Enum.UserInputType.Keyboard then listening=false;Settings.Keybind=input.KeyCode;KB.Text="["..input.KeyCode.Name.."]";KB.TextColor3=Settings.AccentColor end end)
end

local function TPBtn(p,n,pos,o)
    local B=Instance.new("TextButton",p);B.Size=UDim2.new(1,0,0,30);B.BackgroundColor3=Settings.CardBG;B.BorderSizePixel=0;B.Text="  📍 "..n;B.TextColor3=Settings.TextColor;B.TextSize=11;B.Font=Enum.Font.GothamMedium;B.LayoutOrder=o;B.TextXAlignment=Enum.TextXAlignment.Left;B.AutoButtonColor=false;Instance.new("UICorner",B).CornerRadius=UDim.new(0,6);Instance.new("UIPadding",B).PaddingLeft=UDim.new(0,6)
    local cd=false
    B.MouseEnter:Connect(function() if not cd then TweenService:Create(B,TweenInfo.new(0.12),{BackgroundColor3=Settings.AccentColor}):Play();B.TextColor3=Color3.new(1,1,1) end end)
    B.MouseLeave:Connect(function() if not cd then TweenService:Create(B,TweenInfo.new(0.12),{BackgroundColor3=Settings.CardBG}):Play();B.TextColor3=Settings.TextColor end end)
    B.MouseButton1Click:Connect(function() if cd then return end;cd=true;B.Text="  ⏳ Teleporting...";B.TextColor3=Color3.fromRGB(255,200,50)
        SafeTeleport(CFrame.new(pos));task.wait(0.5);B.Text="  ✅ "..n;B.TextColor3=Color3.fromRGB(80,255,80)
        task.wait(1);B.Text="  📍 "..n;B.TextColor3=Settings.TextColor;B.BackgroundColor3=Settings.CardBG;cd=false end)
end

local StatusLabel,StatusDot,TargetLabel
local function MkStatus(p,o)
    local F=Instance.new("Frame",p);F.Size=UDim2.new(1,0,0,44);F.BackgroundColor3=Settings.CardBG;F.BorderSizePixel=0;F.LayoutOrder=o;Instance.new("UICorner",F).CornerRadius=UDim.new(0,6)
    local Pd=Instance.new("UIPadding",F);Pd.PaddingLeft=UDim.new(0,10);Pd.PaddingRight=UDim.new(0,10);Pd.PaddingTop=UDim.new(0,6);Pd.PaddingBottom=UDim.new(0,6)
    StatusDot=Instance.new("Frame",F);StatusDot.Size=UDim2.new(0,8,0,8);StatusDot.Position=UDim2.new(0,0,0,5);StatusDot.BackgroundColor3=Color3.fromRGB(255,60,60);StatusDot.BorderSizePixel=0;Instance.new("UICorner",StatusDot).CornerRadius=UDim.new(1,0)
    StatusLabel=Instance.new("TextLabel",F);StatusLabel.Size=UDim2.new(1,-14,0,14);StatusLabel.Position=UDim2.new(0,14,0,0);StatusLabel.BackgroundTransparency=1;StatusLabel.Text="DISABLED";StatusLabel.TextColor3=Color3.fromRGB(255,60,60);StatusLabel.TextSize=11;StatusLabel.Font=Enum.Font.GothamBold;StatusLabel.TextXAlignment=Enum.TextXAlignment.Left
    TargetLabel=Instance.new("TextLabel",F);TargetLabel.Size=UDim2.new(1,0,0,12);TargetLabel.Position=UDim2.new(0,0,0,18);TargetLabel.BackgroundTransparency=1;TargetLabel.Text="Target: None";TargetLabel.TextColor3=Settings.DimText;TargetLabel.TextSize=10;TargetLabel.Font=Enum.Font.GothamMedium;TargetLabel.TextXAlignment=Enum.TextXAlignment.Left
end

------------------------------------------------------
--// CREATE ALL TABS
------------------------------------------------------

local AimbotPage = CreateTab("🎯","Aimbot",1)
local ESPPage = CreateTab("👁","ESP",2)
local BorisPage = CreateTab("🔴","Boris",3)
local VasilyPage = CreateTab("🔵","Vasily",4)
local ChurchPage = CreateTab("⛪","Church",5)
local SniperPage = CreateTab("🎯","Sniper",6)
local GeneralPage = CreateTab("📍","General",7)
local SettingsPage = CreateTab("⚙","Settings",8)

Tabs[1].Button.BackgroundColor3=Settings.AccentColor;Tabs[1].Button.TextColor3=Color3.new(1,1,1);Tabs[1].Page.Visible=true;ActiveTab=Tabs[1]

------------------------------------------------------
--// FILL TABS
------------------------------------------------------

-- AIMBOT
do local o=0;local function n() o=o+1;return o end
    Sec(AimbotPage,"Silent Aim",n())
    Tog(AimbotPage,"Enabled",false,n(),function(s) Settings.Enabled=s end)
    Sld(AimbotPage,"FOV Radius",10,500,Settings.FOV,n(),function(v) Settings.FOV=v;FOVCircle.Radius=v end)
    Tog(AimbotPage,"Show FOV",true,n(),function(s) Settings.ShowFOV=s end)
    Drp(AimbotPage,"Target Part",{"Head","HumanoidRootPart","UpperTorso"},Settings.TargetPart,n(),function(v) Settings.TargetPart=v end)
    Tog(AimbotPage,"Wall Check",true,n(),function(s) Settings.WallCheck=s end)
    Sec(AimbotPage,"Status",n());MkStatus(AimbotPage,n())
end

-- ESP
do local o=0;local function n() o=o+1;return o end
    Sec(ESPPage,"Box ESP",n())
    Tog(ESPPage,"ESP Boxes",true,n(),function(s) Settings.ShowESP=s end)
    Tog(ESPPage,"Names",true,n(),function(s) Settings.ShowName=s end)
    Tog(ESPPage,"Health",true,n(),function(s) Settings.ShowHealth=s end)
    Tog(ESPPage,"Distance",true,n(),function(s) Settings.ShowDistance=s end)
    Sec(ESPPage,"Skeleton",n())
    Tog(ESPPage,"Skeleton ESP",true,n(),function(s) Settings.ShowSkeleton=s end)
    Sld(ESPPage,"Thickness",1,4,2,n(),function(v) Settings.SkeletonThickness=v end)
    Sec(ESPPage,"Chams",n())
    Tog(ESPPage,"Chams",true,n(),function(s) Settings.ShowChams=s end)
end

-- BORIS
do local o=0;local function n() o=o+1;return o end
    Sec(BorisPage,"Boris Side",n())

    -- TP to nearest enemy on Boris side
    local TPEnemyBoris=Instance.new("TextButton",BorisPage)
    TPEnemyBoris.Size=UDim2.new(1,0,0,30);TPEnemyBoris.BackgroundColor3=Color3.fromRGB(180,50,50)
    TPEnemyBoris.BorderSizePixel=0;TPEnemyBoris.Text="👤 TP Nearest Enemy (Boris Side)"
    TPEnemyBoris.TextColor3=Color3.new(1,1,1);TPEnemyBoris.TextSize=11;TPEnemyBoris.Font=Enum.Font.GothamBold
    TPEnemyBoris.LayoutOrder=n();TPEnemyBoris.AutoButtonColor=false
    Instance.new("UICorner",TPEnemyBoris).CornerRadius=UDim.new(0,6)
    TPEnemyBoris.MouseEnter:Connect(function() TweenService:Create(TPEnemyBoris,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(220,60,60)}):Play() end)
    TPEnemyBoris.MouseLeave:Connect(function() TweenService:Create(TPEnemyBoris,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(180,50,50)}):Play() end)
    TPEnemyBoris.MouseButton1Click:Connect(function()
        local cl,cd=nil,math.huge
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and IsAlive(p) and IsEnemy(p) then
                local r=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                local mr=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if r and mr then local d=(mr.Position-r.Position).Magnitude;if d<cd then cd=d;cl=p end end
            end
        end
        if cl and cl.Character then local r=cl.Character:FindFirstChild("HumanoidRootPart");if r then SafeTeleport(r.CFrame*CFrame.new(0,0,5)) end end
    end)

    Sec(BorisPage,"Locations",n())
    for _,loc in ipairs(ColdWarLocations.Boris) do
        TPBtn(BorisPage,loc.name,loc.pos,n())
    end
end

-- VASILY
do local o=0;local function n() o=o+1;return o end
    Sec(VasilyPage,"Vasily Side",n())

    local TPEnemyVasily=Instance.new("TextButton",VasilyPage)
    TPEnemyVasily.Size=UDim2.new(1,0,0,30);TPEnemyVasily.BackgroundColor3=Color3.fromRGB(50,80,180)
    TPEnemyVasily.BorderSizePixel=0;TPEnemyVasily.Text="👤 TP Nearest Enemy (Vasily Side)"
    TPEnemyVasily.TextColor3=Color3.new(1,1,1);TPEnemyVasily.TextSize=11;TPEnemyVasily.Font=Enum.Font.GothamBold
    TPEnemyVasily.LayoutOrder=n();TPEnemyVasily.AutoButtonColor=false
    Instance.new("UICorner",TPEnemyVasily).CornerRadius=UDim.new(0,6)
    TPEnemyVasily.MouseEnter:Connect(function() TweenService:Create(TPEnemyVasily,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(60,100,220)}):Play() end)
    TPEnemyVasily.MouseLeave:Connect(function() TweenService:Create(TPEnemyVasily,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(50,80,180)}):Play() end)
    TPEnemyVasily.MouseButton1Click:Connect(function()
        local cl,cd=nil,math.huge
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and IsAlive(p) and IsEnemy(p) then
                local r=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                local mr=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if r and mr then local d=(mr.Position-r.Position).Magnitude;if d<cd then cd=d;cl=p end end
            end
        end
        if cl and cl.Character then local r=cl.Character:FindFirstChild("HumanoidRootPart");if r then SafeTeleport(r.CFrame*CFrame.new(0,0,5)) end end
    end)

    Sec(VasilyPage,"Locations",n())
    for _,loc in ipairs(ColdWarLocations.Vasily) do
        TPBtn(VasilyPage,loc.name,loc.pos,n())
    end
end

-- CHURCH
do local o=0;local function n() o=o+1;return o end
    Sec(ChurchPage,"Church Area",n())
    for _,loc in ipairs(ColdWarLocations.Church) do
        TPBtn(ChurchPage,loc.name,loc.pos,n())
    end
end

-- SNIPER
do local o=0;local function n() o=o+1;return o end
    Sec(SniperPage,"Sniper Positions",n())
    for _,loc in ipairs(ColdWarLocations.Sniper) do
        TPBtn(SniperPage,loc.name,loc.pos,n())
    end
end

-- GENERAL
do local o=0;local function n() o=o+1;return o end
    -- TP to any enemy
    local TPAnyBtn=Instance.new("TextButton",GeneralPage)
    TPAnyBtn.Size=UDim2.new(1,0,0,30);TPAnyBtn.BackgroundColor3=Color3.fromRGB(180,80,40)
    TPAnyBtn.BorderSizePixel=0;TPAnyBtn.Text="👤 TP to Nearest Enemy"
    TPAnyBtn.TextColor3=Color3.new(1,1,1);TPAnyBtn.TextSize=11;TPAnyBtn.Font=Enum.Font.GothamBold
    TPAnyBtn.LayoutOrder=n();TPAnyBtn.AutoButtonColor=false
    Instance.new("UICorner",TPAnyBtn).CornerRadius=UDim.new(0,6)
    TPAnyBtn.MouseEnter:Connect(function() TweenService:Create(TPAnyBtn,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(220,100,50)}):Play() end)
    TPAnyBtn.MouseLeave:Connect(function() TweenService:Create(TPAnyBtn,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(180,80,40)}):Play() end)
    TPAnyBtn.MouseButton1Click:Connect(function()
        local cl,cd=nil,math.huge
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and IsAlive(p) and IsEnemy(p) then
                local r=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                local mr=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if r and mr then local d=(mr.Position-r.Position).Magnitude;if d<cd then cd=d;cl=p end end
            end
        end
        if cl and cl.Character then local r=cl.Character:FindFirstChild("HumanoidRootPart");if r then SafeTeleport(r.CFrame*CFrame.new(0,0,5)) end end
    end)

    Sec(GeneralPage,"Map Locations",n())
    for _,loc in ipairs(ColdWarLocations.General) do
        TPBtn(GeneralPage,loc.name,loc.pos,n())
    end
end

-- SETTINGS
do local o=0;local function n() o=o+1;return o end
    Sec(SettingsPage,"General",n())
    Tog(SettingsPage,"Team Check",true,n(),function(s) Settings.TeamCheck=s end)
    Kbnd(SettingsPage,"Aim Toggle",Settings.Keybind,n())
    Sec(SettingsPage,"Danger Zone",n())

    local DestroyBtn=Instance.new("TextButton",SettingsPage)
    DestroyBtn.Size=UDim2.new(1,0,0,32);DestroyBtn.BackgroundColor3=Color3.fromRGB(180,40,40)
    DestroyBtn.BorderSizePixel=0;DestroyBtn.Text="🗑 Destroy Menu";DestroyBtn.TextColor3=Color3.new(1,1,1)
    DestroyBtn.TextSize=12;DestroyBtn.Font=Enum.Font.GothamBold;DestroyBtn.LayoutOrder=n();DestroyBtn.AutoButtonColor=false
    Instance.new("UICorner",DestroyBtn).CornerRadius=UDim.new(0,6)
    DestroyBtn.MouseEnter:Connect(function() TweenService:Create(DestroyBtn,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(220,50,50)}):Play() end)
    DestroyBtn.MouseLeave:Connect(function() TweenService:Create(DestroyBtn,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(180,40,40)}):Play() end)
    DestroyBtn.MouseButton1Click:Connect(function()
        Settings.Enabled=false;Settings.ShowFOV=false;Settings.ShowESP=false;Settings.ShowSkeleton=false;Settings.ShowChams=false
        FOVCircle:Remove()
        for _,p in ipairs(Players:GetPlayers()) do
            if ChamsObjects[p] then ChamsObjects[p]:Destroy() end
            if ESPObjects[p] then for _,obj in pairs(ESPObjects[p]) do obj:Remove() end end
            if SkLines[p] then for _,l in pairs(SkLines[p]) do l:Remove() end end
        end
        ScreenGui:Destroy()
    end)
end

------------------------------------------------------
--// DRAGGING
------------------------------------------------------

do local dragging,dragInput,dragStart,startPos
    TopBar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true;dragStart=i.Position;startPos=MainFrame.Position;i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dragging=false end end) end end)
    TopBar.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement then dragInput=i end end)
    UserInputService.InputChanged:Connect(function(i) if i==dragInput and dragging then local d=i.Position-dragStart;MainFrame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y) end end)
end

------------------------------------------------------
--// AIM + RENDER
------------------------------------------------------

local function GetClosestPlayer()
    local cl,cp=nil,nil;local sh=Settings.FOV;local mP=GetMouseViewportPos()
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LocalPlayer and IsAlive(p) and IsEnemy(p) then
            local ch=p.Character;local part=ch:FindFirstChild(Settings.TargetPart) or ch:FindFirstChild("HumanoidRootPart")
            if part then
                if Settings.WallCheck and not IsVisible(part) then continue end
                local sp,on=Camera:WorldToViewportPoint(part.Position)
                if on then local d=(mP-Vector2.new(sp.X,sp.Y)).Magnitude;if d<sh then sh=d;cl=p;cp=part.Position end end
            end
        end
    end
    return cl,cp
end

RunService.RenderStepped:Connect(function()
    Camera=workspace.CurrentCamera
    local mP=GetMouseViewportPos()
    FOVCircle.Position=mP;FOVCircle.Radius=Settings.FOV;FOVCircle.Visible=Settings.ShowFOV
    FOVCircle.Color=Settings.Enabled and Settings.AccentColor or Settings.FOVColor
    if Settings.Enabled then local t,p=GetClosestPlayer();CurrentTarget=t;CachedTargetPosition=p
    else CurrentTarget=nil;CachedTargetPosition=nil end
    UpdateSkeleton();UpdateESP();UpdateChams()
    if StatusLabel then
        if Settings.Enabled then StatusLabel.Text="ENABLED";StatusLabel.TextColor3=Color3.fromRGB(80,255,80);StatusDot.BackgroundColor3=Color3.fromRGB(80,255,80)
        else StatusLabel.Text="DISABLED";StatusLabel.TextColor3=Color3.fromRGB(255,60,60);StatusDot.BackgroundColor3=Color3.fromRGB(255,60,60) end
        if CurrentTarget then TargetLabel.Text="Target: "..CurrentTarget.Name;TargetLabel.TextColor3=Settings.AccentColor
        else TargetLabel.Text="Target: None";TargetLabel.TextColor3=Settings.DimText end
    end
end)

------------------------------------------------------
--// HOOK
------------------------------------------------------

local HM={FindPartOnRayWithIgnoreList=true,FindPartOnRay=true,FindPartOnRayWithWhitelist=true,Raycast=true}
local oldNC;oldNC=hookmetamethod(game,"__namecall",newcclosure(function(self,...)
    local m=getnamecallmethod()
    if not Settings.Enabled or not CachedTargetPosition or not HM[m] or self~=workspace then return oldNC(self,...) end
    local a={...}
    if m=="Raycast" then
        if typeof(a[1])=="Vector3" and typeof(a[2])=="Vector3" then a[2]=(CachedTargetPosition-a[1]).Unit*a[2].Magnitude;return oldNC(self,unpack(a)) end
    else
        if typeof(a[1])=="Ray" then local o2=a[1].Origin;local mg=a[1].Direction.Magnitude;a[1]=Ray.new(o2,(CachedTargetPosition-o2).Unit*mg);return oldNC(self,unpack(a)) end
    end
    return oldNC(self,...)
end))

------------------------------------------------------
--// INPUT
------------------------------------------------------

UserInputService.InputBegan:Connect(function(i,g) if g then return end
    if i.KeyCode==Settings.Keybind then Settings.Enabled=not Settings.Enabled end
    if i.KeyCode==Enum.KeyCode.Insert then MainFrame.Visible=not MainFrame.Visible end
end)

------------------------------------------------------
--// NOTIF
------------------------------------------------------

local N=Instance.new("Frame",ScreenGui);N.Size=UDim2.new(0,320,0,36);N.AnchorPoint=Vector2.new(0.5,0)
N.Position=UDim2.new(0.5,0,0,-42);N.BackgroundColor3=Settings.SideBG;N.BorderSizePixel=0
Instance.new("UICorner",N).CornerRadius=UDim.new(0,6);Instance.new("UIStroke",N).Color=Settings.AccentColor
local NTx=Instance.new("TextLabel",N);NTx.Size=UDim2.new(1,0,1,0);NTx.BackgroundTransparency=1
NTx.Text="🎯 Loaded | Insert=Menu | X=Toggle";NTx.TextColor3=Color3.new(1,1,1);NTx.TextSize=11
NTx.Font=Enum.Font.GothamMedium;NTx.TextXAlignment=Enum.TextXAlignment.Center;NTx.TextYAlignment=Enum.TextYAlignment.Center
TweenService:Create(N,TweenInfo.new(0.5,Enum.EasingStyle.Back),{Position=UDim2.new(0.5,0,0,12)}):Play()
task.delay(4,function() TweenService:Create(N,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Position=UDim2.new(0.5,0,0,-48)}):Play();task.wait(0.6);N:Destroy() end)

print("[Silent Aim v5.0] Loaded!")
