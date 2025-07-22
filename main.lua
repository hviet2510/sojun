-- main.lua

-- Tải Rayfield UI lib
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/Rayfield.lua"))()

-- Load modules từ GitHub
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/enemylist.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/autofarm.lua"))()

-- Tạo cửa sổ UI
local Window = Rayfield:CreateWindow({
	Name = "⚔️ Blox Fruits AutoFarm",
	LoadingTitle = "Đang khởi động...",
	LoadingSubtitle = "by hviet2510",
	ConfigurationSaving = {
		Enabled = false
	},
	KeySystem = false
})

-- Tab Farm
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)

-- Lấy danh sách quái
local mobList = EnemyList.GetEnemyNames()
local selectedMob = mobList[1]

-- Set mặc định ban đầu
AutoFarm.SetTarget(selectedMob)

-- Dropdown chọn mob thủ công
local MobDropdown = FarmTab:CreateDropdown({
	Name = "🎯 Chọn Quái (Thủ Công)",
	Options = mobList,
	CurrentOption = selectedMob,
	Callback = function(option)
		selectedMob = option
		AutoFarm.SetManualTarget(option)
	end
})

-- Toggle auto farm
FarmTab:CreateToggle({
	Name = "🔁 Bật Auto Farm",
	CurrentValue = false,
	Callback = function(state)
		AutoFarm.Toggle(state)
	end
})

-- Nút làm mới danh sách mob từ enemylist
FarmTab:CreateButton({
	Name = "🔄 Làm Mới Danh Sách Quái",
	Callback = function()
		local newList = EnemyList.GetEnemyNames()
		MobDropdown:Refresh(newList, true)

		if table.find(newList, selectedMob) then
			MobDropdown:Set(selectedMob)
			AutoFarm.SetManualTarget(selectedMob)
		else
			selectedMob = newList[1]
			MobDropdown:Set(selectedMob)
			AutoFarm.SetManualTarget(selectedMob)
		end
	end
})
