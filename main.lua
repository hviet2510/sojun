-- main.lua
-- Khởi chạy giao diện và auto farm

-- Load UI lib Rayfield
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/Rayfield.lua"))()

-- Load các module
local farmlogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/farmlogic.lua"))()
local autofarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/autofarm.lua"))

-- Khởi tạo cửa sổ UI
local Window = Rayfield:CreateWindow({
    Name = "Noda Hub | Blox Fruits",
    LoadingTitle = "Noda Hub Loading...",
    LoadingSubtitle = "by hviet2510",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NodaHub",
        FileName = "config"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- Tạo tab chính
local MainTab = Window:CreateTab("Auto Farm", 4483362458)

-- Toggle Auto Farm
local AutoFarmEnabled = false

MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        AutoFarmEnabled = Value
        if AutoFarmEnabled then
            -- Chạy autofarm nếu bật toggle
            task.spawn(function()
                autofarm()
            end)
        end
    end
})

-- Dropdown chọn quái thủ công
MainTab:CreateDropdown({
    Name = "Chọn Quái Thủ Công",
    Options = {"Bandit", "Monkey", "Gorilla"},
    CurrentOption = nil,
    Flag = "ManualMob",
    Callback = function(mobName)
        farmlogic.SetManualMob(mobName)
        farmlogic.EnableAutoMob(false)
    end
})

-- Toggle bật lại chế độ tự động chọn quái theo level
MainTab:CreateToggle({
    Name = "Tự Động Chọn Quái Theo Level",
    CurrentValue = true,
    Flag = "AutoMobSelect",
    Callback = function(value)
        farmlogic.EnableAutoMob(value)
    end
})
