AddCSLuaFile()

ENT.Base  = "base_point"
ENT.Type  = "point"

-------------------------------------------------
-- One-time environment bootstrap
-------------------------------------------------
if not _G.P2VScriptEnv then
    local ENV = {}
    _G.P2VScriptEnv = ENV
    setmetatable(ENV, { __index = _G })

    -------------------------------------------------
    -- Helper: prints only when a file is actually parsed
    -------------------------------------------------
    local function PInclude(path)
        include(path)
        print("[P2]  -> " .. path)
    end

    PInclude("portal2/portal2_common.lua")
    PInclude("portal2/vscript/mapspawn.lua")

    -- Doors
    PInclude("portal2/vscript/button_door/button_target_large.lua")
    PInclude("portal2/vscript/button_door/button_target_small.lua")
    PInclude("portal2/vscript/button_door/button_target.lua")
    PInclude("portal2/vscript/button_door/door.lua")
    PInclude("portal2/vscript/button_door/maker.lua")
    PInclude("portal2/vscript/button_door/sign_target.lua")
    PInclude("portal2/vscript/button_door/sign.lua")

    -- Choreo
    print("[P2] LOADING CHOREO")
    PInclude("portal2/vscript/choreo/glados.lua")
    PInclude("portal2/vscript/choreo/glados_coop.lua")
    PInclude("portal2/vscript/choreo/sphere_flashlight_tour_choreo.lua")
    PInclude("portal2/vscript/choreo/turret_factory_working.lua")
    PInclude("portal2/vscript/choreo/glados_camera.lua")

    -- Coop
    print("[P2] LOADING COOP")
    PInclude("portal2/vscript/coop/mp_coop_ping_select_test.lua")
    PInclude("portal2/vscript/coop/mp_coop_start_connected.lua")

    -- Debug_scripts
    PInclude("portal2/vscript/debug_scripts/mp_coop_lobby.lua")
    PInclude("portal2/vscript/debug_scripts/mp_coop_start_check_dev.lua")
    PInclude("portal2/vscript/debug_scripts/mp_coop_transition_list.lua")

    -- Transitions
    print("[P2] LOADING TRANSITIONS")
    PInclude("portal2/vscript/transitions/sp_elevator_motifs.lua")
    PInclude("portal2/vscript/transitions/sp_transition_list.lua")

    -- Videos
    PInclude("portal2/vscript/videos/video_splitter.lua")

    -- Nugget
    PInclude("portal2/vscript/nugget/nugget_maker.lua")

    -- Animations
    print("[P2] LOADING ANIMATIONS")
    PInclude("portal2/vscript/animations/stacked_container_control.lua")
    PInclude("portal2/vscript/panels/ceiling_seal_in.lua")

    -- Sounds
    print("[P2] LOADING SOUNDS")
    PInclude("portal2/game_sounds.lua")
    PInclude("portal2/game_sounds_animation.lua")
    PInclude("portal2/game_sounds_music_a1.lua")
    PInclude("portal2/game_sounds_physics.lua")
    PInclude("portal2/game_sounds_scripted_sequence.lua")
    PInclude("portal2/game_sounds_vfx.lua")
    PInclude("portal2/game_sounds_world.lua")
    PInclude("portal2/game_sounds_npc.lua")
end

-------------------------------------------------
-- Entity logic
-------------------------------------------------
function ENT:Initialize()
    -- Mirror every function from the shared environment into ourselves
    local t = {}
    for k, v in pairs(_G.P2VScriptEnv) do
        if isfunction(v) then
            t[k] = v -- no wrapper needed; we pass self explicitly later
        end
    end
    self.ScriptFunctions = t
end

-------------------------------------------------
-- AcceptInput: RunScriptCode
-------------------------------------------------
function ENT:AcceptInput(name, activator, caller, data)
    if not data then return end
    if name == "runscriptcode" or name == "RunScriptCode" then
        local f = self.ScriptFunctions[data]
        if f then
            print(self:GetName() .. " running function: " .. data)
            f(self, activator, caller)
        else
            print(self:GetName() .. " tried to run unknown script: " .. data)
        end
    elseif name == "changelevel" or name == "Changelevel" then
        RunConsoleCommand("changelevel", data)
    else
        return 
    end
end

-------------------------------------------------
-- Allow @entName:SomeFunc() syntax
-------------------------------------------------
ENT.__index = function(self, k)
    return self.ScriptFunctions[k] or ENT[k]
end