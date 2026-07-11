--=============================================================================
-- this script will open prop_portal_linked_door entities if the player is 
-- within OPEN_DIST of the door and also in noclip mode
-- script will also draw DBG lines between linked doors while in noclip mode
--=============================================================================

DBG = true
-- parallel arrays to contain list of doors and targets
portal_door_array = {}
portal_door_linked_target_array = {}

-- number of doors in map
number_of_doors = 0

-- opening distance
OPEN_DIST = 80

-----------------------------------------------------------
-- Collect Doors in map into arrays and remove reciprocal entries
-----------------------------------------------------------
function CollectDoors()
	-- iterators
	local cur_ent = nil
	
	-- clear the arrays
	portal_door_array = {}
	portal_door_linked_target_array = {}

	-- reset door count
	number_of_doors = 0
	
	-- collect doors into array
	repeat
		local reciprocal = false
		cur_ent = ents.FindByClass( cur_ent, "prop_linked_portal_door" )	
		if ( cur_ent != nil  ) then
			for index, door in pairs(portal_door_linked_target_array ) do
				if( portal_door_linked_target_array[index] ) then
					if( cur_ent:GetName() == portal_door_linked_target_array[index]:GetName() ) then
						if( portal_door_linked_target_array[index].GetPartnerInstance():GetName() == portal_door_array[index]:GetName() ) then
							reciprocal = true
						end
					end
				end
			end

			if ( !reciprocal ) then
				table.insert( portal_door_array, cur_ent )
				table.insert( portal_door_linked_target_array, portal_door_array[#portal_door_array]:GetPartnerInstance() )
				number_of_doors = number_of_doors + 1
			end
		end
	until cur_ent == nil
	
	-- dump data to the console if DBGging is enabled
	if(DBG) then DBGDumpDoorArrayData() end
end

function DBGDumpDoorArrayData()
	print("--- doors = " .. number_of_doors )
	
	for index, door in pairs(portal_door_linked_target_array )
		if portal_door_linked_target_array[index] then
			print( index .. ") --- " .. portal_door_array[index]:GetName() .. "=>" .. portal_door_linked_target_array[index]:GetName() )
		end
	end
end

function DrawLinkedPartnerLines()	
	-- draw line between doors
	for i = 1, #portal_door_linked_target_array do
		if( portal_door_linked_target_array[i] ) then
			render.DrawLine( portal_door_array[i]:GetPos(), portal_door_linked_target_array[i]:GetPos(), 100, 100, 100, true, 0.2 )
		end
	end
end

function Think()
	-- open nearby doors
	if( game.SinglePlayer() == true and ply:GetMoveType() == MOVETYPE_NOCLIP ) then
		-- draw links between doors and partners
		CollectDoors()
		if (DBG) then DrawLinkedPartnerLines() end
		
		local cur_ent = nil
		local linked_partner_name = nil
		repeat
			cur_ent = ents.FindByClass( cur_ent, "prop_linked_portal_door", ply:GetPos(), OPEN_DIST )
			if( cur_ent ) then
				EntFire( cur_ent:GetName(), "open" )
			end
		until ( cur_ent == nil )
	end
end