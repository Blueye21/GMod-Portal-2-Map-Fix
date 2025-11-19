AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Hard Light Bridge Projected"
ENT.Category = "Portal 2"
ENT.Spawnable = false

ENT.Length = 0
ENT.Enabled = true
ENT.Width = 48   -- slightly narrower than before
ENT.Thickness = 4

if CLIENT then
    ENT.BridgeMaterial = Material("effects/blueblacklargebeam") -- glowy beam material
end

function ENT:Initialize()
    if CLIENT then return end

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetCollisionGroup(COLLISION_GROUP_NONE)
    self:SetSaveValue("gmod_allowphysgun", "0")

    -- initialize physics with a tiny box so it has a physobj
    self:PhysicsInitBox(Vector(0, -self.Width / 2, -self.Thickness / 2),
                        Vector(1, self.Width / 2, self.Thickness / 2))
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(false)
    end

    self:NextThink(CurTime())
end

function ENT:Think()
    local maxLen = 4096
    local tr = util.TraceLine({
        start = self:GetPos(),
        endpos = self:GetPos() + self:GetAngles():Forward() * maxLen,
        mask = MASK_SOLID_BRUSHONLY
    })

    local newLength = maxLen * tr.Fraction
    if math.abs(newLength - self.Length) > 1 then
        self.Length = newLength

        -- Update collision bounds + physics to match length
        local mins = Vector(0, -self.Width / 2, -self.Thickness / 2)
        local maxs = Vector(self.Length, self.Width / 2, self.Thickness / 2)

        self:SetCollisionBounds(mins, maxs)
        self:PhysicsInitBox(mins, maxs)

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:EnableMotion(false)
        end

        self:SetRenderBounds(mins, maxs)
    end

    self:NextThink(CurTime() + 0.05) -- 20Hz update rate
    return true
end

if CLIENT then
    function ENT:Draw()
        local ang = self:GetAngles()
        local pos = self:GetPos()

        local mins = Vector(0, -self.Width / 2, -self.Thickness / 2)
        local maxs = Vector(self.Length, self.Width / 2, self.Thickness / 2)

        render.SetMaterial(self.BridgeMaterial)
        render.DrawBox(pos, ang, mins, maxs, Color(0, 200, 255, 180))

        -- Optionally, draw a glow at the end
        local endPos = pos + ang:Forward() * self.Length
        render.SetMaterial(Material("sprites/light_glow02_add"))
        render.DrawSprite(endPos, 32, 32, Color(0, 200, 255, 200))
    end
end