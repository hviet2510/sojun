-- modules/enemylist.lua

local EnemyList = {}

-- Danh sách mob cố định Sea 1
EnemyList.List = {
    { Name = "Bandit", Position = Vector3.new(1060, 17, 1548) },
    { Name = "Monkey", Position = Vector3.new(-1600, 35, 144) },
    { Name = "Gorilla", Position = Vector3.new(-1320, 85, -510) },
    { Name = "Pirate", Position = Vector3.new(-1202, 4, 3892) },
    { Name = "Brute", Position = Vector3.new(-1140, 15, 4320) },
    { Name = "Buggy", Position = Vector3.new(-1145, 5, 4395) },
    { Name = "Desert Bandit", Position = Vector3.new(933, 7, 4480) },
    { Name = "Desert Officer", Position = Vector3.new(1572, 10, 4371) },
    { Name = "Snow Bandit", Position = Vector3.new(1426, 106, -1327) },
    { Name = "Snowman", Position = Vector3.new(1243, 137, -1452) },
    { Name = "Chief Petty Officer", Position = Vector3.new(-4881, 22, 4308) },
    { Name = "Sky Bandit", Position = Vector3.new(-4951, 296, -2852) },
    { Name = "Dark Master", Position = Vector3.new(-5224, 430, -2285) },
    { Name = "Prisoner", Position = Vector3.new(5293, 4, 476) },
    { Name = "Dangerous Prisoner", Position = Vector3.new(5227, 0, 865) },
    { Name = "Toga Warrior", Position = Vector3.new(-1796, 8, -2741) },
    { Name = "Gladiator", Position = Vector3.new(-1278, 7, -3173) },
    { Name = "Military Soldier", Position = Vector3.new(-4975, 29, 2015) },
    { Name = "Military Spy", Position = Vector3.new(-5811, 5, 2426) },
    { Name = "Fishman Warrior", Position = Vector3.new(6086, 19, -2435) },
    { Name = "Fishman Commando", Position = Vector3.new(5787, 10, -2672) },
    { Name = "Wysper", Position = Vector3.new(6181, 65, -3626) },
    { Name = "Thunder God", Position = Vector3.new(-5911, 44, -227) },
    { Name = "Cyborg", Position = Vector3.new(2611, 3, -5655) },
    { Name = "Vice Admiral", Position = Vector3.new(-5036, 72, 851) },
    { Name = "Swan Pirate", Position = Vector3.new(877, 122, 1235) },
    { Name = "Factory Staff", Position = Vector3.new(295, 40, 430) },
    { Name = "Magma Admiral", Position = Vector3.new(-5111, 86, -2984) },
}

-- Trả về danh sách tên mob (dùng cho dropdown)
function EnemyList.GetEnemyNames()
    local names = {}
    for _, enemy in ipairs(EnemyList.List) do
        table.insert(names, enemy.Name)
    end
    return names
end

-- Lấy vị trí mob theo tên
function EnemyList.GetEnemyData(name)
    for _, enemy in ipairs(EnemyList.List) do
        if enemy.Name == name then
            return enemy
        end
    end
    return nil
end

return EnemyList
