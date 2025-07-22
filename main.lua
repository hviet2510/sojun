-- main.lua

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/Rayfield.lua"))()

local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/enemylist.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/autofarm.lua"))()

local mobList = EnemyList.GetEnemyNames()
local selectedMob = nil

-- Giao diện
local Window = Rayfield:CreateWindow({
	Name = "Blox Fruits AutoFarm",
	LoadingTitle = "Khởi chạy...",
	LoadingSubtitle = "by hviet2510",
	ConfigurationSaving = { Enabled = false },
	KeySystem = false
})

local FarmTab = Window:CreateTab("Auto Farm", 4483362458)

FarmTab:CreateDropdown({
	Name = "Chọn Mob Thủ Công",
	Options = mobList,
	CurrentOption = mobList[1],
	Callback = function(option)
		selectedMob = option
		AutoFarm.SetTarget(option)
	end
})

FarmTab:CreateToggle({
	Name = "Bật Auto Farm",
	CurrentValue = false,
	Callback = function(state)
		if not selectedMob then
			local stats = game.Players.LocalPlayer:FindFirstChild("leaderstats")
			local level = stats and (stats:FindFirstChild("Level") or stats:FindFirstChild("Lv"))
			if level then
				local auto = EnemyList.GetByLevel(tonumber(level.Value))
				if auto then
					AutoFarm.SetTarget(auto.Name)
				end
			end
		end
		AutoFarm.Toggle(state)
	end
})
