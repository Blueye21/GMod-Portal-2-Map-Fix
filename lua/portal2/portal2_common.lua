--[[---------------------------------------------------------------------------
    Portal 2 VScript helpers – optimised
---------------------------------------------------------------------------]]--

-- ---------------------------------------------------------------------------
-- Fast single-line exit helper
local function early(ret) return ret end

-- ---------------------------------------------------------------------------
-- Fire an input on every entity that matches *targetname*.
-- *param* and *delay* are optional.
function EntFire(targetname, input, param, delay)
    if targetname == "" then return end          -- empty string is the only bad value we need to guard
    for _, ent in ipairs(ents.FindByName(targetname)) do
        if ent.Fire then ent:Fire(input, param or "", delay or 0) end
    end
end

function EntFireByHandle(sceneUD, input, param, delay, activator, caller)
    if not sceneUD then return end

    -- Try to get an entity index from the userdata
    local idx
    if sceneUD.EntIndex then
        idx = sceneUD:EntIndex()
    elseif sceneUD.GetEntityIndex then
        idx = sceneUD:GetEntityIndex()
    end
    if not idx then return end

    local ent = Entity(idx)
    if not IsValid(ent) then return end

    delay = delay or 0

    if delay <= 0 then
        ent:Input(input, activator, caller, param)
        -- or: ent:Fire(input, param or "", 0)
    else
        timer.Simple(delay, function()
            if IsValid(ent) then
                ent:Input(input, activator, caller, param)
            end
        end)
    end
end
-- ---------------------------------------------------------------------------
-- Fire an input on one entity or on every entity whose name matches *target*.
-- *target* may be an entity object or a string.
function SafeEntFire(target, input, param, delay)
    if not target then
        print("[P2] SafeEntFire: nil target")
        return
    end

    local list
    if isstring(target) then
        list = ents.FindByName(target)
    elseif IsValid(target) then
        list = {target}          -- single entity wrapped
    else
        print("[P2] SafeEntFire: invalid target type", type(target))
        return
    end

    for i = 1, #list do                     -- faster than ipairs
        local ent = list[i]
        if IsValid(ent) then ent:Fire(input, param or "", delay or 0) end
    end
end

-- ---------------------------------------------------------------------------
-- Spawn a logic_choreographed_scene and return it (server only).
function CreateSceneEntity(path)
    if CLIENT then return end

    local ent = ents.Create("logic_choreographed_scene")
    if not IsValid(ent) then return end

    ent:SetKeyValue("SceneFile", path)
    ent:SetPos(vector_origin)   -- cheaper than Vector(0,0,0)
    ent:Spawn()
    ent:Activate()

    return ent
end