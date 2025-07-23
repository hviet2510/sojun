-- autofarm.lua
-- Hệ thống auto farm tự động tìm và đánh quái gần nhất theo cấp độ

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local rs = game:GetService("RunService")

local farmlogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/farmlogic.lua"))()

-- Hàm lấy cấp độ hiện tại
local function GetLevel()
    return player:FindFirstChild("Data") and player.Data.Level.Value or 0
end

-- Hàm dịch chuyển đến vị trí
local function TeleportTo(pos)
    if typeof(pos) == "Vector3" then
        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
    end
end

-- Hàm lấy thông tin quái hiện tại
local function GetMob()
    local level = GetLevel()
    local name, info = farmlogic.GetTargetMob(level)
    return name, info
end

-- Hàm chính: quét quái và đánh
rs.RenderStepped:Connect(function()
    local mobName, mobData = GetMob()
    if not mobData then return end

    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob.Name == mobName and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
            pcall(function()
                hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                end
            end)
        end
    end
end)
