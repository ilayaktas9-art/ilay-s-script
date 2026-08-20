local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- SETZE HIER DEINE BILD-ID EIN:
local BACKGROUND_IMAGE_ID = "rbxassetid://1234567890" 

-- KEY EINSTELLUNG
local CORRECT_KEY = "THE_UCHIA_CALN"
local TIKTOK_LINK = "https://www.tiktok.com/@ilay.aktas?_r=1&_t=ZG-9927y7wTqzo"

-- Fly Settings
local flying = false
local flySpeed = 50
local maxSpeed = 100
local minSpeed = 0
local moveUp = false
local moveDown = false

-- ScreenGui Erstellung
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UchiaFlyGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- DRAG SYSTEM HILFSFUNKTION
local function makeDraggable(guiElement, dragHandle)
    dragHandle = dragHandle or guiElement
    local dragging, dragInput, dragStart, startPos
    
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiElement.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            guiElement.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

------------------------------------------------------------------
-- 1. KEY SYSTEM GUI
------------------------------------------------------------------
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 220, 0, 140)
keyFrame.Position = UDim2.new(0.5, -110, 0.4, -70)
keyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
keyFrame.BorderSizePixel = 2
keyFrame.BorderColor3 = Color3.fromRGB(150, 0, 0)
keyFrame.Active = true
keyFrame.Parent = screenGui

makeDraggable(keyFrame)

-- Titel
local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 30)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "UCHIA KEY SYSTEM"
keyTitle.TextColor3 = Color3.fromRGB(255, 50, 50)
keyTitle.Font = Enum.Font.SourceSansBold
keyTitle.TextSize = 14
keyTitle.Parent = keyFrame

-- Text-Eingabefeld
local keyTextBox = Instance.new("TextBox")
keyTextBox.Size = UDim2.new(0.85, 0, 0, 30)
keyTextBox.Position = UDim2.new(0.075, 0, 0.28, 0)
keyTextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyTextBox.BorderSizePixel = 1
keyTextBox.BorderColor3 = Color3.fromRGB(100, 100, 100)
keyTextBox.PlaceholderText = "Enter Key Here..."
keyTextBox.Text = ""
keyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTextBox.Font = Enum.Font.SourceSans
keyTextBox.TextSize = 12
keyTextBox.Parent = keyFrame

-- Get Key Button (Link kopieren)
local btnGetKey = Instance.new("TextButton")
btnGetKey.Size = UDim2.new(0.4, 0, 0, 30)
btnGetKey.Position = UDim2.new(0.075, 0, 0.65, 0)
btnGetKey.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
btnGetKey.BorderColor3 = Color3.fromRGB(0, 100, 255)
btnGetKey.Text = "Get Key"
btnGetKey.TextColor3 = Color3.fromRGB(255, 255, 255)
btnGetKey.Font = Enum.Font.SourceSansBold
btnGetKey.TextSize = 12
btnGetKey.Parent = keyFrame

-- Unlock Button
local btnUnlock = Instance.new("TextButton")
btnUnlock.Size = UDim2.new(0.4, 0, 0, 30)
btnUnlock.Position = UDim2.new(0.525, 0, 0.65, 0)
btnUnlock.BackgroundColor3 = Color3.fromRGB(30, 80, 30)
btnUnlock.BorderColor3 = Color3.fromRGB(0, 255, 100)
btnUnlock.Text = "Unlock"
btnUnlock.TextColor3 = Color3.fromRGB(255, 255, 255)
btnUnlock.Font = Enum.Font.SourceSansBold
btnUnlock.TextSize = 12
btnUnlock.Parent = keyFrame

------------------------------------------------------------------
-- 2. HAUPT FLY GUI (Wird erst nach Unlock sichtbar)
------------------------------------------------------------------
local w = 48 
local h = 27 

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, w * 4, 0, h * 3)
mainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
mainFrame.BackgroundTransparency = 1
mainFrame.Active = true
mainFrame.Visible = false -- Standardmäßig unsichtbar
mainFrame.Parent = screenGui

makeDraggable(mainFrame)

-- HINTERGRUNDBILD
local bgImage = Instance.new("ImageLabel")
bgImage.Size = UDim2.new(1, 0, 1, 0)
bgImage.Position = UDim2.new(0, 0, 0, 0)
bgImage.Image = BACKGROUND_IMAGE_ID
bgImage.ScaleType = Enum.ScaleType.Crop
bgImage.BackgroundTransparency = 1
bgImage.ZIndex = 1
bgImage.Parent = mainFrame

-- Hilfsfunktion für Fly-Buttons
local function createButton(text, pos, size)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Position = pos
    btn.Size = size
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextStrokeTransparency = 0
    btn.BackgroundTransparency = 0.5
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(150, 0, 0)
    btn.ZIndex = 2
    btn.Parent = mainFrame
    return btn
end

-- BUTTON LAYOUT
local btnX = createButton("X", UDim2.new(0, 0, 0, 0), UDim2.new(0, w, 0, h))
btnX.TextColor3 = Color3.fromRGB(255, 50, 50)
local btnMinus = createButton("-", UDim2.new(0, w, 0, 0), UDim2.new(0, w, 0, h))

local btnUp = createButton("UP", UDim2.new(0, 0, 0, h), UDim2.new(0, w, 0, h))
local btnPlus = createButton("+", UDim2.new(0, w, 0, h), UDim2.new(0, w, 0, h))
local btnTitle = createButton("UCHIA FLY", UDim2.new(0, w * 2, 0, h), UDim2.new(0, w * 2, 0, h))

local btnDown = createButton("DOWN", UDim2.new(0, 0, 0, h * 2), UDim2.new(0, w, 0, h))
local btnSpeedDisplay = createButton(tostring(flySpeed), UDim2.new(0, w, 0, h * 2), UDim2.new(0, w, 0, h))
local btnFlyToggle = createButton("FLY", UDim2.new(0, w * 2, 0, h * 2), UDim2.new(0, w * 2, 0, h))

------------------------------------------------------------------
-- LOGIK & EVENTS
------------------------------------------------------------------

-- Get Key Button Event
btnGetKey.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(TIKTOK_LINK)
        btnGetKey.Text = "Copied Link!"
        task.wait(1.5)
        btnGetKey.Text = "Get Key"
    else
        btnGetKey.Text = "Link copied!"
    end
end)

-- Unlock Button Event (Sichere Überprüfung)
btnUnlock.MouseButton1Click:Connect(function()
    -- Entfernt unnötige Leerzeichen und wandelt in Großbuchstaben um
    local enteredText = string.gsub(keyTextBox.Text, "^%s*(.-)%s*$", "%1")
    enteredText = string.upper(enteredText)
    
    if enteredText == string.upper(CORRECT_KEY) then
        keyFrame:Destroy() -- Schließt das Key GUI
        mainFrame.Visible = true -- Öffnet das Fly GUI
    else
        btnUnlock.Text = "Wrong Key!"
        btnUnlock.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
        task.wait(1.5)
        btnUnlock.Text = "Unlock"
        btnUnlock.BackgroundColor3 = Color3.fromRGB(30, 80, 30)
    end
end)

-- Fly Steuerung Logik
btnPlus.MouseButton1Click:Connect(function()
    flySpeed = math.min(flySpeed + 5, maxSpeed)
    btnSpeedDisplay.Text = tostring(flySpeed)
end)

btnMinus.MouseButton1Click:Connect(function()
    flySpeed = math.max(flySpeed - 5, minSpeed)
    btnSpeedDisplay.Text = tostring(flySpeed)
end)

btnX.MouseButton1Click:Connect(function()
    flying = false
    screenGui:Destroy()
end)

btnUp.MouseButton1Down:Connect(function() moveUp = true end)
btnUp.MouseButton1Up:Connect(function() moveUp = false end)
btnDown.MouseButton1Down:Connect(function() moveDown = true end)
btnDown.MouseButton1Up:Connect(function() moveDown = false end)

-- Flight Physics Logic
local bodyVelocity, bodyGyro

btnFlyToggle.MouseButton1Click:Connect(function()
    flying = not flying
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    
    if flying then
        btnFlyToggle.TextColor3 = Color3.fromRGB(0, 255, 100)
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.Parent = root
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        bodyGyro.P = 9000
        bodyGyro.CFrame = root.CFrame
        bodyGyro.Parent = root
    else
        btnFlyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
    end
end)

-- 3D Camera Movement
RunService.RenderStepped:Connect(function()
    if flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local char = LocalPlayer.Character
        local hum = char:FindFirstChildOfClass("Humanoid")
        local cam = workspace.CurrentCamera
        
        if hum and bodyVelocity and bodyGyro then
            local moveDir = hum.MoveDirection
            local flyVector = Vector3.zero
            
            if moveDir.Magnitude > 0 then
                local camLookHorizontal = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
                if camLookHorizontal.Magnitude > 0 then camLookHorizontal = camLookHorizontal.Unit end
                local camYawCFrame = CFrame.lookAt(Vector3.zero, camLookHorizontal)
                local localMove = camYawCFrame:VectorToObjectSpace(moveDir)
                flyVector = (cam.CFrame.RightVector * localMove.X) + (cam.CFrame.LookVector * -localMove.Z)
            end
            
            local extraVertical = (moveUp and 1 or 0) - (moveDown and 1 or 0)
            bodyVelocity.Velocity = (flyVector + Vector3.new(0, extraVertical, 0)) * (flySpeed * 2)
            bodyGyro.CFrame = cam.CFrame
        end
    end
end)
