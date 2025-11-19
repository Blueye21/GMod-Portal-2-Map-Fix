print("[P2] game_sounds.lua loaded")
--sp_a1_intro1
sound.Add({
    name = "Error",               -- Name of the sound
    channel = CHAN_STATIC,        -- Matches the "channel" from game_sounds.txt
    volume = 1.0,                 -- Default volume
    soundlevel = 0,
    pitch = 100,                  -- Default pitch
    sound = "error.wav"           -- Path to the .wav file inside "sound/" folder
})

--[[
sound.Add({
    name = "",
    channel = ,
    volume = ,
    level = ,
    pitch = ,
    sound = ""
})
]]