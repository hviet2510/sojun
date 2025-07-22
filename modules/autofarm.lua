-- modules/autofarm.lua

local RunService = game:GetService("RunService")

local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/enemylist.lua"))()
local FarmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/farmlogic.lua"))()

local AutoFarm = {}

local isFarming = false
local selectedMob = nil
local connection = nil

function AutoFarm.SetTarget(mobName)
	selectedMob = mobName
end

function AutoFarm.Toggle(state)
	isFarming = state

	if isFarming then
		connection = RunService.Heartbeat:Connect(function()
			local mobToFarm = selectedMob

			if not mobToFarm then
				local stats = game.Players.LocalPlayer:FindFirstChild("leaderstats")
				local level = stats and stats:FindFirstChild("Level") or stats:FindFirstChild("Lv")
				if level then
					local auto = EnemyList.GetByLevel(tonumber(level.Value))
					if auto then
						mobToFarm = auto.Name
					end
				end
			end

			if mobToFarm then
				FarmLogic.Farm(mobToFarm)
			end
		end)
	else
		if connection then
			connection:Disconnect()
			connection = nil
		end
	end
end

return AutoFarm
