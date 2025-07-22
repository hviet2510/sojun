-- modules/enemylist.lua

local EnemyList = {}

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
    -- Thêm nhiều quái nữa nếu bạn muốn
}

function EnemyList.GetEnemyNames()
    local names = {}
    for _, enemy in ipairs(EnemyList.List) do
        table.insert(names, enemy.Name)
    end
    return names
end

function EnemyList.GetEnemyDataByName(name)
    for _, enemy in ipairs(EnemyList.List) do
        if enemy.Name == name then
            return enemy
        end
    end
    return nil
end

return EnemyList
