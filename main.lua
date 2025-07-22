-- main.lua

-- Load UI và modules từ raw GitHub
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/Rayfield.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/enemylist.lua"))()

-- Tạo UI window
local Window = Rayfield:CreateWindow({
	Name = "Blox Fruits AutoFarm",
	LoadingTitle = "Đang khởi động...",
	LoadingSubtitle = "by hviet2510",
	ConfigurationSaving = { Enabled = false },
	KeySystem = false
})

-- Tab Auto Farm
local FarmTab = Window:CreateTab("⚔️ Auto Farm", 4483362458)

-- Lấy danh sách quái từ enemylist.lua
local mobList = EnemyList.GetEnemyNames()
local selectedMob = mobList[1] or "Bandit"
AutoFarm.SetTarget(selectedMob)

-- Dropdown chọn quái
local MobDropdown = FarmTab:CreateDropdown({
	Name = "🎯 Chọn Quái (theo tên trong enemylist)",
	Options = mobList,
	CurrentOption = selectedMob,
	Callback = function(option)
		selectedMob = option
		AutoFarm.SetTarget(option)
	end
})

-- Toggle bật auto farm
FarmTab:CreateToggle({
	Name = "🔁 Bật Auto Farm",
	CurrentValue = false,
	Callback = function(state)
		AutoFarm.Toggle(state)
	end
})

-- Nút làm mới danh sách quái
FarmTab:CreateButton({
	Name = "🔄 Làm Mới Danh Sách Quái",
	Callback = function()
		mobList = EnemyList.GetEnemyNames()
		MobDropdown:Refresh(mobList, true)

		if table.find(mobList, selectedMob) then
			MobDropdown:Set(selectedMob)
			AutoFarm.SetTarget(selectedMob)
		else
			selectedMob = mobList[1]
			MobDropdown:Set(selectedMob)
			AutoFarm.SetTarget(selectedMob)
		end
	end
})
