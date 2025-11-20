function GetDeveloperLevel()
    return 0
end

function SpawnCheckDev()
	if GetDeveloperLevel() >= 1 then
		print( "=== DEV " .. GetDeveloperLevel() .. " === Skipping wait for partner- starting map" )
		EntFire( "@relay_debug_start_both_connected", "Trigger", "", 1.0 )	
    end
end

function OrangeConnected()
	if GetDeveloperLevel() >= 1 then
		print( "=== DEV " + GetDeveloperLevel() + " ===  Orange Partner connected.  Skipping intro movie." )
		//EntFire( "@relay_debug_start_both_connected", "Trigger", "", 1.0 )
	else
		EntFire( "@relay_start_both_connected", "Trigger", "", 1.0 )	
    end

	EntFire( "@command", "command", "mp_earn_taunt smallWave", 2.0 )
end