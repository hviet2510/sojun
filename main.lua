-- main.lua
-- Tải UI và modules auto farm

local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/Rayfield.lua"))()
end)

if not success then
    warn("Không thể tải Rayfield UI")
    return
end

-- Load các module
local enemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/enemylist.lua"))()
local farmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/farmlogic.lua"))()
local autoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/autofarm.lua"))()

-- Tạo UI Window
local Window = Rayfield:CreateWindow({
    Name = "Sojun Hub - Blox Fruits",
    LoadingTitle = "Sojun Hub",
    LoadingSubtitle = "by hviet2510",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "SojunHub",
        FileName = "SojunConfig"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- Tab Auto Farm
local MainTab = Window:CreateTab("Auto Farm", 4483362458)

-- Toggle Auto Farm
MainTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(state)
        if state then
            autoFarm.StartFarm(enemyList, farmLogic)
        else
            autoFarm.StopFarm()
        end
    end
})

-- Dropdown chọn mob thủ công
local options = {}
for name, data in pairs(enemyList) do
    table.insert(options, data.DisplayName)
end

MainTab:CreateDropdown({
    Name = "Chọn Mob thủ công",
    Options = options,
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

-- Toggle auto chọn mob theo level
MainTab:CreateToggle({
    Name = "Auto chọn Mob theo level",
    CurrentValue = true,
    Callback = function(value)
        farmLogic.EnableAutoMob(value)
    end
})
