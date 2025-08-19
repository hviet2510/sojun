-- MacroCore.lua — Garden Tower Defense Macro Core (Record / Play / Save / Load / List / Delete)
-- Author: GPT

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

-- RemoteEvents trong game
local PlaceTowerEvent = ReplicatedStorage.RemoteEvents:WaitForChild("PlaceTower")
local UpgradeEvent    = ReplicatedStorage.RemoteEvents:WaitForChild("UpgradeTower")
local SellEvent       = ReplicatedStorage.RemoteEvents:WaitForChild("SellTower")
local SkipEvent       = ReplicatedStorage.RemoteEvents:WaitForChild("Skip")

-- Dữ liệu
local MacroTable = {}
local Recording = false
local Playing = false
local LastActionTime = tick()
local Folder = "GardenMacros"

if not isfolder(Folder) then
    makefolder(Folder)
end

-- Ghi hành động
local function RecordAction(actionType, args)
    if not Recording then return end
    local now = tick()
    local delay = now - LastActionTime
    LastActionTime = now
    table.insert(MacroTable, {Type = actionType, Args = args, Delay = delay})
end

-- Hook vào các RemoteEvent để ghi hành động game
local oldPlace = PlaceTowerEvent.FireServer
PlaceTowerEvent.FireServer = function(self, tower, position, ...)
    RecordAction("Place", {tower, position})
    return oldPlace(self, tower, position, ...)
end

local oldUpgrade = UpgradeEvent.FireServer
UpgradeEvent.FireServer = function(self, tower, ...)
    RecordAction("Upgrade", {tower})
    return oldUpgrade(self, tower, ...)
end

local oldSell = SellEvent.FireServer
SellEvent.FireServer = function(self, tower, ...)
    RecordAction("Sell", {tower})
    return oldSell(self, tower, ...)
end

local oldSkip = SkipEvent.FireServer
SkipEvent.FireServer = function(self, ...)
    RecordAction("Skip", {})
    return oldSkip(self, ...)
end

-- Phát lại macro
local function PlayMacro()
    if Playing or #MacroTable == 0 then return end
    Playing = true
    task.spawn(function()
        for _, action in ipairs(MacroTable) do
            if not Playing then break end  -- cho phép dừng giữa lúc chạy
            task.wait(action.Delay)
            if action.Type == "Place" then
                PlaceTowerEvent:FireServer(unpack(action.Args))
            elseif action.Type == "Upgrade" then
                UpgradeEvent:FireServer(unpack(action.Args))
            elseif action.Type == "Sell" then
                SellEvent:FireServer(unpack(action.Args))
            elseif action.Type == "Skip" then
                SkipEvent:FireServer()
            end
        end
        Playing = false
    end)
end

-- Lưu macro vào file
local function SaveMacro(name)
    if #MacroTable == 0 then return end
    local data = HttpService:JSONEncode(MacroTable)
    writefile(Folder .. "/" .. name .. ".json", data)
end

-- Load macro từ file
local function LoadMacro(name)
    local path = Folder .. "/" .. name .. ".json"
    if not isfile(path) then return end
    local content = readfile(path)
    local ok, decoded = pcall(function() return HttpService:JSONDecode(content) end)
    if ok then
        MacroTable = decoded
    end
end

-- Liệt kê file macro đã lưu
local function ListMacros()
    local result = {}
    local files = listfiles(Folder)
    for _, path in ipairs(files) do
        if path:match("%.json$") then
            local name = path:match("([^/\\]+)%.json$")
            table.insert(result, name)
        end
    end
    return result
end

-- Xóa macro
local function DeleteMacro(name)
    local path = Folder .. "/" .. name .. ".json"
    if isfile(path) then
        delfile(path)
    end
end

-- Dừng chạy macro giữa chừng
local function StopMacro()
    Playing = false
end

-- Xóa dữ liệu tạm
local function ClearMacro()
    MacroTable = {}
end

-- Xuất API cho bạn bind UI
local Macro = {}

function Macro.StartRecord() Recording = true; MacroTable = {}; LastActionTime = tick() end
function Macro.StopRecord() Recording = false end
function Macro.Play() PlayMacro() end
function Macro.Stop() StopMacro() end
function Macro.Save(name) if name and name ~= "" then SaveMacro(name) end end
function Macro.Load(name) if name and name ~= "" then LoadMacro(name) end end
function Macro.List() return ListMacros() end
function Macro.Delete(name) if name and name ~= "" then DeleteMacro(name) end end
function Macro.Clear() ClearMacro() end

return Macro
