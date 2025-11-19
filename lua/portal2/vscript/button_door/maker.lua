print("[P2] maker.lua loaded")
--=========================================================
-- This script is attached to an entity spawner. It will
-- spawn a template at a specifically named info_target
-- and move the sign to a specifically named info_target.
--
-- Button info_targets must be named like:
-- door01_button01
--
-- Sign info_targets must be named like:
-- door01_sign01
--=========================================================

-- debugging
local DBG = true

-- object sizes
local size = {
    small = 1,
    normal = 2,
    large = 3
}

-- table for entity groups (replace these with actual templates/entities)
local EntityGroup = {
    [size.small] = {},
    [size.normal] = {},
    [size.large] = {}
}

-- spawn a button at the info_target
local function SpawnButtonAtTarget(target, button_size)
    if not target then return end
    local group = EntityGroup[button_size]
    if not group then return end
    
    -- For simplicity, just print what would spawn
    if DBG then
        print("Spawning button of size: ", button_size)
    end
    
    -- Assuming group is a table of entity class names to spawn
    for _, class in ipairs(group) do
        local ent = ents.Create(class)
        if IsValid(ent) then
            ent:SetPos(target:GetPos())
            ent:Spawn()
        end
    end
end

-- main function
local function OnPostSpawn()
    local cur_ent_index = 0
    local info_targets = ents.FindByClass("info_target")
    
    for _, cur_ent in ipairs(info_targets) do
        local name = cur_ent:GetName()
        if name:find("button") and cur_ent.is_button_target then
            local butt_pos = name:find("button")
            local system_name = string.sub(name, 1, butt_pos - 1)
            local butt_numb = string.sub(name, butt_pos + 6)

            if DBG then
                print("Button pos: " .. butt_pos)
                print("System name: " .. system_name)
                print("Button number: " .. butt_numb)
            end

            SpawnButtonAtTarget(cur_ent, cur_ent.button_size or size.normal)

            -- find corresponding sign
            local sign = nil
            local brushes = ents.FindInSphere(cur_ent:GetPos(), 1000)
            for _, brush in ipairs(brushes) do
                if brush:GetClass() == "func_brush" and brush.is_sign then
                    sign = brush
                    if DBG then
                        print("Found a brush: " .. tostring(brush))
                    end
                    break
                end
            end

            if not sign then
                if DBG then
                    print("No sign for " .. tostring(cur_ent))
                end
                return
            end

            local sign_dest_name = system_name .. "sign" .. butt_numb
            local dest = ents.FindByName(sign_dest_name)[1]
            if dest then
                sign:SetPos(dest:GetPos())
                sign:SetAngles(dest:GetAngles())
                if DBG then
                    print("Moved sign to: " .. sign_dest_name)
                end
            else
                if DBG then
                    print("Destination sign not found: " .. sign_dest_name)
                end
            end
        end
    end
end

-- Run the function (for testing or hooking to entity spawn)
OnPostSpawn()