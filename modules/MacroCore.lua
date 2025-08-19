local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/sojun/main/modules/Orion.lua"))()

local Window = OrionLib:MakeWindow({
    Name = "Sojun Hub - Garden Tower Defense",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "SojunHub"
})

-- Load Macro tab
loadstring(game:HttpGet("https://raw.githubusercontent.com/sojun/main/tabs/MacroTab.lua"))()(Window)

OrionLib:Init()
