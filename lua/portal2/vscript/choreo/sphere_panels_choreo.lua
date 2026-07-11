--[[
--GladosPlayVcd indexes for original text
DialogVcd = {}
DialogVcd[1000] = 388
DialogVcd[1001] = 389
DialogVcd[1002] = 390
DialogVcd[1003] = 391


--Factory
Dialog[1000] = { speaker = WHEATLEY, one = "We have to find the neurotoxin now", two = "The feeder tube should be in here somewhere" }

Dialog[1001] = { speaker = WHEATLEY, one = "Drop down here onto this track" }

Dialog[1002] = { speaker = WHEATLEY, one = "I can see the neurotoxin tube in the next room" }

Dialog[1003] = { speaker = WHEATLEY, one = "Keep following the neurotoxin tubes", two = "I'll meet you up ahead" }

function SpeakLineVcd( arg )
	if DialogVcd[arg] then
		---EntFire("@glados","RunScriptCode","GladosPlayVcd("..DialogVcd[arg]..")", 0.00)
		GladosPlayVcd(DialogVcd[arg])
	else
		SpeakLine( arg )
	end
end


function PanelWheatleyFindToxin()
	SpeakLineVcd( 1000 )
end

function PanelWheatleyDropDown()
	SpeakLineVcd( 1001 )
end

function PanelWheatleySeeToxin()
	SpeakLineVcd( 1002 )
end

function PanelWheatleyFollowToxin()
	SpeakLineVcd( 1003 )
end
]]