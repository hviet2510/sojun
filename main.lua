-- Rez UI Library (No Key System)
local Rez = {}

-- Create Window
function Rez:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RezUI"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 16
    titleLabel.Parent = mainFrame

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Padding = UDim.new(0, 5)
    uiListLayout.Parent = mainFrame

    return {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        Tabs = {},
        CreateTab = function(self, name)
            local tabButton = Instance.new("TextButton")
            tabButton.Size = UDim2.new(0, 100, 0, 30)
            tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            tabButton.Text = name
            tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            tabButton.Parent = mainFrame

            local tabFrame = Instance.new("Frame")
            tabFrame.Size = UDim2.new(1, -10, 1, -40)
            tabFrame.Position = UDim2.new(0, 5, 0, 35)
            tabFrame.BackgroundTransparency = 1
            tabFrame.Parent = mainFrame
            tabFrame.Visible = false

            table.insert(self.Tabs, {Button = tabButton, Frame = tabFrame})
            return tabFrame
        end
    }
end

-- Create Section
function Rez:CreateSection(tabFrame, name)
    local sectionFrame = Instance.new("Frame")
    sectionFrame.Size = UDim2.new(1, -10, 0, 200)
    sectionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sectionFrame.BorderSizePixel = 0
    sectionFrame.Parent = tabFrame

    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Size = UDim2.new(1, 0, 0, 20)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = name
    sectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectionTitle.Parent = sectionFrame

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Padding = UDim.new(0, 5)
    uiListLayout.Parent = sectionFrame

    return sectionFrame
end

-- Create UI Components
function Rez:CreateButton(sectionFrame, name, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = sectionFrame
    button.MouseButton1Click:Connect(callback)
end

function Rez:CreateLabel(sectionFrame, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Parent = sectionFrame
end

function Rez:CreateTextbox(sectionFrame, name, default, callback)
    local textboxFrame = Instance.new("Frame")
    textboxFrame.Size = UDim2.new(1, -10, 0, 30)
    textboxFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    textboxFrame.Parent = sectionFrame

    local textbox = Instance.new("TextBox")
    textbox.Size = UDim2.new(1, -10, 1, -5)
    textbox.Position = UDim2.new(0, 5, 0, 2)
    textbox.BackgroundTransparency = 0
    textbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    textbox.Text = default or ""
    textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textbox.Parent = textboxFrame
    textbox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(textbox.Text)
        end
    end)
end

function Rez:CreateToggle(sectionFrame, name, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -10, 0, 30)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggleFrame.Parent = sectionFrame

    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Size = UDim2.new(1, -40, 1, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = name
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.Parent = toggleFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 30, 0, 30)
    toggleButton.Position = UDim2.new(1, -35, 0, 0)
    toggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    toggleButton.Text = ""
    toggleButton.Parent = toggleFrame
    toggleButton.MouseButton1Click:Connect(function()
        local newState = not default
        toggleButton.BackgroundColor3 = newState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        default = newState
        callback(newState)
    end)
end

function Rez:CreateDropdown(sectionFrame, name, options, callback)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, -10, 0, 30)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    dropdownFrame.Parent = sectionFrame

    local dropdownLabel = Instance.new("TextLabel")
    dropdownLabel.Size = UDim2.new(1, -10, 1, 0)
    dropdownLabel.BackgroundTransparency = 1
    dropdownLabel.Text = name .. ": None"
    dropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownLabel.Parent = dropdownFrame

    dropdownLabel.MouseButton1Click:Connect(function()
        for _, option in pairs(options) do
            local optionButton = Instance.new("TextButton")
            optionButton.Size = UDim2.new(1, -20, 0, 25)
            optionButton.Position = UDim2.new(0, 10, 0, 0)
            optionButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            optionButton.Text = option
            optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            optionButton.Parent = dropdownFrame
            optionButton.MouseButton1Click:Connect(function()
                dropdownLabel.Text = name .. ": " .. option
                callback(option)
                optionButton:Destroy()
            end)
            wait(0.1)
            optionButton:Destroy()
        end
    end)
end

function Rez:CreateSlider(sectionFrame, name, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -10, 0, 30)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderFrame.Parent = sectionFrame

    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(1, -10, 0, 20)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = name .. ": " .. default
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.Parent = sliderFrame

    local sliderBar = Instance.new("TextButton")
    sliderBar.Size = UDim2.new(1, -20, 0, 5)
    sliderBar.Position = UDim2.new(0, 10, 0, 20)
    sliderBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    sliderBar.AutoButtonColor = false
    sliderBar.Parent = sliderFrame

    local sliderKnob = Instance.new("TextButton")
    sliderKnob.Size = UDim2.new(0, 10, 0, 15)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    sliderKnob.Parent = sliderBar
    local function updateSlider(x)
        local percent = math.clamp((x - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        local value = min + (max - min) * percent
        value = math.floor(value)
        sliderKnob.Position = UDim2.new(percent, -5, -0.5, -5)
        sliderLabel.Text = name .. ": " .. value
        callback(value)
    end
    sliderBar.MouseButton1Down:Connect(function(x)
        updateSlider(x.Position.X)
        local moveConnection
        moveConnection = game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                updateSlider(input.Position.X)
            end
        end)
        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                moveConnection:Disconnect()
            end
        end)
    end)
    updateSlider(sliderBar.AbsolutePosition.X + default / (max - min) * sliderBar.AbsoluteSize.X)
end

function Rez:CreateKeybind(sectionFrame, name, default, callback)
    local keybindFrame = Instance.new("Frame")
    keybindFrame.Size = UDim2.new(1, -10, 0, 30)
    keybindFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    keybindFrame.Parent = sectionFrame

    local keybindLabel = Instance.new("TextLabel")
    keybindLabel.Size = UDim2.new(1, -40, 1, 0)
    keybindLabel.BackgroundTransparency = 1
    keybindLabel.Text = name .. ": " .. tostring(default)
    keybindLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    keybindLabel.Parent = keybindFrame

    keybindLabel.MouseButton1Click:Connect(function()
        local inputConnection
        inputConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                keybindLabel.Text = name .. ": " .. tostring(input.KeyCode)
                callback(input.KeyCode)
                inputConnection:Disconnect()
            end
        end)
    end)
end

function Rez:CreateColorpicker(sectionFrame, name, default, callback)
    local colorpickerFrame = Instance.new("Frame")
    colorpickerFrame.Size = UDim2.new(1, -10, 0, 30)
    colorpickerFrame.BackgroundColor3 = default
    colorpickerFrame.Parent = sectionFrame

    local colorpickerLabel = Instance.new("TextLabel")
    colorpickerLabel.Size = UDim2.new(1, 0, 1, 0)
    colorpickerLabel.BackgroundTransparency = 1
    colorpickerLabel.Text = name
    colorpickerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    colorpickerLabel.Parent = colorpickerFrame

    colorpickerFrame.MouseButton1Click:Connect(function()
        local colorPicker = Instance.new("ColorPicker")
        colorPicker.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        colorPicker.Position = UDim2.new(0, 100, 0, 100)
        colorPicker.Color = default
        colorPicker.Changed:Connect(function(prop)
            if prop == "Color" then
                colorpickerFrame.BackgroundColor3 = colorPicker.Color
                callback(colorPicker.Color)
            end
        end)
    end)
end

function Rez:CreateImage(sectionFrame, name, imageId)
    local imageFrame = Instance.new("Frame")
    imageFrame.Size = UDim2.new(1, -10, 0, 100)
    imageFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    imageFrame.Parent = sectionFrame

    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(1, -10, 1, -10)
    imageLabel.Position = UDim2.new(0, 5, 0, 5)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = "rbxassetid://" .. imageId
    imageLabel.Parent = imageFrame
end

function Rez:CreateInputBox(sectionFrame, name, placeholder, callback)
    local inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(1, -10, 0, 30)
    inputFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    inputFrame.Parent = sectionFrame

    local inputLabel = Instance.new("TextLabel")
    inputLabel.Size = UDim2.new(1, -10, 0, 20)
    inputLabel.BackgroundTransparency = 1
    inputLabel.Text = name
    inputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputLabel.Parent = inputFrame

    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(1, -10, 0, 20)
    inputBox.Position = UDim2.new(0, 5, 0, 20)
    inputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    inputBox.PlaceholderText = placeholder
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.Parent = inputFrame
    inputBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(inputBox.Text)
        end
    end)
end

return Rez
