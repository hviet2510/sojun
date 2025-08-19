return function(Window)
    local Macro = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/MacroCore.lua"))()

    local MacroTab = Window:MakeTab({
        Name = "Macro",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    MacroTab:AddButton({
        Name = "Start Record",
        Callback = function()
            Macro.StartRecord()
        end
    })

    MacroTab:AddButton({
        Name = "Stop Record",
        Callback = function()
            Macro.StopRecord()
        end
    })

    MacroTab:AddButton({
        Name = "Play Macro",
        Callback = function()
            Macro.Play()
        end
    })

    MacroTab:AddButton({
        Name = "Stop Macro",
        Callback = function()
            Macro.Stop()
        end
    })

    MacroTab:AddTextbox({
        Name = "Save Macro",
        Default = "MyMacro",
        TextDisappear = true,
        Callback = function(txt)
            Macro.Save(txt)
        end
    })

    MacroTab:AddDropdown({
        Name = "Load Macro",
        Default = "",
        Options = Macro.List(),
        Callback = function(opt)
            Macro.Load(opt)
        end
    })

    MacroTab:AddButton({
        Name = "Delete Macro",
        Callback = function()
            local list = Macro.List()
            if #list > 0 then
                Macro.Delete(list[1]) -- xoá macro đầu tiên (có thể chỉnh theo UI)
            end
        end
    })
end


