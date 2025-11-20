DBG = 0

m_nLocalBranch = 0

HUB_MAP = "mp_coop_lobby_2"

DAY_ONE_START_MAP = "mp_coop_doors"
DAY_ONE_END_MAP = "mp_coop_teambts"
DAY_ONE_LENGTH = 1

DAY_TWO_START_MAP = "mp_coop_fling_3"
DAY_TWO_END_MAP = "mp_coop_fan"
DAY_TWO_LENGTH = 1

DAY_THREE_START_MAP = "mp_coop_wall_intro"
DAY_THREE_END_MAP = "mp_coop_wall_5"
DAY_THREE_LENGTH = 1

DAY_FOUR_START_MAP = "mp_coop_tbeam_redirect"
DAY_FOUR_END_MAP = "mp_coop_tbeam_end"
DAY_FOUR_LENGTH = 1

DAY_FIVE_START_MAP = "mp_coop_paint_come_along"
DAY_FIVE_END_MAP = "mp_coop_paint_longjump_intro"
DAY_FIVE_LENGTH = 1

DAY_SIX_START_MAP = "mp_coop_credits"	-- We need this so that the length of day five is counted properly
DAY_SIX_END_MAP = "mp_coop_credits"
DAY_SIX_LENGTH = 1

MapPlayOrder = {
-- this is the order to play the multiplayer maps

--"mp_coop_mic_calibration",

-- INTRO
"mp_coop_start",	-- small wave
"mp_coop_lobby_2",	
--HUB - high-5

-- DAY 1 Start
------TEAMBUILDING----
"mp_coop_doors",
"mp_coop_race_2",
"mp_coop_laser_2",
"mp_coop_rat_maze", --- RPS
"mp_coop_laser_crusher",
"mp_coop_teambts",
--HUB - laugh

-- DAY 2 Start
------FLINGING----
-- "Mass and Velocity"
"mp_coop_fling_3",
"mp_coop_infinifling_train",
"mp_coop_come_along",
"mp_coop_fling_1", 
"mp_coop_catapult_1", --- robotDance
"mp_coop_multifling_1",
"mp_coop_fling_crushers",
"mp_coop_fan",
--HUB - teamtease

-- DAY 3 Start
------LIGHTBRIDGES----
-- "Hard-Light Surfaces"
"mp_coop_wall_intro", 
"mp_coop_wall_2",
"mp_coop_catapult_wall_intro",
"mp_coop_wall_block",
"mp_coop_catapult_2",
"mp_coop_turret_walls",
"mp_coop_turret_ball",
"mp_coop_wall_5", --- teamhug

-- DAY 4 Start
------TBEAM----
-- "Excursion Funnels"
"mp_coop_tbeam_redirect",
"mp_coop_tbeam_drill",
"mp_coop_tbeam_catch_grind_1", --- trickfire
"mp_coop_tbeam_laser_1",
"mp_coop_tbeam_polarity",
"mp_coop_tbeam_polarity2",
"mp_coop_tbeam_polarity3",
"mp_coop_tbeam_maze",
"mp_coop_tbeam_end",

-- DAY 5 Start
------PAINT----
-- "Mobility Gels"
"mp_coop_paint_come_along",
"mp_coop_paint_redirect",
"mp_coop_paint_bridge",
"mp_coop_paint_walljumps",
"mp_coop_paint_speed_fling",
"mp_coop_paint_red_racer",
"mp_coop_paint_speed_catch",
"mp_coop_paint_longjump_intro",

-- END OF LINE
------NOTHING----
"mp_coop_credits"	-- We need this so that the length of day five is counted properly
}

-- --------------------------------------------------------
-- OnPostSpawn
-- --------------------------------------------------------
function OnPostSpawn()
    local nBranch = 0
    local daymapcount = 0
    local mapcount = 0

    if DBG then
        print("================DUMPING MAP PLAY ORDER")
    end

    AddBranchLevelName(0, "CLEAR ALL")

    for index, map in ipairs(MapPlayOrder) do
        if MapPlayOrder[index] == DAY_ONE_START_MAP then
            nBranch = nBranch + 1
            daymapcount = 0

            if DBG then
                print("=== Start of Track 1")
            end

        elseif MapPlayOrder[index] == DAY_TWO_START_MAP then
            nBranch = nBranch + 1
            DAY_ONE_LENGTH = daymapcount
            daymapcount = 0

            if DBG then
                print("< " .. DAY_ONE_LENGTH .. " levels in Track 1 >")
                print("=== Start of Track 2")
            end

        elseif MapPlayOrder[index] == DAY_THREE_START_MAP then
            nBranch = nBranch + 1
            DAY_TWO_LENGTH = daymapcount
            daymapcount = 0

            if DBG then
                print("< " .. DAY_TWO_LENGTH .. " levels in Track 2 >")
                print("=== Start of Track 3")
            end

        elseif MapPlayOrder[index] == DAY_FOUR_START_MAP then
            nBranch = nBranch + 1
            DAY_THREE_LENGTH = daymapcount
            daymapcount = 0

            if DBG then
                print("< " .. DAY_THREE_LENGTH .. " levels in Track 3 >")
                print("=== Start of Track 4")
            end

        elseif MapPlayOrder[index] == DAY_FIVE_START_MAP then
            nBranch = nBranch + 1
            DAY_FOUR_LENGTH = daymapcount
            daymapcount = 0

            if DBG then
                print("< " .. DAY_FOUR_LENGTH .. " levels in Track 4 >")
                print("=== Start of Track 5")
            end

        elseif MapPlayOrder[index] == DAY_SIX_START_MAP then
            nBranch = nBranch + 1
            DAY_FIVE_LENGTH = daymapcount
            daymapcount = 0

            if DBG then
                print("< " .. DAY_FIVE_LENGTH .. " levels in Track 5 >")
                print("=== Start of Track 6")
            end
        end

        if DBG then
            if game.GetMap() == MapPlayOrder[index] then
                print(index .. " " .. MapPlayOrder[index] .. " <--- You Are Here")
            else
                print(index .. " " .. MapPlayOrder[index])
            end
        end

        AddBranchLevelName(nBranch, MapPlayOrder[index])

        if MapPlayOrder[index] == DAY_SIX_END_MAP then
            nBranch = nBranch + 1
            DAY_SIX_LENGTH = daymapcount + 1
            daymapcount = 0

            if DBG then
                print("< " .. DAY_SIX_LENGTH .. " levels in Track 6 >")
                print("=== PLEASE DO NOT TEST ANY MAP BELOW THIS LINE ===")
            end
        end

        mapcount = mapcount + 1
        daymapcount = daymapcount + 1
    end

    if DBG then
        print(mapcount .. " maps total.")
        print("================END DUMP")
    end
end

function MapPostLoaded()
end

function SetMapBranchAndLevel()
    local nBranch = 0
    local daymapcount = 1

    for index, map in ipairs(MapPlayOrder) do
        local bResetDayMapCount = false
        -- print("= Branch: " .. nBranch .. ", Level: " .. daymapcount)

        if MapPlayOrder[index] == DAY_ONE_START_MAP then
            nBranch = nBranch + 1
            bResetDayMapCount = true
        elseif MapPlayOrder[index] == DAY_TWO_START_MAP then
            nBranch = nBranch + 1
            bResetDayMapCount = true
        elseif MapPlayOrder[index] == DAY_THREE_START_MAP then
            nBranch = nBranch + 1
            bResetDayMapCount = true
        elseif MapPlayOrder[index] == DAY_FOUR_START_MAP then
            nBranch = nBranch + 1
            bResetDayMapCount = true
        elseif MapPlayOrder[index] == DAY_FIVE_START_MAP then
            nBranch = nBranch + 1
            bResetDayMapCount = true
        elseif MapPlayOrder[index] == DAY_SIX_START_MAP then
            nBranch = nBranch + 1
            bResetDayMapCount = true
        end

        -- reset the daymap count
        if bResetDayMapCount then
            daymapcount = 1
        end

        if game.GetMap() == MapPlayOrder[index] then
            -- print("################=== This is TRACK #" .. nBranch .. ", level " .. daymapcount)
            EntFire("@command", "command", "lobby_select_day " .. nBranch, 0)
            EntFire("@command", "Command", "coop_lobby_select_level " .. nBranch .. " " .. daymapcount .. " 1", 0)
            return
        end

        daymapcount = daymapcount + 1
    end
end

-- --------------------------------------------------------
-- TransitionFromMap
-- TAUNTS - 	highFive and smallWave already unlocked at the start in code
--		robotDance and thumbsUp already unlocked in mp_coop_lobby.nut file
-- --------------------------------------------------------
function TransitionFromMap()
    SaveMPStatsData()

    MarkMapComplete(game.GetMap())

    if game.GetMap() == HUB_MAP then
        TransitionToSection()
    elseif game.GetMap() == DAY_ONE_END_MAP or
           game.GetMap() == DAY_TWO_END_MAP or
           game.GetMap() == DAY_THREE_END_MAP or
           game.GetMap() == DAY_FOUR_END_MAP or
           game.GetMap() == DAY_FIVE_END_MAP or
           game.GetMap() == DAY_SIX_END_MAP then
        EntFire("@command", "command", "changelevel " .. HUB_MAP, 1.0)
    else
        local bInBranches = 0
        for index, map in ipairs(MapPlayOrder) do
            if game.GetMap() == map then
                if index + 1 >= #MapPlayOrder then
                    if DBG then print("Map " .. game.GetMap() .. " is the last map") end
                    EntFire("end_of_playtest_text", "display", 0)
                    EntFire("@command", "command", "disconnect", 2.6)
                else
                    if DBG then print("Map " .. game.GetMap() .. " connects to " .. MapPlayOrder[index + 1]) end
                    EntFire("@command", "command", "changelevel " .. MapPlayOrder[index + 1], 1.3)
                end
                return
            end
        end
    end
end

-- --------------------------------------------------------
-- TransitionToLevelFromHub
-- --------------------------------------------------------
function TransitionToLevelFromHub(nBranch)
    SaveMPStatsData()

    EntFire("@command", "command", "lobby_select_day " .. nBranch, 0)

    local nStartLevel = 0

    -- Find the index of the current map
    for index, map in ipairs(MapPlayOrder) do
        if game.GetMap() == map then
            break
        end
        nStartLevel = nStartLevel + 1
    end

    -- Apply track offsets based on branch number
    if nBranch > 1 then
        nStartLevel = nStartLevel + DAY_ONE_LENGTH
    end
    if nBranch > 2 then
        nStartLevel = nStartLevel + DAY_TWO_LENGTH
    end
    if nBranch > 3 then
        nStartLevel = nStartLevel + DAY_THREE_LENGTH
    end
    if nBranch > 4 then
        nStartLevel = nStartLevel + DAY_FOUR_LENGTH
    end
    if nBranch > 5 then
        nStartLevel = nStartLevel + DAY_FIVE_LENGTH
    end

    if nBranch > 6 then
        print("=== Branch is out of range!!!!!!!!!")
        return
    end

    local nCurrentLevel = GetCoopBranchLevelIndex(nBranch)
    local index = nCurrentLevel + nStartLevel

    if DBG then
        print("=== Branch = " .. nBranch .. ", named " .. MapPlayOrder[index])
        print("=== Going to Level #" .. index .. ", named " .. MapPlayOrder[index])
    end

    EntFire("@command", "command", "changelevel " .. MapPlayOrder[index], 0.5)
end


-- --------------------------------------------------------
-- ReturnToHubFromLevel
-- --------------------------------------------------------
function ReturnToHubFromLevel()
	if DBG then
		print( "=== RETURNING TO HUB" )
    end

	SaveMPStatsData()

	EntFire( "@command", "command", "changelevel " + HUB_MAP, 0.2 )
end

function CheckDayLights()
	local section = GetCoopSectionIndex()
	
	if section == 1 then
		EntFire( "light_day1", "TurnOn", "", 0.0 )
	else
		EntFire( "light_day1", "TurnOff", "", 0.0 )	
    end
	
	if section == 2 then
		EntFire( "light_day2", "TurnOn", "", 0.0 )
	else
		EntFire( "light_day2", "TurnOff", "", 0.0 )	
    end
	
	if section == 3 then
		EntFire( "light_day3", "TurnOn", "", 0.0 )
	else
		EntFire( "light_day3", "TurnOff", "", 0.0 )	
    end
	
	if section ~= 0 then
		EntFire( "@exit_door_1", "Open", "", 0.0 )
    end
end

function TransitionToSection()
    local section = GetCoopSectionIndex()

    if DBG then
        print("Transitioning " .. section)
    end

    if section == 0 then
        EntFire("@command", "command", "changelevel mp_coop_lobby_2", 1.3)
    elseif section == 1 then
        TransitionToDayOne()
    elseif section == 2 then
        TransitionToDayTwo()
    elseif section == 3 then
        TransitionToDayThree()
    elseif section == 4 then
        TransitionToDayFour()
    elseif section == 5 then
        TransitionToDayFive()
    elseif section == 6 then
        TransitionToDaySix()
    end
end

function TransitionToDayOne()
	EntFire( "@command", "command", "changelevel " .. DAY_ONE_START_MAP, 0.1 )
end

function TransitionToDayTwo()
	EntFire( "@command", "command", "changelevel " .. DAY_TWO_START_MAP, 0.1 )
end

function TransitionToDayThree()
	EntFire( "@command", "command", "changelevel " .. DAY_THREE_START_MAP, 0.1 )
end

function TransitionToDayFour()
	EntFire( "@command", "command", "changelevel " .. DAY_FOUR_START_MAP, 0.1 )
end

function TransitionToDayFive()
	EntFire( "@command", "command", "changelevel " .. DAY_FIVE_START_MAP, 0.1 )
end

function TransitionToDaySix()
	EntFire( "@command", "command", "changelevel " .. DAY_SIX_START_MAP, 0.1 )
end

------------------------
-- level select buttons
------------------------

function SubtractLevelSelect(nBranch)
    local nCurrentLevel = GetCoopBranchLevelIndex(nBranch)

    local nNewLevel = nCurrentLevel - 1
    local bContinue = true

    while bContinue and nNewLevel > 1 and not IsLevelComplete(nBranch - 1, nNewLevel - 1) do
        if nNewLevel > 1 and IsLevelComplete(nBranch - 1, nNewLevel - 2) then
            bContinue = false
        else
            nNewLevel = nNewLevel - 1
        end
    end

    if DBG then
        print("----@=== Selecting Day " .. nBranch .. ", Level " .. (nCurrentLevel - 1))
    end

    if nNewLevel < 1 then
        return
    end

    EntFire("@command", "Command", "coop_lobby_select_level " .. nBranch .. " " .. nNewLevel, 0)

    local nMaxLevelsInDay = GetMaxLevelsInDay(nBranch)
    UpdateLevelSelectButtons(nBranch, nNewLevel, nMaxLevelsInDay)
end

function AddLevelSelect(nBranch)
    if nBranch < 1 then
        return
    end

    local nCurrentLevel = GetCoopBranchLevelIndex(nBranch)
    local nMaxLevelsInDay = GetMaxLevelsInDay(nBranch)

    local nNewLevel = nCurrentLevel + 1
    local bContinue = true

    while bContinue and nNewLevel <= nMaxLevelsInDay and not IsLevelComplete(nBranch - 1, nNewLevel - 1) do
        if nNewLevel > 1 and IsLevelComplete(nBranch - 1, nNewLevel - 2) then
            bContinue = false
        else
            nNewLevel = nNewLevel + 1
        end
    end

    if nNewLevel > nMaxLevelsInDay then
        if DBG then
            print("nNewLevel (" .. nNewLevel .. ") > nMaxLevelsInDay (" .. nMaxLevelsInDay .. ")")
        end
        return
    end

    UpdateLevelSelectButtons(nBranch, nNewLevel, nMaxLevelsInDay)

    EntFire("@command", "Command", "coop_lobby_select_level " .. nBranch .. " " .. nNewLevel, 0)
end

-- --------------------------------------------------------
-- Sets the local branch #
-- --------------------------------------------------------
function SetLocalBranchNumber( nBranch )
	-- this is to make sure that the client and server are on the same page
	-- and sets the selected level to the last in the track or first uncompleted
	--print( "^^^@=== SetLocalBranchNumber, setting to max in branch " + nBranch )
	EntFire( "@command", "Command", "coop_lobby_select_level " .. nBranch .. " " .. 99, 0)	
	
	if DBG then
		print( "Setting local branch to = " .. nBranch )
	end

	m_nLocalBranch = nBranch
	InitLevelSelectButtons( m_nLocalBranch )
end

function InitLevelSelectButtons(nBranch)
    if nBranch < 1 and m_nLocalBranch < 1 then
        print("nBranch and m_nLocalBranch is < 1 !!!!!")
        return
    end

    if nBranch < 1 then
        nBranch = m_nLocalBranch
    end

    if DBG then
        print("*********CALLING InitLevelSelectButtons( " .. nBranch .. " )")
    end

    local nCurrentLevel = GetCoopBranchLevelIndex(nBranch)
    local nMaxLevelsInDay = GetMaxLevelsInDay(nBranch)

    UpdateLevelSelectButtons(nBranch, nCurrentLevel, nMaxLevelsInDay)
end

function UpdateLevelSelectButtons(nBranch, nCurrentLevel, nMaxLevelsInDay)
    if nCurrentLevel <= 1 then
        -- turn off the left light
        EntFire(EntityGroup[1]:GetName(), "Skin", "1", 0)
    else
        -- turn on the left light
        EntFire(EntityGroup[1]:GetName(), "Skin", "0", 0)
    end

    -- IsLevelComplete checks the data directly so we have to subtract one from the branch and level number
    local bCurrentLevelIsComplete = IsLevelComplete(nBranch - 1, nCurrentLevel - 1)
    local bMoreLevelsComplete = false

    if not bCurrentLevelIsComplete then
        for j = nCurrentLevel + 1, nMaxLevelsInDay - 1 do
            if IsLevelComplete(nBranch - 1, j - 1) then
                bMoreLevelsComplete = true
            end
        end
    end

    if DBG then
        print(
            "bCurrentLevelIsComplete = " .. tostring(bCurrentLevelIsComplete) ..
            " -- nCurrentLevel = " .. nCurrentLevel ..
            " -- nMaxLevelsInDay = " .. nMaxLevelsInDay
        )
    end

    if ((bCurrentLevelIsComplete == false and not bMoreLevelsComplete) or nCurrentLevel >= nMaxLevelsInDay) then
        -- turn off the right light
        EntFire(EntityGroup[2]:GetName(), "Skin", "1", 0)
    else
        -- turn on the right light
        EntFire(EntityGroup[2]:GetName(), "Skin", "0", 0)
    end
end

function GetMaxLevelsInDay(nBranch)
    local nMaxLevelsInDay = DAY_ONE_LENGTH

    if nBranch == 2 then
        nMaxLevelsInDay = DAY_TWO_LENGTH
    elseif nBranch == 3 then
        nMaxLevelsInDay = DAY_THREE_LENGTH
    elseif nBranch == 4 then
        nMaxLevelsInDay = DAY_FOUR_LENGTH
    elseif nBranch == 5 then
        nMaxLevelsInDay = DAY_FIVE_LENGTH
    elseif nBranch == 6 then
        nMaxLevelsInDay = DAY_SIX_LENGTH
    end

    return nMaxLevelsInDay
end