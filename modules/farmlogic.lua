-- modules/farmlogic.lua

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local FarmLogic = {}

-- Tween mượt đến mob (an toàn)
local function TweenToPosition(position)
	local char = LocalPlayer.Character
	if not char then return end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local goalCFrame = CFrame.new(position + Vector3.new(0, 5, 0))
	local tweenInfo = TweenInfo.new((hrp.Position - position).Magnitude / 100, Enum.EasingStyle.Linear)

	local tween = TweenService:Create(hrp, tweenInfo, { CFrame = goalCFrame })
	tween:Play()

	local success, err = pcall(function()
		tween.Completed:Wait()
	end)
end

-- Tìm quái theo tên
local function FindTargetMob(name)
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

	return nil
end

-- Gọi farm
function FarmLogic.FarmEnemy(mobName)
	if typeof(mobName) ~= "string" then
		warn("[FarmLogic] Tên mob không hợp lệ:", typeof(mobName))
		return
	end

	local mob = FindTargetMob(mobName)
	if not mob then
		warn("[FarmLogic] Không tìm thấy mob:", mobName)
		return
	end

	local char = LocalPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	local tool = char:FindFirstChildOfClass("Tool")
	if not tool then
		warn("[FarmLogic] Không có vũ khí để đánh.")
		return
	end

	TweenToPosition(mob.HumanoidRootPart.Position)

	if (char.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude <= 50 then
		tool:Activate()
	end
end

return FarmLogic
