local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local wl = {"Abiniz272731", "Ilaykingo18acc4", "h0cker767"}
local ok = false

-- Whitelist Check
for _, v in ipairs(wl) do 
    if LP.Name == v then ok = true break end 
end

if not ok then 
    LP:Kick("❌ Kein Zugriff: Ilay's Premium Whitelist erforderlich!") 
    return 
end

-- GUI Setup
local sg = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
sg.Name = "IlaysScriptV2_Fixed"
sg.ResetOnSpawn = false

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 320, 0, 270)
main.Position = UDim2.new(0.5, -160, 0.5, -135)
main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 15)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 130, 255)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "❄️ ILAY'S PREMIUM V2"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold

local status = Instance.new("TextLabel", main)
status.Size = UDim2.new(1, 0, 0, 20)
status.Position = UDim2.new(0, 0, 0.9, 0)
status.BackgroundTransparency = 1
status.Text = "Status: Bereit ✅"
status.TextColor3 = Color3.fromRGB(150, 150, 150)
status.TextSize = 12
status.Font = Enum.Font.Gotham

-- Die FIX-Funktion (nutzt task.spawn, damit der Code nicht hängen bleibt)
local function executeScript(btn, url, originalText)
    btn.Text = "⏳ Loading..."
    status.Text = "Status: Script wird geladen..."
    
    -- Das hier startet das Script in einem eigenen Thread
    task.spawn(function()
        local success, err = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        
        if not success then
            status.Text = "Status: Fehler! ❌"
            warn("Fehler: " .. err)
        else
            status.Text = "Status: Script aktiv! 🚀"
        end
    end)

    -- Dieser Teil läuft jetzt SOFORT weiter und setzt den Button zurück
    task.wait(1.5) 
    btn.Text = originalText
end

-- Helfer-Funktion für Buttons
local function createButton(name, text, pos, color)
    local btn = Instance.new("TextButton", main)
    btn.Name = name
    btn.Size = UDim2.new(0.85, 0, 0, 42)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    btn.Text = text
    btn.TextColor3 = color
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

-- Buttons erstellen
local btnSteal = createButton("Steal", "⚔️ Insta Steal", UDim2.new(0.075, 0, 0.25, 0), Color3.fromRGB(80, 170, 255))
local btnKick = createButton("Kick", "🚫 Kick Zone", UDim2.new(0.075, 0, 0.46, 0), Color3.fromRGB(255, 80, 80))
local btnSemiTP = createButton("SemiTP", "📍 SEMI TP", UDim2.new(0.075, 0, 0.67, 0), Color3.fromRGB(200, 80, 255))

-- Events
btnSteal.MouseButton1Click:Connect(function()
    executeScript(btnSteal, "https://api.luarmor.net/files/v4/loaders/76b1779d41784f4cfe496bedfb0f513c.lua", "⚔️ Insta Steal")
end)

btnKick.MouseButton1Click:Connect(function()
    executeScript(btnKick, "https://rawscripts.net/raw/Universal-Script-noks-anti-scam-ahh-daddy-chill-94360", "🚫 Kick Zone")
end)

btnSemiTP.MouseButton1Click:Connect(function()
    executeScript(btnSemiTP, "https://api.luarmor.net/files/v4/loaders/9f36032d5d93c469e6bdc062f6853fa0.lua", "📍 SEMI TP")
end)

-- Close Button
local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(0.88, 0, 0.03, 0)
close.BackgroundTransparency = 1
close.Text = "✕"
close.TextColor3 = Color3.new(1, 0, 0)
close.TextSize = 20
close.MouseButton1Click:Connect(function() sg:Destroy() end)
