
-- --------------------------------------------------------
function CloseCeilingOld()
    local panelDelay=0.35
    local panelCount=57
    local exitPanelCount=3
    local panelOrder={}

    -- seed
    for i=1, panelCount - 1 do
        panelOrder[i]=i
    end

    -- shuffle
    for i=1, panelCount - exitPanelCount do
        local temp=panelOrder[i]
        local index=math.random(0, panelCount - (exitPanelCount + 1))
        panelOrder[i]=panelOrder[index]
        panelOrder[index]=temp
    end

    for i=1, panelCount - 1 do
        local doorNum=1 + panelOrder[i]

        --		printl("closing door " + doorNum)

        EntFire("door_" .. doorNum .. "-shutter_door","Open","", panelDelay * i)
    end
end

-- --------------------------------------------------------
--function SealChambers()
--{
--	local panelCount = 56
--
--	for(local i=0;i<panelCount;i+=1)
--	{
--		local doorNum = 1 + i
--		EntFire("door_" + doorNum + "-shutter_door","Close", "", 0 )
--	}
--}

armCount=61

closeDoor1=28
closeDoor2=29
farDoor1=25
farDoor2=26
finalDoor1=33
finalDoor2=61

function Seal()
    --	local armOrder = {}
    --
    --	-- seed
    --	for(local i=0;i<armCount;i+=1)
    --	{
    --		local checkDoor = i+1
    --		if( checkDoor != closeDoor1 &&
    --			checkDoor != closeDoor2 &&
    --			checkDoor != farDoor1 &&
    --			checkDoor != farDoor2 &&
    --			checkDoor != finalDoor1 &&
    --			checkDoor != finalDoor2 )
    --		{
    --			armOrder[armOrder.len()] = i
    --		}
    --	}
    --
    --	-- shuffle
    --	for(local i=0;i<armOrder.len();i+=1)
    --	{
    --		local temp = armOrder[i]
    --		local index = RandomInt(0,armOrder.len()-1)
    --		armOrder[i] = armOrder[index]
    --		armOrder[index] = temp
    --	}
    --
    --	armOrder[armOrder.len()] = closeDoor1
    --	armOrder[armOrder.len()] = closeDoor2
    --	armOrder[armOrder.len()] = farDoor1
    --	armOrder[armOrder.len()] = farDoor2
    --	armOrder[armOrder.len()] = finalDoor1
    --	armOrder[armOrder.len()] = finalDoor2
    --
    --	for(local i=0;i<armOrder.len();i+=1)
    --	{
    --		printl( "Arm " + (armOrder[i] + 1) + " has timer " + timer * 0.35 )
    --
    --		SealOneArm( armOrder[i] + 1, i * 0.35 ) -- the last arms in the list go last
    --	}

    local timer=0
    for i=1, armCount - 1 do
        if i == 33 then
            timer=0
        end

        local count=i
        if count > 32 then
            count=count - 34
            timer=timer + 0.02 * count
        else
            timer=timer + 0.014 * count

            --		printl( "" + (i+1) + " at time " + timer )

            SealOneArm(i + 1, timer) -- the last arms in the list go last
        end
    end

    --	EntFire( "door_script", "RunScriptCode", "TryCloseFinalDoors()", 0.35*( armOrder.len()+2) )
end

function Setup()
    for i=1, armCount - 1 do
        local armNum=1 + i
        SetArmIdle(armNum)
    end
end

function Cleanup()
    for i=1, armCount - 1 do
        local armNum=1 + i
        CleanUpArm(armNum)
    end
end

function ShowDoors()
    for i=1, armCount - 1 do
        local armNum=1 + i
        EnableArm(armNum, true)
    end
end

function HideDoors()
    for i=1, armCount - 1 do
        local armNum=1 + i
        EnableArm(armNum, false)
    end
end

function CloseFirstDoor()
    --	printl("Closing first door!")
    --	SealOneArm( closeDoor1, 0 )
    --	SealOneArm( closeDoor2, 0 )
    --
    --	closeDoor1 = -1
    --	closeDoor2 = -1
end

function CloseSecondDoor()
    --	printl("Closing second door!")
    --	SealOneArm( farDoor1, 0 )
    --	SealOneArm( farDoor2, 0 )
    --
    --	farDoor1 = -1
    --	farDoor2 = -1
end

function TryCloseFinalDoors()
    if closeDoor1 ~= -1 then
        SealOneArm(closeDoor1, 0)
    end

    if closeDoor2 ~= -1 then
        SealOneArm(closeDoor2, 0)
    end

    if farDoor1 ~= -1 then
        SealOneArm(farDoor1, 0)
    end

    if farDoor2 ~= -1 then
        SealOneArm(farDoor2, 0)
    end

    SealOneArm(finalDoor1, 0)
    SealOneArm(finalDoor2, 0)
end

function SetArmIdle(arm_number)
    local prefabName="sealin_" .. arm_number
    EntFire(prefabName .. "-arm_1","setanimationnoreset","block_lower01_drop_idle");
    EntFire(prefabName .. "-arm_2","setanimationnoreset","block_upper01_drop_idle");
end

function SealOneArm(arm_number, delay)
    local prefabName="sealin_" .. arm_number
    local bottomArmName=prefabName .. "-arm_1"
    local topArmName=prefabName .. "-arm_2"
    local bottomPanelName=prefabName .. "-panel_1"
    local topPanelName=prefabName .. "-panel_2"

    if arm_number ~= closeDoor1 and
    arm_number ~= closeDoor2 and
    arm_number ~= farDoor1 and
    arm_number ~= finalDoor1 and
    (arm_number % 3) ~= 0 then
        EntFire(bottomArmName,"setanimationnoreset","block_lower01_drop", 0.0 + delay);
        EntFire(bottomArmName,"setanimationnoreset","block_lower01_grabpanel", 1.0 + delay);

        EntFire(bottomPanelName,"setparent", bottomArmName, 1.5 + delay);
        EntFire(bottomPanelName,"setparentattachment","panel_attach", 1.5 + delay);

        EntFire(bottomArmName,"setanimationnoreset","block_lower01_pushforward", 2.0 + delay);

        delay = delay + math.Rand(-0.2, 0.2)

        EntFire(topArmName,"setanimationnoreset","block_upper01_pushforward", 2.0 + delay);

        EntFire(bottomPanelName,"clearparent","", 3.5 + delay);
    else
        EntFire(topArmName,"setanimationnoreset","block_upper02_abovestairs", 2.0 + delay);
        EntFire(bottomArmName,"kill","", 0.0);
    end

    EntFire(topArmName,"setanimationnoreset","block_upper01_drop", 0.0 + delay);
    EntFire(topArmName,"setanimationnoreset","block_upper01_grabpanel", 1.0 + delay);

    EntFire(topPanelName,"setparent", topArmName, 1.5 + delay);
    EntFire(topPanelName,"setparentattachment","panel_attach", 1.5 + delay);

    EntFire(topPanelName,"clearparent","", 3.5 + delay);
end

function CleanUpArm(arm_number, delay)
    local prefabName="sealin_" .. arm_number
    local bottomArmName=prefabName .. "-arm_1"
    local topArmName=prefabName .. "-arm_2"
    local bottomPanelName=prefabName .. "-panel_1"
    local topPanelName=prefabName .. "-panel_2"

    EntFire(topArmName,"kill","", 0.0);
    EntFire(topPanelName,"kill","", 0.0);
    EntFire(bottomArmName,"kill","", 0.0);
    EntFire(bottomPanelName,"kill","", 0.0);
end

function EnableArm(arm_number, enabled)
    local prefabName="sealin_" .. arm_number
    local bottomArmName=prefabName .. "-arm_1"
    local topArmName=prefabName .. "-arm_2"
    local bottomPanelName=prefabName .. "-panel_1"
    local topPanelName=prefabName .. "-panel_2"

    if enabled then
        EntFire(topArmName,"Enable","", 0.0);
        EntFire(topPanelName,"Enable","", 0.0);
        EntFire(bottomArmName,"Enable","", 0.0);
        EntFire(bottomPanelName,"Enable","", 0.0);
    else
        EntFire(topArmName,"Disable","", 0.0);
        EntFire(topPanelName,"Disable","", 0.0);
        EntFire(bottomArmName,"Disable","", 0.0);
        EntFire(bottomPanelName,"Disable","", 0.0);
    end
end
