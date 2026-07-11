-- enable DBG to display debug spew 
DBG 		= 0
DoorCloseDist 	= 125
DidPlayerExitRoom = false
PlayerDist = 0

-- Precache sounds we will emit
--function Precache()
--{
--	self.PrecacheSoundScript( "Portal.elevator_ding" )
--	self.PrecacheSoundScript( "Portal.button_up" )
--}

function OnPostSpawn()
	if DBG then print("==========================OnPostSpawn:: connecting outputs")	end
	hook.Add("OnFullyOpen", "OnFullyOpenHook", OnDoorFullyOpen())
	hook.Add("OnFullyClosed", "OnFullyClosedHook", OnDoorFullyClosed())
end

function OnDoorFullyOpened()
	if DBG then print("==========================Door Opened!") end
	PlayDoorOpenSound()	
end

function OnDoorFullyClosed()
	if DBG then print("==========================Door Closed!") end
	if not DidPlayerExitRoom then
		PlayDoorCloseSound()
	end
end

-----------------------------------------------------------
-- fires when player teleports to portal
-----------------------------------------------------------
function OnPlayerTeleportToMeOutput()
	if DBG then print("==========================TO output fired! Setting false. ")	end
	DidPlayerExitRoom = false
end

-----------------------------------------------------------
-- fires when player teleports from portal
-----------------------------------------------------------
function OnPlayerTeleportFromMeOutput()
	if DBG then print("==========================FROM output fired! Setting true. ") end
	DidPlayerExitRoom = true
end

function PlayDoorOpenSound()
	if DBG then print("==========================Playing door open sound <DING> ") end
	self:EmitSound( "Portal.elevator_ding" )
end

function PlayDoorCloseSound()
	if DBG then print("==========================Playing door closed sound <BBZT> ") end
	self:EmitSound( "Portal.button_up" )
end
