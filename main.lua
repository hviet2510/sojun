-- Rayfield UI (gọn lại)
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/sojun/main/Rayfield.lua"))()

-- Giao diện UI
local Window = Rayfield:CreateWindow({
   Name = "Auto Farm Blox Fruits - Sea 1",
   LoadingTitle = "Noda System",
   LoadingSubtitle = "by hviet2510",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "NodaSystem",
      FileName = "NodaFarmConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false
})

-- Tab Farm
local FarmTab = Window:CreateTab("🏝️ Auto Farm", 4483362458)

-- Biến
local AutoFarm = false
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Enemy list Sea 1 (dữ liệu cố định)
local Enemies = {
   {Name = "Bandit", LevelReq = 0, Quest = "BanditQuest1", QuestPart = "Bandit", QuestPos = CFrame.new(1060, 17, 1547), MobPos = CFrame.new(1145, 17, 1638)},
   {Name = "Monkey", LevelReq = 10, Quest = "JungleQuest", QuestPart = "Monkey", QuestPos = CFrame.new(-1599, 37, 153), MobPos = CFrame.new(-1446, 67, 109)},
   {Name = "Gorilla", LevelReq = 20, Quest = "JungleQuest", QuestPart = "Gorilla", QuestPos = CFrame.new(-1599, 37, 153), MobPos = CFrame.new(-1320, 82, -521)},
   {Name = "Pirate", LevelReq = 35, Quest = "BuggyQuest1", QuestPart = "Pirate", QuestPos = CFrame.new(-1143, 14, 3828), MobPos = CFrame.new(-1110, 14, 4350)},
   -- Add thêm tùy ý
}

-- Tìm quái theo level người chơi
local function GetEnemyForLevel(level)
   local selected
   for _, enemy in ipairs(Enemies) do
      if level >= enemy.LevelReq then
         selected = enemy
      end
   end
   return selected
end

-- Hàm nhận nhiệm vụ
local function GetQuest(enemy)
   local quest = game:GetService("Workspace").NPCs:FindFirstChild(enemy.Quest)
   if quest then
      HRP.CFrame = enemy.QuestPos
      wait(1.2)
      fireclickdetector(quest.ClickDetector)
      wait(1)
      game:GetService("ReplicatedStorage").Remotes.Comm:InvokeServer("StartQuest", enemy.Quest, 1)
   end
end

-- Đánh quái
local function AttackMob(enemy)
   for _, mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
      if mob.Name == enemy.Name and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
         repeat
            pcall(function()
               HRP.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)
               game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
               game:GetService("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
            end)
            wait(0.25)
         until not mob or not mob.Parent or mob.Humanoid.Health <= 0 or AutoFarm == false
      end
   end
end

-- Bật farm
FarmTab:CreateToggle({
   Name = "Tự động Farm Level Sea 1",
   CurrentValue = false,
   Flag = "AutoFarmToggle",
   Callback = function(Value)
      AutoFarm = Value
      while AutoFarm do
         local level = Player.Data.Level.Value
         local enemy = GetEnemyForLevel(level)
         if enemy then
            if not Player.PlayerGui.Main.Quest.Visible or not string.find(Player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, enemy.Name) then
               GetQuest(enemy)
            else
               AttackMob(enemy)
            end
         end
         wait(0.5)
      end
   end,
})
