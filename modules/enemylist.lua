-- modules/enemylist.lua

local EnemyList = {}

-- 🔍 Quét workspace và lấy danh sách quái đang spawn
function EnemyList.GetEnemyNames()
	local enemies = workspace:FindFirstChild("Enemies")
	if not enemies then return {} end

	local mobSet = {}

	for _, mob in ipairs(enemies:GetChildren()) do
		if mob:IsA("Model") and mob:FindFirstChild("Humanoid") then
			local name = mob.Name:match("^(.-)%s?%[") or mob.Name
			mobSet[name] = true
		end
	end

	local mobList = {}
	for name, _ in pairs(mobSet) do
		table.insert(mobList, name)
	end

	table.sort(mobList)
	return mobList
end

return EnemyList
