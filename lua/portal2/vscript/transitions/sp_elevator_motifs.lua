		ElevatorMotifs = 
{
	{ map = "sp_a1_intro1", speed = 400 },
	{ map = "sp_a1_intro2", speed = 400 },	// this is what we do for continual elevator shafts
	{ map = "sp_a1_intro3", speed = 400 },	// this is what we do for continual elevator shafts
	{ map = "sp_a1_intro5", speed = 400 },	// this is what we do for continual elevator shafts
	{ map = "sp_a1_intro6", speed = 400 },	// this is what we do for continual elevator shafts
	{ map = "sp_a2_bridge_intro", speed = 400  },
	{ map = "sp_a2_laser_over_goo", speed = 600, motifs = { "@shaft_stoppage_1", "transition", } },
	{ map = "sp_a2_column_blocker", speed = 400 },
	{ map = "sp_a2_trust_fling", speed = 600 },


	{ map = "sp_a2_intro", speed = 250 },	
	{ map = "sp_a2_laser_intro", speed = 400 },
	{ map = "sp_a2_laser_stairs", speed = 400 },
	{ map = "sp_a2_dual_lasers", speed = 400 },
	{ map = "sp_a2_catapult_intro", speed = 400 },
	{ map = "sp_a2_pit_flings", speed = 400 },
	{ map = "sp_a2_fizzler_intro", speed = 400 },
	{ map = "sp_a2_sphere_peek", speed = 400 },
	{ map = "sp_a2_ricochet", speed = 400 },
	{ map = "sp_a2_bridge_the_gap", speed = 400},
	{ map = "sp_a2_turret_intro", speed = 400 },
	{ map = "sp_a2_laser_relays", speed = 400 },
	{ map = "sp_a2_turret_blocker", speed = 400 },
	{ map = "sp_a2_laser_vs_turret", speed = 400 },
	{ map = "sp_a2_pull_the_rug", speed = 400 },
	{ map = "sp_a2_ring_around_turrets", speed = 400 },
	{ map = "sp_a2_laser_chaining", speed = 400 },
	{ map = "sp_a2_triple_laser", speed = 400 },
	{ map = "sp_a3_jump_intro", speed = 240 },
	{ map = "sp_a3_bomb_flings", speed = 240 },
	{ map = "sp_a3_crazy_box", speed = 240 },
	{ map = "sp_a3_speed_ramp", speed = 240 },
	{ map = "sp_a3_speed_flings", speed = 240 },
	{ map = "sp_a4_intro", speed = 400 },
	{ map = "sp_a4_tb_intro", speed = 400 },
	{ map = "sp_a4_tb_trust_drop", speed = 400 },
	{ map = "sp_a4_tb_wall_button", speed = 400 },
	{ map = "sp_a4_tb_polarity", speed = 400 },
	{ map = "sp_a4_tb_catch", speed = 200 },
	{ map = "sp_a4_stop_the_box", speed = 400 },
	{ map = "sp_a4_laser_catapult", speed = 400 },
	{ map = "sp_a4_speed_tb_catch", speed = 400 },
	{ map = "sp_a4_jump_polarity", speed = 400 },
}

-- Fix for Squirrel auto self passing
elevator = "departure_elevator-elevator_1"

function StartMoving()
	--RunConsoleCommand( "map_wants_save_disable 1" )	
	
	local foundLevel = false
	
	for index, level in pairs(ElevatorMotifs) do
		if (level.map == game.GetMap() and (level.speed) ) then
			print( "Starting elevator " .. elevator .. " with speed " .. level.speed )
			EntFire(elevator,"SetSpeedReal",level.speed,0.0)
			foundLevel = true
		end
	end
	
	if (foundLevel == false) then
		print( "Using default elevator speed 300" )
		EntFire(elevator,"SetSpeedReal","300",0.0)
	end
end

function ReadyForTransition()
	// see if we need to teleport to somewhere else or 
	PrepareTeleport()
end

function FailSafeTransition()
	// fire whichever one of these we have.
	EntFire("@transition_from_map","Trigger","",0.0)
	EntFire("@transition_with_survey","Trigger","",0.0)
end

function PrepareTeleport()
	local foundLevel = false
		
	if ( TransitionFired == 1 ) then
		return
	end

	for index, level in pairs(ElevatorMotifs) do
		if ( level.map == game.GetMap() ) then
			if (level.motifs) then
				print( "Trying to connect to motif " .. level.motifs[MotifIndex] )

				if( level.motifs[MotifIndex] == "transition" ) then
					EntFire("@transition_with_survey","Trigger","",0.0)
					EntFire("@transition_from_map","Trigger","",0.0)
					return
				else
					EntFire(elevator,"SetRemoteDestination",level.motifs[MotifIndex],0.0)
					if( MotifIndex == 0 ) then
						EntFire("departure_elevator-elevator_1","Stop","",0.05)
					end
				end
				foundLevel = true
			else
				if( GlTransitionReady == 1 ) then
					TransitionFired = 1
					EntFire("@transition_from_map","Trigger","",0.0)
					EntFire("@transition_with_survey","Trigger","",0.0)
				end
				// just bail, we don't need to do anything weird here.
				return;
			end
		end
	end
	
	if (foundLevel == false) then
//		print("**********************************")
//		print("Level not found in elevator_motifs")
//		print("**********************************")
		TransitionFired = 1
		EntFire("@transition_with_survey","Trigger","",0.0)
		EntFire("@transition_from_map","Trigger","",0.0)
		print("Level not found in elevator_motifs defaulting to transition")

		// just bail, we don't need to do anything weird here.
		return;
	end
	
	EntFire(elevator,"Enable",0.0)	
	MotifIndex = MotifIndex + 1
end

function OnPostSpawn()
	MotifIndex = 0
	GlTransitionReady = 0
	TransitionFired = 0
end
OnPostSpawn()
if Debug then print("sp_elevator_motifs.lua loaded") end