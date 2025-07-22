-- modules/enemylist.lua

local EnemyList = {}

-- Tự động quét danh sách quái trong workspace.Enemies
function EnemyList.GetEnemyList()
	local enemiesFolder = workspace:FindFirstChild("Enemies")
	if not enemiesFolder then return {} end

	local seen = {}
	local result = {}

	for _, mob in ipairs(enemiesFolder:GetChildren()) do
		if mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
			local mobName = mob.Name:match("^(.-)%s?%[") or mob.Name
			if not seen[mobName] then
				table.insert(result, {
					Name = mobName,
					Position = mob.HumanoidRootPart.Position
				})
				seen[mobName] = true
			end
		end
	end

	return result
end

-- Trả danh sách tên quái cho UI dropdown
function EnemyList.GetEnemyNames()
	local list = EnemyList.GetEnemyList()
	local names = {}
	for _, enemy in ipairs(list) do
		table.insert(names, enemy.Name)
	end
	return names
end

-- Lấy vị trí quái theo tên
function EnemyList.GetPositionByName(name)
	local list = EnemyList.GetEnemyList()
	for _, enemy in ipairs(list) do
		if enemy.Name:lower() == name:lower() then
			return enemy.Position
		end
	end
	return nil
end

return EnemyList
