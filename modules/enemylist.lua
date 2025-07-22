-- modules/enemylist.lua

local EnemyList = {}

-- Danh sách quái cố định Sea 1 theo level
EnemyList.Sea1 = {
	{ Name = "Bandit", MinLevel = 1, MaxLevel = 10, Position = Vector3.new(1060, 17, 1548) },
	{ Name = "Monkey", MinLevel = 11, MaxLevel = 19, Position = Vector3.new(-1600, 35, 144) },
	{ Name = "Gorilla", MinLevel = 20, MaxLevel = 29, Position = Vector3.new(-1320, 85, -510) },
	{ Name = "Pirate", MinLevel = 30, MaxLevel = 39, Position = Vector3.new(-1202, 4, 3892) },
	{ Name = "Brute", MinLevel = 40, MaxLevel = 54, Position = Vector3.new(-1140, 15, 4320) },
	{ Name = "Buggy", MinLevel = 55, MaxLevel = 74, Position = Vector3.new(-1145, 5, 4395) },
	-- … Thêm quái Sea 1 khác
}

-- 🔁 Lấy tên quái từ workspace thực tế
function EnemyList.GetSpawnedEnemies()
	local enemiesFolder = workspace:FindFirstChild("Enemies")
	local result, seen = {}, {}

	if enemiesFolder then
		for _, mob in ipairs(enemiesFolder:GetChildren()) do
			if mob:IsA("Model") and mob:FindFirstChild("Humanoid") then
				local name = mob.Name:match("^(.-)%s?%[") or mob.Name
				if not seen[name] then
					table.insert(result, name)
					seen[name] = true
				end
			end
		end
	end

	table.sort(result)
	return result
end

-- 📌 Lọc danh sách Sea1 theo level hiện tại
function EnemyList.GetSuitableEnemies()
	local player = game.Players.LocalPlayer
	local stats = player:FindFirstChild("leaderstats")
	if not stats then return {} end

	local lv = stats:FindFirstChild("Lv") or stats:FindFirstChild("Level")
	if not lv then return {} end

	local level = tonumber(lv.Value)
	local result = {}

	for _, mob in ipairs(EnemyList.Sea1) do
		if level >= mob.MinLevel and level <= mob.MaxLevel then
			table.insert(result, mob.Name)
		end
	end

	return result
end

-- 📌 Kết hợp: quái phù hợp level & đang spawn
function EnemyList.GetValidTargets()
	local suitable = EnemyList.GetSuitableEnemies()
	local spawned = EnemyList.GetSpawnedEnemies()
	local final = {}

	for _, name in ipairs(suitable) do
		if table.find(spawned, name) then
			table.insert(final, name)
		end
	end

	return final
end

return EnemyList
