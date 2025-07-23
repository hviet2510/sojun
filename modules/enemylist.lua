-- enemylist.lua
-- Danh sách thông tin từng loại quái tại Sea 1 (Level yêu cầu, tên nhiệm vụ, vị trí NPC và Mob)

return {
    ["Bandit"] = {
        Level = 5,
        QuestName = "BanditQuest1",
        QuestLevel = 1,
        QuestPos = Vector3.new(1060, 17, 1547),
        MobPos = Vector3.new(1150, 17, 1630)
    },
    ["Monkey"] = {
        Level = 10,
        QuestName = "JungleQuest",
        QuestLevel = 1,
        QuestPos = Vector3.new(-1603, 7, 153),
        MobPos = Vector3.new(-1448, 8, 112)
    },
    ["Gorilla"] = {
        Level = 20,
        QuestName = "JungleQuest",
        QuestLevel = 2,
        QuestPos = Vector3.new(-1603, 7, 153),
        MobPos = Vector3.new(-1320, 6, -530)
    },
    -- Thêm các quái tiếp theo tại đây...
}
