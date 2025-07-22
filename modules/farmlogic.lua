-- modules/farmlogic.lua

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local FarmLogic = {}

-- Tween đến mob
local function TweenTo(pos)
	local char = LocalPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	local hrp = char.HumanoidRootPart
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
	local goal = { CFrame = CFrame.new(pos + Vector3.new(0, 5, 0)) }

	local tween = TweenService:Create(hrp, tweenInfo, goal)
	tween:Play()
	tween.Completed:Wait()
end

-- Tìm mob
local function FindMob(name)
	local enemies = workspace:FindFirstChild("Enemies")
	if not enemies then return nil end

	for _, mob in ipairs(enemies:GetChildren()) do
		if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
			local mobName = mob.Name:match("^(.-)%s?%[") or mob.Name
			if mobName:lower() == name:lower() and mob.Humanoid.Health > 0 then
				return mob
			end
		end
	end
end

function FarmLogic.FarmEnemy(name)
	local mob = FindMob(name)
	if not mob then return end

	local char = LocalPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	local tool = char:FindFirstChildOfClass("Tool")
	if not tool then return end

	TweenTo(mob.HumanoidRootPart.Position)

	if (char.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude <= 50 then
		tool:Activate()
	end
end

return FarmLogic
