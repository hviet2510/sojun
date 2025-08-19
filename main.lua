-- main.lua
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/Orion.lua"))()
local Window = OrionLib:MakeWindow({Name = "Sojun Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "Sojun"})

-- ===== Macro =====
local MacroCore = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/MacroCore.lua"))()

local MacroTab = Window:MakeTab({
    Name = "Macro",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MacroTab:AddButton({
    Name = "Start Record",
    Callback = function()
        MacroCore.StartRecord()
        OrionLib:MakeNotification({Name="Macro", Content="Bắt đầu ghi macro", Time=3})
    end
})

MacroTab:AddButton({
    Name = "Stop Record",
    Callback = function()
        MacroCore.StopRecord()
        OrionLib:MakeNotification({Name="Macro", Content="Dừng ghi macro", Time=3})
    end
})

MacroTab:AddButton({
    Name = "Play Macro",
    Callback = function()
        MacroCore.Play()
        OrionLib:MakeNotification({Name="Macro", Content="Đang phát macro", Time=3})
    end
})

MacroTab:AddTextbox({
    Name = "Tên Macro",
    Default = "",
    TextDisappear = true,
    Callback = function(txt)
        getgenv().MacroName = txt
    end
})

MacroTab:AddButton({
    Name = "Save Macro",
    Callback = function()
        if getgenv().MacroName then
            MacroCore.Save(getgenv().MacroName)
            OrionLib:MakeNotification({Name="Macro", Content="Đã lưu macro "..getgenv().MacroName, Time=3})
        end
    end
})

MacroTab:AddButton({
    Name = "Load Macro",
    Callback = function()
        if getgenv().MacroName then
            MacroCore.Load(getgenv().MacroName)
            OrionLib:MakeNotification({Name="Macro", Content="Đã load macro "..getgenv().MacroName, Time=3})
        end
    end
})
