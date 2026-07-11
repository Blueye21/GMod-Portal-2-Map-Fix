--Map Name
curMapName = game.GetMap()

-- Set wheatley idle on map spawn.  
if curMapName == "sp_a2_bts2" or curMapName == "sp_a2_bts6" then
	print("===== Setting Wheatley glance concerned idle")
	EntFire( "@sphere", "SetIdleSequence", "sphere_damaged_glance_concerned", 0 )
else
	print("===== Setting Wheatley idle concerned")
	EntFire( "@sphere", "SetIdleSequence", "sphere_damaged_idle_concerned", 0 )
end
