--********************************************************************************************
--Turret scanner screens
--********************************************************************************************
DBG = true 

stock_scanner_turret_type = 0
master_scanner_turret_type = 1  --  master starts out as functional turret

player_in_scanner = 0 -- whether player is standing in scanner or not

-- -------------------------------------------------------------------
-- Returns true if template turret is function, false if it was swapped
-- -------------------------------------------------------------------
function IsTemplateTurretFunctional()
	return master_scanner_turret_type
end

-- -------------------------------------------------------------------
-- Returns true if template turret is function, false if it was swapped
-- -------------------------------------------------------------------
function ConveyorTurretFunctional()
	return stock_scanner_turret_type
end

-- -------------------------------------------------------------------
-- Template turret has been swapped for a broken variety
-- -------------------------------------------------------------------
function TemplateTurretBroken()
	if DBG then print("===== Switching master template to broken.") end
	master_scanner_turret_type = 0;
end

-- -------------------------------------------------------------------
-- Turret about to be scanned is a functional turret
-- -------------------------------------------------------------------
function StockTurretFunctional()
	if DBG then print("===== Switching stock scanner to functional.") end
	stock_scanner_turret_type = 1;
end


-- -------------------------------------------------------------------
-- Turret about to be scanned is a broken turret
-- -------------------------------------------------------------------
function StockTurretBroken()
	if DBG then print("===== Switching stock scanner to broken.") end
	stock_scanner_turret_type = 0;
end

-- -------------------------------------------------------------------
-- Change the display to the pass screen
-- -------------------------------------------------------------------
function SetStockDisplayPass()
	EntFire( "stock_scanner_display", "skin", "3", 0.5)
end

-- -------------------------------------------------------------------
-- Change the display to the fail screen
-- -------------------------------------------------------------------
function SetStockDisplayFail()
	EntFire( "stock_scanner_display", "skin", "2", 0.5)
end

-- -------------------------------------------------------------------
-- Change the display to the reset screen
-- -------------------------------------------------------------------
function SetStockDisplayReset()
	EntFire( "stock_scanner_display", "skin", "0", 0)
end

-- -------------------------------------------------------------------
-- Change the display to the pass screen
-- -------------------------------------------------------------------
function SetMasterDisplayPass()
	if IsPlayerInScanner() then
		if DBG then print("===== Player in scanner. Overriding pass screen with error screen.") end
		EntFire( "master_scanner_display", "skin", "1", 0.5)
		-- fire achievement
		EntFire("turret_scanner_achievement", "FireEvent", 0, 0 )
	else
		EntFire( "master_scanner_display", "skin", "3", 0.5)
	end
end

-- -------------------------------------------------------------------
-- Change the display to the fail screen
-- -------------------------------------------------------------------
function SetMasterDisplayFail()
	EntFire( "master_scanner_display", "skin", "2", 0.5)
end

-- -------------------------------------------------------------------
-- Change the display to the reset screen
-- -------------------------------------------------------------------
function SetMasterDisplayReset()
	EntFire( "master_scanner_display", "skin", "0", 0)
end

-- -------------------------------------------------------------------
-- Change the display to the bad match screen
-- -------------------------------------------------------------------
function SetResultDisplayBadMatch()
	EntFire( "result_scanner_display", "skin", "2", 0)
end

-- -------------------------------------------------------------------
-- Change the display to the good match screen
-- -------------------------------------------------------------------
function SetResultDisplayGoodMatch()
	EntFire( "result_scanner_display", "skin", "3", 0)
end

-- -------------------------------------------------------------------
-- Change the display to the mixed match screen
-- -------------------------------------------------------------------
function SetResultDisplayNoMatchLeftGreen()
	EntFire( "result_scanner_display", "skin", "5", 0)
end

-- -------------------------------------------------------------------
-- Change the display to the mixed match screen
-- -------------------------------------------------------------------
function SetResultDisplayNoMatchRightGreen()
	EntFire( "result_scanner_display", "skin", "4", 0)
end

-- -------------------------------------------------------------------
-- Change the display to the reset screen
-- -------------------------------------------------------------------
function SetResultDisplayReset()
	EntFire( "result_scanner_display", "skin", "0", 0)
end

-- -------------------------------------------------------------------
-- Reset all of the displays
-- -------------------------------------------------------------------
function ResetScannerDisplays()
	if DBG then print("===== RESETTING ALL DISPLAYS.") end
	SetResultDisplayReset()
	SetStockDisplayReset()
	SetMasterDisplayReset()
end

-- -------------------------------------------------------------------
-- Set whether player is standing in scanner or not
-- -------------------------------------------------------------------
function SetPlayerInScanner( bool )
	if DBG then print("===== Setting Player in scanner to " .. bool ) end
	player_in_scanner = bool
end

-- -------------------------------------------------------------------
-- Returns true if player is standing in scanner
-- -------------------------------------------------------------------
function IsPlayerInScanner()
	return player_in_scanner
end


-- -------------------------------------------------------------------
-- Scan master turret
-- -------------------------------------------------------------------
function ScanMasterTurret()
	-- play scanner animation
	EntFire( "master_scanner_model", "SetAnimation", "turret_scanner_master_scan", 0)	
	
	-- update the display with the results
	if IsTemplateTurretFunctional() then
		SetMasterDisplayPass()
	else
		SetMasterDisplayFail()
	end
end

-- -------------------------------------------------------------------
-- Scan stock turret
-- -------------------------------------------------------------------
function ScanStockTurret()
	-- play scanner animation
	EntFire( "stock_scanner_model", "SetAnimation", "turret_scanner_master_scan", 0)
	
	-- update the display with the results
	if ConveyorTurretFunctional() then
		SetStockDisplayPass()
	else
		SetStockDisplayFail()
	end
end


-- -------------------------------------------------------------------
-- Display results of scan on the board
-- -------------------------------------------------------------------
function DisplayScanResults()
	-- test with functional master
	if IsTemplateTurretFunctional() then
		if ConveyorTurretFunctional() then
			SetResultDisplayGoodMatch()
		else
			SetResultDisplayNoMatchRightGreen()
		end
	else
		if ConveyorTurretFunctional() then
			SetResultDisplayNoMatchLeftGreen()
		else
			SetResultDisplayBadMatch()
		end
	end
end

