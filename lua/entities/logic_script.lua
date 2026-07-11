AddCSLuaFile()

ENT.Base = "base_point"
ENT.Type = "point"
ENT.EntityGroup = {}
local _included = false

local sharedEnv = setmetatable({}, {
    __index = _G,
    __newindex = function(t, k, v)
        _G[k] = v  -- write through to _G properly
    end
})

local function RunScriptFile(path, ent)
    local fn = CompileFile(path)
    if not fn then
        print("[VScript] Skipped (not found or failed to compile): " .. path)
        return
    end

    sharedEnv.self = ent  -- update self per-script
    setfenv(fn, sharedEnv)
    local ok, err = pcall(fn)
    if not ok then
        ErrorNoHalt("[VScript] Runtime error in " .. path .. ": " .. tostring(err) .. "\n")
    end
end

function ENT:Initialize()
    self.EntityGroup = {}
    timer.Simple(0, function()
        if not IsValid(self) then return end
        for i = 1, 15 do
            if self.EntityGroup[i] ~= nil then
                self.EntityGroup[i] = ents.FindByName(self.EntityGroup[i])[1]
            end
        end
    end)

    if _included then return end
    _included = true  -- Set immediately so concurrent/re-entrant calls are also blocked

    local map = game.GetMap()

    -- Core
    RunScriptFile("portal2/portal2_common.lua", self)
    RunScriptFile("portal2/vscript/mapspawn.lua", self)

    -- Button Door
    RunScriptFile("portal2/vscript/button_door/button_target_large.lua", self)
    RunScriptFile("portal2/vscript/button_door/button_target_small.lua", self)
    RunScriptFile("portal2/vscript/button_door/button_target.lua", self)
    RunScriptFile("portal2/vscript/button_door/door.lua", self)
    RunScriptFile("portal2/vscript/button_door/maker.lua", self)
    RunScriptFile("portal2/vscript/button_door/sign_target.lua", self)
    --RunScriptFile("portal2/vscript/button_door/sign.lua", self)

    -- Choreo/Main
    if string.StartsWith(map, "sp_") then
        RunScriptFile("portal2/vscript/choreo/glados.lua", self)
    end
    if string.StartsWith(map, "mp_") then
        RunScriptFile("portal2/vscript/choreo/glados_coop.lua", self)
    end

    -- Only here until I find a file that includes this
    if string.StartsWith(map, "sp_a4_") then
        RunScriptFile("portal2/vscript/choreo/act4_part01.lua", self)
    end

    -- Choreo/Wheatley
    RunScriptFile("portal2/vscript/choreo/sphere_choreo_include.lua", self)
    if string.StartsWith(map, "sp_a2_bts") then
        RunScriptFile("portal2/vscript/choreo/sphere_flashlight_tour_choreo.lua", self)
        RunScriptFile("portal2/vscript/choreo/sphere_jailbreak_choreo.lua", self)
        RunScriptFile("portal2/vscript/choreo/sphere_panels_choreo.lua", self)
        RunScriptFile("portal2/vscript/choreo/sphere_toxin_destruct_choreo.lua", self)
        RunScriptFile("portal2/vscript/choreo/turret_vo_manager.lua", self)
        RunScriptFile("portal2/vscript/choreo/turret_factory_working.lua", self)
        RunScriptFile("portal2/vscript/choreo/turret_grinder_dialog.lua", self)
        RunScriptFile("portal2/vscript/choreo/turret_scanner_screens.lua", self)
    end

    -- Choreo/Map Specific
    if map == "sp_a1_wakeup" then
        RunScriptFile("portal2/vscript/choreo/glados_camera.lua", self)
    end

    -- Coop
    if string.StartsWith(map, "mp_") then
        RunScriptFile("portal2/vscript/coop/mp_coop_ping_select_test.lua", self)
        RunScriptFile("portal2/vscript/coop/mp_coop_start_connected.lua", self)
        RunScriptFile("portal2/vscript/debug_scripts/mp_coop_transition_list.lua", self)
        RunScriptFile("portal2/vscript/debug_scripts/mp_coop_start_check_dev.lua", self)
        RunScriptFile("portal2/vscript/debug_scripts/mp_coop_lobby.lua", self)
    end

    --Debug Scripts

    --Door Close Sensor

    -- Panels
    RunScriptFile("portal2/vscript/panels/ceiling_seal_in.lua", self)
    if string.StartsWith(map, "mp_") then
        RunScriptFile("portal2/vscript/panels/coop_level_select_panel_flip.lua", self)
    end
    RunScriptFile("portal2/vscript/animations/stacked_container_control.lua", self)

    -- Sabotage Glados
    RunScriptFile("portal2/vscript/sabotage_glados/maintenance_pit.lua", self)

    -- Transitions
    RunScriptFile("portal2/vscript/transitions/sp_elevator_motifs.lua", self)
    RunScriptFile("portal2/vscript/transitions/sp_transition_list.lua", self)

    -- Videos
    RunScriptFile("portal2/vscript/videos/video_splitter.lua", self)

    -- Sounds
    RunScriptFile("portal2/game_sounds_animation.lua", self)
    RunScriptFile("portal2/game_sounds_music_a1.lua", self)
    RunScriptFile("portal2/game_sounds_npc.lua", self)
    RunScriptFile("portal2/game_sounds_physics.lua", self)
    RunScriptFile("portal2/game_sounds_scripted_sequence.lua", self)
    RunScriptFile("portal2/game_sounds_vfx.lua", self)
    RunScriptFile("portal2/game_sounds_world.lua", self)
    RunScriptFile("portal2/game_sounds.lua", self)
end

function ENT:KeyValue(k, v)
    for i = 0, 15 do
        if k == "EntityGroup[" .. i .. "]" then
            self.EntityGroup[i] = v
        end
    end
end

function ENT:AcceptInput(name, activator, caller, data)
    if name == "RunScriptCode" then
        print(self:GetName() .. " Ran " .. data)

        local env = setmetatable({ self = self }, { __index = _G })

        local fn, err = CompileString(data, self:GetName() .. ":" .. data, false)
        if not fn then
            ErrorNoHalt("[VScript] Compile error in " .. self:GetName() .. ": " .. tostring(err) .. "\n")
            return false
        end

        setfenv(fn, env)
        local ok, runErr = pcall(fn)
        if not ok then
            ErrorNoHalt("[VScript] Runtime error in " .. self:GetName() .. ": " .. tostring(runErr) .. "\n")
            return false
        end

        return true
    end

    return false
end