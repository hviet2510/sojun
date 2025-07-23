-- farmlogic.lua
-- Load dữ liệu enemylist từ link ngoài (không dùng require)

local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/modules/enemylist.lua"))()

local selectedMob = nil
local autoMob = true

-- Tự động chọn mob theo level
local function GetTargetMob(currentLevel)
    if not autoMob and selectedMob and EnemyList[selectedMob] then
        return selectedMob, EnemyList[selectedMob]
    end

    local bestMob = nil
    local bestLevel = 0

    for mobName, mobData in pairs(EnemyList) do
        if currentLevel >= mobData.Level and mobData.Level >= bestLevel then
            bestMob = mobName
            bestLevel = mobData.Level
        end
    end

    if bestMob then
        selectedMob = bestMob
        return selectedMob, EnemyList[selectedMob]
    end

    return nil, nil
end

-- Đặt mob thủ công
local function SetManualMob(mobName)
    if EnemyList[mobName] then
        selectedMob = mobName
        autoMob = false
        return true
    end
    return false
end

-- Bật/tắt auto chọn mob
local function EnableAutoMob(state)
    autoMob = state
end

-- Trả danh sách mob phù hợp theo level
local function GetFarmableMobs(currentLevel)
    local result = {}
    for name, data in pairs(EnemyList) do
        if currentLevel >= data.Level then
            table.insert(result, name)
        end
    end
    return result
end

return {
    GetTargetMob = GetTargetMob,
    SetManualMob = SetManualMob,
    EnableAutoMob = EnableAutoMob,
    GetFarmableMobs = GetFarmableMobs
}
