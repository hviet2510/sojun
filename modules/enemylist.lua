-- enemylist.lua

-- Danh sách mob Sea 1: level, auto chọn, hiển thị, thông tin nhiệm vụ, tên mob, vị trí mob
return {
    ["Bandit"] = {
        Level = 5, AutoMob = true, DisplayName = "Bandit (Lv 5+)",
        QuestName = "BanditQuest1", QuestLevel = 1, QuestNPC = "BanditQuestGiver",
        QuestPos = Vector3.new(1060,17,1547), MobName = "Bandit",
        MobPos = Vector3.new(1150,17,1630)
    },
    ["Monkey"] = {
        Level = 10, AutoMob = true, DisplayName = "Monkey (Lv 10+)",
        QuestName = "JungleQuest", QuestLevel = 1, QuestNPC = "JungleQuestGiver",
        QuestPos = Vector3.new(-1603,7,153), MobName = "Monkey",
        MobPos = Vector3.new(-1448,8,112)
    },
    ["Gorilla"] = {
        Level = 20, AutoMob = true, DisplayName = "Gorilla (Lv 20+)",
        QuestName = "JungleQuest", QuestLevel = 2, QuestNPC = "JungleQuestGiver",
        QuestPos = Vector3.new(-1603,7,153), MobName = "Gorilla",
        MobPos = Vector3.new(-1320,6,-530)
    },
    ["Pirate"] = {
        Level = 30, AutoMob = true, DisplayName = "Pirate (Lv 30+)",
        QuestName = "PirateQuest", QuestLevel = 3, QuestNPC = "PirateQuestGiver",
        QuestPos = Vector3.new(-1202,4,3892), MobName = "Pirate",
        MobPos = Vector3.new(-1202,4,3892)
    },
    ["Brute"] = {
        Level = 40, AutoMob = true, DisplayName = "Brute (Lv 40+)",
        QuestName = "BruteQuest", QuestLevel = 4, QuestNPC = "BruteQuestGiver",
        QuestPos = Vector3.new(-1140,15,4320), MobName = "Brute",
        MobPos = Vector3.new(-1140,15,4320)
    },
    ["Buggy"] = {
        Level = 55, AutoMob = true, DisplayName = "Buggy (Lv 55+)",
        QuestName = "BuggyQuest", QuestLevel = 5, QuestNPC = "BuggyQuestGiver",
        QuestPos = Vector3.new(-1145,5,4395), MobName = "Buggy",
        MobPos = Vector3.new(-1145,5,4395)
    },
    ["Desert Bandit"] = {
        Level = 75, AutoMob = true, DisplayName = "Desert Bandit (Lv 75+)",
        QuestName = "DesertBanditQuest", QuestLevel = 6, QuestNPC = "DesertQuestGiver",
        QuestPos = Vector3.new(933,7,4480), MobName = "Desert Bandit",
        MobPos = Vector3.new(933,7,4480)
    },
    ["Desert Officer"] = {
        Level = 90, AutoMob = true, DisplayName = "Desert Officer (Lv 90+)",
        QuestName = "DesertOfficerQuest", QuestLevel = 7, QuestNPC = "DesertQuestGiver",
        QuestPos = Vector3.new(1572,10,4371), MobName = "Desert Officer",
        MobPos = Vector3.new(1572,10,4371)
    },
    ["Snow Bandit"] = {
        Level = 100, AutoMob = true, DisplayName = "Snow Bandit (Lv 100+)",
        QuestName = "SnowQuest", QuestLevel = 8, QuestNPC = "SnowQuestGiver",
        QuestPos = Vector3.new(1426,106,-1327), MobName = "Snow Bandit",
        MobPos = Vector3.new(1426,106,-1327)
    },
    ["Snowman"] = {
        Level = 120, AutoMob = true, DisplayName = "Snowman (Lv 120+)",
        QuestName = "SnowQuest", QuestLevel = 9, QuestNPC = "SnowQuestGiver",
        QuestPos = Vector3.new(1243,137,-1452), MobName = "Snowman",
        MobPos = Vector3.new(1243,137,-1452)
    },
    ["Chief Petty Officer"] = {
        Level = 150, AutoMob = true, DisplayName = "Chief Petty Officer (Lv 150+)",
        QuestName = "OfficerQuest", QuestLevel = 10, QuestNPC = "OfficerQuestGiver",
        QuestPos = Vector3.new(-4881,22,4308), MobName = "Chief Petty Officer",
        MobPos = Vector3.new(-4881,22,4308)
    },
    ["Sky Bandit"] = {
        Level = 175, AutoMob = true, DisplayName = "Sky Bandit (Lv 175+)",
        QuestName = "SkyQuest", QuestLevel = 11, QuestNPC = "SkyQuestGiver",
        QuestPos = Vector3.new(-4951,296,-2852), MobName = "Sky Bandit",
        MobPos = Vector3.new(-4951,296,-2852)
    },
    ["Dark Master"] = {
        Level = 190, AutoMob = true, DisplayName = "Dark Master (Lv 190+)",
        QuestName = "DarkQuest", QuestLevel = 12, QuestNPC = "DarkQuestGiver",
        QuestPos = Vector3.new(-5224,430,-2285), MobName = "Dark Master",
        MobPos = Vector3.new(-5224,430,-2285)
    },
    ["Prisoner"] = {
        Level = 210, AutoMob = true, DisplayName = "Prisoner (Lv 210+)",
        QuestName = "PrisonerQuest", QuestLevel = 13, QuestNPC = "PrisonQuestGiver",
        QuestPos = Vector3.new(5293,4,476), MobName = "Prisoner",
        MobPos = Vector3.new(5293,4,476)
    },
    ["Dangerous Prisoner"] = {
        Level = 250, AutoMob = true, DisplayName = "Dangerous Prisoner (Lv 250+)",
        QuestName = "DangerousPrisonerQuest", QuestLevel = 14, QuestNPC = "PrisonQuestGiver",
        QuestPos = Vector3.new(5227,0,865), MobName = "Dangerous Prisoner",
        MobPos = Vector3.new(5227,0,865)
    },
    ["Toga Warrior"] = {
        Level = 275, AutoMob = true, DisplayName = "Toga Warrior (Lv 275+)",
        QuestName = "TogaQuest", QuestLevel = 15, QuestNPC = "TogaQuestGiver",
        QuestPos = Vector3.new(-1796,8,-2741), MobName = "Toga Warrior",
        MobPos = Vector3.new(-1796,8,-2741)
    },
    ["Gladiator"] = {
        Level = 300, AutoMob = true, DisplayName = "Gladiator (Lv 300+)",
        QuestName = "GladiatorQuest", QuestLevel = 16, QuestNPC = "GladiatorQuestGiver",
        QuestPos = Vector3.new(-1278,7,-3173), MobName = "Gladiator",
        MobPos = Vector3.new(-1278,7,-3173)
    },
    ["Military Soldier"] = {
        Level = 325, AutoMob = true, DisplayName = "Military Soldier (Lv 325+)",
        QuestName = "MilitaryQuest", QuestLevel = 17, QuestNPC = "MilitaryQuestGiver",
        QuestPos = Vector3.new(-4975,29,2015), MobName = "Military Soldier",
        MobPos = Vector3.new(-4975,29,2015)
    },
    ["Military Spy"] = {
        Level = 350, AutoMob = true, DisplayName = "Military Spy (Lv 350+)",
        QuestName = "MilitarySpyQuest", QuestLevel = 18, QuestNPC = "MilitaryQuestGiver",
        QuestPos = Vector3.new(-5811,5,2426), MobName = "Military Spy",
        MobPos = Vector3.new(-5811,5,2426)
    },
    ["Fishman Warrior"] = {
        Level = 375, AutoMob = true, DisplayName = "Fishman Warrior (Lv 375+)",
        QuestName = "FishmanQuest", QuestLevel = 19, QuestNPC = "FishmanQuestGiver",
        QuestPos = Vector3.new(6086,19,-2435), MobName = "Fishman Warrior",
        MobPos = Vector3.new(6086,19,-2435)
    },
    ["Fishman Commando"] = {
        Level = 400, AutoMob = true, DisplayName = "Fishman Commando (Lv 400+)",
        QuestName = "FishmanQuest", QuestLevel = 20, QuestNPC = "FishmanQuestGiver",
        QuestPos = Vector3.new(5787,10,-2672), MobName = "Fishman Commando",
        MobPos = Vector3.new(5787,10,-2672)
    },
    ["Wysper"] = {
        Level = 450, AutoMob = true, DisplayName = "Wysper (Lv 450+)",
        QuestName = "WysperQuest", QuestLevel = 21, QuestNPC = "FishmanQuestGiver",
        QuestPos = Vector3.new(6181,65,-3626), MobName = "Wysper",
        MobPos = Vector3.new(6181,65,-3626)
    },
    ["Thunder God"] = {
        Level = 475, AutoMob = true, DisplayName = "Thunder God (Lv 475+)",
        QuestName = "ThunderGodQuest", QuestLevel = 22, QuestNPC = "FishmanQuestGiver",
        QuestPos = Vector3.new(-5911,44,-227), MobName = "Thunder God",
        MobPos = Vector3.new(-5911,44,-227)
    },
    ["Cyborg"] = {
        Level = 525, AutoMob = true, DisplayName = "Cyborg (Lv 525+)",
        QuestName = "CyborgQuest", QuestLevel = 23, QuestNPC = "CyborgQuestGiver",
        QuestPos = Vector3.new(2611,3,-5655), MobName = "Cyborg",
        MobPos = Vector3.new(2611,3,-5655)
    },
    ["Vice Admiral"] = {
        Level = 550, AutoMob = true, DisplayName = "Vice Admiral (Lv 550+)",
        QuestName = "AdmiralQuest", QuestLevel = 24, QuestNPC = "CyborgQuestGiver",
        QuestPos = Vector3.new(-5036,72,851), MobName = "Vice Admiral",
        MobPos = Vector3.new(-5036,72,851)
    },
    ["Swan Pirate"] = {
        Level = 625, AutoMob = true, DisplayName = "Swan Pirate (Lv 625+)",
        QuestName = "SwanQuest", QuestLevel = 25, QuestNPC = "AdmiralQuestGiver",
        QuestPos = Vector3.new(877,122,1235), MobName = "Swan Pirate",
        MobPos = Vector3.new(877,122,1235)
    },
    ["Factory Staff"] = {
        Level = 650, AutoMob = true, DisplayName = "Factory Staff (Lv 650+)",
        QuestName = "FactoryQuest", QuestLevel = 26, QuestNPC = "FactoryQuestGiver",
        QuestPos = Vector3.new(295,40,430), MobName = "Factory Staff",
        MobPos = Vector3.new(295,40,430)
    },
    ["Magma Admiral"] = {
        Level = 675, AutoMob = true, DisplayName = "Magma Admiral (Lv 675+)",
        QuestName = "MagmaQuest", QuestLevel = 27, QuestNPC = "FactoryQuestGiver",
        QuestPos = Vector3.new(-5111,86,-2984), MobName = "Magma Admiral",
        MobPos = Vector3.new(-5111,86,-2984)
    }
}
