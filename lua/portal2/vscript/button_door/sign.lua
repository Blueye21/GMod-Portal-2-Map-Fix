--=========================================================
-- This script is attached to the sign entity.
-- When the sign spawn it looks around for nearby doors.
-- If the doors are portal doors then the doors increment
-- their total buttons.
--=========================================================

-- debugging
DBG = true

-- door search range
FIND_DOOR_RANGE = 200


my_door = nil
is_sign = true

-----------------------------------------------------------
-- OnPostSpawn
-----------------------------------------------------------
function OnPostSpawn()
	local cur_ent = nil
	
	repeat
		cur_ent = ents.FindByClass( cur_ent, "func_door", self:GetOrigin(), FIND_DOOR_RANGE )
		
		if DBG and cur_ent ~= nil then print( self:GetName() .. " " .. cur_ent:GetName() ) end

		if cur_ent ~= null and cur_ent.is_portal_door then
			my_door = cur_ent
			if DBG then print( self:GetName() .. " found a door " .. cur_ent:GetName() ) end
		end
	until (cur_ent == nil)

	if my_door == nil then
		if DBG then print( self:GetName() .. ": Did not find a nearby door." ) end
		return
	end
	
	my_door:IncrementTotalButtons()
end

-----------------------------------------------------------
-- fires when OnUser1 is triggered, which is any time the
-- button gets pressed
-----------------------------------------------------------
function OnUser1Output()
	if DBG then print( " attempting to open nearby door with door.nut" ) end
	my_door:CloseButton()
	
	-- find nearby info_target that is_sign_target and fire its user1 output	
	local cur_ent = nil
				
	-- find info_target that sign was spawned on
	repeat
		cur_ent = ents.FindByClass( cur_ent, "info_target", self:GetOrigin(), 8 )

		if cur_ent ~= nil and cur_ent.is_sign_target then
			if DBG then print(" found info_target: " .. cur_ent ) end
			EntFire( cur_ent:GetName(), "fireuser1" )
		end
	until (cur_ent == nil)
end
hook.Add( "OnUser1", "SignButtonPressed", OnUser1Output )
-----------------------------------------------------------
-- fires when OnUser2 is triggered, which is any time the
-- button gets unpressed
-----------------------------------------------------------
function OnUser2Output()
	if DBG then print( " closing door " ) end
	my_door:OpenButton()
	
		-- find nearby info_target that is_sign_target and fire its user1 output	
	local cur_ent = nil
				
	-- find info_target that sign was spawned on
	repeat
		cur_ent = ents.FindByClass( cur_ent, "info_target", self:GetOrigin(), 8 )

		if cur_ent ~= nil and cur_ent.is_sign_target then
			if DBG then print(" found info_target: " + cur_ent ) end
			EntFire( cur_ent:GetName(), "fireuser2" )
		end
	until (cur_ent == nil)
end
hook.Add( "OnUser2", "SignButtonUnpressed", OnUser2Output )
OnPostSpawn()