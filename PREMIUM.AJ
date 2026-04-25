local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- DEINE WHITELIST LOGIK
-- Füge hier Namen hinzu oder entferne sie
local wl = {"Ilaykingo18", "Ilaykingo18acc4", "Abiniz272731"}
local ok = false

for _, v in ipairs(wl) do 
    if LP.Name == v then 
        ok = true 
        break 
    end 
end

-- WICHTIG: Wenn nicht auf Whitelist, stoppe das komplette Script sofort!
if not ok then 
    print("Zugriff verweigert für " .. LP.Name)
    return -- Das beendet das Script hier, nichts danach wird ausgeführt
end

-- AB HIER kommt der Rest vom Script (nur für Whitelisted User)
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId

local sg = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0, 280, 0, 80)
btn.Position = UDim2.new(0.5, -140, 0.2, 0)
btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
btn.Text = "🚀 ilay's AJ (premium)"
btn.TextColor3 = Color3.new(1, 1, 1)
btn.TextSize = 20
btn.Font = Enum.Font.GothamBold
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

-- ... Rest deiner Teleport-Logik ...
