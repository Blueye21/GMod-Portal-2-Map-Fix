print("[P2] stacked_container_control.lua loaded")
// --------------------------------------------------------
function PrecacheContainerAnimations()
end

function StartContainerAnimations()
	EntFire("@container_stacks_1", "setanimation", "anim1", 0 )
	EntFire("@container_stacks_2", "setanimation", "anim1", 0 )
	EntFire("@container_stacks_2", "DisableDraw", "", 0 )
	
//	for(local i=1;i<=92;i+=1)
//	{
//		EntFire("container_stacked_" + i,"setparentattachment", "vstattachment", 0 )
//		EntFire("@container_stacked_" + i,"setanimation", "container" + i, 0 )
//		
//		if( i > 56 )
//		{
//			EntFire("@container_stacked_" + i,"DisableDraw", "", 0 )	
//		}	
//	}
end

function ShowHiddenContainers()
	EntFire("@container_stacks_2","EnableDraw", "", 0 )
//	for(local i=57;i<=92;i+=1)
//	{
//		EntFire("@container_stacked_" + i,"EnableDraw", "", 0 )
//	}
end

function SetupContainerAttachments()
//	for(local i=1;i<=92;i+=1)
//	{
//		EntFire("container_stacked_" + i,"SetParentAttachmentMaintainOffset", "vstAttachment_noOrient", 0 )
//	}
end
