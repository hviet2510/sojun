local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")

local isFarming = false

-- ✅ Bảng định nghĩa level yêu cầu của từng quái Sea 1
local mobLevelRanges = {
	["Bandit"] = {min = 0, max = 10},
	["Monkey"] = {min = 10, max = 15},
	["Gorilla"] = {min = 15, max = 20},
	["Brute"] = {min = 20, max = 30},
	["Pirate"] = {min = 30, max = 40},
	["Captain"] = {min = 40, max = 55},
	["Clown Pirate"] = {min = 55, max = 70},
	["Swordman Pirate"] = {min = 70, max = 90},
	-- Thêm tiếp nếu muốn
}

-- 🔍 Lấy tên mob phù hợp với level hiện tại
local function GetTargetMobName(playerLevel)
	for mobName, range in pairs(mobLevelRanges) do
		if playerLevel >= range.min and playerLevel <= range.max then
			return mobName
		end
	end
	return nil
end

-- ✅ Lấy mob gần nhất đúng tên
local function GetClosestMob(targetMobName)
	local closestMob = nil
	local shortestDistance = math.huge

	for _, mob in pairs(workspace.Enemies:GetChildren()) do
		local humanoid = mob:FindFirstChild("Humanoid")
		local hrp = mob:FindFirstChild("HumanoidRootPart")

		if humanoid and humanoid.Health > 0 and hrp and mob.Name == targetMobName then
			local distance = (hrp.Position - RootPart.Position).Magnitude
			if distance < shortestDistance then
				shortestDistance = distance
				closestMob = mob
			end
		end
	end

	return closestMob
end

local function TweenToPosition(pos)
	local distance = (RootPart.Position - pos).Magnitude
	local tweenInfo = TweenInfo.new(distance / 250, Enum.EasingStyle.Linear)
	local tween = TweenService:Create(RootPart, tweenInfo, { CFrame = CFrame.new(pos) })
	tween:Play()
	tween.Completed:Wait()
end

local function AttackMob()
	pcall(function()
		for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
			if tool:IsA("Tool") then
				tool.Parent = Character
			end
		end
		Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	end)
end

local function StartAutoFarm()
	isFarming = true

	task.spawn(function()
		while isFarming do
			local level = LocalPlayer.Data.Level.Value
			local targetMobName = GetTargetMobName(level)
			if not targetMobName then
				warn("❌ Không tìm thấy mob phù hợp với level " .. tostring(level))
				wait(1)
				continue
			end

			local mob = GetClosestMob(targetMobName)

			if mob and mob:FindFirstChild("HumanoidRootPart") then
				local mobPos = mob.HumanoidRootPart.Position + Vector3.new(0, 10, 0)
				TweenToPosition(mobPos)
				wait(0.2)
				AttackMob()
			end

			wait(0.25)
		end
	end)
end

local function StopAutoFarm()
	isFarming = false
end

return {
	StartAutoFarm = StartAutoFarm,
	StopAutoFarm = StopAutoFarm,
}
