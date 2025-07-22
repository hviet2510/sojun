-- modules/autofarm.lua

local RunService = game:GetService("RunService")

local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/enemylist.lua"))()
local FarmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/farmlogic.lua"))()

local AutoFarm = {}

local farming = false
local manualTarget = nil
local connection

function AutoFarm.SetManualTarget(name)
	manualTarget = name
end

function AutoFarm.SetTarget(name) -- Alias để tương thích main.lua cũ
	manualTarget = name
end

function AutoFarm.Toggle(state)
	farming = state

	if connection then
		connection:Disconnect()
		connection = nil
	end

	if farming then
		print("[AutoFarm] Đã bật.")
		connection = RunService.Heartbeat:Connect(function()
			local targetMob = manualTarget or EnemyList.GetMobByLevel()
			if targetMob then
				FarmLogic.FarmEnemy(targetMob)
			end
		end)
	else
		print("[AutoFarm] Đã tắt.")
	end
end

return AutoFarm
