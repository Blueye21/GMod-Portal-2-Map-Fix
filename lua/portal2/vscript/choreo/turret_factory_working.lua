name = "dummyshoot_conveyor_1_turret_1&0371"
function PlayStuckSound()
	print("=================I AM TURRET NAMED: " .. name )
	
	TurretVoManager.TurretStuck(name)
end

-- -------------------------------------------------------------------
-- Called when a functioning turret starts the  test and will pass
-- -------------------------------------------------------------------
function FunctioningTurretPass()
	print("=================TURRET NAME: " .. name )
	TurretVoManager.GoodTurretPass(name)
	--ScannerPassTurret()
end

-- -------------------------------------------------------------------
-- Called when a functioning turret starts the  test and will fail
-- -------------------------------------------------------------------
function FunctioningTurretFail()
	TurretVoManager.GoodTurretTest(name)
	--ScannerRejectTurret()
end

-- -------------------------------------------------------------------
-- Called when a malfunctioning turret starts the  test and will pass
-- -------------------------------------------------------------------
function MalfunctioningTurretPass()
	--.EmitSound("turret.TurretStuckInTube01")
	TurretVoManager.DefectTurretPass(name)
	--ScannerPassTurret()
end

-- -------------------------------------------------------------------
-- Called when a malfunctioning turret starts the  test and will fail
-- -------------------------------------------------------------------
function MalfunctioningTurretFail()
	--.EmitSound("turret.TurretStuckInTubeGoodbye01")
	TurretVoManager.DefectTurretTest(name)
	--ScannerRejectTurret()
end

function MalfunctioningTurretFling()
	TurretVoManager.DefectTurretFail(name)
end

function FunctioningTurretFling()
	TurretVoManager.GoodTurretFail(name)
end

function grabbedDefect()
	print("==========GRABBED A TURRET!")
	TurretVoManager.grabbedDefectTurret(name)
end

function MalfunctioningTurretSneakBy()
	print("===STARTING SNEAK!!!")
	TurretVoManager.DefectTurretSneakBy(name)
end

-- =======================================================================
-- =======================================================================


-- -------------------------------------------------------------------
-- Precache sounds we will emit
-- -------------------------------------------------------------------
function Precache()
	--.PrecacheSoundScript( "turret.TurretStuckInTube01" )
	--.PrecacheSoundScript( "turret.TurretStuckInTubeGoodbye01" )
end

-- -------------------------------------------------------------------
-- Allow turret to pass scanner
-- -------------------------------------------------------------------
function ScannerPassFunctionTurret()
	EntFire( "accept_turret_relay", "trigger", 0, 4 )
end

-- -------------------------------------------------------------------
-- Catapults the turret away 
-- -------------------------------------------------------------------
function ScannerRejectFunctioningTurret()
	EntFire( "reject_turret_relay", "trigger", 0, 4 )
end

-- -------------------------------------------------------------------
-- Allow turret to pass scanner
-- -------------------------------------------------------------------
function ScannerPassMalfunctionTurret()
	EntFire( "accept_turret_relay", "trigger", 0, 4 )
end

-- -------------------------------------------------------------------
-- Catapults the turret away
-- -------------------------------------------------------------------
function ScannerRejectMalfunctioningTurret()
	EntFire( "reject_turret_relay", "trigger", 0, 4 )
end



-- =======================================================================
-- =======================================================================

-- -------------------------------------------------------------------
-- Called when a functioning turret is in position to shoot a dummy
-- -------------------------------------------------------------------
function FunctioningTurretReachedDummyShootPosition()
	TurretVoManager.GoodTurretShootPosition(name)
end

-- -------------------------------------------------------------------
-- Called when a malfunctioning turret is in position to shoot a dummy
-- -------------------------------------------------------------------
function MalfunctioningTurretReachedDummyShootPosition()
	TurretVoManager.DefectTurretShootPosition(name)
end


-- -------------------------------------------------------------------
-- Spawn a turret to shoot at dummy
-- -------------------------------------------------------------------
function SpawnDummyShootTurret()
	print("***Spawning a turret to shoot at dummy!")
	
	-- spawn a new turret
	--EntFire("dummyshoot_conveyor_1_spawn_rl", "trigger", 0, 2 )
	
	-- send current train on down the line to exit
	--EntFire("dummyshoot_conveyor_1_advance_train_relay", "trigger", 0, 2 )
end


----------------------------------------------------------------------------------------------------------------
--Turret Queue Functions
----------------------------------------------------------------------------------------------------------------
DBG = true

if not GlobalTurretFactoryQueue then
	-- set up global queue
	GlobalTurretFactoryQueue = {}
end

function OnPostSpawn()
	if not GlobalTurretFactoryQueue then
		QueueInitialize()
		if DBG then print("===== Initializing QUEUE.  Length: " .. GlobalTurretFactoryQueue:len()) end
	end
end

--Initialize the queue
function QueueInitialize()
	GlobalTurretFactoryQueue = {}
end

--Add a scene to the queue
function QueueAdd()
	GlobalTurretFactoryQueue.append( name )
	if DBG then print("====== Adding " .. name .. " to queue. Length = " .. GlobalTurretFactoryQueue:len() ) end
	if GlobalTurretFactoryQueue:len() > 4 then
		if DBG then print("====== Turret queue reached " .. GlobalTurretFactoryQueue:len() .. ". Removing turret " .. GlobalTurretFactoryQueue[1] .. " New queue Length = " .. GlobalTurretFactoryQueue:len() ) end
		
		-- detonate turret
		EntFire( GlobalTurretFactoryQueue[0], "destruct", 0, 0 )
		
		-- remove the turret from the queue
		QueueDeleteFirstItem()
	end
end

--Returns number of items in the queue
function QueueLen()
	return GlobalTurretFactoryQueue:len()
end

--Delete a single item by index from the queue
function QueueDelete( index )
	if QueueLen()==0 then
		return false
	end
	-- remove from queue
 	GlobalTurretFactoryQueue[index] = nil
end

--Sort through queue and remove  if found
function RemoveFromQueue()
	turretname = name
	if DBG then print("===== ATTEMPTING to remove  from queue: " .. turretname ) end
	
	if QueueLen()==0 then
		return false
	end
	for index, val in ipairs(GlobalTurretFactoryQueue) do
		if turretname == GlobalTurretFactoryQueue[index] then
			if DBG then print(" === removing #" .. index .. " named: " .. GlobalTurretFactoryQueue[index] ) end
 			GlobalTurretFactoryQueue[index] = nil
 			return true
 		end
	end
	return false
end

--Delete first item from the queue
function QueueDeleteFirstItem()
	QueueDelete(1)
end