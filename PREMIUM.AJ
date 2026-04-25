local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- DEINE WHITELIST LOGIK
-- Nur diese Namen kommen rein:
local wl = {"Ilaykingo18", "Ilaykingo18acc4", "Abiniz272731"}
local ok = false

for _, v in ipairs(wl) do 
    if LP.Name == v then 
        ok = true 
        break 
    end 
end

-- KICK-SYSTEM: Wenn nicht auf Whitelist, wird der Spieler sofort gekickt
if not ok then 
    LP:Kick("Not Whitelist - Join the Discord for Access!") -- Hier steht dann die Nachricht beim Kick
    return -- Stoppt das Script sofort
end

-- AB HIER kommt der Rest vom Script (nur für Whitelisted User)
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId

local sg = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
sg.Name = "IlayPremium"

local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0, 280, 0, 80)
btn.Position = UDim2.new(0.5, -140, 0.2, 0)
btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
btn.Text = "🚀 ilay's AJ (premium)"
btn.TextColor3 = Color3.new(1, 1, 1)
btn.TextSize = 20
btn.Font = Enum.Font.GothamBold
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

-- Deine Teleport Funktion
local function teleport()
    btn.Text = "Suche Server..."
    local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local res = game:HttpGet(url)
    local decoded = HttpService:JSONDecode(res)
    if decoded and decoded.data then
        for _, s in pairs(decoded.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(PlaceId, s.id, LP)
                break
            end
        end
    end
end

btn.MouseButton1Click:Connect(teleport)
