-- modules/autofarm.lua

local RunService = game:GetService("RunService")

local EnemyList = require(script.Parent.enemylist)
local FarmLogic = require(script.Parent.farmlogic)

local AutoFarm = {}

local farming = false
local heartbeatConn = nil

function AutoFarm.Toggle(state)
	farming = state

	if farming then
		print("[AutoFarm] Bật auto farm.")
		heartbeatConn = RunService.Heartbeat:Connect(function()
			local target = EnemyList.GetCurrentTarget()
			FarmLogic.Farm(target)
		end)
	else
		print("[AutoFarm] Tắt auto farm.")
		if heartbeatConn then
			heartbeatConn:Disconnect()
			heartbeatConn = nil
		end
	end
end

return AutoFarm
