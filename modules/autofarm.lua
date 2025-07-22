-- modules/autofarm.lua

local RunService = game:GetService("RunService")
local FarmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/farmlogic.lua"))()

local AutoFarm = {}

local isFarming = false
local targetMob = nil
local conn = nil

function AutoFarm.SetTarget(name)
	targetMob = name
end

function AutoFarm.Toggle(state)
	isFarming = state

	if isFarming then
		print("[AutoFarm] Bắt đầu farm:", targetMob)

		conn = RunService.Heartbeat:Connect(function()
			if targetMob then
				FarmLogic.FarmEnemy(targetMob)
			end
		end)
	else
		print("[AutoFarm] Dừng farm.")
		if conn then
			conn:Disconnect()
			conn = nil
		end
	end
end

return AutoFarm
