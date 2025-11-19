AddCSLuaFile()

ENT.Base = "base_point"
ENT.Type = "point"

-- Only include scripts once
if not _G.P2VScriptEnv then
    _G.P2VScriptEnv = {}
    setmetatable(_G.P2VScriptEnv, { __index = _G })

    -- Portal 2 VScript equivalents
    include("portal2/portal2_common.lua")

    -- Map spawn scripts
    include("portal2/vscript/mapspawn.lua")

    -- Doors
    include("portal2/vscript/button_door/button_target_large.lua")
    include("portal2/vscript/button_door/button_target_small.lua")
    include("portal2/vscript/button_door/button_target.lua")
    include("portal2/vscript/button_door/door.lua")
    include("portal2/vscript/button_door/maker.lua")
    include("portal2/vscript/button_door/sign_target.lua")
    include("portal2/vscript/button_door/sign.lua")

    -- Choreo
    print("[P2] LOADING CHOREO")
    include("portal2/vscript/choreo/glados.lua")

    -- Transitions
    print("[P2] LOADING TRANSITIONS")
    include("portal2/vscript/transitions/sp_elevator_motifs.lua")
    include("portal2/vscript/transitions/sp_transition_list.lua")

    -- Videos
    include("portal2/vscript/videos/video_splitter.lua")

    -- Nugget
    include("portal2/vscript/nugget/nugget_maker.lua")

    -- Animations
    print("[P2] LOADING ANIMATIONS")
    include("portal2/vscript/animations/stacked_container_control.lua")
    include("portal2/vscript/panels/ceiling_seal_in.lua")

    -- Sounds
    print("[P2] LOADING SOUNDS")
    include("portal2/game_sounds.lua")
    include("portal2/game_sounds_animation.lua")
    include("portal2/game_sounds_music_a1.lua")
    include("portal2/game_sounds_physics.lua")
    include("portal2/game_sounds_scripted_sequence.lua")
    include("portal2/game_sounds_vfx.lua")
    include("portal2/game_sounds_world.lua")
    include("portal2/game_sounds_npc.lua")
end

-- Called when the entity is initialized
function ENT:Initialize()
    self.ScriptFunctions = {}

    -- Automatically bind all global VScript functions to this entity
    for k, v in pairs(_G.P2VScriptEnv) do
        if type(v) == "function" then
            self.ScriptFunctions[k] = function(...) return v(...) end
        end
    end
end

-- AcceptInput is called when a logic_script entity receives an input
function ENT:AcceptInput(name, activator, caller, data)
    if name == "RunScriptCode" and data then
        local func = self.ScriptFunctions[data]
        if func then
            print(self:GetName().." running function: "..data)
            func(self, activator, caller)
        else
            print(self:GetName().." tried to run unknown script: "..data)
        end
    end
end

-- Allows external calls like @glados:PuzzleStart()
function ENT:__index(key)
    if self.ScriptFunctions and self.ScriptFunctions[key] then
        return self.ScriptFunctions[key]
    else
        return rawget(ENT, key)
    end
end