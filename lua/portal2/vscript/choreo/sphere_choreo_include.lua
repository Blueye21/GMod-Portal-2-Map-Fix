-- speakers --------------------------------------------------------------
local WHEATLEY  = 0
local GLADOS    = 1
local TURRET    = 2
local COMPUTER  = 3

-- runtime state ---------------------------------------------------------
local NextSpeakTime, NextSpeakLine = -1, -1
local NextNagTime,   NextNagLine   = -1, -1

-- ui helpers ------------------------------------------------------------
local UI = {
    [WHEATLEY] = { txt1 = "sphere_text_1",  txt2 = "sphere_text_2",  prefix = "Wheatley: " },
    [GLADOS]   = { txt1 = "glados_text_1",  txt2 = "glados_text_2",  prefix = "GLaDOS: " },
    [TURRET]   = { txt1 = "glados_text_1",  txt2 = "glados_text_2",  prefix = "Turret: " },
    [COMPUTER] = { txt1 = "glados_text_1",  txt2 = "glados_text_2",  prefix = "Computer: " },
}

-- dialogue table (populated externally) ---------------------------------
Dialog = {}

------------------------------------------------------------------------
-- internal
------------------------------------------------------------------------
local function clearUI()
    for _, speaker in pairs(UI) do
        EntFire(speaker.txt1, "SetText", "")
        EntFire(speaker.txt1, "Display", "")
        EntFire(speaker.txt2, "SetText", "")
        EntFire(speaker.txt2, "Display", "")
    end
end

local function showLine(line)
    clearUI()
    local data  = Dialog[line]
    if not data or not data.speaker then return end

    local ui    = UI[data.speaker]
    if data.one then
        EntFire(ui.txt1, "SetText", ui.prefix .. data.one, 0)
        EntFire(ui.txt1, "Display", "", 0)
    end
    if data.two then
        EntFire(ui.txt2, "SetText", ui.prefix .. data.two, 0)
        EntFire(ui.txt2, "Display", "", 0.75)
    end
end

local function scheduleFollowUps(line)
    local data = Dialog[line]
    if not data then return end

    -- next line ---------------------------------------------------------
    if data.nextLine then
        if data.nagDelay then
            print("ERROR: line "..line.." has both nextLine + nagDelay – nag wins")
            NextSpeakTime, NextSpeakLine = -1, -1
        else
            NextSpeakLine = data.nextLine
            NextSpeakTime = CurTime() + (data.nextLineDelay or 5)
        end
    else
        NextSpeakTime, NextSpeakLine = -1, -1
    end

    -- nag ---------------------------------------------------------------
    if data.nagDelay then
        NextNagLine = line
        NextNagTime = CurTime() + data.nagDelay
    else
        NextNagTime, NextNagLine = -1, -1
    end

    -- relay -------------------------------------------------------------
    if data.relay then
        EntFire(data.relay, "Trigger", "", data.relayDelay or 0)
    end
end

------------------------------------------------------------------------
-- public  (identical signatures)
------------------------------------------------------------------------
function SpeakLine(line)
    NextNagTime, NextSpeakTime = -1, -1
    showLine(line)
    scheduleFollowUps(line)
end

function Think()
    local t = CurTime()
    if NextSpeakTime > 0 and t > NextSpeakTime and NextSpeakLine > 0 then
        SpeakLine(NextSpeakLine)
    elseif NextNagTime > 0 and t > NextNagTime and NextNagLine > 0 then
        SpeakLine(NextNagLine)
    end
end

function NextLine()
    if NextSpeakLine > 0 then
        SpeakLine(NextSpeakLine)
    elseif NextNagLine > 0 then
        SpeakLine(NextNagLine)
    end
end

function ShowHelp()
    print("speaker        – 0=Wheatley, 1=GLaDOS, 2=Turret, 3=Computer")
    print("one            – top line text")
    print("two            – second line text")
    print("nextLine       – line index to auto-play")
    print("nextLineDelay  – seconds until nextLine (default 5)")
    print("relay          – relay to trigger")
    print("relayDelay     – seconds before relay fires")
    print("nagDelay       – seconds until this line repeats")
end