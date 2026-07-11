// --------------------------------------------------------
// StartVideo
// --------------------------------------------------------

ElevatorVideos = 
{
	{ map = "sp_a1_intro1", arrival = "", departure = "" },
	{ map = "sp_a1_intro2", arrival = "", departure = "" },
	{ map = "sp_a1_intro3", arrival = "animalking.bik", departure = "animalking.bik", typeOverride = 11  },
	{ map = "sp_a1_intro4", arrival = "exercises_horiz.bik", departure = "exercises_horiz.bik", typeOverride = 10 },
	{ map = "sp_a1_intro5", arrival = "exercises_vert.bik", departure = "exercises_vert.bik", typeOverride = 9 },
	{ map = "sp_a1_intro6", arrival = "plc_blue_vert.bik", departure = "plc_blue_vert.bik", typeOverride = 9 },
	{ map = "sp_a1_intro7", arrival = "plc_blue_horiz.bik", departure = "", typeOverride = 4 },
	{ map = "sp_a2_intro", arrival = "", departure = "plc_blue_horiz.bik", typeOverride = 1 },
	{ map = "sp_a2_laser_intro",	arrival = "laser_portal.bik", departure = "laser_portal.bik", typeOverride = 12  },
	{ map = "sp_a2_laser_stairs",	arrival = "laser_portal.bik", departure = "laser_portal.bik", typeOverride = 12 },
	{ map = "sp_a2_dual_lasers",	arrival = "laser_portal.bik", departure = "laser_portal.bik", typeOverride = 12 },
	{ map = "sp_a2_laser_over_goo", arrival = "aperture_appear_vert.bik", departure = "aperture_appear_vert.bik", typeOverride = 9 },
	{ map = "sp_a2_catapult_intro", arrival = "faithplate.bik", departure = "faithplate.bik", typeOverride = 6 },
	{ map = "sp_a2_trust_fling",	arrival = "faithplate.bik", departure = "faithplate.bik", typeOverride = 6 },
	{ map = "sp_a2_pit_flings",	arrival = "aperture_appear_vert.bik", departure = "aperture_appear_vert.bik", typeOverride = 9 },
	{ map = "sp_a2_fizzler_intro",	arrival = "fizzler.bik", departure = "fizzler.bik", typeOverride = 6 },
	{ map = "sp_a2_sphere_peek",	arrival = "aperture_appear_vert.bik", departure = "aperture_appear_vert.bik", typeOverride = 9 },
	{ map = "sp_a2_ricochet",	arrival = "aperture_appear_vert.bik", departure = "aperture_appear_vert.bik", typeOverride = 9 },
	{ map = "sp_a2_bridge_intro",	arrival = "hard_light.bik", departure = "hard_light.bik", typeOverride = 12 },
	{ map = "sp_a2_bridge_the_gap", arrival = "hard_light.bik", departure = "hard_light.bik", typeOverride = 6 },
	{ map = "sp_a2_turret_intro",	arrival = "turret_exploded_grey.bik", departure = "", typeOverride = 6 },
	{ map = "sp_a2_laser_relays",	arrival = "", departure = "aperture_appear_vert.bik", typeOverride = 9 },
	{ map = "sp_a2_turret_blocker",	arrival = "turret_exploded_grey.bik", departure = "turret_exploded_grey.bik", typeOverride = 6 },
	{ map = "sp_a2_laser_vs_turret",arrival = "turret_colours_type.bik", departure = "turret_colours_type.bik", typeOverride = 6 },
	{ map = "sp_a2_pull_the_rug",	arrival = "aperture_appear_vert.bik", departure = "aperture_appear_vert.bik", typeOverride = 9 },
	{ map = "sp_a2_column_blocker", arrival = "turret_dropin.bik", departure = "turret_dropin.bik", typeOverride = 6 },
	{ map = "sp_a2_laser_chaining", arrival = "turret_colours_type.bik", departure = "turret_colours_type.bik", typeOverride = 6 },
	{ map = "sp_a2_triple_laser",	arrival = "aperture_appear_vert.bik", departure = "aperture_appear_vert.bik", typeOverride = 9 },
	{ map = "sp_a2_bts1",			arrival = "aperture_appear_vert.bik", departure = "", typeOverride = 9 },
	{ map = "sp_a4_intro",			arrival = "", departure = "plc_blue_horiz.bik", typeOverride = 6 },
	{ map = "sp_a4_tb_intro",		arrival = "exercises_horiz.bik", departure = "exercises_horiz.bik", typeOverride = 6 },
	{ map = "sp_a4_tb_trust_drop",	arrival = "plc_blue_horiz.bik", departure = "plc_blue_horiz.bik", typeOverride = 6 },
	{ map = "sp_a4_tb_wall_button",	arrival = "", departure = "" },
	{ map = "sp_a4_tb_polarity",	arrival = "exercises_horiz.bik", departure = "exercises_horiz.bik", typeOverride = 6 },
	{ map = "sp_a4_tb_catch",		arrival = "plc_blue_horiz.bik", departure = "plc_blue_horiz.bik", typeOverride = 6 },
	{ map = "sp_a4_stop_the_box",	arrival = "bluescreen.bik", departure = "bluescreen.bik", typeOverride = 14 },
	{ map = "sp_a4_laser_catapult",	arrival = "bluescreen.bik", departure = "bluescreen.bik", typeOverride = 14 },
	{ map = "sp_a4_laser_platform",	arrival = "bluescreen.bik", departure = "", typeOverride = 14 },
	{ map = "sp_a4_speed_tb_catch",	arrival = "", departure = "bluescreen.bik", typeOverride = 14 },
	{ map = "sp_a4_jump_polarity",	arrival = "bluescreen.bik", departure = "bluescreen.bik", typeOverride = 14 },
	{ map = "sp_a4_finale1",		arrival = "bluescreen.bik", departure = "" },
}

ARRIVAL_VIDEO = 0
DEPARTURE_VIDEO = 1
ARRIVAL_DESTRUCTED_VIDEO = 2
DEPARTURE_DESTRUCTED_VIDEO = 3

OVERRIDE_VIDEOS = 0

FIRST_CLEAN_MAP = "sp_a2_catapult_intro"

function Precache()
	if self.PrecachedVideos then
		// don't do anything
	else
		// Commenting this line out because it prevents properly re-precaching movies after loading a save game.
		// The cost is that we end up running this code below about 2x too often, but it's fairly cheap and not realtime code anyways...
		//::PrecachedVideos = 1

		local mapName = game.GetMap()
		for index, level in ipairs(ElevatorVideos) do
			if (level.map == mapName) then
				local movieName
				if ( level.additional and level.additional != "" ) then
					movieName = "media\\" .. level.additional
					//printl( "Preching movie: " + movieName )
					PrecacheMovie( movieName )
				end
				
				if (level.arrival and level.arrival != "" )	then
					movieName = "media\\"
					if( OVERRIDE_VIDEOS == 1 ) then
						movieName = movieName .. "entry_emergency.bik"
					else
						movieName = movieName .. level.arrival
					end
				
					//printl( "Preching movie: " + movieName )
					PrecacheMovie( movieName )
				end
				
				if (level.departure and level.departure != "" )	then
					movieName = "media\\"
					if( OVERRIDE_VIDEOS == 1 ) then
						movieName = movieName .. "exit_emergency.bik"
					else
						movieName = movieName .. level.departure
					end
				
					//printl( "Preching movie: " + movieName )
					PrecacheMovie( movieName )
				end
			end
		end
	end
end

// stubs to supress error - will delete these soon.
function StopEntryVideo(width,height)
end

function StopExitVideo(width,height)
end

function StartEntryVideo(width,height)
end

function StartExitVideo(width,height)
end

function StartDestructedEntryVideo(width,height)
end

function StartDestructedExitVideo(width,height)
end

//============================

function StopArrivalVideo(width,height)
	EntFire("@arrival_video_master", "Disable", "", 0)
	EntFire("@arrival_video_master", "killhierarchy", "", 1.0)
	StopVideo(ARRIVAL_VIDEO,width,height)
end

function StopDepartureVideo(width,height)
	EntFire("@departure_video_master", "Disable", "", 0)
	EntFire("@departure_video_master", "killhierarchy", "", 1.0)
	StopVideo(DEPARTURE_VIDEO,width,height)
end

function StopVideo(videoType,width,height)
	for i=1,width do
		for j=1,height do
			local panelNum = 1 + width*j + i
			local signName
			
			if (videoType == DEPARTURE_VIDEO or videoType == DEPARTURE_DESTRUCTED_VIDEO ) then
				signName = "@departure_sign_" .. panelNum
			else
				signName = "@arrival_sign_" .. panelNum
			end
			
			EntFire(signName, "Disable", "", 0)
			EntFire(signName, "killhierarchy", "", 1.0)
		end
	end
end

function StartArrivalVideo(width,height)
	StartDestructedArrivalVideo(width,height)
	
//	EntFire("@arrival_video_master", "Enable", "", 0)
//	StartVideo(ENTRANCE_VIDEO,width,height)
end

function StartDepartureVideo(width,height)
	StartDestructedDepartureVideo(width,height)

//	EntFire("@departure_video_master", "Enable", "", 0)
//	StartVideo(DEPARTURE_VIDEO,width,height)
end

function StartDestructedArrivalVideo(width,height)
	local playDestructed = true
	local mapName = game.GetMap()
	
	for index, level in ipairs(ElevatorVideos) do
		if (FIRST_CLEAN_MAP == level.map ) then
			playDestructed = false
		end
		
		if (level.map == mapName and level.arrival ) then
			if( level.arrival == "" ) then
				return
			end
				
			local videoName = "media\\"
			if( OVERRIDE_VIDEOS == 1 ) then
				videoName = videoName .. "entry_emergency.bik"
			else
				videoName = videoName .. level.arrival
			end
				
			//printl("Setting arrival movie to " + videoName )
			EntFire("@arrival_video_master", "SetMovie", videoName, 0)
			break
		end
	end
	
	EntFire("@arrival_video_master", "Enable", "", 0.1)
	StartVideo(playDestructed and ARRIVAL_DESTRUCTED_VIDEO or ARRIVAL_VIDEO, width, height)
end

function StartDestructedDepartureVideo(width,height)
	local playDestructed = true
	local mapName = game.GetMap()
	
	for index, level in ipairs(ElevatorVideos) do
		if (FIRST_CLEAN_MAP == level.map ) then
			playDestructed = false
		end
		
		if (level.map == mapName and level.departure ) then
			if( level.departure == "" ) then
				return
			end

			local videoName = "media\\"
			if( OVERRIDE_VIDEOS == 1 ) then
				videoName = videoName .. "exit_emergency.bik"
			else
				videoName = videoName .. level.departure
			end
				
			//printl("Setting departure movie to " + videoName )
			EntFire("@departure_video_master", "SetMovie", videoName, 0)
			break
		end
	end
	
	EntFire("@departure_video_master", "Enable", "", 0.1)
	StartVideo(playDestructed and DEPARTURE_DESTRUCTED_VIDEO or DEPARTURE_VIDEO, width, height)
end

function StartVideo(videoType,width,height)
	local videoScaleType = 0
	local randomDestructChance = 0
	
	if( videoType == ARRIVAL_DESTRUCTED_VIDEO or videoType == DEPARTURE_DESTRUCTED_VIDEO ) then
		videoScaleType = math.random(1,5)
	else
		videoScaleType = math.random(6,7)
	end
		
	local mapName = game.GetMap()
	for index, level in ipairs(ElevatorVideos) do
		if (level.map == mapName) then
			if (level.typeOverride) then
				videoScaleType = level.typeOverride
			end
			
			if (level.destructChance) then
				randomDestructChance = level.destructChance
			end
		end
	end
	
	for i=1,width do
		for j=1,height do
			local panelNum = 1 + width*j + i
			local signName
			
			if (videoType == DEPARTURE_VIDEO or videoType == DEPARTURE_DESTRUCTED_VIDEO ) then
				signName = "@departure_sign_" .. panelNum
			else
				signName = "@arrival_sign_" .. panelNum
			end	
					
			if( randomDestructChance > math.random(0,100) ) then
				EntFire(signName, "Kill", "", 0)
				continue
			end
			
			EntFire(signName, "SetUseCustomUVs", 1, 0)
			
			local uMin = (i+0.0001)/(width)
			local uMax = (i+1.0001)/(width)
			local vMin = (j+0.0001)/(height)
			local vMax = (j+1.0001)/(height)
			
			if( videoScaleType == 0 /*full elevator*/ ) then 				
			
			elseif( videoScaleType == 1 /*stretch*/ ) then
				uMin = 1.0 - (1.0-uMin)*(1.0-uMin)*(1.0-uMin)
				uMax = 1.0 - (1.0-uMax)*(1.0-uMax)*(1.0-uMax)

			elseif( videoScaleType == 2 /*Mirror*/ ) then
				uMin = 4*(1.0-uMin)*uMin
				uMax = 4*(1.0-uMax)*uMax					
			
			elseif( videoScaleType == 3 /*Ouroboros*/ ) then
				uMin = ((i%12)+0.0001)/12
				uMax = ((i%12)+1.0001)/12

				if( ((i)%2) == 1 ) then
					local temp = uMin
					uMin = uMax
					uMax = temp
				end
			
			elseif( videoScaleType == 4 /*Upside down*/ ) then
				vMin = 0.99999
				vMax = 0.00001
				
				uMin = ((i%3)+0.0001)/3
				uMax = ((i%3)+1.0001)/3					
			
			elseif( videoScaleType == 5 /*Tiled*/ ) then
				vMin = 0.00001
				vMax = 0.99999
				
				uMin = ((i%3)+0.0001)/3
				uMax = ((i%3)+1.0001)/3

			elseif( videoScaleType == 6 /*Tiled Really Big*/ ) then
				uMin = ((i%8)+0.0001)/8
				uMax = ((i%8)+1.0001)/8

			elseif( videoScaleType == 7 /*Tiled Big*/ ) then
				uMin = ((i%12)+0.0001)/12
				uMax = ((i%12)+1.0001)/12

			elseif( videoScaleType == 8 /*Tiled Single*/ ) then
				uMin = 0.0001
				uMax = 0.9999
				vMin = 0.0001
				vMax = 0.9999

			elseif( videoScaleType == 9 /*Tiled Double*/ ) then
				uMin = ((i%2)+0.0001)/2
				uMax = ((i%2)+1.0001)/2

			elseif( videoScaleType == 10 /*Two by two*/ ) then
				vMin = 0.00001
				vMax = 0.99999
				
				uMin = ((i%2)+0.0001)/2
				uMax = ((i%2)+1.0001)/2

			elseif( videoScaleType == 11 /*Tiled off 1*/ ) then
				vMin = 0.00001
				vMax = 0.99999
				
				uMin = (((i+1)%3)+0.0001)/3
				uMax = (((i+1)%3)+1.0001)/3

			elseif( videoScaleType == 12 /*Tiled 2x4*/ ) then
				uMin = ((i%6)+0.0001)/6
				uMax = ((i%6)+1.0001)/6

			elseif( videoScaleType == 13 /*Tiled Double - with two blank*/ ) then
				if( ((i)%4) < 2 ) then
					uMin = ((i%2)+0.0001)/2
					uMax = ((i%2)+1.0001)/2
				else
					uMin = 0.97
					uMax = 0.97
				end

			elseif( videoScaleType == 14 /*bluescreen*/ ) then
				if( (i%8) >= 1 and 
					(i%8) < 7 ) then
					uMin = (((i-1)%8)+0.0001)/6
					uMax = (((i-1)%8)+1.0001)/6
				else
					uMin = 0.97
					uMax = 0.97
				end
			end
								
			EntFire(signName, "SetUMin", uMin, 0)
			EntFire(signName, "SetUMax", uMax, 0)
			EntFire(signName, "SetVMin", vMin, 0)
			EntFire(signName, "SetVMax", vMax, 0)

			EntFire(signName, "Enable", "", 0.1)
			
//				printl(signName + " " + uMin + " " + uMax + " " + vMin + " " + vMax )
		end
	end
end
if DBG then print("[P2] video_splitter.lua loaded") end