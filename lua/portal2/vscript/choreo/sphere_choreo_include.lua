WHEATLEY = 0
GLADOS = 1

TURRET= 2
COMPUTER= 3

NextNagTime = -1
NextNagLine = -1

NextSpeakTime = -1
NextSpeakLine = -1

NagLine1 = -1
NagLine2 = -1

Dialog = {}

function SpeakLine( line )
	NextNagTime = -1
	NextSpeakTime = -1
	
	EntFire( "sphere_text_1", "SetText", "", 0 )	
	EntFire( "sphere_text_1", "Display", "", 0 )	
	EntFire( "sphere_text_2", "SetText", "", 0 )
	EntFire( "sphere_text_2", "Display", "", 0 )
	EntFire( "glados_text_1", "SetText", "", 0 )	
	EntFire( "glados_text_1", "Display", "", 0 )	
	EntFire( "glados_text_2", "SetText", "", 0 )
	EntFire( "glados_text_2", "Display", "", 0 )

	if Dialog[line].speaker and Dialog[line].speaker == GLADOS then
		if Dialog[line].one then
			EntFire( "glados_text_1", "SetText", "GLaDOS: " .. Dialog[line].one, 0 )
			EntFire( "glados_text_1", "Display", "", 0 )
			
			EntFire( "glados_text_2", "SetText", "", 0 )
			EntFire( "glados_text_2", "Display", "", 0 )
        end
		if Dialog[line].two then
			EntFire( "glados_text_2", "SetText", "GLaDOS: " .. Dialog[line].two, 0 )
			EntFire( "glados_text_2", "Display", "", 0.75 )		
        end
	elseif Dialog[line].speaker and Dialog[line].speaker == WHEATLEY then
		if Dialog[line].one then
			EntFire( "sphere_text_1", "SetText", "Wheatley: " .. Dialog[line].one, 0 )
			EntFire( "sphere_text_1", "Display", "", 0 )
			
			EntFire( "sphere_text_2", "SetText", "", 0 )
			EntFire( "sphere_text_2", "Display", "", 0 )
        end
		if Dialog[line].two then
			EntFire( "sphere_text_2", "SetText", "Wheatley: " .. Dialog[line].two, 0 )
			EntFire( "sphere_text_2", "Display", "", 0.75 )		
        end
	
	elseif Dialog[line].speaker and Dialog[line].speaker == TURRET then
		if Dialog[line].one then
			EntFire( "glados_text_1", "SetText", "Turret: " .. Dialog[line].one, 0 )
			EntFire( "glados_text_1", "Display", "", 0 )
			
			EntFire( "glados_text_2", "SetText", "", 0 )
			EntFire( "glados_text_2", "Display", "", 0 )
        end
		if Dialog[line].two then
			EntFire( "glados_text_2", "SetText", "Turret: " .. Dialog[line].two, 0 )
			EntFire( "glados_text_2", "Display", "", 0.75 )		
        end
	elseif Dialog[line].speaker and Dialog[line].speaker == COMPUTER then
		if Dialog[line].one then
			EntFire( "glados_text_1", "SetText", "Computer: " .. Dialog[line].one, 0 )
			EntFire( "glados_text_1", "Display", "", 0 )
			
			EntFire( "glados_text_2", "SetText", "", 0 )
			EntFire( "glados_text_2", "Display", "", 0 )
        end
		if Dialog[line].two then
			EntFire( "glados_text_2", "SetText", "Computer: " .. Dialog[line].two, 0 )
			EntFire( "glados_text_2", "Display", "", 0.75 )		
        end
	end
	
		
	if Dialog[line].nextLine then
		if Dialog[line].nextLineDelay then
			NextSpeakTime = CurTime() + Dialog[line].nextLineDelay
		else
			NextSpeakTime = CurTime() + 5
        end
		
		NextSpeakLine = Dialog[line].nextLine
	else
		NextSpeakTime = -1
		NextSpeakLine = -1
    end
	
	if Dialog[line].nagDelay then
		if Dialog[line].nextLine then
			print("Hey Dummy! How are you going to nag and speak another line? Well - I'm waiting?!?")
			print("Hey Dummy! How are you going to nag and speak another line? Well - I'm waiting?!?")
			print("Hey Dummy! How are you going to nag and speak another line? Well - I'm waiting?!?")
			print("Hey Dummy! How are you going to nag and speak another line? Well - I'm waiting?!?")
			print("Hey Dummy! How are you going to nag and speak another line? Well - I'm waiting?!?")
			
			NextSpeakTime = -1
			NextSpeakLine = -1
        end

		NextNagLine = line
		NextNagTime = CurTime() + Dialog[line].nagDelay
	end
	
	if Dialog[line].relay then
		EntFire( Dialog[line].relay, "Trigger", "", Dialog[line].relayDelay )
    end
end

function Think()
	if NextSpeakTime > -1 and NextSpeakLine > -1 and CurTime() > NextSpeakTime then
		SpeakLine( NextSpeakLine ) -- this might set new next lines to speak.
	elseif NextNagTime > -1 and NextNagLine > -1 and CurTime() > NextNagTime then
		SpeakLine( NextNagLine )
	end
end

hook.Add("Think", "SphereChoreoIncludeThink", Think)

function NextLine()
	if NextSpeakLine > -1 then
		SpeakLine( NextSpeakLine )	
	elseif NextNagLine > -1 then
		SpeakLine( NextNagLine )
    end
end

function ShowHelp()
	print("speaker -  who is speaking, GLADOS or WHEATLEY")
	print("one -      text displayed at the center of the screen")
	print("two -      text displayed slightly below one")
	print("nextLine - Line to play immediately after this one completes")
	print("nextLineDelay - how long to wait until nextline is played")
	print("relay -	   relay to fire when this line is spoken")
	print("relayDelay - how to wait before the relay fires")
	print("nagDelay - If this line is a nag how long until it repeats")
end