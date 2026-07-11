////////////////////////////////////  CONSTANTS //////////////////////////////////////////
m_nBranch = 0

m_bAskedClose = false
m_bAskedOpen = false
m_bOpening = false
m_bClosing = false

///////////////////////////////////  FUNCTION DEFINITIONS ////////////////////////////////
// --------------------------------------------------------
// Sets the local branch #
// --------------------------------------------------------
function SetLocalBranchNumber( nBranch )
	m_nBranch = nBranch
end

// --------------------------------------------------------
// Open Start
// --------------------------------------------------------
function OpenScreenStart()
	m_bAskedOpen = true
	m_bAskedClose = false
end

// --------------------------------------------------------
// Close Start
// --------------------------------------------------------
function CloseScreenStart()
	m_bAskedClose = true
	m_bAskedOpen = false
end

// --------------------------------------------------------
// Close Animating
// --------------------------------------------------------
function ScreenFinish()
	m_bOpening = false
	m_bClosing = false
end
function Think()
	if ( m_bAskedOpen == true ) then
		if ( m_bOpening == true ) then
			m_bAskedOpen = false
			return
		end
		
		if ( m_bClosing == true ) then
			return
		end
		
		m_bOpening = true
		m_bAskedOpen = false		
		
		local bAllLevelsIncomplete = true;
		
		for  j = 1, 16 do
			if ( IsLevelComplete( m_nBranch-1, j ) ) then
				bAllLevelsIncomplete = false;
			end
		end
		
		if ( !bAllLevelsIncomplete ) then
			EntFire( EntityGroup[2]:GetName(), "Enable", "", 0)
		else
			EntFire( EntityGroup[2]:GetName(), "Disable", "", 0)
		end
		EntFire( EntityGroup[0]:GetName(), "Trigger", "", 0.01)	
	end
	
	if ( m_bAskedClose == true ) then
		if ( m_bClosing == true ) then
			m_bAskedClose = false
			return
		end
		
		if ( m_bOpening == true ) then
			return
		end
		
		m_bClosing = true
		m_bAskedClose = false
		
		local bAllLevelsIncomplete = true;
		
		for j = 1, 16 do
			if ( IsLevelComplete( m_nBranch-1, j ) ) then
				bAllLevelsIncomplete = false;
			end
		end
		
		if ( !bAllLevelsIncomplete ) then
			EntFire( EntityGroup[3]:GetName(), "Enable", "", 0)
		else
			EntFire( EntityGroup[3]:GetName(), "Disable", "", 0)
		end
		EntFire( EntityGroup[1]:GetName(), "Trigger", "", 0)	
	end
end
hook.Add("GM:Think", "coop_level_select_panel_flipThink", Think)