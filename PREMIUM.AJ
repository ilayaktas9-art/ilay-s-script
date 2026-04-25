local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- DEINE WHITELIST LOGIK
-- HIER NUR DIE NAMEN REIN, DIE ZUGRIFF HABEN SOLLEN
local wl = {"Ilaykingo18", "Ilaykingo18acc4", "Abiniz272731"}
local ok = false

for _, v in ipairs(wl) do 
    if LP.Name == v then 
        ok = true 
        break 
    end 
end

-- WICHTIG: Wenn der Name NICHT in der Liste ist, stoppt das Script SOFORT
if not ok then 
    warn("ZUGRIFF VERWEIGERT: Du bist nicht auf der Whitelist.")
    return -- Beendet das gesamte Script, bevor die GUI geladen wird
end

-- ALLES AB HIER WIRD NUR FÜR WHITELISTED USER GELADEN
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId

local sg = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
sg.Name = "IlayPremiumGui"

local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0, 280, 0, 80)
btn.Position = UDim2.new(0.5, -140, 0.2, 0)
btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
btn.Text = "🚀 ilay's AJ (premium)"
btn.TextColor3 = Color3.new(1, 1, 1)
btn.TextSize = 20
btn.Font = Enum.Font.GothamBold
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

-- Funktion für Teleport
local function teleport()
    btn.Text = "Suche Server..."
    local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local success, result = pcall(function() return game:HttpGet(url) end)

    if success then
        local decoded = HttpService:JSONDecode(result)
        if decoded and decoded.data then
            for _, server in pairs(decoded.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LP)
                    return
                end
            end
        end
    end
    btn.Text = "Kein Server gefunden!"
end

btn.MouseButton1Click:Connect(teleport)
