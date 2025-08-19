-- MacroCore.lua v2 — Record/Play/Save/Load cho Garden Tower Defense
-- Không hardcode tên Remote, dùng __namecall hook + serialize args an toàn.

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Folder = "GardenMacros"
if not isfolder(Folder) then makefolder(Folder) end

-- ===== Serialize / Deserialize (Vector3, CFrame, Instance path, table lồng nhau) =====
local function InstPath(inst)
    local ok, full = pcall(function() return inst:GetFullName() end)
    return ok and full or nil
end

local function Serialize(v)
    local t = typeof(v)
    if t == "Vector3" then
        return {__t="Vector3", x=v.X, y=v.Y, z=v.Z}
    elseif t == "CFrame" then
        local comps = {v:GetComponents()}
        return {__t="CFrame", c=comps}
    elseif t == "Instance" then
        local p = InstPath(v)
        return {__t="Instance", path=p}
    elseif t == "table" then
        local out = {}
        for k,val in pairs(v) do out[k] = Serialize(val) end
        return out
    else
        return v
    end
end

local function WaitFind(parent, name, timeout)
    timeout = timeout or 5
    local obj = parent:FindFirstChild(name)
    if obj then return obj end
    local t = 0
    while t < timeout do
        obj = parent:FindFirstChild(name)
        if obj then return obj end
        task.wait(0.1); t += 0.1
    end
    return nil
end

local function ResolvePath(path)
    if not path or type(path) ~= "string" then return nil end
    local segments = {}
    for seg in string.gmatch(path, "[^%.]+") do table.insert(segments, seg) end
    if #segments == 0 then return nil end

    local current
    -- segment đầu tiên thường là tên Service như "ReplicatedStorage"
    local first = segments[1]
    pcall(function() current = game:GetService(first) end)
    if not current then return nil end

    for i = 2, #segments do
        current = WaitFind(current, segments[i], 5)
        if not current then return nil end
    end
    return current
end

local function Deserialize(v)
    if type(v) == "table" and v.__t == "Vector3" then
        return Vector3.new(v.x, v.y, v.z)
    elseif type(v) == "table" and v.__t == "CFrame" then
        return CFrame.new(unpack(v.c))
    elseif type(v) == "table" and v.__t == "Instance" then
        return ResolvePath(v.path)
    elseif type(v) == "table" then
        local out = {}
        for k,val in pairs(v) do out[k] = Deserialize(val) end
        return out
    else
        return v
    end
end

-- ===== Macro state =====
local MacroTable = {}
local Recording = false
local Playing   = false
local LastActionTime = tick()

local function ClearMacro() MacroTable = {} end

-- ===== Record via __namecall hook =====
local old; old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if Recording and method == "FireServer" and self.ClassName == "RemoteEvent" then
        -- Lọc bớt chat để khỏi rác
        if not self:GetFullName():find("DefaultChatSystemChatEvents") then
            -- Chỉ lấy các RemoteEvent nằm trong ReplicatedStorage (thường là vậy ở game này)
            if self:IsDescendantOf(ReplicatedStorage) then
                local now = tick()
                local delay = now - LastActionTime
                LastActionTime = now

                table.insert(MacroTable, {
                    Delay = delay,
                    RemotePath = InstPath(self),
                    Method = "FireServer",
                    Args = Serialize(args),
                })
            end
        end
    end

    return old(self, ...)
end))

-- ===== Play =====
local function PlayMacro()
    if Playing or #MacroTable == 0 then return end
    Playing = true
    task.spawn(function()
        for _, step in ipairs(MacroTable) do
            if not Playing then break end
            task.wait(step.Delay or 0)
            local remote = ResolvePath(step.RemotePath)
            if remote and remote.ClassName == "RemoteEvent" and step.Method == "FireServer" then
                local args = Deserialize(step.Args or {})
                pcall(function()
                    remote:FireServer(unpack(args))
                end)
            end
        end
        Playing = false
    end)
end

-- ===== Save / Load / List / Delete =====
local function SaveMacro(name)
    if not name or name == "" or #MacroTable == 0 then return end
    local ok, data = pcall(function() return HttpService:JSONEncode(MacroTable) end)
    if ok then writefile(("%s/%s.json"):format(Folder, name), data) end
end

local function LoadMacro(name)
    if not name or name == "" then return end
    local path = ("%s/%s.json"):format(Folder, name)
    if not isfile(path) then return end
    local ok, decoded = pcall(function()
        return HttpService:JSONDecode(readfile(path))
    end)
    if ok and type(decoded) == "table" then
        MacroTable = decoded
    end
end

local function ListMacros()
    local list = {}
    if not isfolder(Folder) then return list end
    for _, p in ipairs(listfiles(Folder)) do
        if p:match("%.json$") then table.insert(list, (p:match("([^/\\]+)%.json$"))) end
    end
    table.sort(list)
    return list
end

local function DeleteMacro(name)
    local path = ("%s/%s.json"):format(Folder, name)
    if isfile(path) then delfile(path) end
end

-- ===== Public API =====
local M = {}
function M.StartRecord() Recording = true; ClearMacro(); LastActionTime = tick() end
function M.StopRecord()  Recording = false end
function M.Play()        PlayMacro() end
function M.Stop()        Playing = false end
function M.Clear()       ClearMacro() end
function M.Save(name)    SaveMacro(name) end
function M.Load(name)    LoadMacro(name) end
function M.List()        return ListMacros() end
function M.Delete(name)  DeleteMacro(name) end
return M
