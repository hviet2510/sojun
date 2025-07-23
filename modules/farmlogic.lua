-- farmlogic.lua
-- Xử lý logic chọn quái tự động hoặc thủ công dựa vào cấp độ

local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/enemylist.lua"))()

local selectedMob = nil
local autoMob = true

-- Hàm chọn quái theo level
local function GetTargetMob(currentLevel)
    if not autoMob and selectedMob and EnemyList[selectedMob] then
        return selectedMob, EnemyList[selectedMob]
    end

    for name, data in pairs(EnemyList) do
        if currentLevel >= data.Level then
            selectedMob = name
        end
    end

    return selectedMob, EnemyList[selectedMob]
end

-- Hàm đặt quái thủ công
local function SetManualMob(mobName)
    if EnemyList[mobName] then
        selectedMob = mobName
        autoMob = false
    end
end

-- Hàm bật/tắt chế độ tự động chọn quái
local function EnableAutoMob(state)
    autoMob = state
end

return {
    GetTargetMob = GetTargetMob,
    SetManualMob = SetManualMob,
    EnableAutoMob = EnableAutoMob
}
