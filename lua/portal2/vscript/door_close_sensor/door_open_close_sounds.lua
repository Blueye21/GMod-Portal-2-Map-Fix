DBG 		= 1

DoorOpenSound = "prop_portal_door.open"
DoorCloseSound = "prop_portal_door.close"

-- Precache sounds we will emit
--glua does not need this
--function Precache()
--	self.PrecacheSoundScript( DoorOpenSound )
--	self.PrecacheSoundScript( DoorCloseSound )
--end

function OnPostSpawn()
	if DBG then print("==========================OnPostSpawn:: connecting outputs") end
	hook.Add("OnFullyOpen", "OnFullyOpenHook", OnFullyOpen())
	hook.Add("OnFullyClosed", "OnFullyClosedHook", OnFullyClosed())
end

function OnFullyOpened()
	if DBG then print("==========================Door Opened!") end
	PlayOpenSound()	
end

function OnFullyClosed()
	if DBG then print("==========================Door Closed!") end
	PlayCloseSound()
end

function PlayOpenSound()
	if DBG then print("==========================Playing door open sound <DING> ") end
	self:EmitSound( DoorOpenSound )
end

function PlayCloseSound()
	if DBG then print("==========================Playing door closed sound <BBZT> ") end
	self:EmitSound( DoorCloseSound )
end