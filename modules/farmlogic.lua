-- farmlogic.lua
-- Logic chọn mob để farm dựa vào cấp độ người chơi và tùy chỉnh thủ công

local selectedMob = nil
local autoMob = true

local function GetTargetMob(currentLevel, enemyList)
    if not autoMob and selectedMob and enemyList[selectedMob] then
        return selectedMob, enemyList[selectedMob]
    end

    local bestMob = nil
    for name, data in pairs(enemyList) do
        if data.AutoMob and currentLevel >= data.Level then
            bestMob = name
        end
    end

    selectedMob = bestMob
    return selectedMob, enemyList[selectedMob]
end

local function SetManualMob(mobName, enemyList)
    if enemyList[mobName] then
        selectedMob = mobName
        autoMob = false
    end
end

local function EnableAutoMob(state)
    autoMob = state
end

return {
    GetTargetMob = GetTargetMob,
    SetManualMob = SetManualMob,
    EnableAutoMob = EnableAutoMob
}
