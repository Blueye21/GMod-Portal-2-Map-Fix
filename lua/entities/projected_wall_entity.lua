AddCSLuaFile()

ENT.Type            = "anim"
ENT.Base            = "base_anim"
ENT.PrintName       = "Hard Light Bridge Projected"
ENT.Category        = "Portal 2"
ENT.Spawnable       = true
ENT.RenderGroup     = RENDERGROUP_BOTH          -- always draw, even through portal rooms

--------------------------------------------------------------------
--  Client / server shared
--------------------------------------------------------------------
ENT.Length          = 0
ENT.Enabled         = true

--------------------------------------------------------------------
--  Precache everything once
--------------------------------------------------------------------
local MAT_BRIDGE    = Material("color")         -- cheap emissive
local BRIDGE_WIDTH  = 32
local BRIDGE_HEIGHT = 2
local MAX_TRACE     = 4096

--------------------------------------------------------------------
--  Initialize
--------------------------------------------------------------------
function ENT:Initialize()
    -- Physics only on server
    if SERVER then
        self:SetSolid(SOLID_BBOX)
        self:SetMoveType(MOVETYPE_NONE)
        hook.Add("PhysgunPickup", "NoPickup_ProjectedWall", function(ply, ent)
            if ent:GetClass() == "projected_wall_entity" then
                return false
            end
        end)
        self:DrawShadow(false)
    end

    -- Start thinking next tick
    self:NextThink(CurTime())
    return true
end

--------------------------------------------------------------------
--  Server-side think: extend bridge until we hit something
--------------------------------------------------------------------
function ENT:Think()
    local dir   = self:GetForward()
    local trace = util.TraceLine{
        start  = self:GetPos(),
        endpos = self:GetPos() + dir * MAX_TRACE,
        filter = self
    }

    self.Length = MAX_TRACE * trace.Fraction

    -- Resize physics and visual bounds in one call
    self:SetCollisionBounds(
        Vector(0, -BRIDGE_WIDTH, -BRIDGE_HEIGHT),
        Vector(self.Length, BRIDGE_WIDTH, BRIDGE_HEIGHT)
    )

    self:NextThink(CurTime())
    return true
end

--------------------------------------------------------------------
--  Client-side draw
--------------------------------------------------------------------
function ENT:Draw()
    local len = self.Length
    if len <= 0 then return end

    -- Only update render bounds when length actually changes
    if self._lastLength ~= len then
        self:SetRenderBounds(
            Vector(0, -BRIDGE_WIDTH, -BRIDGE_HEIGHT),
            Vector(len, BRIDGE_WIDTH, BRIDGE_HEIGHT)
        )
        self._lastLength = len
    end

    local pos = self:GetPos()
    local ang = self:GetAngles()

    render.SetMaterial(MAT_BRIDGE)
    render.DrawBox(
        pos, ang,
        Vector(0, -BRIDGE_WIDTH, -BRIDGE_HEIGHT),
        Vector(len, BRIDGE_WIDTH, BRIDGE_HEIGHT),
        color_white
    )
end