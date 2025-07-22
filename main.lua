-- main.lua

-- Tải Rayfield UI từ GitHub
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/Rayfield.lua"))()

-- Load các module qua raw URL
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/enemylist.lua"))()

-- Tạo cửa sổ giao diện
local Window = Rayfield:CreateWindow({
	Name = "Sojun | Blox Fruits AutoFarm",
	LoadingTitle = "Đang khởi động...",
	LoadingSubtitle = "by hviet2510",
	ConfigurationSaving = {
		Enabled = false
	},
	KeySystem = false
})

-- Tab chính
local FarmTab = Window:CreateTab("⚔️ Auto Farm", 4483362458)

-- Lấy danh sách quái hiện tại từ workspace
local enemyNames = EnemyList.GetEnemyNames()
local selectedMob = enemyNames[1] or "Bandit"

-- Cài target ban đầu
AutoFarm.SetTarget(selectedMob)

-- Dropdown chọn quái
local MobDropdown = FarmTab:CreateDropdown({
	Name = "🎯 Chọn Quái",
	Options = enemyNames,
	CurrentOption = selectedMob,
	Callback = function(option)
		selectedMob = option
		AutoFarm.SetTarget(option)
	end
})

-- Toggle bật/tắt farm
FarmTab:CreateToggle({
	Name = "🔁 Bật Auto Farm",
	CurrentValue = false,
	Callback = function(state)
		AutoFarm.Toggle(state)
	end
})

-- Nút làm mới danh sách quái từ workspace
FarmTab:CreateButton({
	Name = "🔄 Làm Mới Danh Sách Quái",
	Callback = function()
		local newList = EnemyList.GetEnemyNames()
		MobDropdown:Refresh(newList, true)

		-- Nếu quái đã chọn vẫn còn
		if table.find(newList, selectedMob) then
			MobDropdown:Set(selectedMob)
			AutoFarm.SetTarget(selectedMob)
		else
			-- Nếu quái cũ không còn -> chọn quái mới đầu danh sách
			selectedMob = newList[1]
			MobDropdown:Set(selectedMob)
			AutoFarm.SetTarget(selectedMob)
		end
	end
})
