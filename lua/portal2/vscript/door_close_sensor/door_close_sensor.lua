-- enable DBG to display DBG spew 
DBG 		= 1
DoorCloseDist 	= 125
DoorSensorActive = false
PlayerDist = 0

--CN: Need to connect this to a hook.Add, but no available hook
--self.ConnectOutput( "OnPlayerTeleportToMe", "OnPlayerTeleportToMeOutput" )
--self.ConnectOutput( "OnPlayerTeleportFromMe", "OnPlayerTeleportFromMeOutput" )

-----------------------------------------------------------
-- fires when player teleports to portal
-----------------------------------------------------------
function OnPlayerTeleportToMeOutput()
	if DBG then print("==========================TO output fired! Setting true. ") end
	DoorSensorActive = true
	-- poll the distance to the player for the first time
	
	if DBG then print("==========================Getting distance to player for the first time. ") end
	PlayerDist = GetDistanceToPlayer()
end

-----------------------------------------------------------
-- fires when player teleports from portal
-----------------------------------------------------------
function OnPlayerTeleportFromMeOutput()
	if DBG then print("==========================FROM output fired! Setting false. ") end
	DoorSensorActive = false	
end


-----------------------------------------------------------
-- THINK function
-----------------------------------------------------------
function Think()
	if DBG then print("==========================" .. DoorSensorActive .. " before check. ")
	--engine specific function
	if DoorSensorActive and IsMultiplayer() == false then		
		if DBG then print("==========================GetDistanceToPlayer() returned" .. PlayerDist ) end
		if DBG then debugoverlay.Line(player:GetPos(), self:GetPos(), 1, Color(0, 255, 0), true) end
		if DBG then print("==========================" .. DoorSensorActive .. " after check. ")	end
		if PlayerDist > DoorCloseDist then
			if DBG then print("==========================Closing door: " .. self:GetName() .. "================" ) end
			CloseDoor()
		end
		-- poll the new distance to the player 
		PlayerDist = GetDistanceToPlayer()
	else
		if DBG then print("==========================FAILED due to false ")	end
	end
end

hook.Add("Think", "DoorCloseSensorThink", Think)

function GetDistanceToPlayer()
	-- get player origin
	local posPlayer = player:GetPos();
	
	-- get door (self) origin
	local posDoor = self:GetPos();
	
	-- calculate distance to player from door
	local dist = ( posDoor - posPlayer ):Length2D();
	
	return dist
end

function CloseDoor()
	EntFire(self:GetName(),"close")
	DoorSensorActive = false
	-- autosave
end