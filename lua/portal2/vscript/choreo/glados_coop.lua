BluePingCount = 0	
BlueBadPingCount = 0
BlueLastPing = CurTime()
BlueInPortalTraining =0
OrangeInPortalTraining =0
OrangePingCount = 0	
OrangeLastPing = CurTime()
OrangeBadPingCount = 0
BluePortalTrainingCounter = 0
OrangePortalTrainingCounter = 0
BlueHasGun =0
OrangeHasGun =0
CoopStartCalCompleteSet = 0
BlueInMaze = 0
OrangeInMaze = 0
BlueInCrusher =0
OrangeInCrusher =0
mp_coop_infinifling_traindeath = 0
mp_coop_infinifling_traindeath01 = 0
mp_coop_catapult_wall_introdeath = 0
mp_coop_wall_blockdeath = 0
bluetrust =0
orangetrust =0
BlueTalk =0
OrangeTalk =0
BlueNoTalk =0
OrangeNoTalk =0
startdeath =0
mp_coop_turret_ballcount =0
InHub2 =0
teambtstaunts = 0
GladosInsideTauntCam = 0
GladosInsideTauntCamCounter = 1
GladosInsideTauntCamInterval = 0
GladosInsideTauntCamLastInterval = 0
OrangeTauntCam =0
BlueTauntCam =0
BlueTauntFinaleInterval =0
OrangeTauntFinaleInterval =0
LastDeathTime = 0
LastTauntTime = 0
BluePingStartTimer =0
OrangePingStartTimer =0
BluePingStartDone = 0
OrangePingStartDone = 0
--Fire Once
CoopStartBButtonSet =0
CoopStartButtonSet =0
CoopStartBoxButtonSet =0
CoopCrushersBlueCrushset = 0
CoopCrushersOrangeCrushset = 0
CoopMazeBlueCrushset = 0
CoopMazeOrangeCrushset = 0
InHub2Set = 0
testcnt =0
BluePingTraining1 =0
BluePingTraining2 =0
OrangePingTraining1 =0
OrangePingTraining2 =0
mp_coop_wall_2death =0
HumanResourceDeath1 =0
HumanResourceDeath2 =0
HumanResourceDeath3 =0
HumanResourceDeath4 =0
HumanResourceDeath5 =0
HumanResourceDeath6 =0
HumanResourceDeath7 =0
EarlyDeath1 =0
EarlyDeath2 =0
EarlyDeath3 =0
EarlyDeath4 =0
EarlyDeath5 =0
Tbeam_enddeathturret =0
Tbeam_enddeathfall =0
Tbeam_enddeathcounter =0
Tbeam_enddeathother = 0
mp_coop_laser_crusherdeath =0
mp_coop_turret_wallscount =0
mp_coop_tbeam_laser_1death1 =0
mp_coop_tbeam_laser_1death2 =0
mp_coop_tbeam_redirectdeath =0
mp_coop_tbeam_drilldeathorange =0
mp_coop_tbeam_drilldeathblue =0
mp_coop_tbeam_polaritydeathorange =0
mp_coop_tbeam_polaritydeathblue =0
mp_coop_tbeam_polarity3deathorange =0
mp_coop_tbeam_polarity3deathblue =0
polarity2whisper = 0
mp_coop_multifling_1cube = 0
summer_sale_cube_died = false

--ispaused()
--IsPlayingBack()
--EstimateLength()

--DBG stuff
DBGInterval = 10.00

lastthink = CurTime()
startBlock = 0

--Queue of scenes started with GladosPlayVcd()
scenequeue = {}
firedfromqueue = false

--Map Name
curMapName = game.GetMap()

--PitchShifting stuff
pitchShifting = false
pitchShiftLastThink = CurTime()
pitchShiftInterval = 1.0
pitchShiftValue = 1.0
pitchOverride = nil

--State Flags
stateSlowFieldTraining = false


--jailbreak specific stuff
if curMapName=="sp_sabotage_jailbreak_01" or curMapName=="sp_sabotage_jailbreak" or curMapName=="sp_a2_bts1" then
	jailbreakpos = 0
end


--sp_catapult_fling_sphere_peek specific stuff
if curMapName=="sp_a2_sphere_peek" then
	peekctr = 0
end


--Dings
sceneDingOn  = CreateSceneEntity("scenes/npc/glados_manual/ding_on.vcd")
sceneDingOff = CreateSceneEntity("scenes/npc/glados_manual/ding_off.vcd")



--include("choreo/glados_coop_scenetable_include.lua")
--include("choreo/glados_coop_scenetable_include_manual.lua")

--Co-op sepcific stuff
	coopFirstPlayerToGetGun = 0 --Saves id of first player to pick up portal gun
	coopBlue = 2 --id of blue player
	coopOrange = 1 --id of orange player
	coopTalkIDBlue =1 --Blue id for IsPlayerSpeaking() - There's some weirdness where it may not be the same as coopBlue  
	coopTalkIDOrange =2 --Orange id for IsPlayerSpeaking() - There's some weirdness where it may not be the same as coopOrange
	coopWaitingForGetGun = nil --Waiting for the second player to pick up the portal gun
	coopRelaxationVaultVoiceMonitor = false --true = GladosThink() should monitor for player speech
	coopRelaxationVaultVoiceBlueTicks = 0 --Number of times GladosThink() has detected Blue speaking
	coopRelaxationVaultVoiceOrangeTicks = 0 --Number of times GladosThink() has detected Blue speaking
	coopRelaxationVaultthreshold = 20 --number of times in GladosThink that a player has to talk before it is an interruption
	coopSilencethreshold = 1.0 --number of seconds in GladosThink that both players have to remain silent before it is considered a silence
	coopSilenceTicks = 0 --Number of consecutive GladosThink() calls during which neither player was speaking
	coopSayOnSilence = 0 --if >0: When coopSilenceTicks>=coopSilencethreshold, GladosPlayVcd(coopSayOnSilence)
	coopWaitingToExit = false
--Co-op Ping Training Stuff
	coopPingGameOn = false
	coopPingPlayerTurn = 0
	coopPingTurnNumber = 0
	coopPingNextScene = nil
	coopPingNextSceneDelay = nil
	coopWrongMovesBlue = 0
	coopWrongMovesOrange = 0
	coopSaidWrongMovesDialog = false
	coopPingsOrange = 0
	coopPingsBlue = 0
	coopPingNoInterrupt = false
	coopTimeSinceTurn = CurTime()
	coopSilenceBlahsPlayed = 0
	coopTriggeredElevator = false
	
--Score Stating Stuff
	coopScoreToState = nil

-- Achievement LIMITED_PORTALS
LIMITED_PORTALS_MAP = "mp_coop_catapult_wall_intro"	-- Map the achievement takes place on.
LIMITED_PORTALS_COUNT = 5								-- Max number of portals to make the achievement.

-- Achievement STAYING_ALIVE
STAYING_ALIVE_SECTION = 4								-- Section the achievement applies to.

-- Achievement SPEED_RUN_COOP
SPEED_RUN_THRESHOLD = 60								-- Number of seconds a run must be finished in to count.
SPEED_RUN_SECTION = 2									-- Section the achievement applies to.
mp_coop_speed_run_time = 0

function printlDBG(arg)
	if DBG then
		print(arg)
	end
end


-- OnPostSpawn - this is all the initial setup stuff
function OnPostSpawn()
		local i = 0
		--assign a unique id to each scene entity (uses SetTeam because that's the only thing available)
		for val, _ in ipairs(SceneTable) do
			i = i + 1
			val.vcd.ValidateScriptScope()
			val.vcd.SetTeam(i)
			val.index = i
		end
		--Initialize the deferred scene queue
		QueueInitialize()
				
		--Map specific Spawn stuff
		if curMapName == "sp_a1_wakeup" then
			EntFire("@glados","runscriptcode","sp_a1_wakeup_start_map()",1.0)
		end
	end



--Passed the unique team id associated with a scene entity defined in SceneTable, this function returns the correct SceneTable index for that entry
--ex: SceneTableInst = SceneTable[findIndex(team)]
function findIndex(team)
    for idx, val in ipairs(SceneTable) do
        if val.index == team then
            return idx
        end
    end

    return nil
end

-- Passed the unique team id associated with a scene entity defined in SceneTable,
-- this function returns the scene instance that originally fired it.
-- If multiple scene instances fire the same VCD, this isn't reliable.
function FindSceneInstanceByTeam(team)
    local inst = nil

    for _, scene in ipairs(scenequeue) do
        if scene.waitFiredVcds then
            for _, vcdTeam in ipairs(scene.waitFiredVcds) do
                if vcdTeam == team then
                    inst = scene
                    break
                end
            end
        end

        if inst ~= nil then
            break
        end
    end

    return inst
end

function SceneCanceled()
    -- GLua method call should use ':' instead of '.'
    local team = owninginstance:GetTeam()

    printlDBG(
        "========SCENE CANCELLED - CALLING ENTITY: " ..
        tostring(findIndex(team))
    )
end

--If a vcd is tagged to "exit early" (by setting postdelay < 0), this event fires rather than PlayNextScene() when the vcd finishes.
--SkipOnCompletion() has all the functionality of PlayNextScene(), except it doesn't actually play the next scene, because the next scene presumably
--already started playing when the vcd exited early.
--SkipOnCompletion does, however, evaluate the vcd's SceneTable entry to see if any EntFires need to happen.
--[[
function SkipOnCompletion()
{
	printlDBG("========SKIPONCOMPLETION CALLING ENTITY: "+findIndex(owninginstance.GetTeam())+" : TIME "+CurTime())
	local team = owninginstance.GetTeam()
	local inst = FindSceneInstanceByTeam(team)
	if (inst ~= nil)
	{
		inst.deleteFiredVcd(team)
		inst.waitVcdCurrent = findIndex(team)
		--Are there any EntFires associated with this vcd?
		if (inst.waitVcdCurrent ~= nil)
		{
			if ("fires" in SceneTable[inst.waitVcdCurrent])
			{
				local idx, val
				foreach (idx, val in SceneTable[inst.waitVcdCurrent].fires)
				{
					if (!("fireatstart" in val))
					{
						printlDBG(">>>>>>ENT FIRE AT (SKIPCOMPLETION) END: "+val.entity+":"+val.input)
						EntFire(val.entity,val.input,val.parameter,val.delay)
					}
				}
			}
		}
	}
}	


function PlayNextScene()
	printlDBG("========PLAYNEXTSCENE CALLING ENTITY: "..findIndex(owninginstance.GetTeam()).." : TIME "..CurTime())
	local team = owninginstance.GetTeam()
	local inst = FindSceneInstanceByTeam(team)
	if inst ~= nil then
		inst.deleteFiredVcd(team)
		inst.waitVcdCurrent = findIndex(team)
		PlayNextSceneInternal(inst)
	end
end



function PlayNextSceneInternal(inst = nil)
--inst = just completed scene
{
	local i = 0
	local tmp = 0
	--printlDBG("===================Scene Done!" + i)
	
	--Set the ducking back to the default value
	SendToConsole( "snd_ducktovolume 0.55" )
	
	--Are there any "fire at the end" triggers associated with the just completed?
	if (inst.waitVcdCurrent ~= nil)
	{
		if ("fires" in SceneTable[inst.waitVcdCurrent])
		{
			local idx, val
			foreach (idx, val in SceneTable[inst.waitVcdCurrent].fires)
			{
				if (!("fireatstart" in val))
				{
					printlDBG(">>>>>>ENT FIRE AT END: "+val.entity+":"+val.input)
					EntFire(val.entity,val.input,val.parameter,val.delay)
				}
			}
		}
	}
	--Is there another vcd in the scene chain?
	if (inst.waitNext ~= nil)
	{
		printlDBG("=====There is a next scene: "+inst.waitNext)
		if (inst.waitLength == nil)
		{
			i+=1
			printlDBG("===================Ready to play:" + i)
			GladosPlayVcd(inst)
 		}	
		else
		{
			inst.waitStartTime = CurTime()
			inst.waiting = 1
		}	
	}
	else
	{
		printlDBG("=====No next scene!")
		--Remove the instance from the scene list
		scenequeue_DeleteScene(inst.index)
		--The current scene is over. Check to see if there are any queued scenes.
		if (QueueCheck())
			return

		--Do the ding if nothing's queued and the previous scene requires a ding
		if (!inst.waitNoDingOff)
			EntFireByHandle( sceneDingOff, "Start", "", 0.1, nil, nil )
	}
}


--Think function
function GladosThink()
	--Put DBG stuff here!
	if DBG then
		if CurTime()-lastthink>DBGInterval then
			printlDBG("===================GladosThink-> " .. lastthink)
			lastthink = CurTime()
			QueueDBG()
		end
	end
	


	local idx, val
	for idx,val in ipairs(scenequeue) do
		--Check if current vcd is scheduled to exit early
		if val.waitExitingEarly then
			if CurTime()-val.waitExitingEarlyStartTime >= val.waitExitingEarlyThreshold then
				local team
				val.waitExitingEarly=false
				local curscene = characterCurscene(val.currentCharacter)
				if curscene~=nil then
					curscene.ValidateScriptScope()
					curscene.GetScriptScope().SkipOnCompletion = SkipOnCompletion.bindenv(this)
					curscene.DisconnectOutput("OnCompletion", "PlayNextScene")
					curscene.DisconnectOutput("OnCompletion", "SkipOnCompletion")
					curscene.ConnectOutput( "OnCompletion", "SkipOnCompletion" )
					team = curscene.GetTeam()
					val.waitVcdCurrent = findIndex(team)
				end
				printlDBG("====EXITING EARLY!!!!!!!")
				PlayNextSceneInternal(val)
				return
			end
		end
	end
	
	local tmp
	--Check the deferred scene queue
	tmp = QueueThink()
	--Is a queued scene ready to fire?
	if tmp ~= nil then
			printlDBG("===========Forcing a queued Scene!!!~========")
			GladosPlayVcd(tmp,true)
			return
	end

	for idx,val in ipairs(scenequeue)
		--Are we waiting to play another vcd?
		if val.waiting == 1 then
			if CurTime()-val.waitStartTime >= val.waitLength then
				val.waiting = 0
				GladosPlayVcd(val)
			end
		end
	end
	
	if curMapName=="mp_coop_start" and  BluePingStartDone==1 then
		local curTime=CurTime()
		local BluePingStartInterval = curTime - BluePingStartTimer
		if BluePingStartInterval>20 then
			BluePingStartTimer=CurTime()
			GladosPlayVcd(1331)
		end
	end
	if curMapName=="mp_coop_start" and  OrangePingStartDone==1 then
		local curTime=CurTime()
		local OrangePingStartInterval = curTime - OrangePingStartTimer
		if OrangePingStartInterval>20 then
			OrangePingStartTimer=CurTime()
			GladosPlayVcd(1332)
		end	
	end

	if GladosInsideTauntCam == 1 then
		local curTime=CurTime()
		local tauntreactionfired = 0
		local GladosInsideTauntCamInterval = curTime-GladosInsideTauntCamLastInterval
		printlDBG("=================================== CAM INTERVAL:"+GladosInsideTauntCamCounter+" - "+GladosInsideTauntCamInterval+" - "+GladosInsideTauntCam)
		if GladosInsideTauntCamInterval>8 or GladosInsideTauntCamCounter==1 then
			if (BlueTauntCam==1	and OrangeTauntCam==0){
				if (curTime-BlueTauntFinaleInterval<5){
					tauntreactionfired = 1
					GladosInsideTauntCamLastInterval=CurTime()-6
					GladosPlayVcd(1194)
				}
			}

			if (BlueTauntCam==0	and OrangeTauntCam==1){
				if (curTime-OrangeTauntFinaleInterval<5){
					tauntreactionfired = 1
					GladosInsideTauntCamLastInterval=CurTime()-6
					GladosPlayVcd(1195)
				}
			}

			if (tauntreactionfired == 0){
			switch (GladosInsideTauntCamCounter)
			{
				case 1: 
					GladosPlayVcd(1156)
					GladosInsideTauntCamCounter=GladosInsideTauntCamCounter+1
					GladosInsideTauntCamLastInterval=CurTime()
					-- this is where we want to count completing paint_longjump
					EndSpeedRunTimer()
					break

				case 2: 
					GladosPlayVcd(1166)
					GladosInsideTauntCamCounter=GladosInsideTauntCamCounter+1
					GladosInsideTauntCamLastInterval=CurTime()
					break
				case 3: 
					GladosPlayVcd(1165)
					GladosInsideTauntCamCounter=GladosInsideTauntCamCounter+1
					GladosInsideTauntCamLastInterval=CurTime()
					break
				case 4: 
					GladosPlayVcd(1167)
					GladosInsideTauntCamCounter=GladosInsideTauntCamCounter+1
					GladosInsideTauntCamLastInterval=CurTime()
					break
				case 5: 
					GladosPlayVcd(1168)
					GladosInsideTauntCamCounter=GladosInsideTauntCamCounter+1
					GladosInsideTauntCamLastInterval=CurTime()
					break
				case 6: 
					GladosPlayVcd(1158)
					GladosInsideTauntCamCounter=GladosInsideTauntCamCounter+1
					GladosInsideTauntCamLastInterval=CurTime()
					break
				case 7: 
					GladosPlayVcd(1157)
					GladosInsideTauntCamCounter=GladosInsideTauntCamCounter+1
					GladosInsideTauntCamLastInterval=CurTime()
					break
				case 8: 
					GladosPlayVcd(1169)
					GladosInsideTauntCamCounter=GladosInsideTauntCamCounter+1
					GladosInsideTauntCamLastInterval=CurTime()
					break
				case 9: 
					GladosPlayVcd(1159)
					GladosInsideTauntCamCounter=GladosInsideTauntCamCounter+1
					GladosInsideTauntCamLastInterval=CurTime()
					break
				case 10: 
					GladosPlayVcd(1160)
					GladosInsideTauntCamCounter=GladosInsideTauntCamCounter+1
					GladosInsideTauntCamLastInterval=CurTime()
					break
				case 11: 
					GladosPlayVcd(1164)
					GladosInsideTauntCamCounter=GladosInsideTauntCamCounter+1
					GladosInsideTauntCamLastInterval=CurTime()
					break
				case 12: 
					GladosPlayVcd(1163)
					GladosInsideTauntCamCounter=1
					GladosInsideTauntCamLastInterval=CurTime()
					break
			}
			}
			
		}

	}


}

function GladosBlowUpBots()
{
	-- this calls the function in game code
	CoopGladosBlowUpBots()
}

function GladosEndingTauntCam_Begin(){
	GladosInsideTauntCam =1 
}

function GladosEndingTauntCam_End(){
	GladosInsideTauntCam =0 
}


--Play a vcd from the SceneTable, plus set up next line (if any).
--This is the function that should be used to start a scene from inside a map.
function GladosPlayVcd(arg,IgnoreQueue = nil, caller = nil)
--arg==instance	-> Continue playing scene defined by scene class instance arg
--arg==integer	-> Start playing new scene (scene being a chain of vcds) from SceneTable[SceneTableLookup[arg]]
--arg==string		-> Start playing new scene (scene being a chain of vcds) from SceneTable[arg]
--arg==nil			-> Continue playing current scene with next vcd in current chain
--IgnoreQueue		-> true == don't check for queue status (this is used to force a queued vcd to play)
--caller				-> If passed as an entity, the vcd will have its "target1" set to caller.GetName()
--[[
{
	printlDBG("=========GladosPlayVcd Called~=========")	
	local dingon = false
	local inst
	local fromqueue = firedfromqueue
	firedfromqueue = false
	if (curMapName=="mp_coop_start" ){	
		if (arg==30){	
			BluePingStartDone=1
			BluePingStartTimer=CurTime()+15
		}
		if (arg==32){	
			BluePingStartDone=2
			OrangePingStartDone=1
			OrangePingStartTimer=CurTime()+25
		}
		if (arg==34){	
			OrangePingStartDone=2
		}
	}
	
	
	if (typeof arg == "instance")
	{
		inst = arg
		arg=inst.waitNext
	}
	else
	{
		--If this is a call from the map, look up the integer arg in the scene lookup table.
		--We need to do this because hammer/the engine can't pass a squirrel script a string, just an integer.
		--In other words, from a map, @glados.GladosPlayVcd("MyVcd") crashes the game. GladosPlayVcd(16) doesn't.
		local sceneStart = 0
		if (typeof arg == "integer")
		{
			sceneStart = arg
			printlDBG("{}{}{}{}{}{}{}{}{}GladosPlayVcd: "+arg)	
			arg = SceneTableLookup[arg]
		}
		else
		{
			sceneStart = 0
		}
		--if SkipIfBusy is present & we're already playing a scene, skip this new scene
		if ("skipifbusy" in SceneTable[arg])
		{
		  if (!("char" in SceneTable[arg])){
		  	SceneTable[arg].char = "glados" 
		  }

			if (characterCurscene(SceneTable[arg].char)~=nil)
			{
				return
			}
		}
		--if queue is present & we're already playing a scene, add scene to queue
 		if ("queue" in SceneTable[arg])
	 	{
	 		if (IgnoreQueue == nil)
			{
				--queue if a specific character is talking 
		 		if ("queuecharacter" in SceneTable[arg])
		 		{
					if (characterCurscene(SceneTable[arg].queuecharacter)~=nil)
					{
				 		QueueAdd(arg)
			 			return
			 		}
				}
				--otherwise, queue if the character associated with the vcd is talking
				else
				{
					if (!("char" in SceneTable[arg])){
	  				SceneTable[arg].char = "glados" 
			  	}

					if (characterCurscene(SceneTable[arg].char)~=nil)
					{
				 		QueueAdd(arg)
			 			return
			 		}
			 	}	
			}		
	  }
	  if (!("char" in SceneTable[arg])){
	  	SceneTable[arg].char = "glados" 
	  }
 		if (scenequeue_AddScene(arg,SceneTable[arg].char) == nil)
			return
		inst = scenequeue[arg]
		inst.waitSceneStart = sceneStart
		
		if ("idle" in SceneTable[arg])
		{
			nags_init(inst,arg)
		}

		--This is a new dialog block, so turn off special processing
		dingon=true
		pitchShifting = false
		--startBlock = CurTime()
		if ("noDingOff" in SceneTable[arg])
			inst.waitNoDingOff = true
		else
			inst.waitNoDingOff = false	
		if ("noDingOn" in SceneTable[arg])
			inst.waitNoDingOn = true
		else
			inst.waitNoDingOn = false	
	}
	
	--If this scene is a nag/idle cycle, grab the next line off the stack
	if (inst.isNag)
	{
		--If we're not in a vcd chain, grab the next vcd from the randomized pool
		if (!inst.naginchain)
		{
			arg = nags_fetch(inst)
		}	
		--if nothing fetched (because the nag has used all the lines and isn't marked as "repeat"), remove this scene
		if (arg == nil)
		{
			scenequeue_DeleteScene(inst.index)
			return
		}
	}
	
	--Set ducking volume correctly for booming glados audio
	SendToConsole( "snd_ducktovolume 0.2" )
	
  --SetDucking( "announcerVOLayer", "announcerVO", 0.01 ) 
  --SetDucking( "gladosVOLayer", "gladosVO", 0.1 ) 

	local preDelay = 0.00
	preDelay = EvaluateTimeKey("predelay", SceneTable[arg])
	if (fromqueue and "queuepredelay" in SceneTable[arg])
	{
		preDelay = EvaluateTimeKey("queuepredelay", SceneTable[arg])
	}
		
	if ( arg ~= nil )
	{

		local ltalkover
		ltalkover =  "talkover" in SceneTable[arg]

		--Cancel any vcd that's already playing
		if (!ltalkover)
		{
			GladosAllCharactersStopScene()
		}	
		else
		{
			--characters can't currently talk over themselves
	  	if (!("char" in SceneTable[arg])){
		  	SceneTable[arg].char = "glados" 
		  }
			GladosCharacterStopScene(SceneTable[arg].char)
		}
		
		--Play the initial ding (unless the scene specifically requests no ding)
		if (dingon and !inst.waitNoDingOn)
			EntFireByHandle( sceneDingOn, "Start", "", preDelay, nil, nil )

		
		--Start the new vcd	
		printlDBG("===================Playing:" + arg)
	  if (!("char" in SceneTable[arg])){
	  	SceneTable[arg].char = "glados" 
	  }

		inst.currentCharacter = SceneTable[arg].char
		
		--Bind the OnCompletion Event
		SceneTable[arg].vcd.ValidateScriptScope()
		SceneTable[arg].vcd.GetScriptScope().PlayNextScene = PlayNextScene.bindenv(this)
		SceneTable[arg].vcd.DisconnectOutput( "OnCompletion", "PlayNextScene" )
		SceneTable[arg].vcd.ConnectOutput( "OnCompletion", "PlayNextScene" )
		SceneTable[arg].vcd.ConnectOutput( "OnCanceled", "SceneCanceled" )
		
		--Set the target1 if necessary
		if (caller ~= nil)
		{
			if (typeof caller == "string")
			{
				EntFireByHandle( SceneTable[arg].vcd, "SetTarget1", caller, 0, nil, nil )
				printlDBG("++++++++++++SETTING TARGET: "+caller)
			}	
			else
			{
				EntFireByHandle( SceneTable[arg].vcd, "SetTarget1", caller.GetName(), 0, nil, nil )
			}
		}	
		if ("settarget1" in SceneTable[arg])
		{
			EntFireByHandle( SceneTable[arg].vcd, "SetTarget1", SceneTable[arg].settarget1 , 0, nil, nil )
		}

		inst.waitVcdTeam = SceneTable[arg].index
		inst.waitVcdCurrent = arg
		
		inst.addFiredVcd(SceneTable[arg].index)
				
		if (dingon and !inst.waitNoDingOn)
			EntFireByHandle( SceneTable[arg].vcd, "Start", "", preDelay+0.18, nil, nil )
		else	
			EntFireByHandle( SceneTable[arg].vcd, "Start", "", preDelay, nil, nil )

		
		--Does this vcd have a "fire into entities" array?
		if ("fires" in SceneTable[arg])
		{
			local idx, val
			foreach (idx, val in SceneTable[arg].fires)
			{
				if ("fireatstart" in val)
				{
					printlDBG(">>>>>>ENT FIRE AT START: "+val.entity+":"+val.input)
					EntFire(val.entity,val.input,val.parameter, val.delay)
				}
			}
		}

		if ("special" in SceneTable[arg])
		{
			switch (SceneTable[arg].special)
			{
				case 1: --Block-wide pitch shifting
					pitchShifting = true
					break
				case 2: --Speed up
					if (pitchOverride == nil)	
						EntFireByHandle( SceneTable[arg].vcd, "PitchShift", "2.5", 0, nil, nil )
					break
				case 3: --Slow down a bit	
					EntFireByHandle( SceneTable[arg].vcd, "PitchShift", "0.9", 0, nil, nil )
					break
			}
		}
		if (pitchOverride~=nil)
			EntFireByHandle( SceneTable[arg].vcd, "PitchShift", pitchOverride.tostring(), 0, nil, nil )

    --Setup next line (if there is one)
    if (SceneTable[arg].next ~= nil or inst.isNag)
    {
    	local pdelay = EvaluateTimeKey("postdelay",SceneTable[arg])
    	
    	--if this is a nag, use min/max defined in the first entry in the scene
    	if (inst.isNag)
    	{
    		pdelay = RandomFloat(inst.nagminsecs,inst.nagmaxsecs)
    	}

    	if (pdelay<0.00)
    	{
    		if (inst.isNag)
    			--If the "next" key ~= nil, it means we're in a vcd chain
    			if (SceneTable[arg].next ~= nil)
    			{
    				inst.waitNext = SceneTable[arg].next
    				inst.naginchain = true
    			}
    			else
    			{
    				--Otherwise, just slug in the same index (any non-nil value would work here, however)
						inst.waitNext = arg
    				inst.naginchain = false
					}
    		else
					inst.waitNext = SceneTable[arg].next 
 				inst.waitExitingEarly=true
 				inst.waitLength=nil
 				inst.waitExitingEarlyStartTime=CurTime()
				--If we're in a nag vcd chain, use the vcds postdelay rather than the nag-wide delay
				--This is because vcd chains generally need to be explicitly timed at the chain level
				--since the vcds are grouped together as a block
 				if (inst.naginchain)
 					pdelay = EvaluateTimeKey("postdelay",SceneTable[arg])
 				inst.waitExitingEarlyThreshold=pdelay*-1
			}
			else
			{
 				inst.waitExitingEarly=false
    		if (inst.isNag)
    		{
    			--If the "next" key ~= nil, it means we're in a vcd chain
    			if (SceneTable[arg].next ~= nil)
    			{
    				inst.waitNext = SceneTable[arg].next
    				inst.naginchain = true
    			}
    			else
    			{
    				--Otherwise, just slug in the same index (any non-nil value would work here, however)
						inst.waitNext = arg
    				inst.naginchain = false
					}
				}
    		else
    		{
					inst.waitNext = SceneTable[arg].next 
				}	
				--If we're in a nag vcd chain, use the vcds postdelay rather than the nag-wide delay
				--This is because vcd chains generally need to be explicitly timed at the chain level
				--since the vcds are grouped together as a block
 				if (inst.naginchain)
 					pdelay = EvaluateTimeKey("postdelay",SceneTable[arg])
			}	
   		inst.waitLength = pdelay
    }	
		else
		{
			inst.waitNext = nil
			printlDBG("===================SCENE END")
		}
	}	
}

function EvaluateTimeKey(keyname, keytable)
{
	local ret = nil

 	if (keyname in keytable)
 	{
 		local typ = typeof keytable[keyname]
 		if (typ == "array")
 		{
 			if (keytable[keyname].len() ~= 2)
 			{
				printlDBG("!!!!!!!!!!!!EVALUATE TIME KEY ERROR: "+keyname+" is an array with a length ~= 2") 		
				return 0.00
 			}
	 		ret = RandomFloat(keytable[keyname][0],keytable[keyname][1])
	 	}
	 	else
	 	{
	 		ret = keytable[keyname]
	 	}	
 	}
 	if (ret == nil)
 		ret = 0.00
	printlDBG(">>>>>>>>>EVALUATE TIME KEY: "+keyname+" : "+ret) 		
 	return ret
}


function GladosToggleDBG(arg = nil)
{
	DBG = !DBG
	if (DBG)
		printl("======================GLaDOS DBG ON")
	else
		printl("======================GLaDOS DBG OFF")
	if (arg~=nil)
		DBGInterval = arg
}

function GladosSetPitch(arg)
{
	pitchOverride = arg
	local curscene = self.GetCurrentScene()
	if ( curscene ~= nil )	
		EntFireByHandle( curscene, "PitchShift", pitchOverride.tostring(), 0, nil, nil )
}


--Stops a scene for all characters
function GladosAllCharactersStopScene()
{
	GladosCharacterStopScene("glados")
	GladosCharacterStopScene("wheatley")
	GladosCharacterStopScene("cave_body")
}

function characterCurscene(arg)
{
	local ret = nil, ent = nil
	switch (arg)
	{
		case "glados":
		case "@glados":
			ent = Entities.FindByName(ent, "@glados")
			break
		case "@sphere":
		case "wheatley":	
		case "sphere":
			ent = Entities.FindByName(ent, "@sphere")
			break
		case "cave_body":	
		case "cavebody":	
			ent = Entities.FindByName(ent, "@cave_body")
			break
	}
	if (ent ~= nil)
	{
		ret = ent.GetCurrentScene()
	}	
	return ret
}

--Stops a scene for a particular character
function GladosCharacterStopScene(arg)
{
	local ent = nil
	local curscene = characterCurscene(arg)
	if ( curscene ~= nil )
	{
		EntFireByHandle( curscene, "Cancel", "", 0, nil, nil )
	}
}

--Turns off current Glados speech
function GladosStopTalking()
{
	local curscene = self.GetCurrentScene()
	pitchOverride = nil
	waitNext = nil
	waitLength = nil
	if ( curscene ~= nil )	
			EntFireByHandle( curscene, "Cancel", "", 0, nil, nil )
}

--Turns off current Glados speech if the scene # passed as arg is currently playing
function GladosStopScene(arg)
{
	if (waitSceneStart == arg)
	{ 
		local curscene = self.GetCurrentScene()
		pitchOverride = nil
		waiting = 0
		waitNext = nil
		waitLength = nil
		if ( curscene ~= nil )	
			EntFireByHandle( curscene, "Cancel", "", 0, nil, nil )
	}		
}

--Slowfield functions
function GladosEndSlowFieldTraining()
{
	stateSlowFieldTraining = false
	GladosStopTalking()
}

function GladosStartSlowFieldTraining()
{
	stateSlowFieldTraining = true
	GladosPlayVcd(40)
}

function GladosSlowFieldOn()
{
	if (stateSlowFieldTraining)
		GladosPlayVcd(41)
}

function GladosSlowFieldOff()
{
	if (stateSlowFieldTraining)
		GladosPlayVcd(40)
}
--End of Slowfield functions

--Special Chamber Processing
function GladosRelaxationVaultPowerUp()
{
	EntFire("open_portal_relay","Trigger","", 0.00)
}


----------------------------------------------------------------------------------------------------------------
--Queue Functions
----------------------------------------------------------------------------------------------------------------

Queue = []

--Initialize the queue
function QueueInitialize()
{
	Queue.clear()
}

--Add a scene to the queue
function QueueAdd(arg)
{
	Queue.append( { item = arg added = CurTime() })
	if (arg in SceneTable)
	{
 		if ("queueforcesecs" in SceneTable[arg])
 		{
 			Queue[Queue.len()-1].queueforcesecs = SceneTable[arg].queueforcesecs
 		}
 		if ("queuetimeout" in SceneTable[arg])
 		{
 			Queue[Queue.len()-1].queuetimeout = SceneTable[arg].queuetimeout
 		}
 		if ("queuepredelay" in SceneTable[arg])
 		{
 			Queue[Queue.len()-1].queuepredelay = SceneTable[arg].queuepredelay
 		}

	}
}

--Returns number of items in the queue
function QueueLen()
{
	return Queue.len()
}


--Fetch the next scene in the queue
function QueueGetNext()
{
	local ret,l
	ret = nil
	l=QueueLen()
	if (l>0)
	{
		ret = Queue[l-1].item
		Queue.remove(l-1)
	}
	return ret
}

function QueueDBG()
{
	printlDBG("===================  items in queue-> " + Queue.len())
}

--General stuff called from GladosThink()
function QueueThink()
{
	local ret,t,index
	if (QueueLen()==0)
	{
		return nil
	}	
	
	t=CurTime()
	--Check to see if any queued scenes timed out
	for (index = QueueLen(); index > 0; index -= 1)
	{
 		if ("queuetimeout" in Queue[index-1])
 		{
 			if (t-Queue[index-1].added > Queue[index-1].queuetimeout)
 			{
 				Queue.remove(index-1)
 			}
 		}
	}

	--Check to see if any queued scenes should force fire
	foreach (index, scene in Queue)
	{
 		if ("queueforcesecs" in scene)
 		{
 			if (t-scene.added >scene.queueforcesecs)
 			{
 				ret = scene.item
 				Queue.remove(index)
 				return ret
 			}
 		}
	}
	return nil
}

--DBG testbed function
function QueueTest()
{
	local a = []
	for(local i=0;i<10;i+=1)
	{
		a.append(math.random(1,100))
		printlDBG(">>>>>> " + i + " : " + a[i])
	}
	for (local i = a.len(); i>0; i-=1)
	{
		if (a[i-1]<50)
			a.remove(i-1)
	}
	foreach (index, n in a)
	{
		printlDBG(">>>>>> " + index + " : " + a[index])
	}
}

--Delete a single item from the queue
function QueueDeleteItem(item)
{
	if (QueueLen()==0)
	{
		return false
	}	
	foreach (index, scene in Queue)
	{
		if (scene.item == item)
		{
 				Queue.remove(index)
 				return true
 		}
	}
	return false
}


--Check to see if there's a Queued scene ready to go. If so, fire it! (and return true)
function QueueCheck()
{
	local tmp
	if (QueueLen()>0)
	{
		tmp=QueueGetNext()
		if (tmp ~= nil)
		{
			firedfromqueue = true
			GladosPlayVcd(tmp,true)
			--GladosPlayVcd(tmp)
			return true
		}
	}
	return false
}

----------------------------------------------------------------------------------------------------------------
--End of Queue Functions
----------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------
--sp_sabotage_jailbreak specific functions 
----------------------------------------------------------------------------------------------------------------

function jailbreak_alert(arg)
{
	jailbreakpos =arg
	printlDBG("==========JAILBREAK ALERT "+arg)
}

function jailbreak_whoah_speech()
{
	if (jailbreakpos == 0)
	{
		GladosPlayVcd(303)
	}
	else
	{
		GladosPlayVcd(302)
	}
}


----------------------------------------------------------------------------------------------------------------
--sp_sabotage_darkness specific functions 
----------------------------------------------------------------------------------------------------------------


function PlayGhostStory()
{
	GladosPlayVcd(445)
}

function PlaySmellyHumansOne()
{
	GladosPlayVcd(446)
}

function PlaySmellyHumansTwo()
{
	GladosPlayVcd(447)
}
 
function PlaySmellyHumansThree()
{
	GladosPlayVcd(448)
}

function PlaySmellyHumansFour()
{
	GladosPlayVcd(449)
}


----------------------------------------------------------------------------------------------------------------
--Glados Battle specific functions 
----------------------------------------------------------------------------------------------------------------

function sp_sabotage_glados_specials(arg)
{
	switch (arg)
	{
		case 1: 
			SendToConsole( "scene_playvcd npc/sphere03/fgb_ready_glados06")
			break
		case 2: 
			--SendToConsole( "scene_playvcd npc/sphere03/gladosbattle_pre09")
			SendToConsole( "scene_playvcd npc/sphere03/fgb_pull_me_out01")
			break
	}
}

glados_gibbering = false
glados_gibbering_start = CurTime()
glados_gibbering_next = 0.00
glados_gibbering_times = {}

glados_gibbering_times[1] = 0.7
glados_gibbering_times[2] = 1.37
glados_gibbering_times[3] = 1.22
glados_gibbering_times[4] = 1.27
glados_gibbering_times[5] = 5.29
glados_gibbering_times[6] = 4.15
glados_gibbering_times[7] = 3.35



function sp_sabotage_glados_start_gibberish()
{
	--gibberish is off for now
	--glados_gibbering = true
	glados_gibbering_start = CurTime()
	glados_gibbering_next = 0.00
}

function sp_sabotage_glados_stop_gibberish()
{
	glados_gibbering = false
}

function sp_sabotage_glados_gibberish()
{
	local i = math.random(1,7)
	if (CurTime() - glados_gibbering_start > glados_gibbering_next)
	{
		SendToConsole( "scene_playvcd npc/glados/sp_sabotage_glados_gibberish0"+i)
		glados_gibbering_start = CurTime()
		--glados_gibbering_next = RandomFloat(3.5, 5.0)
		glados_gibbering_next = glados_gibbering_times[i]
	}	
}



-- ==============================
-- player starts vault trap
-- ==============================
function VaultTrapStart()
{
	GladosPlayVcd(-50)
}

-- ==============================
-- player begins moving in relaxation vault
-- ==============================
function VaultTrapStartMoving() 
{
	GladosPlayVcd(-53)
}

-- ==============================
-- turrets are on the ground and begin their scene
-- ==============================
function TurretScene()
{
	GladosPlayVcd(-700)
}
 
-- ==============================
-- ==============================
function TurretDeathReactionDialog()
{
	GladosPlayVcd(-57)
	--gladosbattle_pre_05 -- my turrets!
	--gladosbattle_pre_06 -- oh, you were busy back there
	--gladosbattle_pre_17 -- i suppose we could just sit here and glare ... but i have a better idea
}



-- ==============================
-- ==============================
function WheatleyBouncingDownTubeDialog()
{
	-- play various "ouch.. oof... ow..." lines here
	-- play glados dialog responding to wheatley falling.  "...sigh..."
}


-- ==============================
-- ==============================
function WheatleyLandsInChamberDialog()
{
	GladosPlayVcd(-61)
	printlDBG("==========HELLO!!!!!!!!!!!!!!!!!!!!!")
	--wheatley - gladosbattle_pre01 -- Hello!
	--gladosbattle_pre_09 -- i hate you so much
}

-- ==============================
-- ==============================
function CoreDetectedDialog()
{
	--announcer - gladosbattle02 -- warning: core corrupted
	--glados - gladosbattle_xfer04 -- that's funny i don't feel corrupted. in fact i feel pretty good
	--announcer - gladosbattle03 -- alternate core detected
	--wheatley pre05  -- ah that's me they're talking about!
	--announcer - gladosbattle03 -- to initiate a core transfer deposit core in receptacle
	--ent_fire "deploy_core_receptacle_relay" trigger -- deploys the core receptacle
	--glados - gladosbattle_xfer05 -- core transfer?
	--glados - gladosbattle_xfer06 -- oh you are kidding me
	
	-- ********************************************************************************
	-- ********************************************************************************
	-- TODO - NAG: NEED NAG FOR 'INSERT CORE' TO PLAY UNTIL WheatleyCoreSocketed() GETS CALLED
	-- ********************************************************************************
	-- ********************************************************************************
}


-- ==============================
-- ==============================
function WheatleyCoreSocketed()
{
	-- ********************************************************************************
	-- ********************************************************************************
	-- TODO - NAG:  END 'INSERT CORE' NAG HERE
	-- ********************************************************************************
	-- ********************************************************************************
	
	GladosPlayVcd(-71) -- announcer - substitute core accepted.  core, are you willing to start the procedure?
	
	-- ********************************************************************************
	-- ********************************************************************************
	-- TODO - NAG:  BEGIN 'PRESS BUTTON' NAG HERE
	-- ********************************************************************************
	-- ********************************************************************************
}

-- ==============================
--	called when the player reaches a catapult or enters the room to press stalemate button
-- ==============================
function StalemateAssociateNotSoFast()
{
	GladosPlayVcd(-84)
}


-- ==============================
-- ==============================
function CoreTransferInitiated()
{
	-- ********************************************************************************
	-- ********************************************************************************
	-- TODO - NAG:  END 'PRESS BUTTON' NAG HERE
	-- ********************************************************************************
	-- ********************************************************************************

	GladosPlayVcd(-88) --Stalemate Resolved. Core Transfer Initiated.
}

-- ==============================
-- ==============================
function WheatleyCoreTransferStart()
{
	GladosPlayVcd(-4) -- Here I go!
}

-- ==============================
-- ==============================
function PitHandsGrabGladosHead()
{
	GladosPlayVcd(-89) -- Get your hands off me!
}

-- ==============================
-- ==============================
function PullGladosIntoPit()
{
	GladosPlayVcd(-90) -- CHELL! STOP THIS! I AM YOUR MOTHER!
}

-- ==============================
-- ==============================
function CoreTransferCompleted()
{
	GladosPlayVcd(-9)  -- Wow! Check ME out, Partner! .. Look how small you are!
} 

-- ==============================
-- ==============================
function PlayerEnteredElevator()
{
	GladosPlayVcd(-13) -- Glados: Don't do this...
}


-- ==============================
-- ==============================
function DialogDuringPotatosManufacture()
{
	GladosPlayVcd(-33)
}

-- ==============================
-- ==============================
function PotatosPresentation()
{
	GladosPlayVcd(-34)
}

-- ==============================
-- ==============================
function ElevatorMoronScene()
{
	GladosPlayVcd(-37)
}

-- ==============================
-- ==============================
function ElevatorConclusion()
{
	GladosPlayVcd(-44)
}


----------------------------------------------------------------------------------------------------------------
--sp_sabotage_factory functions 
----------------------------------------------------------------------------------------------------------------

function sabotage_factory_WatchTheLine()
{
	GladosPlayVcd(441)
}

function sabotage_factory_ReachedHackingSpot()
{
	GladosPlayVcd(442)
}

function sabotage_factory_PlayerReachedWheatley()
{
	WheatleyStopNag()
	GladosPlayVcd(443)
}

function sabotage_factory_PlayerReachedExitDoor()
{
	WheatleyStopNag()
	GladosPlayVcd(444)
}	


----------------------------------------------------------------------------------------------------------------
--sp_sabotage_factory - Science Fair functions 
----------------------------------------------------------------------------------------------------------------
function ScienceFairGoingTheRightWay()
{
	GladosPlayVcd( -100 )
}

function ScienceFairBringDaughter()
{
	GladosPlayVcd( -101 )
}

function JustToReassureYou()
{
	GladosPlayVcd( -102 )
}

function DefinitelySureThisWay()
{
	GladosPlayVcd( -103 )
}


----------------------------------------------------------------------------------------------------------------
--sp_catapult_fling_sphere_peek functions 
----------------------------------------------------------------------------------------------------------------

function sp_catapult_fling_sphere_peek()
{
		switch (peekctr)
		{
			case 0:
				GladosPlayVcd(335)
				break
			case 2:
				GladosPlayVcd(362)
				break
			case 4:
				GladosPlayVcd(363)
				break
		}	
		peekctr+=1
}


----------------------------------------------------------------------------------------------------------------
--New test functions 
----------------------------------------------------------------------------------------------------------------
function GladosTest1(arg)
{
	foreach (index, scene in arg)
	{
		if (scene.item)
		{
			arg.remove(index)
		}
	}
}


----------------------------------------------------------------------------------------------------------------
--Scene Queue Functions START
----------------------------------------------------------------------------------------------------------------

class scene {
	--constructor
	constructor(a, caller)
	{
		index = a
		owner = caller
		currentCharacter = ""
		waitSceneStart = 0 --1 means we're waiting for the current vcd to finish so we can play the next vcd in the chain
		waiting = 0  
		waitVcdCurrent = nil
		waitStartTime = CurTime()
		waitLength = CurTime()
		waitNext = nil 
		waitExitingEarly = false 
		waitExitingEarlyStartTime = CurTime() 
		waitExitingEarlyThreshold = 0.00 --How many seconds sould the VCD play before moving on to the next one
		waitNoDingOff = false
		waitNoDingOn = false
		waitVcdTeam = -1
		waitFiredVcds = []
		nagminsecs = 0
		nagmaxsecs = 0
		nags = []
		isNag = false
		nagpool = []
		naglastfetched = nil
		nagrandom = false
		nagrandomonrepeat = false
		nagtimeslistcompleted = 0
		nagrepeat = false
		naginchain = false
	}
	
	function nagsClear()
	{
		naglastfetched = nil
		nags.clear()
	}
	
	function nagpoolClear()
	{
		nagpool.clear()
	}


	function addFiredVcd(team)
	{
		waitFiredVcds.append(team)
	}

	function deleteFiredVcd(team)
	{
		local idx, val
		local fnd = nil
		foreach (idx, val in waitFiredVcds)
		{
			if (val == team)
			{
				fnd = idx
				break
			}
		}	
		if (fnd ~= nil)
		{
			waitFiredVcds.remove(fnd)
		}
	}

	
	--property
	index = 0;
	owner = nil;
	currentCharacter = "";
	waitSceneStart = 0; --1 means we're waiting for the current vcd to finish so we can play the next vcd in the chain
	waiting = 0;  
	waitVcdCurrent = nil; --SceneTable index of last launched vcd
	waitStartTime = 0;
	waitLength = 0;
	waitNext = nil; 
	waitExitingEarly = false; 
	waitExitingEarlyStartTime = 0; 
	waitExitingEarlyThreshold = 0.00; --How many seconds sould the VCD play before moving on to the next one
	waitNoDingOff = false;
	waitNoDingOn = false;
	waitFires = [];
	waitVcdTeam = -1;
	waitFiredVcds = [];
	isNag = false;
	nags = [];
	nagpool = [];
	nagminsecs = 0;
	nagmaxsecs = 0;
	naglastfetched = nil;
	nagrandom = false;
	nagrandomonrepeat = false;
	nagtimeslistcompleted = 0;
	nagrepeat = false;
	naginchain = false;
}


function scenequeue_AddScene(arg,char)
{
	local idx, val,delme
	delme=nil
	foreach (idx, val in scenequeue)
	{
		if (SceneTable[idx].char==char)
		{
			delme = idx
		}
		if (idx == arg)
		{
			printlDBG(">>>>>>>>>>Scene "+arg+" is already in the queue")
			return nil
		}
	}
	if (delme ~= nil)
	{
		printlDBG(">>>>>>>>>>DELETING SCENE "+delme)
		scenequeue_DeleteScene(delme)
	}
	scenequeue[arg] = scene(arg, this)
	scenequeue_Dump()
	return scenequeue[arg]
}

function scenequeue_DeleteScene(arg)
{
	local idx, val
	foreach (idx, val in scenequeue)
	{
		if (idx == arg)
		{
			printlDBG(">>>>>>>>>>Scene "+arg+" deleted!")
			delete scenequeue[arg]
			return true
		}
	}
	return nil
}

function scenequeue_Dump()
{
	
	printlDBG(">>>>>>>>>>Scene Dump at "+CurTime())
	foreach (idx, val in scenequeue)
	{
		printlDBG(">>>>>>>>>>Scene "+idx+" ADDED at "+val.waitStartTime+" Type "+ typeof val)
	}	
}

----------------------------------------------------------------------------------------------------------------
--Scene Queue Functions END
----------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------
--Nag Table Functions START
----------------------------------------------------------------------------------------------------------------

function nags_init(inst,scenetableentry)
{
	local i = 0
	inst.nagsClear()
	if ("idleminsecs" in SceneTable[scenetableentry])
	{
		inst.nagminsecs = SceneTable[scenetableentry].idleminsecs
		if ("idlemaxsecs" in SceneTable[scenetableentry])
		{
			inst.nagmaxsecs = SceneTable[scenetableentry].idlemaxsecs
		}
		else
		{
			inst.nagmaxsecs = inst.nagminsecs
		}
	}
	
	if ("idlerandomonrepeat" in SceneTable[scenetableentry])
	{
		inst.nagrandomonrepeat = true
	}
	
	if ("idlerepeat" in SceneTable[scenetableentry])
	{
		inst.nagrepeat = true
	}

	if ("idlerandom" in SceneTable[scenetableentry])
	{
		inst.nagrandom = true
	}

	local igroup = SceneTable[scenetableentry].idlegroup
	local idx, val,oig=0
	foreach (idx, val in SceneTable)
	{
		if (!("idlegroup" in val))
			continue
		if (val.idlegroup ~= igroup)
			continue
		local rar = 101, mnum = 0
		if ("idlerarity" in val)
		{
			rar = val.idlerarity
		}
		if ("idlemaxplays" in val)
		{
			mnum = val.idlemaxplays
		}
		--Skip vcds that are part of a chain (and not the first link in the chain)
		if ("idleunder" in val)
		{
			continue
		}
		if ("idleorderingroup" in val)
		{
			oig=val.idleorderingroup
		}
		else
		{
			oig=0
		}
		inst.nags.append({SceneTableIndex=idx, rarity = rar, maxplays = mnum, totplays = 0,orderingroup = oig})
	}
	inst.nags.sort(nag_array_compare)
	inst.isNag = true
	inst.nagtimeslistcompleted = 0
	nags_createpool(inst)
}

function nags_createpool(inst)
{
	inst.nagpoolClear()
	local idx, val
	local takeit = false
	local tempa = []
	foreach (idx, val in inst.nags)
	{
		takeit=false
		if (val.totplays >= val.maxplays and val.maxplays>0)
		{
			continue
		}
		if (math.random(1,100)<val.rarity)
		{
			takeit=true
		}	
		if (takeit)
		{
			tempa.append(val)
		}
	}
	local r
	--The pool can still be empty at this point if only rare lines were available and none of them "made their roll".
	if (tempa.len() == 0)
		return
	
	if (inst.nagrandom or (inst.nagrandomonrepeat and inst.nagtimeslistcompleted > 0))
	{
		--Make sure the first entry in the new list isn't the same as the last vcd played.
		--This ensures no repeats.
		if (tempa.len()>1 and inst.naglastfetched~=nil)
		{
			while (true) 
			{
				r=math.random(0,tempa.len()-1)
				if (tempa[r].SceneTableIndex ~= inst.naglastfetched)
				{
					inst.nagpool.append(tempa[r])
					tempa.remove(r)
					break
				}
			}
		}
		--Now build the rest of the pool
		while (tempa.len()>0)
		{
			r=math.random(0,tempa.len()-1)
			inst.nagpool.append(tempa[r])
			tempa.remove(r)
		}
	}
	else
	{
		foreach(idx, val in tempa)
		{
			inst.nagpool.append(val)
		}
	}	
}

function nags_nagpooldump(inst)
{
	local idx, val
	foreach (idx, val in inst.nagpool)
		printlDBG("*********NAG "+idx+" : "+val.SceneTableIndex)
}

function nags_fetch(inst)
{
	if (inst.nagpool.len() == 0)
	{
		if (inst.nagrepeat)
		{
			inst.nagtimeslistcompleted += 1
			nags_createpool(inst)
			if (inst.nagpool.len() == 0)
				return nil
		}
		else
		{
			return nil
		}	
	}
	local ret = inst.nagpool[0].SceneTableIndex
	foreach( idx, val in inst.nags)
	{
		if (val.SceneTableIndex == ret)
		{
			val.totplays+=1
			break
		}
	}
	--nags_nagpooldump(inst)
	inst.nagpool.remove(0)
	inst.naglastfetched = ret
	return ret
}

function GladosStopNag(arg = 0)
{
	nag_stop("glados",arg)
}

function WheatleyStopNag(arg = 0)
{
	nag_stop("wheatley",arg)
}

function nag_stop(char, stoptype)
{
	local idx, val
	local todel = nil
	foreach (idx, val in scenequeue)
	{
		if (val.isNag and val.currentCharacter == char)
		{
			todel=idx
			break
		}
	}
	if (todel ~= nil)
	{
		scenequeue_DeleteScene(todel)	
	}
}

function nag_array_compare(a,b)
{
	if(a.orderingroup>b.orderingroup) return 1
	else if(a.orderingroup<b.orderingroup) return -1
	return 0;
}


----------------------------------------------------------------------------------------------------------------
--Nag Table Functions END
----------------------------------------------------------------------------------------------------------------

function SabotageFactoryRecycledTurretNoticesPlayer()
{
	GladosPlayVcd(439, nil, "conveyor_turret")
}

function TrustFlingCatapultTurretNoticesPlayer()
{
	GladosPlayVcd(439, nil, "catapulted_turret")
}






---------------------------------------------------------------------------------------
--Context-specific functions
---------------------------------------------------------------------------------------
]]
function GladosPlayerGetsGun(arg)
	if coopFirstPlayerToGetGun == 0 then
		if arg == coopBlue then
			coopFirstPlayerToGetGun = coopBlue
			BlueHasGun=1
			GladosPlayVcd(1)
		else
			OrangeHasGun=1
			coopFirstPlayerToGetGun = coopOrange
			GladosPlayVcd(2)
		end
	else		
			if arg == coopBlue then
				BlueHasGun=1
				GladosPlayVcd(3)
			else
				OrangeHasGun=1
				GladosPlayVcd(4)
			end

	end
end

-- a newly spawned cube or sphere was destroyed 
function GladosDroppedCubeDestroyed(arg)
	if arg == coopBlue then
		--EntFireByHandle( badCatchBlue, "Start", "", 0, nil, nil )
	else
		--EntFireByHandle( badCatchOrange, "Start", "", 0, nil, nil )
	end
end
--[[
function GladosGiveCompliment(arg)
{
	EntFireByHandle( ComplimentSceneTable[arg], "Start", "", 0, nil, nil )
}

function GladosCoopTurnOffVoice()
{
	coopRelaxationVaultVoiceMonitor = false
	coopRelaxationVaultVoiceBlueTicks = 0
	coopRelaxationVaultVoiceOrangeTicks = 0
}
function GladosInitRelaxationVault()
{
	--coopRelaxationVaultVoiceMonitor = true
	coopRelaxationVaultVoiceMonitor = false
	coopRelaxationVaultVoiceBlueTicks = 0
	coopRelaxationVaultVoiceOrangeTicks = 0
	GladosPlayVcd(0,"glados")
}
]]
function GladosCoopPingPortalTraining()
		GladosPlayVcd(35)	
end

function CoopStartCalComplete()
		if CoopStartCalCompleteSet == 0 then
			CoopStartCalCompleteSet = 1 
			GladosPlayVcd(1007)	
		end
end


function CoopStartBButton(player)
	if player == coopBlue and CoopStartBButtonSet == 0 then
		CoopStartBButtonSet = 1
		GladosPlayVcd(1004)	
	end
end

function CoopStartButton(player)
	if player == coopOrange and CoopStartButtonSet == 0 then
		CoopStartButtonSet = 1
		GladosPlayVcd(1005)	
	end
end

function CoopStartBoxButton(player)
	CoopStartBoxButtonSet = CoopStartBoxButtonSet + 1
	if CoopStartBoxButtonSet == 2 then
		GladosPlayVcd(1006)
	end
end
--[[


function GladosCoopInitiatePlanB()
{
	GladosPlayVcd(60)
}

function GladosCoopEnterRadarRoom()
{
	GladosPlayVcd(65)
}


function GladosCoopStartRadar()
{
	GladosPlayVcd(66)
}

function GladosCoopExplainMakeHuman()
{
	GladosPlayVcd(75)
}

function GladosCoopExplainMakeHumanFail()
{
	GladosPlayVcd(80)
}

------
function GladosCoopArtifact_1_Enter()
{
	GladosPlayVcd(100)
}

function GladosCoopArtifact_1_Scan()
{
	GladosPlayVcd(102)
}

function GladosCoopArtifact_1_Return()
{
	GladosPlayVcd(103)
}
------/

function GladosCoopReturnHubArtifact_1()
{
	GladosPlayVcd(85)
}

function GladosToggleDBGMode()
{
	DBG = !DBG
	if (DBG) printl("=======================GLaDOS DBG mode ON")
	else printl("=======================GLaDOS DBG mode OFF")
}

---------------------------------
-- PAX PAX END OF DEMO
---------------------------------
--ping reminder
function GladosCoopPAXEndDemo()
{
	GladosPlayVcd(153)
}
]]
--PrivateTalk mix vcds
	PrivateMixVcds = {}
	PrivateMixVcds[1] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_MIX01.vcd")
	PrivateMixVcds[2] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_MIX02.vcd")
	PrivateMixVcds[3] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_MIX03.vcd")
	PrivateMixVcds[4] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_MIX04.vcd")
	PrivateMixVcds[5] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_MIX05.vcd")
	PrivateMixVcds[6] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_MIX06.vcd")
	PrivateMixVcds[7] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_MIX07.vcd")
	PrivateMixVcds[8] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_MIX08.vcd")
	PrivateMixVcds[9]  = CreateSceneEntity("scenes/npc/glados/COOP_TEST_CHAMBER_BLUE06.vcd")	
	PrivateMixVcds[10] = CreateSceneEntity("scenes/npc/glados/COOP_TEST_CHAMBER_BLUE03.vcd")
	

--PrivateTalk Both vcds
	PrivateBothVcds = {}
	PrivateBothVcds[1] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_BOTH01.vcd")
	PrivateBothVcds[2] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_BOTH02.vcd")
	PrivateBothVcds[3] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_BOTH03.vcd")
	PrivateBothVcds[4] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_BOTH04.vcd")
	PrivateBothVcds[5] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_BOTH05.vcd")
	PrivateBothVcds[6] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_BOTH06.vcd")
	PrivateBothVcds[7] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_BOTH07.vcd")
	PrivateBothVcds[8] = CreateSceneEntity("scenes/npc/glados/COOP_PRIVATETALK_BOTH08.vcd")
	PrivateBothVcds[9]  = CreateSceneEntity("scenes/npc/glados/COOP_TEST_CHAMBER_ORANGE06.vcd")		
	PrivateBothVcds[10] = CreateSceneEntity("scenes/npc/glados/COOP_TEST_CHAMBER_ORANGE03.vcd")

--Fires two different vcds - one for each player's ears only.
function GladosPrivateTalk(player,vndx)
	if player == coopBlue then
		GladosSetBroadcastState( PrivateMixVcds[vndx], "blue" )
		GladosSetBroadcastState( PrivateBothVcds[vndx], "orange" )
		EntFireByHandle(PrivateMixVcds[vndx], "Start", "", 0.00, nil, nil )
		EntFireByHandle(PrivateBothVcds[vndx], "Start", "", 0.00, nil, nil )
	else
		GladosSetBroadcastState( PrivateMixVcds[vndx], "orange" )
		GladosSetBroadcastState( PrivateBothVcds[vndx], "blue" )
		EntFireByHandle(PrivateMixVcds[vndx], "Start", "", 0.0, nil, nil )
		EntFireByHandle(PrivateBothVcds[vndx], "Start", "", 0.00, nil, nil )
	end
end
--[[
function GladosSayHello(player)
{
	if (player == coopBlue)
	{
		GladosSetBroadcastState( HelloVcds[1], "blue" )
		EntFireByHandle(HelloVcds[1], "Start", "", 0.00, nil, nil )
	}	
	else
	{
		GladosSetBroadcastState( HelloVcds[2], "orange" )
		EntFireByHandle(HelloVcds[2], "Start", "", 0.00, nil, nil )
	}
}
]]
function GladosSetBroadcastState(vcd,target )
	local ORANGE_PLAYER = 2
	local BLUE_PLAYER = 3
	if target == "both" then
		vcd.AddBroadcastTeamTarget( BLUE_PLAYER )
		vcd.AddBroadcastTeamTarget( ORANGE_PLAYER )
	elseif target == "blue" then
		vcd.AddBroadcastTeamTarget( BLUE_PLAYER )
		vcd.RemoveBroadcastTeamTarget( ORANGE_PLAYER )
	elseif target == "orange" then
		vcd.RemoveBroadcastTeamTarget( BLUE_PLAYER )
		vcd.AddBroadcastTeamTarget( ORANGE_PLAYER )
	end
end


--Tells GLaDOS that the level wants to end and transition to the next level.
--This gives her a chance to finish up any dialog before transitioning
--Relies on a relay called "gladosendoflevelrelay" in the map that actually switches levels when triggered.
--GLaDOS triggers "gladosendoflevelrelay" from her think function.
function GladosEndLevelRequest()
	coopWaitingToExit = true
end
--[[
-----------------------------------------------------------
--Score annoucing stuff
-----------------------------------------------------------
	function GladosAnnouncePlayerDemerit(arg,low,hi)
	{
		local mapname = game.GetMap()
		switch (mapname){		
			case "mp_coop_catapult_1": 
				if (arg==coopBlue){
					break
				}
				else{
					break
				}	
		}
	}

	function GladosAnnouncePlayerScore(arg,low,hi)
	{
		local mapname = game.GetMap()
		switch (mapname)
		{
	
			case "mp_coop_doors": 
				if (arg==coopBlue){
					GladosPlayVcd(1012)
					break
				}
				else{
					GladosPlayVcd(1013)
					break
				}	
			case "mp_coop_fling_3":
				if (arg==coopBlue){
--					GladosPlayVcd(1012)
					break
				}
				else{
	--				GladosPlayVcd(1013)  turned off for now, not on right track.
					break
				}	

		}

		printlDBG("2222222222222222222222222222222222")
	}
]]
	function GladosStateScore()
		printlDBG("333333333333333333333333333333")
	end

	function GladosStateScienceCollaborationPoints()
				printlDBG("444444444444444444444444444444")
	end
-----------------------------------------------------------
--END OF Score annoucing stuff
-----------------------------------------------------------


---------------------------------
-- NEW NEW Ping Training Sequence stuff
---------------------------------
	--ping reminder
	function GladosCoopPingReminder1()
		GladosPlayVcd(45)
	end
---------------------------------
--Ping Training Sequence stuff
---------------------------------
	--Play the ping training intro
	function GladosCoopPingTrainingIntro()
		GladosPlayVcd(10)
	end

	--Housecleaning / entity stuff that happens when the ping training is over  
	function GladosCoopPingGameOver()
		EntFire("aperture_door","SetSpeed",35, 0.00)
		EntFire("aperture_door","Close", "", 0.00)
		EntFire("dome_exit_door_blue","Open", "", 3.00)
		EntFire("dome_exit_door_orange","Open", "", 3.00)
		EntFire("platform_2_gate_exit","Open", "", 1.00)
		EntFire("platform_1_gate_exit","Open", "", 1.00)
	end

	--Turns ping training game on
	function GladosCoopPingTrainingGameOn()
		if DBG then
			printl("========================GAME ON!!!!!")
		end
		coopPingGameOn = true  --We are in ping training mode!
		coopPingPlayerTurn = coopBlue  --It's BLUE's turn
		coopPingTurnNumber = 1 --It's turn #1
		coopTimeSinceTurn = CurTime()  --Turn #1 starts NOW!
		EntFire("PingHint","ShowHint", "!player_blue", 0.00)  --Fire the ping hint to blue player
	end
	
	--Dome ping redirect
	function GladosPingTrainingPingDome(arg)
		GladosPingTrainingPing(arg)
	end
--[[
	--Handles player placing a ping
	function GladosPingTrainingPing(arg)
	{
		--Track total # of pings by both players
		if (arg == coopBlue) coopPingsBlue += 1
		if (arg == coopOrange) coopPingsOrange += 1
		--Process ping only if GLaDOS isn't talking
		if ((!coopPingNoInterrupt) and coopPingGameOn)
		{
			if (arg==coopBlue) --Ping belongs to BLUE
			{
				if (coopPingPlayerTurn==coopBlue) --Is it actually BLUE's turn?
				{
					switch (coopPingTurnNumber)
					{
						case 1:  --Turn 1
							coopPingPlayerTurn = coopOrange
							coopPingNextScene = 5 
							coopPingNextSceneDelay = 0.4
							coopTimeSinceTurn = CurTime()
							GladosPingTrainingSpeak(2,true,0.00)
							EntFire("PingHint","EndHint", "!player_blue", 0.00)  
							EntFire("PingHint","ShowHint", "!player_orange", 3.00)  
							break
						case 2: --Turn 2
							coopPingPlayerTurn = coopOrange
							coopPingNextScene = 16 
							coopPingNextSceneDelay = 0.4
							coopTimeSinceTurn = CurTime()
							GladosPingTrainingSpeak(4, true, 0.00)
							break
					}
				}
				else --BLUE is pinging out of turn!
				{
					GladosPingTrainingWrongMove(coopBlue)
				}
			}
			if (arg==coopOrange) --Ping belongs to ORANGE
			{
				if (coopPingPlayerTurn==coopOrange) --Is it actually ORANGE's turn?
				{
					switch (coopPingTurnNumber)
					{
						case 1: --TURN 1
							coopPingPlayerTurn = coopBlue
							coopPingNextScene = 3
							coopPingTurnNumber = 2 
							coopPingNextSceneDelay = 0.4
							coopTimeSinceTurn = CurTime()
							GladosPingTrainingSpeak(19, true, 0.00)
							EntFire("PingHint","EndHint", "!player_orange", 0.00)  
							--GladosPingTrainingSpeak(20, true, 0.00)
							break
						case 2: --TURN 2 (FINAL MOVE OF GAME)
							coopPingGameOn = false
							GladosPlayVcd(11) --Play game over dialog dialog (also closes dome doors)
							break
					}
				}
				else --Orange is pinging out of turn!
				{
					GladosPingTrainingWrongMove(coopOrange)
				}
			}
		}	
	}
	
	--Handles player placing ping when it's not their turn
	function GladosPingTrainingWrongMove(arg)
	{
		--Gave players their last warning, so shut the game down
		if (coopSaidWrongMovesDialog)
		{
			coopPingGameOn = false
			GladosPlayVcd(12)
			return
		} 
		--Give players a final warning
		if (coopPingsBlue>0 and coopPingsOrange>0 and (coopWrongMovesBlue+coopWrongMovesOrange)>0 and !coopSaidWrongMovesDialog)
		{
			coopSaidWrongMovesDialog = true
			GladosPingTrainingSpeak(11, true, 0.00)
			return
		}
		--Tell BLUE not to go out of turn
		if (arg==coopBlue and coopWrongMovesOrange == 0 and coopWrongMovesBlue < 5) --BLUE goes out of turn, but Orange hasn't placed a ping
		{
			GladosPingTrainingSpeak(13, true, 0.00)
			coopWrongMovesBlue +=1
			return
		}
		--Tell ORANGE not to go out of turn
		if (arg==coopOrange and coopWrongMovesBlue == 0 and coopWrongMovesOrange < 5)
		{
			GladosPingTrainingSpeak(14, true, 0.00)
			coopWrongMovesOrange += 1
			return
		}
		--Failsafe for final warning
		if (!coopSaidWrongMovesDialog)
		{
			coopSaidWrongMovesDialog = true
			GladosPingTrainingSpeak(11, true, 0.00)
			return
		} 
	}
	
	function GladosPingTrainingSpeak(arg,setNoInterrupt,d)
	--arg: PingTrainingVcd index
	--setNoInterrupt: true = dialog can't be interrupted by intervening event
	--d: delay (in seconds) before line
	{
			if (setNoInterrupt == nil) setNoInterrupt = true
			if (d == nil) d = 0.00
			coopPingNoInterrupt = setNoInterrupt
			EntFireByHandle(PingTrainingVcds[arg], "Start", "", d, nil, nil )
	}
	
	--Automatically called at the end of every PingTrainingVcd. Starts next vcd if one has been set.
	function GladosPingTrainingNextScene()
	{
		local i = coopPingNextScene
		local d = coopPingNextSceneDelay
		if (coopPingNextScene ~= nil)
		{
			coopPingNextScene = nil
			coopPingNextSceneDelay = nil
			GladosPingTrainingSpeak(i,true,d)
		}
		else coopPingNoInterrupt = false	
	}
----------------------------------------
--END of ping training sequence stuff
----------------------------------------

---------------------------------------------------------------------------------------
--END OF Context-specific functions
---------------------------------------------------------------------------------------

------------------------------------------------------
--microphone utilities
------------------------------------------------------
function GladosStartMicTest()
{
	DBGMicTest = true
}
function GladosStopMicTest()
{
	DBGMicTest = false
}

------------------------------------------------------
--END of microphone utilities
------------------------------------------------------

------------------------------------------------------
--Catches for old method of firing directly into speakvcd
------------------------------------------------------
--Glados placing portals for player using ping tool.
SceneTableLookup[35] = "mp_coop_startcoop_portal_ping_intro00"
function CoopRaceButtonPress(player){
	if (player==coopBlue)
	{
		GladosPlayVcd(1012)	
	}
	else
	{
		GladosPlayVcd(1013)	
	}
}

function CoopStartHandOff()
{
}

function CoopStartBoxCatch()
{
		GladosPlayVcd(1023)
}


function GladosPingIntroDone()
{
	BlueInPortalTraining = 1
	OrangeInPortalTraining = 1
}

function CoopStartTwoPortals(){
	GladosPlayVcd(1002)
}

function CoopRadarRoom(){
  LastDeathTime=CurTime()+5000 --extra time added so death responses will not fire
	GladosPlayVcd(1009)
	EndSpeedRunTimer()
}

function CoopBlueprintRoom(){
  LastDeathTime=CurTime()+5000 --extra time added so death responses will not fire
	GladosPlayVcd(1055) 
	EndSpeedRunTimer()
}
function CoopSecutiryRoom(){
  LastDeathTime=CurTime()+5000 --extra time added so death responses will not fire
	GladosPlayVcd(1196)
	EndSpeedRunTimer()
}

function CoopTbeamSecurity()
{
	LastDeathTime=CurTime()+5000 --extra time added so death responses will not fire
	GladosPlayVcd(1094)

	-- Award the STAYING_ALIVE achievement here, before GLADOS nukes the players.
	-- If no one died...
	local nTotalDeaths = GetPlayerDeathCount( 0 ) + GetPlayerDeathCount( 1 );
	if ( nTotalDeaths == 0 )
	{
		-- ...and both players completed every map in the branch during this session.
		if ( CoopGetLevelsCompletedThisBranch() == CoopGetBranchTotalLevelCount(STAYING_ALIVE_SECTION-1)-1 )
		{
			RecordAchievementEvent( "ACH.STAYING_ALIVE", GetBluePlayerIndex() )
			RecordAchievementEvent( "ACH.STAYING_ALIVE", GetOrangePlayerIndex() )
		}
	}

	EndSpeedRunTimer()
}

function RespondToTaunt(tauntnumber){
	printlDBG("-------------------------------------------RESPONDTOTAUNT"+tauntnumber)
	local curMapName = game.GetMap()
	--taunt 0 given at start
	LastTauntTime=CurTime()
	switch (curMapName)
	{
		case "mp_coop_start":  
			if (tauntnumber == 1)
			{
				GladosPlayVcd(1064)
			}
			break

		case "mp_coop_laser_2":  
			if (tauntnumber == 2)
			{
				GladosPlayVcd(1065)
			}
			break
		case "mp_coop_rat_maze":  
			if (tauntnumber == 3)
			{
				GladosPlayVcd(1017)
			}
			break
		case "mp_coop_catapult_1":  
			if (tauntnumber == 5)
			{
				GladosPlayVcd(1051)
			}
			break
		case "mp_coop_lobby_2":
			if (tauntnumber == 4){		  			
				--moved ot hub stuff
			}
			break
		case "mp_coop_catapult_wall_intro":
			if (tauntnumber == 7){		  			
				GladosPlayVcd(1097)
			}
			break		
		case "mp_coop_wall_5":
			if (tauntnumber == 8){		  			
				GladosPlayVcd(1098)
			}
			break					
		case "mp_coop_tbeam_laser_1":
			if (tauntnumber == 9){		  			
				GladosPlayVcd(1099)
			}
			break								
	}
}

function CoopHubTrack01(){
	GladosPlayVcd(1020)	
}
function CoopHubTrack02(){
	InHub2=1
	GladosPlayVcd(1095)	
}

function CoopHubTrack03(){
	GladosPlayVcd(1062)	
}

function CoopHubTrack04(){
	GladosPlayVcd(1173)	
	
}

function CoopHubTrack05(){
	GladosPlayVcd(1130)
}



function CoopRaceButton(arg)
{
	if (arg==coopBlue)
	{
		GladosPlayVcd(1026)
	}
	else
	{
		GladosPlayVcd(1027)
	}	
}

function CoopLaserTurretkill()
{
	GladosPlayVcd(1028)
}

function CoopMazeOrangeCrush(arg){
	if (arg == 1){
		OrangeInMaze = 1
	}
	else{
		OrangeInMaze = 0
	}
}

function CoopMazeBlueCrush(arg){
	if (arg == 1){
		BlueInMaze = 1
	}
	else{
		BlueInMaze = 0
	}
}

function CoopCrushersBlueCrush(arg){
	if (arg == 1){
		BlueInCrusher = 1
	}
	else{
		BlueInCrusher = 0
	}
}

function CoopCrushersOrangeCrush(arg){
	if (arg == 1){
		OrangeInCrusher = 1
	}
	else{
		OrangeInCrusher = 0
	}
}

function CoopRedirectAhead(player){
	if (player == coopBlue){
		GladosPlayVcd(1092)
	}
	else{
		GladosPlayVcd(1093)	
	}
	
}


function Fling1Drop4Balls(){
		GladosPlayVcd(1198)	
}





function BotDeath(player,dmgtype)
{
	printlDBG("*******************DEATH***************************")
	printlDBG(player)
	printlDBG(dmgtype)
	printlDBG(HumanResourceDeath4)
	printlDBG(LastDeathTime)
	printlDBG(mp_coop_tbeam_laser_1death1)
	printlDBG(mp_coop_tbeam_laser_1death2)
	printlDBG("*******************DEATH***************************")
	local curTime=CurTime()
	if (curTime-LastDeathTime<10){
		return
	}
	LastDeathTime=CurTime()
		
	if (curMapName == "mp_coop_tbeam_polarity3" and mp_coop_tbeam_polarity3deathblue==1 and player== coopBlue){		
		mp_coop_tbeam_polarity3deathblue=2
		GladosPlayVcd(1322)	
		return
	}
	if (curMapName == "mp_coop_tbeam_polarity3" and mp_coop_tbeam_polarity3deathblue==0 and player== coopBlue){		
		mp_coop_tbeam_polarity3deathblue=1
		GladosPlayVcd(1323)	
		return
	}

	if (curMapName == "mp_coop_tbeam_polarity3" and mp_coop_tbeam_polarity3deathorange==1 and player== coopOrange){		
		mp_coop_tbeam_polarity3deathorange=2
		GladosPlayVcd(1325)	
		return
	}
	if (curMapName == "mp_coop_tbeam_polarity3" and mp_coop_tbeam_polarity3deathorange==0 and player== coopOrange){		
		mp_coop_tbeam_polarity3deathorange=1
		GladosPlayVcd(1324)	
		return
	}


	
	
	
	if (curMapName == "mp_coop_tbeam_drill" and mp_coop_tbeam_drilldeathblue==0 and player== coopBlue){		
		mp_coop_tbeam_drilldeathblue=1
		GladosPlayVcd(1318)	
		return
	}
	if (curMapName == "mp_coop_tbeam_drill" and mp_coop_tbeam_drilldeathorange==0 and player== coopOrange){		
		mp_coop_tbeam_drilldeathorange=1
		GladosPlayVcd(1319)	
		return
	}

	if (curMapName == "mp_coop_tbeam_polarity" and mp_coop_tbeam_polaritydeathblue==0 and player== coopBlue){		
		mp_coop_tbeam_polaritydeathblue=1
		GladosPlayVcd(1320)	
		return
	}
	if (curMapName == "mp_coop_tbeam_polarity" and mp_coop_tbeam_polaritydeathorange==0 and player== coopOrange){		
		mp_coop_tbeam_polaritydeathorange=1
		GladosPlayVcd(1321)	
		return
	}


	if (curMapName == "mp_coop_tbeam_redirect" and mp_coop_tbeam_redirectdeath==0){		
		mp_coop_tbeam_redirectdeath=1
		GladosPlayVcd(1316)	
		return
	}
	if (curMapName == "mp_coop_lobby_2"){		
		local tauntflag3 = GetGladosSpokenFlags( 3 ) --used for deaths
		if ((tauntflag3 & (1 << 1)) == 0){
			tauntflag3 = tauntflag3 + (1 << 1)
			AddGladosSpokenFlags( 3, tauntflag3 )
			GladosPlayVcd(1199)
			return
		}
		if ((tauntflag3 & (1 << 2)) == 0){
			tauntflag3 = tauntflag3 + (1 << 2)
			AddGladosSpokenFlags( 3, tauntflag3 )
			GladosPlayVcd(1200)
			return
		}
		if ((tauntflag3 & (1 << 0)) == 0){
			tauntflag3 = tauntflag3 + (1 << 0)
			AddGladosSpokenFlags( 3, tauntflag3 )
			GladosPlayVcd(1096)
			return
		}		
		if ((tauntflag3 & (1 << 3)) == 0){
			tauntflag3 = tauntflag3 + (1 << 3)
			AddGladosSpokenFlags( 3, tauntflag3 )
			GladosPlayVcd(1201)
			return
		}
		if ((tauntflag3 & (1 << 4)) == 0){
			tauntflag3 = tauntflag3 + (1 << 4)
			AddGladosSpokenFlags( 3, tauntflag3 )
			GladosPlayVcd(1202)
			return
		}
	}
	if (curMapName == "mp_coop_turret_walls" and mp_coop_turret_wallscount==9){		
		GladosPlayVcd(1192)	
	}

	if (curMapName == "mp_coop_turret_walls" and mp_coop_turret_wallscount==4){		
		GladosPlayVcd(1193)	
	}
	
	if (curMapName == "mp_coop_turret_walls" and mp_coop_turret_wallscount==2){		
		GladosPlayVcd(1191)	
	}
	
	if (curMapName == "mp_coop_turret_walls" and mp_coop_turret_wallscount==0){		
		GladosPlayVcd(1153)
	}	
	
	if (curMapName == "mp_coop_turret_walls"){		
		mp_coop_turret_wallscount=mp_coop_turret_wallscount+1
	}
	
	
	if (curMapName == "mp_coop_turret_ball" and mp_coop_turret_ballcount==2){		
		if (player==2){
			GladosPlayVcd(1189)	
		}
		else{
			GladosPlayVcd(1188)	
		}
		mp_coop_turret_ballcount=3
	}
	
	if (curMapName == "mp_coop_turret_ball" and mp_coop_turret_ballcount==1){
		mp_coop_turret_ballcount=2
		GladosPlayVcd(1190)	
	}
	if (curMapName == "mp_coop_turret_ball" and mp_coop_turret_ballcount==0){
		mp_coop_turret_ballcount=1
		GladosPlayVcd(1187)	
	}	
		
	if (curMapName == "mp_coop_tbeam_end" ){
		local fireddeath = 0
		if (dmgtype==2 and Tbeam_enddeathturret==0){
				Tbeam_enddeathturret=1
				fireddeath=1
				GladosPlayVcd(1180)	
		}
		if (dmgtype==32 and Tbeam_enddeathfall==0){
			Tbeam_enddeathfall=1
			fireddeath=1
			GladosPlayVcd(1179)	
		}
		if (Tbeam_enddeathother==2 and fireddeath==0)
		{
			GladosPlayVcd(1181)
			Tbeam_enddeathother=Tbeam_enddeathother+1
		}
		if (Tbeam_enddeathother==1 and fireddeath==0)
		{
			GladosPlayVcd(1182)
			Tbeam_enddeathother=Tbeam_enddeathother+1
		}
		if (Tbeam_enddeathother==0 and fireddeath==0)
		{
			GladosPlayVcd(1183)
			Tbeam_enddeathother=Tbeam_enddeathother+1
		}		
		Tbeam_enddeathcounter=Tbeam_enddeathcounter+1
		
	} 

	
	if (curMapName == "mp_coop_rat_maze" )
	{
		if (player== coopBlue and dmgtype == 1 and BlueInMaze == 1 and CoopMazeBlueCrushset == 2)
		{
				CoopMazeBlueCrushset = 3
				GladosPlayVcd(1047)	
		}
		if (player== coopOrange and dmgtype == 1 and OrangeInMaze == 1  and CoopMazeOrangeCrushset == 2)
		{
				CoopMazeOrangeCrushset = 3
				GladosPlayVcd(1048)	
		}					
		if (player==coopBlue and dmgtype == 1 and BlueInMaze == 1 and CoopMazeBlueCrushset == 1)
		{
				CoopMazeBlueCrushset = 2
				GladosPlayVcd(1045)	
		}
		if (player== coopOrange and dmgtype == 1 and OrangeInMaze == 1  and CoopMazeOrangeCrushset == 1)
		{
				CoopMazeOrangeCrushset = 2
				GladosPlayVcd(1046)	
		}				

		if (player==coopBlue and dmgtype == 1 and BlueInMaze == 1 and CoopMazeBlueCrushset == 0)
		{
				CoopMazeBlueCrushset = 1
				GladosPlayVcd(1043)	
		}
		if (player== coopOrange and dmgtype == 1 and OrangeInMaze == 1  and CoopMazeOrangeCrushset == 0)
		{
				CoopMazeOrangeCrushset = 1
				GladosPlayVcd(1044)	
		}		


	}

	if (curMapName == "mp_coop_laser_crusher")
	{
		mp_coop_laser_crusherdeath=1
		if (player==coopBlue and dmgtype == 1 and BlueInCrusher == 1 and CoopCrushersBlueCrushset == 1)
		{
				CoopCrushersOrangeCrushset = 2
				CoopCrushersBlueCrushset = 2
				GladosPlayVcd(1042)	
		}
		if (player== coopOrange and dmgtype == 1 and OrangeInCrusher == 1  and CoopCrushersOrangeCrushset == 1)
		{
				CoopCrushersOrangeCrushset = 2
				CoopCrushersBlueCrushset = 2
				GladosPlayVcd(1042)	
		}				

		if (player==coopBlue and dmgtype == 1 and BlueInCrusher == 1 and CoopCrushersBlueCrushset == 0)
		{
				CoopCrushersBlueCrushset = 1
				GladosPlayVcd(1040)	
		}
		if (player== coopOrange and dmgtype == 1 and OrangeInCrusher == 1  and CoopCrushersOrangeCrushset == 0)
		{
				CoopCrushersOrangeCrushset = 1
				GladosPlayVcd(1041)	
		}		
		
	}
	if (curMapName == "mp_coop_start")
	{
		if (startdeath==3)
		{
			GladosPlayVcd(1086)
			startdeath=startdeath+1

		}
		if (startdeath==2)
		{
			GladosPlayVcd(1085)
			startdeath=startdeath+1

		}
		if (startdeath==1)
		{
			GladosPlayVcd(1084)
			startdeath=startdeath+1

		}
		if (player==coopBlue and startdeath==0)
		{
			startdeath=startdeath+1
			GladosPlayVcd(1088)

		}
		if (player==coopOrange and startdeath==0)
		{
			startdeath=startdeath+1
			GladosPlayVcd(1087)
		}
	}
	if (curMapName == "mp_coop_lobby_2" and InHub2==1 and InHub2Set==0 )	{
			InHub2Set=1
			GladosPlayVcd(1096)
	}
	if (curMapName == "mp_coop_wall_2")	{
			mp_coop_wall_2death=mp_coop_wall_2death+1
	}
	if (curMapName == "mp_coop_paint_redirect" and HumanResourceDeath1==2 ){
		HumanResourceDeath1=3
		GladosPlayVcd(1294)	
	}

	if (curMapName == "mp_coop_paint_redirect" and HumanResourceDeath1==1 ){
		HumanResourceDeath1=2
		GladosPlayVcd(1293)	
	}

	if (curMapName == "mp_coop_paint_redirect" and HumanResourceDeath1==0 ){
		HumanResourceDeath1=1
		GladosPlayVcd(1145)	
	}
	if (curMapName == "mp_coop_paint_bridge" and HumanResourceDeath2==1){
		HumanResourceDeath2=2
		GladosPlayVcd(1296)	
	}
	if (curMapName == "mp_coop_paint_bridge" and HumanResourceDeath2==0){
		HumanResourceDeath2=1
		GladosPlayVcd(1146)	
	}

	if (curMapName == "mp_coop_paint_walljumps" and HumanResourceDeath3==0){
		HumanResourceDeath3=1
		GladosPlayVcd(1150)	
	}
	if (curMapName == "mp_coop_paint_red_racer" and HumanResourceDeath4==5){
		HumanResourceDeath4=6
		GladosPlayVcd(1186)	
	}	
	if (curMapName == "mp_coop_paint_red_racer" and HumanResourceDeath4==4){
		HumanResourceDeath4=HumanResourceDeath4+1
	}		
	if (curMapName == "mp_coop_paint_red_racer" and HumanResourceDeath4==3){
		HumanResourceDeath4=HumanResourceDeath4+1
	}	
	if (curMapName == "mp_coop_paint_red_racer" and HumanResourceDeath4==2){
		HumanResourceDeath4=3
		GladosPlayVcd(1185)	
	}
	if (curMapName == "mp_coop_paint_red_racer" and HumanResourceDeath4==1){
		HumanResourceDeath4=2
		GladosPlayVcd(1184)	
	}
	if (curMapName == "mp_coop_paint_red_racer" and HumanResourceDeath4==0){
		HumanResourceDeath4=1
		GladosPlayVcd(1148)	
	}
	if (curMapName == "mp_coop_paint_speed_catch" and HumanResourceDeath5==0){
		HumanResourceDeath5=1
		GladosPlayVcd(1149)	
	}
	if (curMapName == "mp_coop_paint_speed_fling" and HumanResourceDeath6==0){
		HumanResourceDeath6=1
		GladosPlayVcd(1299)	
	}
		if (curMapName == "mp_coop_paint_longjump_intro" and HumanResourceDeath7==3){
		HumanResourceDeath7=4
		GladosPlayVcd(1303)	
	}
		if (curMapName == "mp_coop_paint_longjump_intro" and HumanResourceDeath7==2){
		HumanResourceDeath7=3
		GladosPlayVcd(1302)	
	}
	if (curMapName == "mp_coop_paint_longjump_intro" and HumanResourceDeath7==1){
		HumanResourceDeath7=2
		GladosPlayVcd(1301)	
	}
	if (curMapName == "mp_coop_paint_longjump_intro" and HumanResourceDeath7==0){
		HumanResourceDeath7=1
		GladosPlayVcd(1300)	
	}
	
 

	if (curMapName == "mp_coop_race_2"and EarlyDeath1==0 ){
		EarlyDeath1=1
		GladosPlayVcd(1151)	
	}
	if (curMapName == "mp_coop_multifling_1" and  EarlyDeath2==0){
		EarlyDeath2=1
		GladosPlayVcd(1152)	
		--add this line to ending if earlydeath2~=1
	}
	if (curMapName == "mp_coop_fling_crushers" and EarlyDeath3==2){
		EarlyDeath3=3
		GladosPlayVcd(1178)	
	}

	if (curMapName == "mp_coop_fling_crushers" and EarlyDeath3==1){
		EarlyDeath3=2
		GladosPlayVcd(1177)	
	}
	if (curMapName == "mp_coop_fling_crushers" and EarlyDeath3==0){
		EarlyDeath3=1
		GladosPlayVcd(1147)	
	}


	if (curMapName == "mp_coop_come_along" and EarlyDeath4==0){
		EarlyDeath4=1
		GladosPlayVcd(1154)	
	}
	if (curMapName == "mp_coop_catapult_1" and EarlyDeath5==0){
		EarlyDeath5=1
		GladosPlayVcd(1155)	
	}
	if (curMapName == "mp_coop_tbeam_laser_1" ){
		if (player==2 and mp_coop_tbeam_laser_1death1==0){
				mp_coop_tbeam_laser_1death1=1
				GladosPlayVcd(1204)	
				return
		}
		if (player==1 and mp_coop_tbeam_laser_1death2==0){
				mp_coop_tbeam_laser_1death2=1
				GladosPlayVcd(1206)	
		}
		if (player==2 and mp_coop_tbeam_laser_1death3==1){
				mp_coop_tbeam_laser_1death1=2
				GladosPlayVcd(1205)	
		}
	}
	if (curMapName == "mp_coop_infinifling_train" and mp_coop_infinifling_traindeath01==0){
		mp_coop_infinifling_traindeath01=1
		GladosPlayVcd(1255)	
	}
	if (curMapName == "mp_coop_infinifling_train" ){
			mp_coop_infinifling_traindeath=mp_coop_infinifling_traindeath+1
	}
	
	if (curMapName == "mp_coop_catapult_wall_intro" and mp_coop_catapult_wall_introdeath==0){
		mp_coop_catapult_wall_introdeath=1
		GladosPlayVcd(1257)	
	}
	if (curMapName == "mp_coop_wall_block" and mp_coop_wall_blockdeath==0){
		mp_coop_wall_blockdeath=1
		GladosPlayVcd(1258)	
	}
}

function CoopCrushersBox(player){
		local x = math.random(1,100)
		if (x>50)
		{
			GladosPlayVcd(1012)	
		}
		else
		{
			GladosPlayVcd(1013)	
		}
}

]]
function GladosCoopMapStart()
	local curMapName = game.GetMap()
	------/Calibration Course
			--/function handled elsewhere	
	------/Team Building Course	
	if curMapName == "mp_coop_doors" then
		GladosPlayVcd(54)
	elseif curMapName == "mp_coop_race_2" then
		GladosPlayVcd(1022)
	elseif curMapName == "mp_coop_laser_2" then
		GladosPlayVcd(1016)
	elseif curMapName == "mp_coop_rat_maze" then
	elseif curMapName == "mp_coop_laser_crusher" then
		local x = math.random(1,100)
		if x > 50 then
			GladosPlayVcd(1018)
		else
			GladosPlayVcd(1019)
		end
	elseif curMapName == "mp_coop_teambts" then
		GladosPlayVcd(1021)		
	------/Confidence Building Course	
	elseif curMapName == "mp_coop_fling_3" then
		GladosPlayVcd(1029)
	elseif curMapName == "mp_coop_infinifling_train" then
		GladosPlayVcd(1031)					
	elseif curMapName == "mp_coop_come_along" then
		GladosPlayVcd(1056)
	elseif curMapName == "mp_coop_fling_1" then
		GladosPlayVcd(1032)
	elseif curMapName == "mp_coop_catapult_1" then
		GladosPlayVcd(1057)
	elseif curMapName == "mp_coop_multifling_1" then
		GladosPlayVcd(1058)
	elseif curMapName == "mp_coop_fling_crushers" then
		GladosPlayVcd(1059)
	elseif curMapName == "mp_coop_fan" then
		GladosPlayVcd(1054)

--------/Obstacle  Building Course
	elseif curMapName == "mp_coop_wall_intro" then
		GladosPlayVcd(1111)
	elseif curMapName == "mp_coop_wall_2" then
		GladosPlayVcd(1118)	
	elseif curMapName == "mp_coop_catapult_wall_intro" then 
		GladosPlayVcd(1117)
		
	elseif curMapName == "mp_coop_wall_block" then 
		GladosPlayVcd(1119)
			
	elseif curMapName == "mp_coop_catapult_2" then 
		GladosPlayVcd(1121)
			
	elseif curMapName == "mp_coop_turret_walls" then --check this is in ?
		GladosPlayVcd(1122)
						
	elseif curMapName == "mp_coop_turret_ball" then 
		GladosPlayVcd(1083)
						
	elseif curMapName == "mp_coop_wall_5" then 
		GladosPlayVcd(1060)
			



	
	------/Subterfuge Building Course
	elseif curMapName == "mp_coop_tbeam_redirect" then
		GladosPlayVcd(1125)	
					
	elseif curMapName == "mp_coop_tbeam_drill" then
		if IsLocalSplitScreen() then
			GladosPlayVcd(1306)
		else
			GladosPrivateTalk(2,10)		
		end
		
	elseif curMapName == "mp_coop_tbeam_catch_grind_1" then
		local x = math.random(1,100)
		if x>50 then
			GladosPlayVcd(1080)	
			bluetrust=1
		else
			GladosPlayVcd(1081)	
			orangetrust=1
		end
		
	elseif curMapName == "mp_coop_tbeam_laser_1" then
		GladosPlayVcd(1073)	
		
	elseif curMapName == "mp_coop_tbeam_polarity" then
		local x = math.random(1,100)
	if x>50 then
			GladosPlayVcd(1069)	
			bluetrust=1
		else
			GladosPlayVcd(1070)	
			orangetrust=1
		end
		
	elseif curMapName == "mp_coop_tbeam_polarity2" then
		local x = math.random(1,100)
		if x>50 then
			GladosPlayVcd(1090)	
		else
			GladosPlayVcd(1091)	
		end
				
	elseif curMapName == "mp_coop_tbeam_polarity3" then
		GladosPlayVcd(1261)	
					
	elseif curMapName == "mp_coop_tbeam_maze" then
		GladosPlayVcd(1127)	
				
	elseif curMapName == "mp_coop_tbeam_end" then
		GladosPlayVcd(1129)	
--			GladosPrivateTalk(2,9)		
			

--------/XXXXXX  Building Course
	elseif curMapName == "mp_coop_paint_come_along" then
		GladosPlayVcd(1131)	
				
	elseif curMapName == "mp_coop_paint_redirect" then
		GladosPlayVcd(1133)	
				
	elseif curMapName == "mp_coop_paint_bridge" then
		GladosPlayVcd(1135)	
				
	elseif curMapName == "mp_coop_paint_walljumps" then
		GladosPlayVcd(1137)	
				
	elseif curMapName == "mp_coop_paint_speed_fling" then
		GladosPlayVcd(1139)	
				
	elseif curMapName == "mp_coop_paint_red_racer" then
		GladosPlayVcd(1141)	
		summer_sale_cube_died = false;
				
	elseif curMapName == "mp_coop_paint_speed_catch" then
		GladosPlayVcd(1175)	
				
	elseif curMapName == "mp_coop_paint_longjump_intro" then
		GladosPlayVcd(1143)	
	end

	StartSpeedRunTimer()
end
--[[

--plays when exit door opens
function GladosCoopOpenExitDoor(player)
{
	--endmap stuff
	local mapname = game.GetMap()
	printlDBG("****=================================Player "+player+" map NEW CODE"+mapname)
	if (DBG)
		printlDBG("****=================================Player "+player+" map "+mapname)
	if (coopTriggeredElevator)
	{
		return
	}
	coopTriggeredElevator = true
	EntFire( "@relay_disable_exit", "Trigger", "", 0.0 )
	switch (mapname)
	{
------/Calibration Course
		case "mp_coop_start": --DONE
			EntFire( "@relay_enable_exit", "Trigger", "", 0 )
			--plays at the end of the taunt stuff
			break	

------/Team Building Course
		case "mp_coop_doors": 	--Done
			GladosPlayVcd(1011)
			break	
		case "mp_coop_race_2": 	--Done
			EntFire( "@relay_enable_exit", "Trigger", "", 0 )			
			-- plays off putting ball in CoopRacePlaceBox
			break
		case "mp_coop_laser_2": --Done
			GladosPlayVcd(18)
			break
		case "mp_coop_rat_maze": --Done
			local x = math.random(1,100)
			if (x>50){
				GladosPlayVcd(1036)
			}
			else{
				GladosPlayVcd(1037)
			}
			break
		case "mp_coop_laser_crusher": -- Done
			if (mp_coop_laser_crusherdeath==0){
				if (player == coopBlue){
					GladosPlayVcd(23)
				}
				else{
					GladosPlayVcd(24)
				}
			}
			else{
					GladosPlayVcd(1170)
			}
			break



------/Confidence Building Course			
		case "mp_coop_fling_3":
			GladosPlayVcd(1030)
			break
		case "mp_coop_infinifling_train":
			if (mp_coop_infinifling_traindeath>0){
				GladosPlayVcd(1049)
			}
			else{
				GladosPlayVcd(1050)
			}
			break
		case "mp_coop_come_along":
			if (EarlyDeath4==0){
				GladosPlayVcd(1172)
			}
			else{
				GladosPlayVcd(1171)
			}
--			GladosPlayVcd(1034) - removed
			break		
		case "mp_coop_fling_1":  --deliberatly blank
			EntFire( "@relay_enable_exit", "Trigger", "", 0.0 )
			break
		case "mp_coop_catapult_1":  	
			EntFire( "@relay_enable_exit", "Trigger", "", 0.0 )
			--end speech fired in taunt response

			break
		case "mp_coop_multifling_1": -- Done
			if (EarlyDeath2==0){
				GladosPlayVcd(1162)	
			}
			else{
				GladosPlayVcd(1052)
			}
			break					
		case "mp_coop_fling_crushers": --Map 6
			if (EarlyDeath3>0){
					GladosPlayVcd(1176)
			}
			else{
					GladosPlayVcd(1053)
			}
			break
		----mp_coop_fan end with CoopBlueprintRoom function	
			
------/Obstacle Building Course		
		case "mp_coop_wall_intro": 
			GladosPlayVcd(1063)
			break
		case "mp_coop_wall_2":
			if (mp_coop_wall_2death==0){
				GladosPlayVcd(1113)
				break
			}
			if (mp_coop_wall_2death==1){
				GladosPlayVcd(1115)
				break
			}
			if (mp_coop_wall_2death==2){
				GladosPlayVcd(1116)
				break
			}
			GladosPlayVcd(1114)
			break
		case "mp_coop_catapult_wall_intro": 
			GladosPlayVcd(1082)
			break
		case "mp_coop_wall_block": 
			if (mp_coop_wall_blockdeath==1){
				GladosPlayVcd(1259)
			}
			else{
				GladosPlayVcd(1120)
			}
			break
		case "mp_coop_catapult_2": 
				GladosPlayVcd(1144)
				break


		case "mp_coop_turret_walls": 
			if (mp_coop_turret_wallscount==0){
				GladosPlayVcd(1123)
			}
			else{
				GladosPlayVcd(1260)
			}
			break			
		case "mp_coop_turret_ball": 
			GladosPlayVcd(1124)
			break		
		case "mp_coop_wall_5": 
			GladosPlayVcd(15)
			break
------/Subterfuge Buidling Course
		case "mp_coop_tbeam_redirect":
			--moved to normal ending as one in front is rarely end.
			break		
		case "mp_coop_tbeam_drill":
			if (IsLocalSplitScreen()){
				GladosPlayVcd(1307)
			}
			else{
				GladosPrivateTalk(2,4)		
				EntFire( "@relay_enable_exit", "Trigger", "", 15.0 )			
			}

			break		
		case "mp_coop_tbeam_catch_grind_1":
			-- chet, I swapped this withtbeam_laser_1 so we can grant the trickfire there -mtw
			GladosPlayVcd(1256)	
			break		
		case "mp_coop_tbeam_laser_1":
			--none here anymore because we gran the trickfire here -mtw			
			break		
		case "mp_coop_tbeam_polarity":
			if (bluetrust==1)
			{
				GladosPlayVcd(1071)	
			}
			else
			{
				GladosPlayVcd(1072)	
			}
			break		
		case "mp_coop_tbeam_polarity2":
			printlDBG("-------------------------------->"+polarity2whisper)
			if (polarity2whisper == 2){		
				GladosPlayVcd(1309)	
			}
			else{
				GladosPlayVcd(1308)	
			}
			break		
		case "mp_coop_tbeam_polarity3":
			GladosPlayVcd(1174)	
			break		
		case "mp_coop_tbeam_maze":
				GladosPlayVcd(1128)		
--			GladosPrivateTalk(2,5)		
	--		EntFire( "@relay_enable_exit", "Trigger", "", 10.0 )			
			break		
		case "mp_coop_tbeam_end":
			GladosPlayVcd(15)		
			break

--------/XXXXXX  Building Course
		case "mp_coop_paint_come_along":
			GladosPlayVcd(1132)		
			break		
		case "mp_coop_paint_redirect":
			GladosPlayVcd(1295)		
			break		
		case "mp_coop_paint_bridge":
			if (HumanResourceDeath2>0){
					GladosPlayVcd(1297)		
			}
			else{
					GladosPlayVcd(1298)		
			}
			break		
		case "mp_coop_paint_walljumps":
			GladosPlayVcd(1138)		
			break		
		case "mp_coop_paint_speed_fling":
			GladosPlayVcd(1140)
			break		
		case "mp_coop_paint_red_racer":
			GladosPlayVcd(1142)		
			if ( summer_sale_cube_died == false )
			{
				-- Award the achievement here
				RecordAchievementEvent( "ACH.SUMMER_SALE", GetBluePlayerIndex() )
				RecordAchievementEvent( "ACH.SUMMER_SALE", GetOrangePlayerIndex() )
			}		
			break		
		case "mp_coop_paint_speed_catch":
			GladosPlayVcd(1262)		
			break		
		case "mp_coop_paint_longjump_intro":
			GladosPlayVcd(15)		
			break
	}

	EndSpeedRunTimer()

	CheckAchievementsOnExitDoorOpen()
}

function CheckAchievementsOnExitDoorOpen()
{
	-- If the player completed the specified map using only a few portals.
	if ( game.GetMap() == LIMITED_PORTALS_MAP and
	     CoopGetNumPortalsPlaced() <= LIMITED_PORTALS_COUNT )
	{
		RecordAchievementEvent( "ACH.LIMITED_PORTALS", GetBluePlayerIndex() )
		RecordAchievementEvent( "ACH.LIMITED_PORTALS", GetOrangePlayerIndex() )
	}
}
]]
function StartSpeedRunTimer()
	mp_coop_speed_run_time = CurTime()
end

function EndSpeedRunTimer()
	local run_length = CurTime() - mp_coop_speed_run_time
	SetMapRunTime( run_length )
end

function SetMapRunTime( flTime )
	-- cap it at two hours
	if flTime > 7200.0 then
		flTime = 7200.0
	end

	CoopSetMapRunTime( flTime )
	 
	if flTime < SPEED_RUN_THRESHOLD and GetCoopSectionIndex() == SPEED_RUN_SECTION then
		NotifySpeedRunSuccess( flTime, game.GetMap() )
	end
end
--[[
function CoopRacePlaceBox()
{
	local mapname = game.GetMap()
	if (mapname == "mp_coop_race_2")
	{
		GladosPlayVcd(19)
	}
}
			


--Plays the final audio for each level
function GladosCoopElevatorEntrance(arg)
{
	printlDBG("====================================Player "+arg+" OLD CODE")
	local mapname = game.GetMap()
	switch (mapname)
	{
--------/Calibration Course
--		case "mp_coop_start": --DONE
--			EntFire( "@relay_enable_exit", "Trigger", "", 0.0 )
--			--plays at the end of the taunt stuff
--			break	
--
--------/Team Building Course
--		case "mp_coop_doors": 	--Done
--			GladosPlayVcd(1011)
--			break	
--		case "mp_coop_race_2": 	--Done
--			GladosPlayVcd(19)
--			break
--		case "mp_coop_laser_2": --Done
--			GladosPlayVcd(18)
--			break
--		case "mp_coop_rat_maze": --Done
--			local x = math.random(1,100)
--			if (x>50){
--				GladosPlayVcd(1036)
--			}
--			else{
--				GladosPlayVcd(1037)
--			}
--			break
--		case "mp_coop_laser_crusher": -- Done
--			if (arg == coopBlue)
--				GladosPlayVcd(23)
--			else
--				GladosPlayVcd(24)
--			break
--		--mp_coop_teambts end with GladosCoopEnterRadarRoom function	
--
--
--------/Confidence Building Course			
--		case "mp_coop_fling_3":
--			GladosPlayVcd(1030)
--			break
--		case "mp_coop_infinifling_train":
--			if (mp_coop_infinifling_traindeath>0){
--				GladosPlayVcd(1049)
--			}
--			else{
--				GladosPlayVcd(1050)
--			}
--			break
--		case "mp_coop_come_along":
--			GladosPlayVcd(1034)
--			break		
--		case "mp_coop_fling_1":  --deliberatly blank
--			EntFire( "@relay_enable_exit", "Trigger", "", 0.0 )
--			break
--		case "mp_coop_catapult_1":  	
--			EntFire( "@relay_enable_exit", "Trigger", "", 0.0 )
--			--end speech fired in taunt response
--
--			break
--		case "mp_coop_multifling_1": -- Done
--			GladosPlayVcd(1052)
--			break					
--		case "mp_coop_fling_crushers": --Map 6
--			GladosPlayVcd(1053)
--			break
--		----mp_coop_fan end with CoopBlueprintRoom function	
--			
--------/Obstacle Building Course		
--		case "mp_coop_wall_intro": 
--			GladosPlayVcd(1082)
--			break
--		case "mp_coop_wall_2":
--			GladosPlayVcd(15)
--			break
--		case "mp_coop_catapult_wall_intro": 
--			GladosPlayVcd(15)
--			break
--		case "mp_coop_wall_block": 
--			GladosPlayVcd(15)
--			break
--		case "mp_coop_catapult_2": 
----			if (OrangeTalk>500 and BlueTalk==0)
----				GladosPlayVcd(15)
----			break
----			}
----			else{
----				if (BlueTalk>500 and OrangeTalk==0)
----					GladosPlayVcd(15)
----					break
----				}
----
----			}
--				GladosPlayVcd(15)
--				break
--				--didn't hook up sound stuff because quiet person may still  have noisy avatar - need more thinking on this.
--
--
--		case "mp_coop_turret_walls": 
--			GladosPlayVcd(15)
--			break			
--		case "mp_coop_turret_ball": 
--			GladosPlayVcd(15)
--			break		
--		case "mp_coop_wall_5": 
--			GladosPlayVcd(15)
--			break
--------/Subterfuge Buidling Course
		case "mp_coop_tbeam_redirect":
			if (IsLocalSplitScreen()){
				GladosPlayVcd(1305)
			}
			else{
				EntFire( "@relay_disable_exit", "Trigger", "", 0.0 )
				GladosPrivateTalk(1,1)		
				EntFire( "@relay_enable_exit", "Trigger", "", 13.0 )			
				break		
			}
--		case "mp_coop_tbeam_drill":
--			GladosPrivateTalk(2,4)		
--			EntFire( "@relay_enable_exit", "Trigger", "", 15.0 )			
--			break		
--		case "mp_coop_tbeam_catch_grind_1":
--			GladosPrivateTalk(1,2)		
--			EntFire( "@relay_enable_exit", "Trigger", "", 14.0 )			
--			break		
--		case "mp_coop_tbeam_laser_1":
--			GladosPrivateTalk(2,3)		
--			EntFire( "@relay_enable_exit", "Trigger", "", 12.0 )			
--			break		
--		case "mp_coop_tbeam_polarity":
--			if (bluetrust==1)
--			{
--				GladosPlayVcd(1071)	
--			}
--			else
--			{
--				GladosPlayVcd(1072)	
--			}
--			break		
--		case "mp_coop_tbeam_polarity2":
--			GladosPlayVcd(15)		
--			break		
--		case "mp_coop_tbeam_polarity3":
--			GladosPlayVcd(15)		
--			break		
--		case "mp_coop_tbeam_maze":
--			GladosPrivateTalk(2,5)		
--			EntFire( "@relay_enable_exit", "Trigger", "", 10.0 )			
--			break		
--		case "mp_coop_tbeam_end":
--			GladosPlayVcd(15)		
--			break
--
----------/XXXXXX  Building Course
--		case "mp_coop_paint_come_along":
--			GladosPlayVcd(15)		
--			break		
--		case "mp_coop_paint_redirect":
--			GladosPlayVcd(15)		
--			break		
--		case "mp_coop_paint_bridge":
--			GladosPlayVcd(15)		
--			break		
--		case "mp_coop_paint_walljumps":
--			GladosPlayVcd(15)		
--			break		
--		case "mp_coop_paint_speed_fling":
--			GladosPlayVcd(15)
--			break		
--		case "mp_coop_paint_red_racer":
--			GladosPlayVcd(15)		
--			break		
--		case "mp_coop_paint_speed_catch":
--			GladosPlayVcd(15)		
--			break		
--		case "mp_coop_paint_longjump_intro":
--			GladosPlayVcd(15)		
--			break
	}
}




function CoopPingTool(player,surface) 
{
	local curTime = CurTime()
	local mapname = game.GetMap()
	printlDBG(surface)
	if (player == coopBlue){		
		if (BlueInPortalTraining == 1 and BlueHasGun == 0 and mapname == "mp_coop_start"){
			local BluePingInterval = curTime-BlueLastPing
			local BluePingInterval2 = curTime-BluePortalTrainingCounter
			BlueLastPing = curTime
			if (surface==1 and BluePortalTrainingCounter==0 and BluePingTraining1==0){
				BluePortalTrainingCounter=CurTime()
				BluePingInterval2=0
				BluePingTraining1=1
				GladosPlayVcd(1000)

			}
			if (surface==1 and BluePingInterval2>7 and BluePortalTrainingCounter~=0  and BluePingTraining2==0){
				BluePortalTrainingCounter=0
				BluePingTraining2=1
				GladosPlayVcd(1001)
			}		
		}
	}

	if (player == coopOrange){		
		if (OrangeInPortalTraining == 1 and OrangeHasGun == 0 and mapname == "mp_coop_start"){
			local OrangePingInterval = curTime-OrangeLastPing
			local OrangePingInterval2 = curTime-OrangePortalTrainingCounter
			OrangeLastPing = curTime
			if (surface==1 and OrangePortalTrainingCounter==0 and OrangePingTraining1==0){
				OrangePortalTrainingCounter=CurTime()
				OrangePingInterval2=0
				OrangePingTraining1=1
				GladosPlayVcd(1014)

			}
			if (surface==1 and OrangePingInterval2>7 and OrangePortalTrainingCounter~=0  and OrangePingTraining2==0){
				OrangePortalTrainingCounter=0
				OrangePingTraining2=1
				GladosPlayVcd(1015)
			}		
		}
	}
}

------/ Subterfuge section

function CoopPolarityWhisper(player){
	if (player == coopBlue){		
				GladosPlayVcd(1066)
				polarity2whisper=2
	}
	else{
				GladosPlayVcd(1067)
				polarity2whisper=1
	}
}



function CoopReturnHubTrack01(){
	local tVcd
	tVcd=math.random(1263,1266)
	printlDBG("THIS IS RANDOM:"+ tVcd)
	GladosPlayVcd(tVcd)
}

function CoopReturnHubTrack02(){
	local tVcd
	tVcd=math.random(1267,1270)
	printlDBG("THIS IS RANDOM:"+ tVcd)
	GladosPlayVcd(tVcd)

}

function CoopReturnHubTrack03(){
	local tVcd
	tVcd=math.random(1271,1273)
	printlDBG("THIS IS RANDOM:"+ tVcd)
	GladosPlayVcd(tVcd)
}

function CoopReturnHubTrack04(){
	local tVcd
	tVcd=math.random(1274,1276)
	printlDBG("THIS IS RANDOM:"+ tVcd)
	GladosPlayVcd(tVcd)
}

function CoopReturnHubTrack05(){
	local tVcd
	tVcd=math.random(1277,1279)
	printlDBG("THIS IS RANDOM:"+ tVcd)
	GladosPlayVcd(tVcd)
}

function CoopReturnHubAllFinished(){
	local tVcd
	tVcd=math.random(1280,1286)
	printlDBG("THIS IS RANDOM:"+ tVcd)
	GladosPlayVcd(tVcd)

}

function PlayerTauntCamera (player,animation){
	printlDBG("===============>CAMERA GESTURE!"+player+" x "+animation)
 	--added to block playing of responses while at vault door.
 	if (curMapName == "mp_coop_paint_longjump_intro"){
 		return
 	}
 	
 	local curTime=CurTime()
	if (curTime-LastTauntTime<5){
		return
	}
	LastTauntTime=CurTime()
	local tauntflag0 = GetGladosSpokenFlags( 0 )  --30
	local tauntflag1 = GetGladosSpokenFlags( 1 )  --18
	local tauntflag2 = GetGladosSpokenFlags( 2 )
	local tauntflag3 = GetGladosSpokenFlags( 3 ) --4 used for deaths
	
	if (((tauntflag1 & (1 << 18)) == 0) and (curMapName == "mp_coop_race_2" or curMapName == "mp_coop_laser_2" or curMapName == "mp_coop_fling_3")){
		local TellStory = 0
		local Player2
		while ( Player2 = Entities.FindByName ( Player2, "blue" )  )
		{
    	print ( "Canceling:\t" + Player2.GetName() + "\n" )
    	if (Player2 ~=nil){
    		break
    	}
		}
		if ( Player2~=nil){
			local vecPlayerPos=Player2.GetOrigin()
			local Door
			while ( Door = (Entities.FindByNameNearest( "@exit_door", vecPlayerPos, 600 )) )
			{
    		if	(Door ~=nil){
    			TellStory = 1
        	break
    		}
			}
		}
		if (TellStory==0){
			tauntflag1 = tauntflag1 + (1 << 18)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1330)
			return
		}  
	}      
	
	if ( animation == "smallWave" ){
		if ((tauntflag0 & (1 << 0)) == 0){
			tauntflag0 = tauntflag0 + (1 << 0)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1227)
			return
		}
		if ((tauntflag0 & (1 << 1)) == 0){
			tauntflag0 = tauntflag0 + (1 << 1)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1228)
			return
		}
		if ((tauntflag0 & (1 << 2)) == 0){
			tauntflag0 = tauntflag0 + (1 << 2)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1229)
			return
		}
		if ((tauntflag0 & (1 << 26)) == 0){
			tauntflag0 = tauntflag0 + (1 << 26)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1234)
			return
		}
		if ((tauntflag0 & (1 << 28)) == 0){
			tauntflag0 = tauntflag0 + (1 << 28)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1236)
			return
		}		
		if ((tauntflag0 & (1 << 29)) == 0){
			tauntflag0 = tauntflag0 + (1 << 29)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1237)
			return
		}		
		if ((tauntflag0 & (1 << 30)) == 0){
			tauntflag0 = tauntflag0 + (1 << 30)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1238)
			return
		}				
	}


	if ( animation == "highFive" ){
		if ((tauntflag0 & (1 << 3)) == 0){
			tauntflag0 = tauntflag0 + (1 << 3)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1207)
			return
		}
		if ((tauntflag0 & (1 << 4)) == 0){
			tauntflag0 = tauntflag0 + (1 << 4)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1208)
			return
		}
		if ((tauntflag0 & (1 << 5)) == 0){
			tauntflag0 = tauntflag0 + (1 << 5)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1209)
			return
		}
		if ((tauntflag1 & (1 << 0)) == 0){
			tauntflag1 = tauntflag1 + (1 << 0)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1248)
			return
		}
		if ((tauntflag1 & (1 << 1)) == 0){
			tauntflag1 = tauntflag1 + (1 << 1)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1249)
			return
		}
		if ((tauntflag1 & (1 << 2)) == 0){
			tauntflag1 = tauntflag1 + (1 << 2)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1251)
			return
		}
		if ((tauntflag1 & (1 << 9)) == 0){
			tauntflag1 = tauntflag1 + (1 << 9)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1289)
			return
		}		

	}
	
	if ( animation == "teamhug" ){
		if ((tauntflag0 & (1 << 6)) == 0){
			tauntflag0 = tauntflag0 + (1 << 6)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1210)
			return
		}
		if ((tauntflag0 & (1 << 7)) == 0){
			tauntflag0 = tauntflag0 + (1 << 7)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1211)
			return
		}
		if ((tauntflag0 & (1 << 8)) == 0){
			tauntflag0 = tauntflag0 + (1 << 8)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1212)
			return
		}
		if ((tauntflag1 & (1 << 3)) == 0){
			tauntflag1 = tauntflag1 + (1 << 3)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1221)
			return
		}		
		if ((tauntflag1 & (1 << 4)) == 0){
			tauntflag1 = tauntflag1 + (1 << 4)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1231)
			return
		}		
		if ((tauntflag1 & (1 << 10)) == 0){
			tauntflag1 = tauntflag1 + (1 << 10)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1290)
			return
		}		

	}

	if ( animation == "TeamEggTease" or animation == "TeamBallTease" ){
		if ((tauntflag0 & (1 << 9)) == 0){
			tauntflag0 = tauntflag0 + (1 << 9)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1213)
			return
		}
		if ((tauntflag0 & (1 << 10)) == 0){
			tauntflag0 = tauntflag0 + (1 << 10)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1214)
			return
		}
		if ((tauntflag0 & (1 << 11)) == 0){
			tauntflag0 = tauntflag0 + (1 << 11)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1215)
			return
		}
		if ((tauntflag0 & (1 << 12)) == 0){
			tauntflag0 = tauntflag0 + (1 << 12)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1216)
			return
		}
		if ((tauntflag1 & (1 << 8)) == 0){
			tauntflag1 = tauntflag1 + (1 << 8)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1288)
			return
		}		

	}


	if ( animation == "laugh" ){
		if ((tauntflag0 & (1 << 13)) == 0){
			tauntflag0 = tauntflag0 + (1 << 13)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1239)
			return
		}
		if ((tauntflag0 & (1 << 14)) == 0){
			tauntflag0 = tauntflag0 + (1 << 14)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1254)
			return
		}

		if ((tauntflag0 & (1 << 15)) == 0){
			tauntflag0 = tauntflag0 + (1 << 15)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1240)
			return
		}
		if ((tauntflag0 & (1 << 16)) == 0){
			tauntflag0 = tauntflag0 + (1 << 16)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1241)
			return
		}
		if ((tauntflag0 & (1 << 17)) == 0){
			tauntflag0 = tauntflag0 + (1 << 17)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1253)
			return
		}
		if ((tauntflag1 & (1 << 11)) == 0){
			tauntflag1 = tauntflag1 + (1 << 11)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1291)
			return
		}		

	}

	if ( animation == "robotDance" ){
		if ((tauntflag0 & (1 << 18)) == 0){
			tauntflag0 = tauntflag0 + (1 << 18)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1242)
			return
		}
		if ((tauntflag0 & (1 << 19)) == 0){
			tauntflag0 = tauntflag0 + (1 << 19)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1243)
			return
		}
		if ((tauntflag1 & (1 << 12)) == 0){
			tauntflag1 = tauntflag1 + (1 << 12)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1292)
			return
		}		

		if ((tauntflag0 & (1 << 20)) == 0){
			tauntflag0 = tauntflag0 + (1 << 20)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1244)
			return
		}
		if ((tauntflag0 & (1 << 21)) == 0){
			tauntflag0 = tauntflag0 + (1 << 21)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1245)
			return
		}
		if ((tauntflag0 & (1 << 22)) == 0){
			tauntflag0 = tauntflag0 + (1 << 22)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1246)
			return
		}
		if ((tauntflag0 & (1 << 23)) == 0){
			tauntflag0 = tauntflag0 + (1 << 23)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1247)
			return
		}
	}

	if ( animation == "rps" ){
		if ((tauntflag0 & (1 << 24)) == 0){
			tauntflag0 = tauntflag0 + (1 << 24)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1217)
			return
		}
		if ((tauntflag0 & (1 << 25)) == 0){
			tauntflag0 = tauntflag0 + (1 << 25)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1218)
			return
		}
		if ((tauntflag0 & (1 << 27)) == 0){
			tauntflag0 = tauntflag0 + (1 << 27)
			AddGladosSpokenFlags( 0, tauntflag0 )
			GladosPlayVcd(1235)
			return
		}		
		if ((tauntflag1 & (1 << 5)) == 0){
			tauntflag1 = tauntflag1 + (1 << 5)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1232)
			return
		}				
		if ((tauntflag1 & (1 << 6)) == 0){
			tauntflag1 = tauntflag1 + (1 << 6)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1233)
			return
		}				
		if ((tauntflag1 & (1 << 13)) == 0){
			tauntflag1 = tauntflag1 + (1 << 13)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1287)
			return
		}				
	}
	if ( animation == "trickfire" ){
		if ((tauntflag1 & (1 << 14)) == 0){
			tauntflag1 = tauntflag1 + (1 << 14)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1252)
			return
		}		

		if ((tauntflag1 & (1 << 15)) == 0){
			tauntflag1 = tauntflag1 + (1 << 15)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1327)
			return
		}		
		if ((tauntflag1 & (1 << 16)) == 0){
			tauntflag1 = tauntflag1 + (1 << 16)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1328)
			return
		}				
		if ((tauntflag1 & (1 << 17)) == 0){
			tauntflag1 = tauntflag1 + (1 << 17)
			AddGladosSpokenFlags( 1, tauntflag1 )
			GladosPlayVcd(1329)
			return
		}				
  }
        
        
        
}

function CoopBotAnimation(player,animation) 
{

	testcnt=testcnt+1
	printlDBG("===============>TEST TEST :"+testcnt)
	printlDBG("===============>GESTURE!"+player+" x "+animation)

	if (GladosInsideTauntCam == 1 ){
		if (player==1){
			OrangeTauntCam=1	
			OrangeTauntFinaleInterval = CurTime()
		}
		if (player==2){
			BlueTauntCam=1	
			BlueTauntFinaleInterval = CurTime()

		}
		if (BlueTauntCam==1 and OrangeTauntCam==1){

			GladosInsideTauntCam = 0 
			printlDBG("===============>CAM TEST :"+GladosInsideTauntCam)
			printlDBG("===============>CAM TEST :"+GladosInsideTauntCam)
			printlDBG("===============>CAM TEST :"+GladosInsideTauntCam)
			printlDBG("===============>CAM TEST :"+GladosInsideTauntCam)
			printlDBG("===============>CAM TEST :"+GladosInsideTauntCam)
			GladosPlayVcd(1161)

		}
	}
       
	if (curMapName == "mp_coop_teambts"){
 		local curTime=CurTime()
		if (curTime-LastTauntTime<5){
			return
		}
		LastTauntTime=CurTime()	
		teambtstaunts=teambtstaunts+1
		switch (teambtstaunts)
		{
			case 1: 
				if (player == coopBlue){		
					GladosPlayVcd(1100)
				}
				else{
					GladosPlayVcd(1101)
				}
				break
			
			case 2: 	
				GladosPlayVcd(1102)		
				break
			
			case 3: 
				if (player == coopBlue){		
					GladosPlayVcd(1103)
				}
				else{
					GladosPlayVcd(1104)
				}
				break				
				
			case 4: 	
				GladosPlayVcd(1105)		
				break
				
			case 5: 	
				GladosPlayVcd(1106)		
				break
		}
	}
}

--/bit for killing stuck players in tbeam
function GladosCoopKillTbeamMaze(){
		GladosPlayVcd(1304)	
}

function CoopCubeFizzle(){
	local curMapName = game.GetMap()
	if (curMapName=="mp_coop_multifling_1"){
		switch (mp_coop_multifling_1cube)
		{
			case 0: 
				mp_coop_multifling_1cube = 1
				GladosPlayVcd(1310)		
				break
			case 1: 
				mp_coop_multifling_1cube = 2
				GladosPlayVcd(1311)		
				break
			case 2: 
				mp_coop_multifling_1cube = 3
				GladosPlayVcd(1312)		
				break
			case 3: 
				mp_coop_multifling_1cube = 4
				GladosPlayVcd(1313)		
				break
		}
	}
	if (curMapName=="mp_coop_paint_red_racer") {
		summer_sale_cube_died = true;
	}
}
]]
-- Announcer Stuf
function CoopHubAllFinished()
	local x = math.random(1,100)
	if x>66 then
		GladosPlayVcd(1108)	
	else
		if x>33 then
			GladosPlayVcd(1109)	
		else
			GladosPlayVcd(1110)	
		end
	end
end