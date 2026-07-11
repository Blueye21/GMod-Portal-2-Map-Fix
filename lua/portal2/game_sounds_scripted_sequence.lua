sound.Add({
    name = "ScriptedSequence.GladosReawaken",
    channel = CHAN_AUTO,
    soundlevel = 150,
    sound = "playonce/scripted_sequences/glados_reawakened_01.wav"
})

sound.Add({
    name = "ScriptedSequence.GladosStairDestruction",
    channel = CHAN_AUTO,
    soundlevel = 150,
    volume = 0.80,
    sound = "playonce/scripted_sequences/glados_stair_destruction_01.wav"
})
if Debug then print("[P2] game_sounds_scripted_sequence.lua loaded") end