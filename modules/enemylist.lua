-- modules/enemylist.lua

local EnemyList = {}

-- Danh sách mob Sea 1 với level và vị trí
EnemyList.List = {
    { Name = "Bandit", MinLevel = 1, MaxLevel = 10, Position = Vector3.new(1060, 17, 1548) },
    { Name = "Monkey", MinLevel = 11, MaxLevel = 19, Position = Vector3.new(-1600, 35, 144) },
    { Name = "Gorilla", MinLevel = 20, MaxLevel = 29, Position = Vector3.new(-1320, 85, -510) },
    { Name = "Pirate", MinLevel = 30, MaxLevel = 39, Position = Vector3.new(-1202, 4, 3892) },
    { Name = "Brute", MinLevel = 40, MaxLevel = 54, Position = Vector3.new(-1140, 15, 4320) },
    { Name = "Buggy", MinLevel = 55, MaxLevel = 74, Position = Vector3.new(-1145, 5, 4395) },
    { Name = "Desert Bandit", MinLevel = 75, MaxLevel = 89, Position = Vector3.new(933, 7, 4480) },
    { Name = "Desert Officer", MinLevel = 90, MaxLevel = 99, Position = Vector3.new(1572, 10, 4371) },
    { Name = "Snow Bandit", MinLevel = 100, MaxLevel = 119, Position = Vector3.new(1426, 106, -1327) },
    { Name = "Snowman", MinLevel = 120, MaxLevel = 149, Position = Vector3.new(1243, 137, -1452) },
    { Name = "Chief Petty Officer", MinLevel = 150, MaxLevel = 174, Position = Vector3.new(-4881, 22, 4308) },
    { Name = "Sky Bandit", MinLevel = 175, MaxLevel = 189, Position = Vector3.new(-4951, 296, -2852) },
    { Name = "Dark Master", MinLevel = 190, MaxLevel = 209, Position = Vector3.new(-5224, 430, -2285) },
    { Name = "Prisoner", MinLevel = 210, MaxLevel = 249, Position = Vector3.new(5293, 4, 476) },
    { Name = "Dangerous Prisoner", MinLevel = 250, MaxLevel = 274, Position = Vector3.new(5227, 0, 865) },
    { Name = "Toga Warrior", MinLevel = 275, MaxLevel = 299, Position = Vector3.new(-1796, 8, -2741) },
    { Name = "Gladiator", MinLevel = 300, MaxLevel = 324, Position = Vector3.new(-1278, 7, -3173) },
    { Name = "Military Soldier", MinLevel = 325, MaxLevel = 349, Position = Vector3.new(-4975, 29, 2015) },
    { Name = "Military Spy", MinLevel = 350, MaxLevel = 374, Position = Vector3.new(-5811, 5, 2426) },
    { Name = "Fishman Warrior", MinLevel = 375, MaxLevel = 399, Position = Vector3.new(6086, 19, -2435) },
    { Name = "Fishman Commando", MinLevel = 400, MaxLevel = 449, Position = Vector3.new(5787, 10, -2672) },
    { Name = "Wysper", MinLevel = 450, MaxLevel = 474, Position = Vector3.new(6181, 65, -3626) },
    { Name = "Thunder God", MinLevel = 475, MaxLevel = 524, Position = Vector3.new(-5911, 44, -227) },
    { Name = "Cyborg", MinLevel = 525, MaxLevel = 549, Position = Vector3.new(2611, 3, -5655) },
    { Name = "Vice Admiral", MinLevel = 550, MaxLevel = 624, Position = Vector3.new(-5036, 72, 851) },
    { Name = "Swan Pirate", MinLevel = 625, MaxLevel = 649, Position = Vector3.new(877, 122, 1235) },
    { Name = "Factory Staff", MinLevel = 650, MaxLevel = 674, Position = Vector3.new(295, 40, 430) },
    { Name = "Magma Admiral", MinLevel = 675, MaxLevel = 699, Position = Vector3.new(-5111, 86, -2984) },
}

-- 🔽 Trả về danh sách tên mob để hiển thị dropdown chọn tay
function EnemyList.GetEnemyNames()
    local names = {}
    for _, mob in ipairs(EnemyList.List) do
        table.insert(names, mob.Name)
    end
    return names
end

-- 🔍 Trả về mob theo tên (chọn thủ công)
function EnemyList.GetEnemyData(name)
    for _, mob in ipairs(EnemyList.List) do
        if mob.Name == name then
            return mob
        end
    end
    return nil
end

-- 🤖 Tự động tìm mob theo level hiện tại
function EnemyList.GetTargetByLevel()
    local player = game.Players.LocalPlayer
    local stats = player:FindFirstChild("leaderstats")
    if not stats then return nil end

    local levelValue = stats:FindFirstChild("Level") or stats:FindFirstChild("Lv")
    if not levelValue then return nil end

    local level = tonumber(levelValue.Value)
    if not level then return nil end

    for _, mob in ipairs(EnemyList.List) do
        if level >= mob.MinLevel and level <= mob.MaxLevel then
            return mob
        end
    end

    return nil
end

return EnemyList
