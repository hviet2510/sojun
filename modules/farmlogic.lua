-- modules/farmlogic.lua

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local FarmLogic = {}

-- ⚡ Tween đến vị trí
local function TweenToPosition(position)
	local character = LocalPlayer.Character
	if not character or not character:FindFirstChild("HumanoidRootPart") then return end

	local hrp = character.HumanoidRootPart
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
	local goal = { CFrame = CFrame.new(position + Vector3.new(0, 5, 0)) }

	local tween = TweenService:Create(hrp, tweenInfo, goal)
	tween:Play()
	tween.Completed:Wait()
end

-- 🔍 Tìm quái trong workspace.Enemies theo tên
local function FindEnemyInWorld(name)
	local enemiesFolder = workspace:FindFirstChild("Enemies")
	if not enemiesFolder then return nil end

	for _, mob in ipairs(enemiesFolder:GetChildren()) do
		if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
			local mobName = mob.Name:match("^(.-)%s?%[") or mob.Name
			if mobName and mobName:lower() == name:lower() and mob.Humanoid.Health > 0 then
				return mob
			end
		end
	end
	return nil
end

-- 🚀 Hàm farm theo tên mob
function FarmLogic.FarmEnemy(mobName)
	if typeof(mobName) ~= "string" then return end

	local mob = FindEnemyInWorld(mobName)

	if mob then
		-- Nếu mob đang spawn thì đánh
		local char = LocalPlayer.Character
		if not char or not char:FindFirstChild("HumanoidRootPart") then return end
		local tool = char:FindFirstChildOfClass("Tool")
		if not tool then return end

		TweenToPosition(mob.HumanoidRootPart.Position)

		if (char.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude <= 50 then
			tool:Activate()
		end
	else
		-- Nếu chưa spawn thì di chuyển đến bãi
		local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/enemylist.lua"))()
		local info = EnemyList.GetEnemyDataByName(mobName)
		if info and info.Position then
			TweenToPosition(info.Position)
		end
	end
end

return FarmLogic
