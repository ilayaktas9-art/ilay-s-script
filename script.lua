local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local wl = {"Ilaykingo18", "Ilaykingo18acc4", "h0cker767"}
local ok = false

-- Whitelist Check
for _, v in ipairs(wl) do 
    if LP.Name == v then ok = true break end 
end

if not ok then 
    LP:Kick("Kein Zugriff: Du stehst nicht auf der Whitelist!") 
    return 
end

-- GUI Setup
local sg = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
sg.Name = "IlaysScriptV2"
sg.ResetOnSpawn = false

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 320, 0, 250)
main.Position = UDim2.new(0.5, -160, 0.5, -125)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 130, 255)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0.02, 0)
title.BackgroundTransparency = 1
title.Text = "❄️ ILAY'S PREMIUM"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 22
title.Font = Enum.Font.GothamBold

-- Helfer-Funktion für Buttons
local function createButton(name, text, pos, color)
    local btn = Instance.new("TextButton", main)
    btn.Name = name
    btn.Size = UDim2.new(0.85, 0, 0, 45)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    btn.Text = text
    btn.TextColor3 = color
    btn.TextSize = 18
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

-- Buttons erstellen
local btnSteal = createButton("Steal", "⚔️ Insta Steal", UDim2.new(0.075, 0, 0.25, 0), Color3.fromRGB(80, 170, 255))
local btnKick = createButton("Kick", "🚫 Kick Zone", UDim2.new(0.075, 0, 0.48, 0), Color3.fromRGB(255, 80, 80))
local btnSemiTP = createButton("SemiTP", "📍 SEMI TP", UDim2.new(0.075, 0, 0.71, 0), Color3.fromRGB(200, 80, 255))

-- Close Button
local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(0.88, 0, 0.05, 0)
close.BackgroundTransparency = 1
close.Text = "✕"
close.TextColor3 = Color3.new(1, 0, 0)
close.TextSize = 20
close.MouseButton1Click:Connect(function() sg:Destroy() end)

-- FUNKTIONALITÄTEN (Ohne automatisches Schließen) --

btnSteal.MouseButton1Click:Connect(function()
    local oldText = btnSteal.Text
    btnSteal.Text = "⏳ Loading..."
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/76b1779d41784f4cfe496bedfb0f513c.lua"))()
    task.wait(1)
    btnSteal.Text = oldText
end)

btnKick.MouseButton1Click:Connect(function()
    local oldText = btnKick.Text
    btnKick.Text = "⏳ Loading..."
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-noks-anti-scam-ahh-daddy-chill-94360"))()
    task.wait(1)
    btnKick.Text = oldText
end)

btnSemiTP.MouseButton1Click:Connect(function()
    local oldText = btnSemiTP.Text
    btnSemiTP.Text = "⏳ Loading..."
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/9f36032d5d93c469e6bdc062f6853fa0.lua"))()
    task.wait(1)
    btnSemiTP.Text = oldText
end)
