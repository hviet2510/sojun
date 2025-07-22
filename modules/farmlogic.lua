-- modules/farmlogic.lua

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local FarmLogic = {}

function FarmLogic.Farm(mobName)
	local enemies = workspace:FindFirstChild("Enemies")
	if not enemies then return end

	local targetMob = nil
	for _, mob in ipairs(enemies:GetChildren()) do
		if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
			local name = mob.Name:match("^(.-)%s?%[") or mob.Name
			if name:lower() == mobName:lower() and mob.Humanoid.Health > 0 then
				targetMob = mob
				break
			end
		end
	end

	if not targetMob then return end

	local char = LocalPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local tool = char:FindFirstChildOfClass("Tool")
	if not tool then return end

	local tween = TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {
		CFrame = targetMob.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
	})
	tween:Play()
	tween.Completed:Wait()

	if (char.HumanoidRootPart.Position - targetMob.HumanoidRootPart.Position).Magnitude <= 50 then
		tool:Activate()
	end
end

return FarmLogic
