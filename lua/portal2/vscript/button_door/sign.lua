print("[P2] sign.lua loaded")
//=========================================================
// This script is attached to the sign entity.
// When the sign spawn it looks around for nearby doors.
// If the doors are portal doors then the doors increment
// their total buttons.
//=========================================================

// debugging
local DBG = 1

// door search range
local FIND_DOOR_RANGE = 200


local my_door = nil
local is_sign = true

//---------------------------------------------------------
// OnPostSpawn
//---------------------------------------------------------
function OnPostSpawn(ent)
    if not IsValid(ent) then return end

    local my_door = nil
    local ent_pos = ent:GetPos()

    -- Get all doors
    local doors = ents.FindByClass("func_door")

    for _, door in ipairs(doors) do
        if IsValid(door) and door.is_portal_door then
            local distance = door:GetPos():Distance(ent_pos)
            if distance <= FIND_DOOR_RANGE then
                my_door = door
                if DBG then
                    print((ent:GetName() or "unnamed") .. " found a door: " .. (door:GetName() or "unnamed") .. " at distance " .. distance)
                end
                break -- take the first valid door within range
            end
        end
    end

    if not my_door then
        if DBG then
            print((ent:GetName() or "unnamed") .. ": Did not find a nearby door.")
        end
        return
    end

    -- Increment total buttons if the door supports it
    if my_door.IncrementTotalButtons then
        my_door:IncrementTotalButtons()
    end
end
local button = ents.FindByClass("prop_floor_button")
for _, ent in ipairs(button) do
    OnPostSpawn(ent)
end

//---------------------------------------------------------
// fires when OnUser1 is triggered, which is any time the
// button gets pressed
//---------------------------------------------------------
hook.Add("OnUser1Output", "ButtonPressedHook", function(ent)
    if DBG then
        print("attempting to open nearby door with door.nut")
    end

    if my_door and my_door.CloseButton then
        my_door:CloseButton()
        end

    local cur_ent = nil
    local info_targets = ents.FindByClass("info_target")

    for _, ent in ipairs(info_targets) do
        local distance = ent:GetPos():Distance(ent:GetPos())
        if distance <= 8 and ent.is_sign_target then
            if DBG then
                print("found info_target: " .. (ent:GetName() or "unnamed"))
            end
            EntFire(ent:GetName(), "fireuser1")
        end
    end
end)
-- Fires when the button is unpressed
hook.Add("OnUser2Output", "ButtonUnpressedHook", function(ent)
    if DBG then
        print("closing door")
    end

    if my_door and my_door.OpenButton then
        my_door:OpenButton()
    end

    local cur_ent = nil
    local info_targets = ents.FindByClass("info_target")

    for _, ent in ipairs(info_targets) do
        local distance = ent:GetPos():Distance(ent:GetPos())
        if distance <= 8 and ent.is_sign_target then
            if DBG then
                print("found info_target: " .. (ent:GetName() or "unnamed"))
            end
            EntFire(ent:GetName(), "fireuser2")
        end
    end
end)