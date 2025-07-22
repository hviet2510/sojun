local RunService = game:GetService("RunService")

local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/enemylist.lua"))()
local FarmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/farmlogic.lua"))()

local AutoFarm = {}

local selectedTarget = nil
local farming = false
local heartbeatConn = nil

function AutoFarm.SetTarget(name)
	selectedTarget = name
end

function AutoFarm.Toggle(state)
	farming = state

	if farming then
		print("[AutoFarm] Bắt đầu farm:", selectedTarget)
		heartbeatConn = RunService.Heartbeat:Connect(function()
			if selectedTarget then
				FarmLogic.FarmEnemy(selectedTarget)
			end
		end)
	else
		print("[AutoFarm] Dừng farm.")
		if heartbeatConn then
			heartbeatConn:Disconnect()
			heartbeatConn = nil
		end
	end
end

return AutoFarm
