-- Neptun v1.3.1 → deprecated notice
-- Replaces the old script entirely. Just shows the GUI.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local INVITE = "https://discord.com/invite/EVqPGdnA6Q"

-- cleanup old
local old = CoreGui:FindFirstChild("NeptunDeprecated")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "NeptunDeprecated"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
pcall(function() gui.Parent = CoreGui end)
if not gui.Parent then gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end

-- dim background
local dim = Instance.new("Frame", gui)
dim.Size = UDim2.fromScale(1, 1)
dim.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
dim.BackgroundTransparency = 1
dim.BorderSizePixel = 0
TweenService:Create(dim, TweenInfo.new(0.35), {BackgroundTransparency = 0.45}):Play()

-- card
local card = Instance.new("Frame", gui)
card.AnchorPoint = Vector2.new(0.5, 0.5)
card.Position = UDim2.fromScale(0.5, 0.5)
card.Size = UDim2.fromOffset(440, 260)
card.BackgroundColor3 = Color3.fromRGB(14, 15, 20)
card.BorderSizePixel = 0
card.BackgroundTransparency = 1

local corner = Instance.new("UICorner", card); corner.CornerRadius = UDim.new(0, 14)
local stroke = Instance.new("UIStroke", card)
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1
stroke.Transparency = 0.85

-- accent bar
local bar = Instance.new("Frame", card)
bar.Size = UDim2.new(1, 0, 0, 2)
bar.Position = UDim2.fromOffset(0, 0)
bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
bar.BorderSizePixel = 0
bar.BackgroundTransparency = 0.4
local barCorner = Instance.new("UICorner", bar); barCorner.CornerRadius = UDim.new(0, 14)

-- title
local title = Instance.new("TextLabel", card)
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(28, 28)
title.Size = UDim2.new(1, -56, 0, 26)
title.Font = Enum.Font.GothamBold
title.Text = "Neptun v2.0 is out"
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(236, 236, 241)
title.TextXAlignment = Enum.TextXAlignment.Left

-- subtitle
local sub = Instance.new("TextLabel", card)
sub.BackgroundTransparency = 1
sub.Position = UDim2.fromOffset(28, 60)
sub.Size = UDim2.new(1, -56, 0, 60)
sub.Font = Enum.Font.Gotham
sub.Text = "This version (v1.3.1) is no longer supported.\nJoin our Discord to get the new v2.0 loader."
sub.TextSize = 14
sub.TextColor3 = Color3.fromRGB(180, 184, 195)
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.TextYAlignment = Enum.TextYAlignment.Top
sub.TextWrapped = true

-- invite box
local linkBox = Instance.new("TextBox", card)
linkBox.Position = UDim2.fromOffset(28, 134)
linkBox.Size = UDim2.new(1, -56, 0, 38)
linkBox.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
linkBox.BorderSizePixel = 0
linkBox.Font = Enum.Font.Code
linkBox.Text = INVITE
linkBox.TextSize = 13
linkBox.TextColor3 = Color3.fromRGB(236, 236, 241)
linkBox.TextXAlignment = Enum.TextXAlignment.Left
linkBox.ClearTextOnFocus = false
linkBox.TextEditable = false
local lbCorner = Instance.new("UICorner", linkBox); lbCorner.CornerRadius = UDim.new(0, 8)
local lbStroke = Instance.new("UIStroke", linkBox)
lbStroke.Color = Color3.fromRGB(255, 255, 255); lbStroke.Transparency = 0.88
local lbPad = Instance.new("UIPadding", linkBox)
lbPad.PaddingLeft = UDim.new(0, 12); lbPad.PaddingRight = UDim.new(0, 12)

-- copy button
local copyBtn = Instance.new("TextButton", card)
copyBtn.Position = UDim2.fromOffset(28, 188)
copyBtn.Size = UDim2.fromOffset(190, 42)
copyBtn.BackgroundColor3 = Color3.fromRGB(236, 236, 241)
copyBtn.BorderSizePixel = 0
copyBtn.AutoButtonColor = false
copyBtn.Font = Enum.Font.GothamBold
copyBtn.Text = "Copy invite"
copyBtn.TextSize = 14
copyBtn.TextColor3 = Color3.fromRGB(14, 15, 20)
local cbCorner = Instance.new("UICorner", copyBtn); cbCorner.CornerRadius = UDim.new(0, 8)

-- close button
local closeBtn = Instance.new("TextButton", card)
closeBtn.Position = UDim2.new(1, -28 - 190, 0, 188)
closeBtn.Size = UDim2.fromOffset(190, 42)
closeBtn.BackgroundColor3 = Color3.fromRGB(28, 30, 38)
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
closeBtn.Font = Enum.Font.GothamMedium
closeBtn.Text = "Close"
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(180, 184, 195)
local clCorner = Instance.new("UICorner", closeBtn); clCorner.CornerRadius = UDim.new(0, 8)
local clStroke = Instance.new("UIStroke", closeBtn)
clStroke.Color = Color3.fromRGB(255, 255, 255); clStroke.Transparency = 0.88

-- intro animation
card.Size = UDim2.fromOffset(440, 240)
TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    BackgroundTransparency = 0,
    Size = UDim2.fromOffset(440, 260),
}):Play()

-- copy handler
local function copyInvite()
    local copied = false
    pcall(function() setclipboard(INVITE); copied = true end)
    if not copied then pcall(function() toclipboard(INVITE); copied = true end) end
    if not copied and syn and syn.write_clipboard then
        pcall(function() syn.write_clipboard(INVITE); copied = true end)
    end
    copyBtn.Text = copied and "Copied!" or "Copy failed"
    task.delay(1.5, function()
        if copyBtn and copyBtn.Parent then copyBtn.Text = "Copy invite" end
    end)
end

copyBtn.MouseButton1Click:Connect(copyInvite)
linkBox.Focused:Connect(function() linkBox:CaptureFocus(); linkBox.SelectionStart = 1; linkBox.CursorPosition = #INVITE + 1 end)

-- close handler
local function closeUI()
    local out = TweenService:Create(card, TweenInfo.new(0.2), {BackgroundTransparency = 1, Size = UDim2.fromOffset(440, 240)})
    local outDim = TweenService:Create(dim, TweenInfo.new(0.2), {BackgroundTransparency = 1})
    out:Play(); outDim:Play()
    out.Completed:Wait()
    gui:Destroy()
end
closeBtn.MouseButton1Click:Connect(closeUI)

-- ESC to close
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Escape then closeUI() end
end)
