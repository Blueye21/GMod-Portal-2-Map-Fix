AddCSLuaFile()

ENT.Type      = "anim"
ENT.Base      = "base_anim"

ENT.PrintName = "Weighted Storage Cube"
ENT.Category  = "Portal 2"
ENT.Spawnable = true

ENT.CubeType       = 0          -- 0 = standard, 1 = companion, 2 = reflection
ENT.Shining        = false
ENT.ShineEndTime   = 0
ENT.NextDamageTime = 0
ENT.IsReflective   = false      -- only reflection cube can reflect

-- Cube type configuration:
-- 0: Standard cube   (metal_box, skin 0)
-- 1: Companion cube  (metal_box, skin 1)
-- 2: Reflection cube (reflection_cube, skin 0, reflective)
local CubeConfig = {
    [0] = {
        model      = "models/props/metal_box.mdl",
        skin       = 0,
        reflective = false
    },
    [1] = {
        model      = "models/props/metal_box.mdl",
        skin       = 1,
        reflective = false
    },
    [2] = {
        model      = "models/props/reflection_cube.mdl",
        skin       = 0,
        reflective = true
    }
}

if CLIENT then
    language.Add("prop_weighted_cube", "Weighted Storage Cube")
    killicon.Add("prop_weighted_cube", "killicons/prop_weighted_cube", Color(255, 80, 0, 200))
end

function ENT:ApplyCubeType()
    -- Normalize / clamp CubeType
    local t = tonumber(self.CubeType) or 0
    if t < 0 then t = 0 end
    if t > 2 then t = 0 end  -- clamp to valid range

    self.CubeType = t

    local cfg = CubeConfig[t] or CubeConfig[0]

    self:SetModel(cfg.model)
    self:SetSkin(cfg.skin or 0)
    self.IsReflective = cfg.reflective or false
end

function ENT:Initialize()
    if SERVER then
        self:ApplyCubeType()

        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:SetMass(120)
            phys:Wake()
        end
    end
end

function ENT:PhysicsCollide(colData, collider)
    if colData.Speed < 150 then return end

    if SERVER then
        local volume = math.Clamp(colData.Speed / 1000, 0, 1)
        self:EmitSound("P2SolidMetal.ImpactHard", 65, 100, volume)
    end
end

function ENT:KeyValue(key, value)
    if key == "CubeType" then
        self.CubeType = tonumber(value) or 0
        -- Safe to apply immediately; Initialize will re-apply too.
        self:ApplyCubeType()
    end
end

-- Shared trace table to reduce allocations
local traceData = {
    start  = nil,
    endpos = nil,
    filter = nil
}

function ENT:Think()
    -- Only reflection cubes can reflect / shine at all
    if not self.IsReflective or not self.Shining then return end

    local ct = CurTime()

    -- Stop shining when timer expires
    if self.ShineEndTime <= ct then
        self.Shining = false
        return
    end

    local startPos = self:GetPos()
    local forward  = self:GetAngles():Forward()

    traceData.start  = startPos
    traceData.endpos = startPos + forward * 25000
    traceData.filter = self

    local tr = util.TraceLine(traceData)

    local hitEnt    = tr.Entity
    local hitPos    = tr.HitPos
    local hitNormal = tr.HitNormal

    local shouldDoParticle = true

    if IsValid(hitEnt) then
        -- Let the hit entity react to the laser (catchers, etc.)
        if hitEnt.OnShineByLaser ~= nil then
            -- If returning false explicitly, caller can suppress particles
            shouldDoParticle = hitEnt:OnShineByLaser(self) ~= false
        end

        if SERVER and not hitEnt:IsWorld() and hitEnt:Health() > 0 and self.NextDamageTime <= ct then
            local isTurret      = (hitEnt:GetClass() == "npc_turret_floor")
            local isNPCOrPlayer = hitEnt:IsNPC() or hitEnt:IsPlayer()

            if (not isTurret and isNPCOrPlayer) then
                hitEnt:TakeDamage(10, self, self)
                hitEnt:EmitSound("HL2Player.BurnPain")
                self.NextDamageTime = ct + 0.2
            else
                if hitEnt.TurretP2SelfDestructing == nil then
                    hitEnt:Ignite(math.huge, 0)
                    hitEnt:Fire("SelfDestruct")
                    hitEnt.TurretP2SelfDestructing = true
                end
            end
        end
    end

    if shouldDoParticle then
        local ed = EffectData()
        ed:SetOrigin(hitPos)
        ed:SetAngles(hitNormal:Angle())
        ed:SetNormal(hitNormal)
        ed:SetMagnitude(1)
        util.Effect("ElectricSpark", ed)
    end

    self:NextThink(ct)
    return true
end

function ENT:Draw()
    self:DrawModel()

    -- Only reflection cubes, and only while shining, draw the laser
    if not self.IsReflective or not self.Shining then return end

    self:SetRenderBounds(
        Vector(-99999, -99999, -99999),
        Vector( 99999,  99999,  99999)
    )

    local startPos = self:GetPos()
    local tr = util.TraceLine({
        start  = startPos,
        endpos = startPos + self:GetAngles():Forward() * 25000,
        filter = self
    })

    render.SetMaterial(Material("cable/redlaser"))
    render.DrawBeam(startPos, tr.HitPos, 5, 0, 0, Color(255, 255, 255, 255))
end

function ENT:OnShineByLaser(laser)
    -- Non-reflection cubes do not reflect lasers at all
    if not self.IsReflective then return end

    -- Extend shine for 0.1s after each hit
    self.ShineEndTime = CurTime() + 0.1
    if self.Shining then return end
    self.Shining = true
end