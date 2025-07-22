-- modules/autofarm.lua

local RunService = game:GetService("RunService")

local FarmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/farmlogic.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/enemylist.lua"))()

local AutoFarm = {}

local targetMobName = "Bandit"
local farming = false
local conn = nil

function AutoFarm.SetTarget(name)
	targetMobName = name
end

function AutoFarm.Toggle(state)
	farming = state

	if farming then
		conn = RunService.Heartbeat:Connect(function()
			if targetMobName then
				FarmLogic.FarmEnemy(targetMobName)
			end
		end)
	else
		if conn then
			conn:Disconnect()
			conn = nil
		end
	end
end

return AutoFarm
