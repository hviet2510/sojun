-- main.lua
-- Giao diện và tích hợp tất cả modules

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()

local enemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/enemylist.lua"))()
local farmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/farmlogic.lua"))()
local autoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/autofarm.lua"))()

local Window = Rayfield:CreateWindow({
    Name = "Sojun Hub - Blox Fruits",
    LoadingTitle = "Sojun Hub",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "SojunHub"
    }
})

local MainTab = Window:CreateTab("Auto Farm", 4483362458)

MainTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(value)
        if value then
            autoFarm.StartFarm(enemyList, farmLogic)
        else
            autoFarm.StopFarm()
        end
    end
})

local mobOptions = {}
for name, data in pairs(enemyList) do
    table.insert(mobOptions, data.DisplayName)
end

MainTab:CreateDropdown({
    Name = "Chọn Mob thủ công",
    Options = mobOptions,
    CurrentOption = {},
    Callback = function(option)
        for name, data in pairs(enemyList) do
            if data.DisplayName == option then
                farmLogic.SetManualMob(name, enemyList)
                break
            end
        end
    end
})

MainTab:CreateToggle({
    Name = "Auto chọn Mob theo level",
    CurrentValue = true,
    Callback = function(value)
        farmLogic.EnableAutoMob(value)
    end
})
