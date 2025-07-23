-- autofarm.lua
-- Tự động farm quái và nhận nhiệm vụ

local TweenService = game:GetService("TweenService")

local isFarming = false

local function MoveTo(position)
    local char = game.Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local tween = TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(position)})
    tween:Play()
    tween.Completed:Wait()
end

local function StartFarm(enemyList, farmLogic)
    isFarming = true

    while isFarming do
        local level = game.Players.LocalPlayer.Data.Level.Value
        local mobName, mobData = farmLogic.GetTargetMob(level, enemyList)
        if not mobData then break end

        -- Lấy quest
        local npc = workspace:FindFirstChild(mobData.QuestNPC)
        if npc then MoveTo(mobData.QuestPos) end

        -- Tấn công quái
        local foundMob = nil
        for _, mob in pairs(workspace.Enemies:GetChildren()) do
            if mob.Name == mobData.MobName and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                foundMob = mob
                break
            end
        end

        if foundMob then
            MoveTo(foundMob.HumanoidRootPart.Position + Vector3.new(0,5,0))
            -- Attack logic ở đây nếu có vũ khí v.v.
        end

        task.wait(1)
    end
end

local function StopFarm()
    isFarming = false
end

return {
    StartFarm = StartFarm,
    StopFarm = StopFarm
}
