
-- main.lua

-- Tải thư viện Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/BloxFruits-AutoFarm/main/Rayfield.lua"))()

-- Load các modules từ repo
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/enemylist.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/autofarm.lua"))()

-- Tạo cửa sổ UI
local Window = Rayfield:CreateWindow({
	Name = "Blox Fruits AutoFarm",
	LoadingTitle = "Đang khởi động...",
	LoadingSubtitle = "by hviet2510",
	ConfigurationSaving = {
		Enabled = false
	},
	KeySystem = false
})

-- Tạo tab Auto Farm
local FarmTab = Window:CreateTab("⚔️ Auto Farm", 4483362458)

-- Lấy danh sách quái
local mobList = EnemyList.GetEnemyNames()
local selectedMob = mobList[1] or "Bandit"

-- Gán mob mặc định cho autofarm
AutoFarm.SetTarget(selectedMob)

-- Tạo dropdown chọn quái
local MobDropdown = FarmTab:CreateDropdown({
	Name = "🎯 Chọn Quái",
	Options = mobList,
	CurrentOption = selectedMob,
	MultiSelection = false, -- 🛠️ Đảm bảo dropdown chỉ chọn 1
	Callback = function(option)
		selectedMob = option
		AutoFarm.SetTarget(option)
	end
})

-- Toggle bật/tắt autofarm
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

		if table.find(newList, selectedMob) then
			MobDropdown:Set(selectedMob)
		else
			selectedMob = newList[1]
			MobDropdown:Set(selectedMob)
			AutoFarm.SetTarget(selectedMob)
		end
	end
})
