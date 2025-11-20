print("[P2] mp_coop_ping_select_test.lua loaded")
BLUE_enabled = 0
ORANGE_enabled = 0

function SelectChoicesSpawn()
    for i = 1, 9 do
        local TriggerNameA = "pingdet_BLUE_" .. i
        local PanelNameA   = "panel_select_BLUE_" .. i
        local TriggerNameB = "pingdet_ORANGE_" .. i
        local PanelNameB   = "panel_select_ORANGE_" .. i

        EntFire(TriggerNameA, "Disable", "", 0)
        EntFire(TriggerNameB, "Disable", "", 0)
        EntFire(PanelNameA, "Open", "", 0)
        EntFire(PanelNameB, "Open", "", 0)
    end
end

function SelectChoicesBlueStart()
    for i = 1, 9 do
        local TriggerNameA = "pingdet_BLUE_" .. i
        local PanelNameA   = "panel_select_BLUE_" .. i

        EntFire(TriggerNameA, "Enable", "", 1)
        EntFire(PanelNameA, "Close", "", 0)
    end

    BLUE_enabled = 1
end

function SelectChoiceBlue(nChoice)
    if BLUE_enabled == 0 then return end

    for i = 1, 9 do
        local TriggerName = "pingdet_BLUE_" .. i
        local PanelName   = "panel_select_BLUE_" .. i

        EntFire(TriggerName, "Kill", "", 0)

        if i ~= nChoice then
            EntFire(PanelName, "Open", "", 0)
        end
    end

    EntFire("@glados", "RunScriptCode", "GladosPlayVcd(32)", 0)
    EntFire("ping_instructor_hint_A_1", "EndHint", "", 0)
    EntFire("ping_instructor_hint_B_1", "EndHint", "", 0)
end

function SelectChoicesOrangeStart()
    for i = 1, 9 do
        local TriggerNameA = "pingdet_ORANGE_" .. i
        local PanelNameA   = "panel_select_ORANGE_" .. i

        EntFire(TriggerNameA, "Enable", "", 1)
        EntFire(PanelNameA, "Close", "", 0)
    end

    ORANGE_enabled = 1
end

function SelectChoiceOrange(nChoice)
    if ORANGE_enabled == 0 then return end

    for i = 1, 9 do
        local TriggerName = "pingdet_ORANGE_" .. i
        local PanelName   = "panel_select_ORANGE_" .. i

        EntFire(TriggerName, "Kill", "", 0)

        if i ~= nChoice then
            EntFire(PanelName, "Open", "", 0)
        end
    end

    EntFire("@glados", "RunScriptCode", "GladosPlayVcd(34)", 0)
    EntFire("ping_instructor_hint_A_2", "EndHint", "", 0)
    EntFire("ping_instructor_hint_B_2", "EndHint", "", 0)
end