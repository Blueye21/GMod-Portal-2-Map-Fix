-- ==========================================================
--  CONFIGURATION CONSTANTS
-- ==========================================================
local PANEL_DELAY      = 0.35
local PANEL_COUNT      = 57
local EXIT_PANEL_COUNT = 3
local ARM_COUNT        = 61

-- Special doors --------------------------------------------------------------
local SPECIAL = {
    closeDoor1  = 28,
    closeDoor2  = 29,
    farDoor1    = 25,
    farDoor2    = 26,
    finalDoor1  = 33,
    finalDoor2  = 61
}

-- ==========================================================
--  INTERNAL HELPERS
-- ==========================================================
local function shuffle(t, n)          -- Fisher–Yates, 1-based
    for i = 1, n do
        local j = math.random(i, n)
        t[i], t[j] = t[j], t[i]
    end
end

local function entsByDoor(doorNum)
    return ents.FindByName(("door_%d-shutter_door"):format(doorNum))
end

local function fireSequenced(list, cmd, value, baseDelay, stepDelay)
    for idx, doorNum in ipairs(list) do
        local delay = baseDelay + (idx - 1) * stepDelay
        for _, ent in ipairs(entsByDoor(doorNum)) do
            ent:Fire(cmd, value, delay)
        end
    end
end

-- ==========================================================
--  OLD FUNCTION NAMES  (unchanged public interface)
-- ==========================================================
function CloseCeilingOld()
    local order = {}
    for i = 1, PANEL_COUNT do order[i] = i end

    shuffle(order, PANEL_COUNT - EXIT_PANEL_COUNT)   -- keep last 3 untouched
    fireSequenced(order, "Open", "", 0, PANEL_DELAY)
end

-- ------------------------------------------------------------------
-- Arm helpers – build entity names once, reuse everywhere
-- ------------------------------------------------------------------
local function armNames(num)
    local prefix = "sealin_" .. num
    return {
        bottomArm   = prefix .. "-arm_1",
        topArm      = prefix .. "-arm_2",
        bottomPanel = prefix .. "-panel_1",
        topPanel    = prefix .. "-panel_2"
    }
end

local function isSpecial(num)
    for _, v in pairs(SPECIAL) do if num == v then return true end end
    return false
end

-- ------------------------------------------------------------------
function SealOneArm(armNum, delay)
    local n = armNames(armNum)
    local variation = math.Rand(-0.2, 0.2)

    -- top arm – always the same ------------------------------------------------
    EntFire(n.topArm,    "setanimationnoreset", "block_upper01_drop", 0 + delay)
    EntFire(n.topArm,    "setanimationnoreset", "block_upper01_grabpanel", 1 + delay)
    EntFire(n.topPanel,  "setparent", n.topArm, 1.5 + delay)
    EntFire(n.topPanel,  "setparentattachment", "panel_attach", 1.5 + delay)
    EntFire(n.topPanel,  "clearparent", "", 3.5 + delay)

    -- bottom arm – conditional -----------------------------------------------
    if not isSpecial(armNum) and armNum % 3 ~= 0 then
        EntFire(n.bottomArm,   "setanimationnoreset", "block_lower01_drop", 0 + delay)
        EntFire(n.bottomArm,   "setanimationnoreset", "block_lower01_grabpanel", 1 + delay)
        EntFire(n.bottomPanel, "setparent", n.bottomArm, 1.5 + delay)
        EntFire(n.bottomPanel, "setparentattachment", "panel_attach", 1.5 + delay)
        EntFire(n.bottomArm,   "setanimationnoreset", "block_lower01_pushforward", 2 + delay)
        EntFire(n.topArm,      "setanimationnoreset", "block_upper01_pushforward", 2 + delay + variation)
    else
        EntFire(n.topArm,    "setanimationnoreset", "block_upper02_abovestairs", 2 + delay)
        EntFire(n.bottomArm, "kill", "", 0)
    end
end

-- ------------------------------------------------------------------
function Seal()
    local timer = 0
    for i = 1, ARM_COUNT do
        if i == 34 then timer = 0 end                 -- reset after door 33

        local count = i > 33 and (i - 34) or i
        timer = timer + (i > 33 and 0.02 or 0.014) * count

        SealOneArm(i, timer)
    end
end

-- ------------------------------------------------------------------
-- One-liners that previously spanned pages
-- ------------------------------------------------------------------
local function iterArms(fn)
    for i = 1, ARM_COUNT do fn(i) end
end

function Setup()        iterArms(SetArmIdle) end
function Cleanup()      iterArms(CleanUpArm) end
function ShowDoors()    iterArms(function(i) EnableArm(i, true)  end) end
function HideDoors()    iterArms(function(i) EnableArm(i, false) end) end

function SetArmIdle(num)
    local n = armNames(num)
    EntFire(n.bottomArm, "setanimationnoreset", "block_lower01_drop_idle")
    EntFire(n.topArm,    "setanimationnoreset", "block_upper01_drop_idle")
end

function CleanUpArm(num)
    local n = armNames(num)
    EntFire(n.topArm,    "kill")
    EntFire(n.topPanel,  "kill")
    EntFire(n.bottomArm, "kill")
    EntFire(n.bottomPanel,"kill")
end

function EnableArm(num, on)
    local n = armNames(num)
    local cmd = on and "Enable" or "Disable"
    EntFire(n.topArm, cmd)
    EntFire(n.topPanel, cmd)
    EntFire(n.bottomArm, cmd)
    EntFire(n.bottomPanel, cmd)
end

-- ------------------------------------------------------------------
-- Special-door helpers (still used by map logic)
-- ------------------------------------------------------------------
function CloseFirstDoor()  SPECIAL.closeDoor1, SPECIAL.closeDoor2 = -1, -1 end
function CloseSecondDoor() SPECIAL.farDoor1,   SPECIAL.farDoor2   = -1, -1 end

function TryCloseFinalDoors()
    for _, v in pairs(SPECIAL) do
        if v ~= -1 then SealOneArm(v, 0) end
    end
end