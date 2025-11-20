AddCSLuaFile()

ENT.Type      = "anim"
ENT.Base      = "base_anim"

ENT.PrintName = "Hard Light Bridge Projected"
ENT.Category  = "Portal 2"
ENT.Spawnable = true

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

-- constants
local BRIDGE_HALF_WIDTH  = 32
local BRIDGE_HALF_THICK  = 2
local BRIDGE_MAX_LENGTH  = 4096

local BOUNDS_MIN = Vector(0, -BRIDGE_HALF_WIDTH, -BRIDGE_HALF_THICK)
local BOUNDS_MAX = Vector(0,  BRIDGE_HALF_WIDTH,  BRIDGE_HALF_THICK)
local BRIDGE_COLOR = Color(0, 255, 255, 255)

-- reusable trace table (avoids allocations each Think)
local traceData = {}

function ENT:Initialize()
    if SERVER then
        self:SetSolid(SOLID_BBOX)
        self:SetMoveType(MOVETYPE_NONE)
        self:SetSaveValue("gmod_allowphysgun", "0")

        -- start with zero-length bridge
        self.Length = 0
        self:SetCollisionBounds(BOUNDS_MIN, BOUNDS_MAX)

        self:NextThink(CurTime())
    else -- CLIENT
        self.Length = 0
        self:SetRenderBounds(BOUNDS_MIN, BOUNDS_MAX)
        self:DrawShadow(false)
    end
end

if CLIENT then

    function ENT:Draw()
        local length = self.Length or 0

        -- update render bounds for culling
        self:SetRenderBounds(
            BOUNDS_MIN,
            Vector(length, BRIDGE_HALF_WIDTH, BRIDGE_HALF_THICK)
        )

        render.SetColorMaterial() -- cheaper than Material("Color") every frame
        render.DrawBox(
            self:GetPos(),
            self:GetAngles(),
            BOUNDS_MIN,
            Vector(length, BRIDGE_HALF_WIDTH, BRIDGE_HALF_THICK),
            BRIDGE_COLOR
        )
    end

else -- SERVER

    function ENT:Think()
        local pos = self:GetPos()
        local dir = self:GetAngles():Forward()

        traceData.start  = pos
        traceData.endpos = pos + dir * BRIDGE_MAX_LENGTH
        traceData.filter = self -- avoid hitting ourselves

        local tr = util.TraceLine(traceData)
        local length = BRIDGE_MAX_LENGTH * tr.Fraction

        self.Length = length

        -- update collision box to match new length
        self:SetCollisionBounds(
            BOUNDS_MIN,
            Vector(length, BRIDGE_HALF_WIDTH, BRIDGE_HALF_THICK)
        )

        self:NextThink(CurTime())
        return true
    end

end