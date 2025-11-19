--=========================================================
-- This script is attached to a logic_script entity.  The  
-- script should reference info_target entities that are 
-- spawn destinations for nuggets.
-- 
-- EntityGroup[0] should point to the env_maker
-- EntityGroup[1] should be the name of the spawn destinations
-- EntityGroup[2] should point to the game_text entity
--=========================================================

-- debugging
local DBG = 0

-- number of available nuggets
local number_of_nuggets = 0

-- number of nuggets awarded to player
local AwardedNuggetCount = 0

-----------------------------------------------------------
-- OnPostSpawn
-----------------------------------------------------------
function OnPostSpawn()
    spawn_dest_array = {} -- reset the array
    number_of_nuggets = 0

    local cur_ent = nil

    -- Collect all info_targets that match EntityGroup[1]'s name
    while true do
        cur_ent = ents.FindByClass(cur_ent, "info_target") -- Not a 1:1 match with VScript, see notes below
        if not IsValid(cur_ent) then break end

        if cur_ent:GetName() == EntityGroup[1]:GetName() then
            number_of_nuggets = number_of_nuggets + 1
            table.insert(spawn_dest_array, cur_ent)

            if DBG then
                print("[VSCRIPT_DEBUG] appended " .. number_of_nuggets .. " " .. cur_ent:GetName() .. " to spawn_dest_array")
            end
        end
    end

    if DBG then
        print("[VSCRIPT_DEBUG] spawning " .. number_of_nuggets .. " nuggets.")
    end

    -- Spawn entities at each destination
    for i = 1, number_of_nuggets do
        -- In Lua arrays are 1-based, so spawn_dest_array[i] is correct
        EntityGroup[0]:SpawnEntityAtEntityOrigin(spawn_dest_array[i])

        if DBG then
            print("[VSCRIPT_DEBUG] spawning " .. tostring(EntityGroup[0]) .. " at " .. spawn_dest_array[i]:GetName())
        end
    end
end

-----------------------------------------------------------
-- This function gets called when a nugget trigger is touched
-----------------------------------------------------------
function AwardNugget()
    AwardedNuggetCount = AwardedNuggetCount + 1

    if DBG then
        print("[VSCRIPT_DEBUG] You got " .. AwardedNuggetCount .. " of " .. number_of_nuggets .. " Aperture Incentivizing Nuggets!")
    end

    -- Fire output events (you may need to implement EntFire in Lua)
    EntFire(EntityGroup[2]:GetName(), "settext",
        "You got " .. AwardedNuggetCount .. " of " .. number_of_nuggets .. " Aperture Incentivizing Nuggets!")
    EntFire(EntityGroup[2]:GetName(), "display")
end