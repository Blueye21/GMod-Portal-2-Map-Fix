print("[P2] sp_transition_list.lua loaded")
DBG = 1
FORCE_GUN_AND_HALLWAY = 0

FIRST_MAP_WITH_GUN = "sp_a1_intro4"
FIRST_MAP_WITH_UPGRADE_GUN = "sp_a2_laser_intro"
FIRST_MAP_WITH_POTATO_GUN = "sp_a3_speed_ramp"
LAST_PLAYTEST_MAP = "sp_a4_finale4"
CreateConVar("loop_single_player_maps", "0", {FCVAR_ARCHIVE, FCVAR_REPLICATED})


CHAPTER_TITLES = 
{
	{ map = "sp_a1_intro1", title_text = "CHAPTER 1", subtitle_text = "THE COURTESY CALL", displayOnSpawn = false,		displaydelay = 1.0 },
	{ map = "sp_a2_laser_intro", title_text = "CHAPTER 2", subtitle_text = "THE COLD BOOT", displayOnSpawn = true,	displaydelay = 2.5 },
	{ map = "sp_a2_sphere_peek", title_text = "CHAPTER 3", subtitle_text = "THE RETURN", displayOnSpawn = true,	displaydelay = 2.5 },
	{ map = "sp_a2_column_blocker", title_text = "CHAPTER 4", subtitle_text = "THE SURPRISE", displayOnSpawn = true, displaydelay = 2.5 },
	{ map = "sp_a2_bts3", title_text = "CHAPTER 5", subtitle_text = "THE ESCAPE", displayOnSpawn = true,			displaydelay = 1.0 },
	{ map = "sp_a3_00", title_text = "CHAPTER 6", subtitle_text = "THE FALL", displayOnSpawn = true,			displaydelay = 1.5 },
	{ map = "sp_a3_speed_ramp", title_text = "CHAPTER 7", subtitle_text = "THE REUNION", displayOnSpawn = true,	displaydelay = 1.0 },
	{ map = "sp_a4_intro", title_text = "CHAPTER 8", subtitle_text = "THE ITCH", displayOnSpawn = true,			displaydelay = 2.5 },
	{ map = "sp_a4_finale1", title_text = "CHAPTER 9", subtitle_text = "THE PART WHERE HE KILLS YOU", displayOnSpawn = false,		displaydelay = 1.0 },
}

-- Display the chapter title
function DisplayChapterTitle()
	for index, level in ipairs(CHAPTER_TITLES) do
		if level.map == game.GetMap() then
			EntFire( "@chapter_title_text", "SetTextColor", "210 210 210 128", 0.0 )
			EntFire( "@chapter_title_text", "SetTextColor2", "50 90 116 128", 0.0 )
			EntFire( "@chapter_title_text", "SetPosY", "0.32", 0.0 )
			EntFire( "@chapter_title_text", "SetText", level.title_text, 0.0 )
			EntFire( "@chapter_title_text", "display", "", level.displaydelay )
			
			EntFire( "@chapter_subtitle_text", "SetTextColor", "210 210 210 128", 0.0 )
			EntFire( "@chapter_subtitle_text", "SetTextColor2", "50 90 116 128", 0.0 )
			EntFire( "@chapter_subtitle_text", "SetPosY", "0.35", 0.0 )
			EntFire( "@chapter_subtitle_text", "settext", level.subtitle_text, 0.0 )
			EntFire( "@chapter_subtitle_text", "display", "", level.displaydelay )
        end
	end
end

-- Display the chapter title on spawn if it is flagged to show up on spawn
function TryDisplayChapterTitle()
	for index, level in ipairs(CHAPTER_TITLES) do
		if level.map == game.GetMap() and level.displayOnSpawn then
			DisplayChapterTitle()
        end
    end
end

local LOOP_TIMER = 0

local initialized = false

-- This is the order to play the maps
MapPlayOrder = {

-- ===================================================
-- ====================== ACT 1 ======================
-- ===================================================

-- ---------------------------------------------------
-- 	Intro
-- ---------------------------------------------------
"sp_a1_intro1",				-- motel to box-on-button
"sp_a1_intro2",				-- portal carousel
"sp_a1_intro3",				-- fall-through-floor, dioramas, portal gun
"sp_a1_intro4",				-- box-in-hole for placing on button
"sp_a1_intro5",				-- fling hinting
"sp_a1_intro6",				-- fling training
"sp_a1_intro7",				-- wheatley meetup
"sp_a1_wakeup",				-- glados 
	"@incinerator",

-- ===================================================
-- ====================== ACT 2 ======================
-- ===================================================

"sp_a2_intro", 		-- upgraded portal gun track

-- ---------------------------------------------------
--	Lasers
-- ---------------------------------------------------
"sp_a2_laser_intro",
"sp_a2_laser_stairs",
"sp_a2_dual_lasers",
"sp_a2_laser_over_goo",

-- ---------------------------------------------------
-- 	Catapult
-- ---------------------------------------------------
"sp_a2_catapult_intro",
"sp_a2_trust_fling",

-- ---------------------------------------------------
--	More Lasers
-- ---------------------------------------------------
"sp_a2_pit_flings",
"sp_a2_fizzler_intro",

-- ---------------------------------------------------
--	Lasers + Catapult
-- ---------------------------------------------------
"sp_a2_sphere_peek",
"sp_a2_ricochet",

-- ---------------------------------------------------
-- 	Bridges
-- ---------------------------------------------------
"sp_a2_bridge_intro",
"sp_a2_bridge_the_gap",

-- ---------------------------------------------------
-- 	Turrets
-- ---------------------------------------------------
"sp_a2_turret_intro",
"sp_a2_laser_relays", -- breather
"sp_a2_turret_blocker",
"sp_a2_laser_vs_turret", -- Elevator Glados Chat - Should be removed?

-- ---------------------------------------------------
-- 	Graduation
-- ---------------------------------------------------
"sp_a2_pull_the_rug",
"sp_a2_column_blocker",		-- Elevator_vista
"sp_a2_laser_chaining",
--"sp_a2_turret_tower",
"sp_a2_triple_laser",

-- ---------------------------------------------------
-- 	Sabotage
-- ---------------------------------------------------

"sp_a2_bts1",
"sp_a2_bts2",
"sp_a2_bts3",
"sp_a2_bts4",
"sp_a2_bts5",
"sp_a2_bts6",

-- ---------------------------------------------------
-- 	Glados Chamber Sequence
-- ---------------------------------------------------
"sp_a2_core",


-- ===================================================
-- ====================== ACT 3 ======================
-- ===================================================

-- ---------------------------------------------------
-- 	Underground
-- ---------------------------------------------------

	"@bottomless_pit",
"sp_a3_00",
"sp_a3_01",
"sp_a3_03",
	"@test_dome_lift",
"sp_a3_jump_intro",
	"@test_dome_lift",
"sp_a3_bomb_flings",
	"@test_dome_lift",
"sp_a3_crazy_box",
	"@test_dome_lift",
"sp_a3_transition01",
	"@test_dome_lift",
"sp_a3_speed_ramp",
	"@test_dome_lift",
"sp_a3_speed_flings",
	"@test_dome_lift",
"sp_a3_portal_intro",
	"@hallway",
"sp_a3_end",

-- ===================================================
-- ====================== ACT 4 ======================
-- ===================================================

-- ---------------------------------------------------
-- 	Recapture
-- ---------------------------------------------------
"sp_a4_intro",

-- ---------------------------------------------------
-- 	Tractor beam
-- ---------------------------------------------------
"sp_a4_tb_intro",
"sp_a4_tb_trust_drop",	
--	"@hallway",
"sp_a4_tb_wall_button",
--	"@hallway",
"sp_a4_tb_polarity",
--	"@hallway",
"sp_a4_tb_catch",	-- GRAD

-- ---------------------------------------------------
-- 	Crushers
-- ---------------------------------------------------

-- ---------------------------------------------------
-- 	Graduation Combos
-- ---------------------------------------------------
"sp_a4_stop_the_box",	-- Grad?
--	"@hallway",
"sp_a4_laser_catapult", -- Grad
--	"@hallway",
--"sp_catapult_course"
--	"@hallway",
--"sp_box_over_goo", -- Grad
--	"@hallway",
"sp_a4_laser_platform",

-- ---------------------------------------------------
-- Tbeam + Paint
-- ---------------------------------------------------
--"sp_paint_jump_tbeam",
--	"@hallway",
"sp_a4_speed_tb_catch",
--	"@hallway",
"sp_a4_jump_polarity",	-- GRAD
--	"@hallway",
--"sp_paint_portal_tbeams",

-- ---------------------------------------------------
-- Wheatley Escape
-- ---------------------------------------------------

"sp_a4_finale1",
	"@hallway",
"sp_a4_finale2",
	"@hallway",
"sp_a4_finale3",
	"@hallway",

-- ---------------------------------------------------
-- 	FIXME: WHEATLEY BATTLE
-- ---------------------------------------------------

"sp_a4_finale4",

-- ---------------------------------------------------
-- 	Demo files
-- ---------------------------------------------------
"demo_intro",
"demo_underground",
"demo_paint",
}


-- --------------------------------------------------------
-- OnPostTransition - we just transitioned, teleport us to the correct place.
-- --------------------------------------------------------
function OnPostTransition()
    local foundMap = false
    local curMap = game.GetMap()

    for index, map in ipairs(MapPlayOrder) do
        if curMap == map then
            foundMap = true

            -- hook up our entry elevator
            if index - 1 >= 1 then -- Lua arrays start at 1, not 0
                if not string.find(MapPlayOrder[index - 1], "@") then
                    print("Teleporting to default start pos")
                    EntFire("@elevator_entry_teleport", "Teleport", 0, 0)
                    EntFire("@arrival_teleport", "Teleport", 0, 0)
                else
                    print("Trying to teleport to " .. MapPlayOrder[index - 1] .. "_teleport")
                    EntFire(MapPlayOrder[index - 1] .. "_entry_teleport", "Teleport", 0, 0.0)
                end
            end
            break
        end
    end

    if not foundMap then
        EntFire("@elevator_entry_teleport", "Teleport", 0, 0)
        EntFire("@arrival_teleport", "Teleport", 0, 0)
    end
end
-- --------------------------------------------------------
-- EntFire_MapLoopHelper
-- --------------------------------------------------------
function EntFire_MapLoopHelper(classname, suffix, command, param, delay)
    -- This calls EntFire on an entity of a given type, named with the given suffix.
    -- This deals with instance name mangling (though it doesn't guarantee uniqueness)

    local suffix_len = #suffix -- Lua uses #string for length
    local found = false

    for _, ent in ipairs(ents.FindByClass(classname)) do
        local ent_name = ent:GetName()
        local suffix_offset = string.find(ent_name, suffix, 1, true) -- plain find (no patterns)

        -- Check if suffix matches at the end of the entity name
        if suffix_offset and suffix_offset == (#ent_name - suffix_len + 1) then
            EntFire(ent_name, command, param, delay)
            found = true
            break
        end
    end

    if not found then
        print("MAPLOOP: ---- ERROR! Failed to find entity " .. suffix .. " while initiating map transition")
    end
end
-- --------------------------------------------------------
-- Think
-- --------------------------------------------------------
hook.Add("Think", "Portal2_LoopThink", function()
    -- Start the game loop if initialized and condition true
    if initialized and GetConVar("loop_single_player_maps"):GetBool() then
        if LOOP_TIMER == 0 then
            LOOP_TIMER = CurTime() + 10
        end
        
        if LOOP_TIMER < CurTime() then
            LOOP_TIMER = 0
            print("\nMAPLOOP: timer expired, moving on...")

            -- Disable viewcontrollers
            for _, vc in ipairs(ents.FindByClass("point_viewcontrol")) do
                vc:Fire("Disable")
            end

            -- Map transition sequence
            EntFire_MapLoopHelper("trigger_once",   "survey_trigger",    "Disable",       "", 0.0)
            EntFire_MapLoopHelper("env_fade",       "exit_fade",         "Fade",          "", 0.0)
            EntFire_MapLoopHelper("point_teleport", "exit_teleport",     "Teleport",      "", 0.3)
            EntFire_MapLoopHelper("logic_script",   "transition_script", "RunScriptCode", "TransitionFromMap()", 0.4)
        end
    end

    if initialized then return end
    initialized = true

    -- Position fix for sp_a3_01
    if game.GetMap() == "sp_a3_01" then
        print("--------------- FIXING PLAYER POSITION FOR sp_a3_01")

        local destination_name = "knockout-teleport"
        local player = Entity(1) -- first player (singleplayer assumption)
        if not IsValid(player) then
            print("*** Cannot find player. Aborting!")
            return
        end

        local destination = ents.FindByName(destination_name)[1]
        if not IsValid(destination) then
            print("*** Cannot find destination entity " .. destination_name .. ". Aborting!")
            return
        end

        player:SetPos(destination:GetPos())
    end

    DumpMapList()

    local portalGunCommand = ""
    local portalGunSecondCommand = ""

    for i, map in ipairs(MapPlayOrder) do
        if map == FIRST_MAP_WITH_GUN then
            portalGunCommand = "give weapon_portalgun"
        elseif map == FIRST_MAP_WITH_UPGRADE_GUN then
            portalGunSecondCommand = "upgrade_portalgun"
        elseif map == FIRST_MAP_WITH_POTATO_GUN then
            portalGunSecondCommand = "upgrade_potatogun"
        end

        if game.GetMap() == map then
            break
        end
    end

    TryDisplayChapterTitle()

    if portalGunCommand ~= "" and game.GetMap() ~= "sp_a2_intro" and game.GetMap() ~= "sp_a3_01" then
        print("=======================Trying to run " .. portalGunCommand)
        for _, cmd in ipairs(ents.FindByClass("point_command")) do
            cmd:Fire("Command", portalGunCommand, 0.0)
        end
    end

    if portalGunSecondCommand ~= "" then
        print("=======================Trying to run " .. portalGunSecondCommand)
        for _, cmd in ipairs(ents.FindByClass("point_command")) do
            cmd:Fire("Command", portalGunSecondCommand, 0.1)
        end
    end
end)

-- --------------------------------------------------------
-- TransitionFromMap
-- --------------------------------------------------------
function DumpMapList()
    if not DBG then return end

    local mapcount = 0
    local currentMap = game.GetMap()

    print("================DUMPING MAP PLAY ORDER")

    for _, map in ipairs(MapPlayOrder) do
        -- weed out our transitions (skip any with '@')
        if not string.find(map, "@") then
            if currentMap == map then
                print(mapcount .. " " .. map .. " <--- You Are Here")
            else
                print(mapcount .. " " .. map)
            end
            mapcount = mapcount + 1
        end
    end

    print(mapcount .. " maps total.")
    print("================END DUMP")
end

-- --------------------------------------------------------
-- TransitionFromMap
-- --------------------------------------------------------
function TransitionFromMap()
    local currentMap = game.GetMap()
    local next_map = nil

    for index, map in ipairs(MapPlayOrder) do
        if map == currentMap then
            -- Skip placeholder maps starting with '@'
            local skipIndex = index
            for i = 1, 2 do
                if skipIndex + 1 <= #MapPlayOrder then
                    if string.find(MapPlayOrder[skipIndex + 1], "@") then
                        skipIndex = skipIndex + 1
                    else
                        break
                    end
                end
            end

            if skipIndex + 1 <= #MapPlayOrder and currentMap ~= LAST_PLAYTEST_MAP then
                next_map = MapPlayOrder[skipIndex + 1]
                if DBG then print("Map " .. currentMap .. " connects to " .. next_map) end
                EntFire("@changelevel", "Changelevel", next_map, 0.0)
                if DBG then print("@changelevel entity missing, using 'map' command instead") end
                RunConsoleCommand("changelevel", next_map)
            end
        end
    end

    if not next_map then
        if DBG then print("Map " .. currentMap .. " is the last map") end

        for _, ent in ipairs(ents.FindByName("end_of_playtest_text")) do
            ent:Fire("Display", "", 0)
        end
        for _, ent in ipairs(ents.FindByName("@end_of_playtest_text")) do
            ent:Fire("Display", "", 0)
        end

        if GetConVar("loop_single_player_maps"):GetBool() then
            next_map = MapPlayOrder[1]
            timer.Simple(0.1, function()
                EntFire("@changelevel", "Changelevel", next_map, 0.0)
            end)
            print("MAPLOOP: Restarting loop.")
        end
    end
    print("")
end

-- --------------------------------------------------------
-- MakeBatFile - dumps the map list in a formatted way, for easy recompilin'
-- --------------------------------------------------------
function MakeBatFile()
    print("================DUMPING maps formatted for batch file")

    local mapcount = 0

    -- First pass: build maps
    for _, map in ipairs(MapPlayOrder) do
        print("call build " .. map)
    end

    -- Second pass: build cubemaps
    for _, map in ipairs(MapPlayOrder) do
        print("call p2_buildcubemaps " .. map)
    end
end

-- This lets the elevator know we are ready to transition.
function TransitionReady()
    TransitionReadyFlag = true -- Just set a global boolean
end
