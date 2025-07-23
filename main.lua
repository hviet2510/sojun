-- main.lua

-- Load UI lib
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/Noda/main/Rayfield.lua"))()

-- Load modules
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/Noda/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/Noda/main/modules/enemylist.lua"))()

-- Tạo UI chính
local Window = Rayfield:CreateWindow({
    Name = "Noda Hub | Blox Fruits",
    LoadingTitle = "Noda Hub",
    LoadingSubtitle = "by hviet2510",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NodaHub",
        FileName = "NodaConfig"
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = false
})

-- Tab Auto Farm
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)

-- Toggle chính bật/tắt Auto Farm
FarmTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        AutoFarm.Toggle(Value)
    end,
})

-- Toggle tự động chọn quái theo level
FarmTab:CreateToggle({
    Name = "Auto chọn Mob theo Level",
    CurrentValue = true,
    Flag = "AutoSelectMobToggle",
    Callback = function(Value)
        AutoFarm.SetAutoMob(Value)
    end,
})

-- Dropdown chọn quái thủ công từ enemylist
FarmTab:CreateDropdown({
    Name = "Chọn Mob thủ công",
    Options = (function()
        local mobs = {}
        for mobName, _ in pairs(EnemyList) do
            table.insert(mobs, mobName)
        end
        table.sort(mobs)
        return mobs
    end)(),
    CurrentOption = nil,
    Flag = "ManualMobSelect",
    Callback = function(option)
        AutoFarm.SetManualMob(option)
    end,
})

Rayfield:LoadConfiguration()
