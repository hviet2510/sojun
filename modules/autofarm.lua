-- autofarm.lua

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Load modules
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/Noda/main/modules/enemylist.lua"))()
local FarmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/Noda/main/modules/farmlogic.lua"))()

-- Cấu hình
local Farming = false
local Distance = 30 -- Khoảng cách đánh quái
local WeaponPriority = {"Combat", "Black Leg", "Electro", "Fishman Karate"}

-- Hàm chọn vũ khí
local function EquipWeapon()
    for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if table.find(WeaponPriority, tool.Name) then
            LocalPlayer.Character.Humanoid:EquipTool(tool)
            break
        end
    end
end

-- Hàm tìm mob
local function FindMob(mobName)
    for _, mob in ipairs(workspace.Enemies:GetChildren()) do
        if mob.Name == mobName and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            return mob
        end
    end
    return nil
end

-- Hàm nhận nhiệm vụ
local function GetQuest(mobData)
    if not mobData.Quest then return end
    local NPC = workspace:FindFirstChild(mobData.Quest.NPC)
    if NPC and (NPC.Position - HumanoidRootPart.Position).Magnitude > 10 then
        HumanoidRootPart.CFrame = NPC.CFrame + Vector3.new(0, 3, 0)
        wait(1)
    end

    local args = {
        [1] = "StartQuest",
        [2] = mobData.Quest.Name,
        [3] = mobData.Quest.Level
    }

    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end

-- Hàm farm
local function FarmLoop()
    while Farming and task.wait() do
        local level = LocalPlayer.Data.Level.Value
        local mobName, mobData = FarmLogic.GetTargetMob(level)
        if not mobName then continue end

        GetQuest(mobData)
        EquipWeapon()

        local mob = FindMob(mobName)
        if mob then
            pcall(function()
                -- Bring Mob
                mob.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, 0, -Distance)

                -- Đánh Mob
                if LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    for _, v in ipairs(getconnections(LocalPlayer.Character:FindFirstChildOfClass("Tool").Activated)) do
                        v:Fire()
                    end
                else
                    LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState(3)
                end
            end)
        end
    end
end

-- Hàm bật/tắt farm
local function SetFarm(state)
    Farming = state
    if state then
        task.spawn(FarmLoop)
    end
end

return {
    Start = function() SetFarm(true) end,
    Stop = function() SetFarm(false) end,
    Toggle = SetFarm
}
