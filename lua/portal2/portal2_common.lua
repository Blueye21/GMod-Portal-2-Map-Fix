-- Common functions used in Portal 2 VScript.

-- Fires a specific input on all entities matching a target name
function EntFire(targetname, input, param, delay)
    if not targetname or targetname == "" then return end
    local targets = ents.FindByName(targetname)
    if not targets or #targets == 0 then return end

    for _, ent in ipairs(targets) do
        if IsValid(ent) and ent.Fire then
            ent:Fire(input, param or "", delay or 0)
        end
    end
end

function SafeEntFire(target, inp, param, delay)
    if not target then
        print("[P2] SafeEntFire caught nil target")
        return
    end

    local targets = {}

    if type(target) == "string" then
        targets = ents.FindByName(target)
    elseif IsValid(target) then
        targets = {target}  -- wrap entity in a table
    else
        print("[P2] SafeEntFire got invalid target:", type(target))
        return
    end

    for _, ent in ipairs(targets) do
        if IsValid(ent) then
            ent:Fire(inp, param, delay or 0)
        end
    end
end

function CreateSceneEntity(path)
    if SERVER then
        local ent = ents.Create("logic_choreographed_scene")
        if not IsValid(ent) then return nil end

        ent:SetKeyValue("SceneFile", path)
        ent:SetPos(Vector(0, 0, 0)) -- You can set this to wherever you want it
        ent:Spawn()
        ent:Activate()

        return ent
    end
end