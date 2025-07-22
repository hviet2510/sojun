-- autofarm.lua (dùng loadstring)

local RunService = game:GetService("RunService")

-- Load modules bằng raw URL
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/enemylist.lua"))()
local FarmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/farmlogic.lua"))()

local AutoFarm = {}

local isFarming = false
local currentTarget = nil
local connection = nil

-- Toggle Auto Farm
function AutoFarm.Toggle(state)
	isFarming = state

	if isFarming then
		print("[AutoFarm] ✅ Bật AutoFarm")
		connection = RunService.Heartbeat:Connect(function()
			if currentTarget then
				FarmLogic.FarmEnemy(currentTarget)
			end
		end)
	else
		print("[AutoFarm] ❌ Tắt AutoFarm")
		if connection then
			connection:Disconnect()
			connection = nil
		end
	end
end

-- Đặt tên quái để farm
function AutoFarm.SetTarget(name)
	currentTarget = name
	print("[AutoFarm] 🎯 Target:", currentTarget)
end

return AutoFarm
