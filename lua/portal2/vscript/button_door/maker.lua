--=========================================================
-- This script is attached to a env_entity_maker.  It will
-- spawn a template at a specifically named info_target
-- and will then move the sign to a specifically named
-- info_target.
--
-- button info_targets must be named with the format:
-- door01_button01
--
-- sign info_targets must be named with the format:
-- door01_sign01 
--=========================================================

-- DBGging
DBG = true



-----------------------------------------------------------
-- OnPostSpawn
-----------------------------------------------------------
function OnPostSpawn()
	-- object sizes
	local size = {
		small = 0,
		normal = 1,
		large = 2
	}

	for _, cur_ent in ipairs(ents.FindByClass("info_target")) do
		if cur_ent:GetName() and string.find(cur_ent:GetName(), "button") and cur_ent.is_button_target then
			local butt_pos = string.find(cur_ent:GetName(), "button")
			local system_name = string.sub(cur_ent:GetName(), 1, butt_pos - 1)
			local butt_numb = string.sub(cur_ent:GetName(), butt_pos + 6)
			
			if DBG then print("butt_pos: " .. butt_pos) end
			if DBG then print("system_name: " .. system_name) end
			if DBG then print("butt_numb: " .. butt_numb) end
			
			if DBG then print("EntityGroup[1]: " .. tostring(EntityGroup[1])) end
				
			local button_size = cur_ent.button_size

			if button_size == size.small then
				if DBG then print("spawning button of small size") end
				if EntityGroup[size.small] then
					EntityGroup[size.small]:SpawnEntityAtEntityOrigin(cur_ent)
				end
			elseif button_size == size.normal then
				if DBG then print("spawning button of normal size") end
				if EntityGroup[size.normal] then
					EntityGroup[size.normal]:SpawnEntityAtEntityOrigin(cur_ent)
				end
			elseif button_size == size.large then
				if DBG then print("spawning button of large size") end
				if EntityGroup[size.large] then
					EntityGroup[size.large]:SpawnEntityAtEntityOrigin(cur_ent)
				end
			end

			-- find sign
			local sign = nil
			for _, brush in ipairs(ents.FindInSphere(cur_ent:GetPos(), 1000)) do
				if brush:GetClass() == "func_brush" and brush.is_sign then
					sign = brush
					break
				end
			end
			
			if not sign then
				if DBG then print("No sign for " .. tostring(cur_ent:GetName())) end
			else
				local sign_dest_name = system_name .. "sign" .. butt_numb
				if DBG then print("sign pos: " .. sign_dest_name) end

				local sign_dest = ents.FindByName(sign_dest_name)[1]
				if sign_dest then
					sign:SetPos(sign_dest:GetPos())
					sign:SetAngles(sign_dest:GetAngles())
				else
					if DBG then print("No sign dest " .. sign_dest_name) end
				end
			end
		end
	end
end
OnPostSpawn()