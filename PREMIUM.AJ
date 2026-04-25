local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PlaceId = game.PlaceId

-- DEINE WHITELIST LOGIK
local wl = {"Ilaykingo18", "Ilaykingo18acc4", "Abiniz272731"}
local ok = false

for _, v in ipairs(wl) do 
    if LP.Name == v then 
        ok = true 
        break 
    end 
end

-- GUI Setup
local sg = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
local btn = Instance.new("TextButton", sg)
-- Box Größe angepasst auf dein Wunsch (280x80)
btn.Size = UDim2.new(0, 280, 0, 80)
btn.Position = UDim2.new(0.5, -140, 0.2, 0)
btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
btn.Text = "🚀 ilay's AJ (premium)"
btn.TextColor3 = Color3.new(1, 1, 1)
btn.TextSize = 20
btn.Font = Enum.Font.GothamBold
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

local function teleport()
    if not ok then
        btn.Text = "❌ No Access"
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        return
    end

    btn.Text = "Suche (100m - 1b)..."
    btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    -- Wir nutzen einen Cursor, um tiefer in die Serverliste zu schauen
    local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        local decoded = HttpService:JSONDecode(result)
        if decoded and decoded.data then
            local possibleServers = {}
            
            for _, server in pairs(decoded.data) do
                -- Filter: Muss Platz haben und darf nicht der aktuelle Server sein
                if server.playing and server.playing < server.maxPlayers and server.id ~= game.JobId then
                    table.insert(possibleServers, server.id)
                end
            end

            if #possibleServers > 0 then
                btn.Text = "Server gefunden! 🛰️"
                local randomServer = possibleServers[math.random(1, #possibleServers)]
                TeleportService:TeleportToPlaceInstance(PlaceId, randomServer, LP)
            else
                btn.Text = "Suche tiefer..."
                task.wait(1)
                teleport()
            end
        end
    else
        btn.Text = "Fehler! Warte 3s..."
        task.wait(3)
        teleport()
    end
end

btn.MouseButton1Click:Connect(function()
    if ok then
        teleport()
    else
        btn.Text = "❌ Nicht auf Whitelist!"
        btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)
