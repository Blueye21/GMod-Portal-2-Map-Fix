//
// sp_a1_intro1
//
sound.Add({
    name = "music.sp_intro_01.01_awake",
    channel = CHAN_STATIC,
    soundlevel = 0,
    volume = 1.0,
    sound = "*music/sp_a1_intro1_b1.wav"
})
sound.Add({
    name = "music.sp_intro_01.02_restasis",
    channel = CHAN_STATIC,
    soundlevel = 0,
    volume = 1.0,
    sound = "*music/sp_a1_intro1_b2a.wav"
})
sound.Add({
    name = "music.sp_a1_intro1_b2b",
    channel = CHAN_STATIC,
    soundlevel = 0,
    volume = 1.0,
    sound = "*music/sp_a1_intro1_b2b.wav"
})
sound.Add({
    name = "music.sp_intro_01.03_door",
    channel = CHAN_STATIC,
    soundlevel = 0,
    volume = 0.6,
    sound = "*music/sp_a1_intro1_b2a.wav"
})
sound.Add({
    name = "music.sp_intro_01.04_yes",
    channel = CHAN_STATIC,
    soundlevel = 75,
    sound = "common/null.wav"
})
if Debug then print("[P2] game_sounds_music_a1.lua loaded") end