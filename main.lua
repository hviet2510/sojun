-- Rayfield UI (đã có từ bạn)
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/Rayfield.lua"))()

-- Dịch vụ
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Cấu hình giao diện UI
local Window = Rayfield:CreateWindow({
   Name = "Auto Farm Blox Fruits - Leveling AI (Mobile)",
   LoadingTitle = "Noda System",
   LoadingSubtitle = "by YourName", -- Bạn có thể đổi tên của mình ở đây
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "NodaSystemConfigs",
      FileName = "MobileFarmConfig"
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false
})

-- Tạo một Tab chính cho Farm
local FarmTab = Window:CreateTab("🌀 Auto Level AI", 4483362458)

-- Biến toàn cục và hằng số cần thiết
local AutoFarmEnabled = false
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")
local CurrentTween = nil -- Biến để theo dõi tween hiện tại, giúp dừng tween cũ nếu có

-- Cấu hình Tweens (di chuyển mượt mà)
local TweenInfoFast = TweenInfo.new(
    0.7, -- Thời gian di chuyển (giây)
    Enum.EasingStyle.Linear, -- Kiểu chuyển động
    Enum.EasingDirection.Out,
    0, -- Lặp lại 0 lần
    false, -- Không đảo ngược
    0 -- Độ trễ
)

local TweenInfoNormal = TweenInfo.new(
    1.5, -- Thời gian di chuyển (giây)
    Enum.EasingStyle.Sine,
    Enum.EasingDirection.Out,
    0,
    false,
    0
)

-- Dữ liệu mở rộng về các khu vực farm và NPC nhiệm vụ
-- Bạn CẦN ĐIỀU CHỈNH CÁC VỊ TRÍ NÀY ĐỂ PHÙ HỢP VỚI SERVER CỦA BẠN!
-- QuestNPCName là tên NPC, QuestPos là vị trí của NPC
-- MobType là tên của quái, MobSpawnArea là khu vực trung tâm quái thường xuất hiện, Range là bán kính quét
local FarmAreas = {
    -- Sea 1
    ["Bandit"] = {LevelReq = 0, QuestNPCName = "BanditQuest1", QuestPos = CFrame.new(1060, 17, 1547), MobType = "Bandit", MobSpawnArea = CFrame.new(1145, 17, 1638), ScanRange = 300},
    ["Monkey"] = {LevelReq = 10, QuestNPCName = "JungleQuest", QuestPos = CFrame.new(-1599, 37, 153), MobType = "Monkey", MobSpawnArea = CFrame.new(-1446, 67, 109), ScanRange = 300},
    ["Gorilla"] = {LevelReq = 20, QuestNPCName = "JungleQuest", QuestPos = CFrame.new(-1599, 37, 153), MobType = "Gorilla", MobSpawnArea = CFrame.new(-1320, 82, -521), ScanRange = 350},
    ["Pirate"] = {LevelReq = 35, QuestNPCName = "BuggyQuest1", QuestPos = CFrame.new(-1143, 14, 3828), MobType = "Pirate", MobSpawnArea = CFrame.new(-1110, 14, 4350), ScanRange = 400},
    ["Brute"] = {LevelReq = 45, QuestNPCName = "BuggyQuest1", QuestPos = CFrame.new(-1143, 14, 3828), MobType = "Brute", MobSpawnArea = CFrame.new(-1175, 14, 4440), ScanRange = 400},
    ["Desperate"] = {LevelReq = 60, QuestNPCName = "FountainQuest", QuestPos = CFrame.new(-489, 14, 3037), MobType = "Desperate", MobSpawnArea = CFrame.new(-540, 14, 2750), ScanRange = 300},
    ["Swordsman"] = {LevelReq = 75, QuestNPCName = "FountainQuest", QuestPos = CFrame.new(-489, 14, 3037), MobType = "Swordsman", MobSpawnArea = CFrame.new(-650, 14, 2600), ScanRange = 350},
    ["Marine"] = {LevelReq = 90, QuestNPCName = "MarineQuest", QuestPos = CFrame.new(-221, 14, 1894), MobType = "Marine", MobSpawnArea = CFrame.new(-150, 14, 1570), ScanRange = 300},
    ["Vice Admiral"] = {LevelReq = 100, QuestNPCName = "MarineQuest", QuestPos = CFrame.new(-221, 14, 1894), MobType = "Vice Admiral", MobSpawnArea = CFrame.new(-270, 14, 1490), ScanRange = 300},
    ["Fishman"] = {LevelReq = 120, QuestNPCName = "FishmanQuest", QuestPos = CFrame.new(650, 20, -1125), MobType = "Fishman", MobSpawnArea = CFrame.new(650, 20, -1125), ScanRange = 350}, -- Cần điều chỉnh MobSpawnArea chính xác
    ["Fishman Lord"] = {LevelReq = 150, QuestNPCName = "FishmanQuest", QuestPos = CFrame.new(650, 20, -1125), MobType = "Fishman Lord", MobSpawnArea = CFrame.new(650, 20, -1125), ScanRange = 400}, -- Cần điều chỉnh MobSpawnArea chính xác
    -- Thêm các khu vực farm khác của Sea 1 nếu cần
}


-- Hàm di chuyển mượt mà đến vị trí
local function TweenTo(targetCFrame, tweenInfo)
    if CurrentTween then
        CurrentTween:Cancel() -- Hủy tween cũ nếu đang chạy
    end
    CurrentTween = TweenService:Create(HRP, tweenInfo, {CFrame = targetCFrame})
    CurrentTween:Play()
    CurrentTween.Completed:Wait() -- Chờ tween hoàn thành
end

-- Hàm tìm khu vực farm phù hợp nhất dựa trên cấp độ
local function GetBestFarmArea(currentLevel)
    local bestArea = nil
    local maxLevelDiff = -math.huge -- Sử dụng để tìm khu vực có levelReq gần nhất nhưng không vượt quá

    for areaName, data in pairs(FarmAreas) do
        if currentLevel >= data.LevelReq then
            local diff = currentLevel - data.LevelReq
            if diff < maxLevelDiff or bestArea == nil then -- Ưu tiên levelReq cao nhất nhưng vẫn nhỏ hơn level hiện tại
                maxLevelDiff = diff
                bestArea = data
            end
        end
    end
    return bestArea
end

-- Hàm tìm quái vật gần nhất và còn sống trong một khu vực
local function FindNearestMobInArea(mobType, areaCenter, scanRange)
    local nearestMob = nil
    local minDistance = math.huge

    for _, mob in ipairs(Workspace.Enemies:GetChildren()) do
        if mob.Name == mobType and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChildOfClass("Humanoid") and mob.Humanoid.Health > 0 then
            local mobHRP = mob.HumanoidRootPart
            local distanceToAreaCenter = (mobHRP.Position - areaCenter.Position).Magnitude
            
            if distanceToAreaCenter <= scanRange then -- Quái vật nằm trong phạm vi quét
                local distanceToPlayer = (HRP.Position - mobHRP.Position).Magnitude
                if distanceToPlayer < minDistance then
                    minDistance = distanceToPlayer
                    nearestMob = mob
                end
            end
        end
    end
    return nearestMob
end

-- Hàm nhận nhiệm vụ từ NPC
local function GetQuest(farmData)
    local questNPC = Workspace.NPCs:FindFirstChild(farmData.QuestNPCName)
    if questNPC and questNPC:FindFirstChildOfClass("ClickDetector") then
        print("Đang di chuyển đến NPC nhiệm vụ: " .. farmData.QuestNPCName)
        TweenTo(farmData.QuestPos, TweenInfoNormal) -- Di chuyển mượt mà đến NPC
        task.wait(0.5) -- Đợi một chút sau khi di chuyển

        fireclickdetector(questNPC.ClickDetector) -- Kích hoạt ClickDetector
        task.wait(1) -- Đợi server phản hồi
        
        -- Gọi remote function để nhận nhiệm vụ
        ReplicatedStorage.Remotes.Comm:InvokeServer("StartQuest", farmData.QuestNPCName, 1)
        print("Đã nhận nhiệm vụ: " .. farmData.MobType)
    else
        warn("Không tìm thấy NPC nhiệm vụ hoặc ClickDetector cho: " .. farmData.QuestNPCName)
    end
end

-- Hàm tấn công quái vật
local function AttackMob(enemyData)
    local targetMob = nil
    -- Tìm quái vật mục tiêu gần nhất và còn sống
    targetMob = FindNearestMobInArea(enemyData.MobType, enemyData.MobSpawnArea, enemyData.ScanRange)

    if targetMob then
        print("Đang tiếp cận và tấn công quái: " .. enemyData.MobType)
        -- Di chuyển mượt mà đến vị trí mob (hơi nhích lên để tránh kẹt)
        TweenTo(targetMob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0), TweenInfoFast)
        task.wait(0.1) -- Đợi một chút để tween xong

        repeat
            pcall(function()
                -- Kiểm tra lại mob còn hợp lệ không trước khi tấn công
                if not targetMob or not targetMob.Parent or not targetMob:FindFirstChildOfClass("Humanoid") or targetMob.Humanoid.Health <= 0 then
                    return -- Mob đã chết hoặc không còn tồn tại
                end
                
                -- Giả lập nhấn phím tấn công (thường là Z trong Blox Fruits)
                VirtualInputManager:SendKeyEvent(true, "Z", false, game)
                VirtualInputManager:SendKeyEvent(false, "Z", false, game)
            end)
            task.wait(0.3) -- Thời gian chờ giữa các lần tấn công
        until not AutoFarmEnabled or not targetMob or not targetMob.Parent or not targetMob:FindFirstChildOfClass("Humanoid") or targetMob.Humanoid.Health <= 0
    else
        print("Không tìm thấy quái '" .. enemyData.MobType .. "' trong khu vực farm. Đang chờ...")
        task.wait(2) -- Đợi nếu không tìm thấy mob
    end
end

-- Nút bật/tắt chức năng Auto Farm
FarmTab:CreateToggle({
   Name = "Bật/Tắt Auto Farm Level AI (Mobile)",
   CurrentValue = false,
   Flag = "AutoFarmLevelAIToggle",
   Callback = function(Value)
      AutoFarmEnabled = Value
      if AutoFarmEnabled then
         print("Auto Farm Level AI đã BẬT. Bắt đầu phân tích...")
         local FarmLoopThread = task.spawn(function()
            while AutoFarmEnabled do
               local currentLevel = Player.Data.Level.Value
               local currentFarmArea = GetBestFarmArea(currentLevel)

               if currentFarmArea then
                  print("Đã chọn khu vực farm: " .. currentFarmArea.MobType .. " (Cấp độ yêu cầu: " .. currentFarmArea.LevelReq .. ")")
                  
                  -- Kiểm tra xem người chơi đã có nhiệm vụ này chưa
                  local questGui = Player.PlayerGui.Main.Quest
                  local hasQuest = false
                  if questGui and questGui.Visible and questGui.Container.QuestTitle.Title.Text then
                    if string.find(questGui.Container.QuestTitle.Title.Text, currentFarmArea.MobType) then
                        hasQuest = true
                    end
                  end
                  
                  if not hasQuest then
                     GetQuest(currentFarmArea) -- Nhận nhiệm vụ nếu chưa có
                     task.wait(1.5) -- Đợi một chút sau khi nhận nhiệm vụ
                  else
                     -- Đã có nhiệm vụ, di chuyển đến khu vực farm và tấn công
                     print("Đã có nhiệm vụ. Di chuyển đến khu vực farm và tấn công...")
                     TweenTo(currentFarmArea.MobSpawnArea, TweenInfoNormal)
                     task.wait(0.5) -- Đợi để tween hoàn thành
                     AttackMob(currentFarmArea) -- Bắt đầu tấn công quái
                  end
               else
                  print("Không tìm thấy khu vực farm phù hợp với cấp độ hiện tại (" .. currentLevel .. ").")
                  task.wait(5) -- Đợi một lát nếu không tìm thấy khu vực phù hợp
               end
               task.wait(1) -- Thời gian chờ giữa các chu kỳ farm chính
            end
            print("Auto Farm Level AI đã TẮT.")
         end)
      else
         if CurrentTween then
             CurrentTween:Cancel() -- Hủy tween nếu đang chạy khi script tắt
             CurrentTween = nil
         end
      end
   end,
})

print("Script Auto Farm Level AI (Mobile) đã tải thành công!")
