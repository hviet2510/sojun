-- main.lua

-- Tải thư viện UI Rayfield
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/Rayfield.lua"))()

-- Load module từ raw GitHub
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/enemylist.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/autofarm.lua"))()

-- Tạo UI chính
local Window = Rayfield:CreateWindow({
	Name = "Blox Fruits AutoFarm",
	LoadingTitle = "Đang khởi động...",
	LoadingSubtitle = "by hviet2510",
	ConfigurationSaving = {
		Enabled = false
	},
	KeySystem = false
})

-- Tab farm
local FarmTab = Window:CreateTab("⚔️ Auto Farm", 4483362458)

-- Danh sách quái ban đầu
local mobList = EnemyList.GetValidTargets()
local selectedMob = mobList[1] or "Bandit"

-- Thiết lập target đầu tiên
AutoFarm.SetTarget(selectedMob)

-- Dropdown chọn quái
local MobDropdown = FarmTab:CreateDropdown({
	Name = "🎯 Chọn Quái (theo Level & đã Spawn)",
	Options = mobList,
	CurrentOption = selectedMob,
	Callback = function(option)
		selectedMob = option
		AutoFarm.SetTarget(option)
	end
})

-- Toggle bật/tắt Auto Farm
FarmTab:CreateToggle({
	Name = "🔁 Bật Auto Farm",
	CurrentValue = false,
	Callback = function(state)
		AutoFarm.Toggle(state)
	end
})

-- Nút làm mới danh sách
FarmTab:CreateButton({
	Name = "🔄 Làm Mới Danh Sách Quái",
	Callback = function()
		local newList = EnemyList.GetValidTargets()
		MobDropdown:Refresh(newList, true)

		if table.find(newList, selectedMob) then
			MobDropdown:Set(selectedMob)
			AutoFarm.SetTarget(selectedMob)
		else
			selectedMob = newList[1] or "Bandit"
			MobDropdown:Set(selectedMob)
			AutoFarm.SetTarget(selectedMob)
		end
	end
})
