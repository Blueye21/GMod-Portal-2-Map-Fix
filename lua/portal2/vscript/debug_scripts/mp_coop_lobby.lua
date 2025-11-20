TauntList = {
--0 
"smallWave",
"highFive",
"not_used",
"rps",
--4 
"laugh",
"robotDance",
--6 
"teamtease",
"not_used",
"teamhug",
"trickfire",
}


function OpenHUBAreas()
    local numHighestActiveBranch = GetHighestActiveBranch()
    local numReturnToHub = GetGladosSpokenFlags(2)

    EntFire("counter_screen_flip", "SetMaxValueNoFire", numHighestActiveBranch, 0)

    if numHighestActiveBranch == 1 then
        if bit.band(numReturnToHub, bit.lshift(1, 0)) ~= 0 then
            -- quick way
            EntFire("counter_return_to_hub", "SetValue", "1", 0)
        else
            -- slow way
            EntFire("counter_choose_course", "SetValue", "1", 0)
            -- remember we saw it
            AddGladosSpokenFlags(2, bit.lshift(1, 0))
        end

        EntFire("counter_music", "SetValue", "1", 0)

    elseif numHighestActiveBranch == 2 then
        if bit.band(numReturnToHub, bit.lshift(1, 1)) ~= 0 then
            -- quick way
            EntFire("counter_return_to_hub", "SetValue", "2", 0)
        else
            -- slow way
            EntFire("counter_choose_course", "SetValue", "2", 0)
            -- remember we saw it
            AddGladosSpokenFlags(2, bit.lshift(1, 1))
        end

        EntFire("texture_course_01", "SetTextureIndex", "1", 3)
        EntFire("counter_music", "SetValue", "2", 0)

    elseif numHighestActiveBranch == 3 then
        if bit.band(numReturnToHub, bit.lshift(1, 2)) ~= 0 then
            -- quick way
            EntFire("counter_return_to_hub", "SetValue", "3", 0)
        else
            -- slow way
            EntFire("counter_choose_course", "SetValue", "3", 0)
            -- remember we saw it
            AddGladosSpokenFlags(2, bit.lshift(1, 2))
        end

        EntFire("texture_course_01", "SetTextureIndex", "2", 3)
        EntFire("texture_course_02", "SetTextureIndex", "1", 4)
        EntFire("counter_music", "SetValue", "3", 0)

    elseif numHighestActiveBranch == 4 then
        if bit.band(numReturnToHub, bit.lshift(1, 3)) ~= 0 then
            -- quick way
            EntFire("counter_return_to_hub", "SetValue", "4", 0)
        else
            -- slow way
            EntFire("counter_choose_course", "SetValue", "4", 0)
            -- remember we saw it
            AddGladosSpokenFlags(2, bit.lshift(1, 3))
        end

        EntFire("texture_course_01", "SetTextureIndex", "2", 3)
        EntFire("texture_course_02", "SetTextureIndex", "2", 4)
        EntFire("texture_course_03", "SetTextureIndex", "1", 5)
        EntFire("counter_music", "SetValue", "4", 0)

    elseif numHighestActiveBranch == 5 then
        if bit.band(numReturnToHub, bit.lshift(1, 4)) ~= 0 then
            -- quick way
            EntFire("counter_return_to_hub", "SetValue", "5", 0)
        else
            -- slow way
            EntFire("counter_choose_course", "SetValue", "5", 0)
            -- remember we saw it
            AddGladosSpokenFlags(2, bit.lshift(1, 4))
        end

        EntFire("texture_course_01", "SetTextureIndex", "2", 3)
        EntFire("texture_course_02", "SetTextureIndex", "2", 4)
        EntFire("texture_course_03", "SetTextureIndex", "2", 5)
        EntFire("texture_course_04", "SetTextureIndex", "1", 6)
        EntFire("counter_music", "SetValue", "5", 0)

    elseif numHighestActiveBranch >= 6 then
        EntFire("counter_return_to_hub", "SetValue", "6", 0)
        EntFire("texture_course_01", "SetTextureIndex", "2", 3)
        EntFire("texture_course_02", "SetTextureIndex", "2", 4)
        EntFire("texture_course_03", "SetTextureIndex", "2", 5)
        EntFire("texture_course_04", "SetTextureIndex", "2", 6)

        if numHighestActiveBranch == 6 then
            EntFire("counter_music", "SetValue", "6", 0)
        else
            EntFire("counter_music", "SetValue", "7", 0)
        end
    end

    -- now grant taunts to players if they are playing with a partner who has unlocked more courses
    -- teamtease first
    if numHighestActiveBranch >= 3 then
        -- check if mp_coop_fan is NOT complete in course 2 by either player
        if IsPlayerLevelComplete(0, 1, 7) == false or IsPlayerLevelComplete(1, 1, 7) == false then
            EntFire("@command", "command", "mp_earn_taunt teamtease 1", 1.0)
            -- print("!!=== SCRIPT trying to grant teamtease silently")
        end
    end

    -- now check the same thing for the laugh taunt
    if numHighestActiveBranch >= 2 then
        -- check if mp_coop_teambts is NOT complete in course 1
        if IsPlayerLevelComplete(0, 0, 5) == false or IsPlayerLevelComplete(1, 0, 5) == false then
            EntFire("@command", "command", "mp_earn_taunt laugh 1", 1.0)
            -- print("!!=== SCRIPT trying to grant laugh silently")
        end
    end

    EntFire("counter_music", "GetValue", "", 1)

    if numHighestActiveBranch >= 2 then
        EntFire("hint_zoom", "Enable", "", 0)
    end

    -- give each player an achievement if they finished the prior branch

    -- TEAM_BUILDING
    if IsPlayerBranchComplete(0, 0) then
        RecordAchievementEvent("ACH.TEAM_BUILDING", GetBluePlayerIndex())
    end
    if IsPlayerBranchComplete(1, 0) then
        RecordAchievementEvent("ACH.TEAM_BUILDING", GetOrangePlayerIndex())
    end

    -- MASS_AND_VELOCITY
    if IsPlayerBranchComplete(0, 1) then
        RecordAchievementEvent("ACH.MASS_AND_VELOCITY", GetBluePlayerIndex())
    end
    if IsPlayerBranchComplete(1, 1) then
        RecordAchievementEvent("ACH.MASS_AND_VELOCITY", GetOrangePlayerIndex())
    end

    -- LIGHT BRIDGES
    if IsPlayerBranchComplete(0, 2) then
        RecordAchievementEvent("ACH.HUG_NAME", GetBluePlayerIndex())
    end
    if IsPlayerBranchComplete(1, 2) then
        RecordAchievementEvent("ACH.HUG_NAME", GetOrangePlayerIndex())
    end

    -- EXCURSION_FUNNELS
    if IsPlayerBranchComplete(0, 3) then
        RecordAchievementEvent("ACH.EXCURSION_FUNNELS", GetBluePlayerIndex())
    end
    if IsPlayerBranchComplete(1, 3) then
        RecordAchievementEvent("ACH.EXCURSION_FUNNELS", GetOrangePlayerIndex())
    end

    for i = 0, 4 do
        for j = 0, 15 do
            if IsLevelComplete(i, j) then
                EntFire("texture_level_complete" .. i .. j, "SetTextureIndex", "1", 0)
            end
        end

        local branch = i + 1

        if IsBranchComplete(i) then
            EntFire("track" .. branch .. "-texture_toggle_door", "SetTextureIndex", "1", i + 3)
        end
    end

    GrantGameCompleteAchievementHUB()
end

function CompleteFinalMap()
	MarkMapComplete( game.GetMap() )
end

function GrantGameCompleteAchievementHUB()
	local bGameCompleteB = true
	local bGameCompleteO = true
	for i = 0, 4 do
		if IsPlayerBranchComplete( 0, i ) == false then
			bGameCompleteB = false
			//printl("!!=== bGameCompleteB = false --- not completed branch " + i )
        end
		if IsPlayerBranchComplete( 1, i ) == false then
			bGameCompleteO = false
        end
	end
	
	if bGameCompleteB then
		RecordAchievementEvent( "ACH.NEW_BLOOD", GetBluePlayerIndex() )	
		RecordAchievementEvent( "AV_SHIRT1", GetBluePlayerIndex() )
		//printl("!!!!!!!!=== AWARDING END GAME ACHIEVEMENT!!!" )
    end
	if bGameCompleteO then
		RecordAchievementEvent( "ACH.NEW_BLOOD", GetOrangePlayerIndex() )	
		RecordAchievementEvent( "AV_SHIRT1", GetOrangePlayerIndex() )	
    end
end

function GrantGameCompleteAchievement()
	// this was moved from the last map because the toast caused the bink movie's sound to echo on the 360!
	// it now lives in credits_coop.nut in CreditsGrantGameCompleteAchievement
end

function EarnTaunt(nTaunt)
    local TauntName = TauntList[nTaunt]
    if TauntName == "not_used" then
        return
    end

    local bGrantTauntB = true
    local bGrantTauntO = true

    if TauntName == "laugh" or TauntName == "teamtease" then
        local nCourse = 0

        if TauntName == "laugh" then
            nCourse = 1
        elseif TauntName == "teamtease" then
            nCourse = 2
        end

        for j = 0, 15 do
            if IsPlayerLevelComplete(0, nCourse, j) then
                bGrantTauntB = false
                -- print("bGrantTauntB = false")
            end

            if IsPlayerLevelComplete(1, nCourse, j) then
                bGrantTauntO = false
                -- print("bGrantTauntO = false")
            end
        end
    end

    if bGrantTauntB == false and bGrantTauntO == false then
        -- print("Not granting " .. TauntName .. " because both players already have it")
        return
    end

    -- print("Earning " .. TauntName)
    EntFire("@command", "command", "mp_earn_taunt " .. TauntName, 0.0)
end

function TransitionToCredits()
    if IsLocalSplitScreen() then
        EntFire("@command", "Command", "changelevel mp_coop_credits", 0.1)
    else
        EntFire("@command", "Command", "changelevel mp_coop_credits", 0.0)
    end
end

function CheckForNewTaunts()
end