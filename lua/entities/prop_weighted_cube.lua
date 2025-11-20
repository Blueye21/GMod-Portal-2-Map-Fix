AddCSLuaFile()

ENT.Type      = "anim"
ENT.Base      = "base_anim"

ENT.PrintName = "Weighted Storage Cube"
ENT.Category  = "Portal 2"
ENT.Spawnable = true

-- 0–4, mapped to CubeModels
ENT.CubeType       = 0
ENT.CubeSkin       = 0

ENT.Shining        = false
ENT.ShineEndTime   = 0
ENT.NextDamageTime = 0

-- Use a compact table literal
local CubeModels = {
    "models/props/metal_box.mdl",   -- 0
    "models/props/metal_box.mdl",   -- 1
    "models/props/reflection_cube.mdl", -- 2
    "models/props/metal_box.mdl",   -- 3
    "models/props/metal_box.mdl"    -- 4
}

if CLIENT then
    language.Add("prop_weighted_cube", "Weighted Storage Cube")
    killicon.Add("prop_weighted_cube", "killicons/prop_weighted_cube", Color(255, 80, 0, 200))
end

local TRACE_DISTANCE = 25000
local LASER_DAMAGE   = 10
local LASER_TICK     = 0.2
local LASER_BEAM_SIZE = 5

-----------------------------------------------------------------------
-- Helpers
-----------------------------------------------------------------------

local function GetCubeModelFromType(cubeType)
    -- Make sure it's numeric and in range
    cubeType = tonumber(cubeType) or 0
    cubeType = math.Clamp(cubeType, 0, #CubeModels - 1)
    if cubeType == 1 then
        local cubeSkin = 1
        return CubeModels[cubeType + 1], cubeType, cubeSkin
    end
    return CubeModels[cubeType + 1], cubeType
end

-----------------------------------------------------------------------
-- Init
-----------------------------------------------------------------------

function ENT:Initialize()
    if CLIENT then return end

    local model, cubeType, cubeSkin = GetCubeModelFromType(self.CubeType)
    self.CubeType = cubeType
    if cubeSkin ~= nil then
        self.CubeSkin = cubeSkin
        self:SetSkin(cubeSkin)
    end
    self:SetModel(model)

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:SetMass(120)
        phys:Wake()
    end

    -- Big render bounds only if we ever shine (safe to set once)
    self:SetCollisionBounds(Vector(-24, -24, -24), Vector(24, 24, 24))
end

-----------------------------------------------------------------------
-- KeyValues (Hammer)
-----------------------------------------------------------------------

function ENT:KeyValue(key, value)
    if key == "CubeType" then
        local model
        model, self.CubeType = GetCubeModelFromType(value)
        self:SetModel(model)
    end
end

-----------------------------------------------------------------------
-- Physics / Impact
-----------------------------------------------------------------------

function ENT:PhysicsCollide(colData, collider)
    if colData.Speed < 150 then return end
    self:EmitSound("SolidMetal.ImpactHard", 65, 100, colData.Speed / 1000)
end

-----------------------------------------------------------------------
-- Laser Logic (Shared Think)
-----------------------------------------------------------------------

function ENT:Think()
    if not self.Shining then return end

    local ct = CurTime()
    self:NextThink(ct)

    local pos    = self:GetPos()
    local forward = self:GetAngles():Forward()

    local tr = util.TraceLine({
        start  = pos,
        endpos = pos + forward * TRACE_DISTANCE,
        filter = self
    })

    self.LastLaserHitPos    = tr.HitPos
    self.LastLaserHitNormal = tr.HitNormal

    local shouldDoParticle = true

    if IsValid(tr.Entity) then
        local ent = tr.Entity

        -- Callback for other entities to react to the laser
        if ent.OnShineByLaser ~= nil then
            shouldDoParticle = ent:OnShineByLaser(self)
        end

        -- Damage / turret handling is server-side only
        if SERVER and not ent:IsWorld() and ent:Health() > 0 and self.NextDamageTime <= ct then
            -- (A and (B or C)) for correct precedence
            if ent:GetClass() ~= "npc_turret_floor" and (ent:IsNPC() or ent:IsPlayer()) then
                ent:TakeDamage(LASER_DAMAGE, self, self)
                ent:EmitSound("HL2Player.BurnPain")
                self.NextDamageTime = ct + LASER_TICK
            else
                -- Turrets
                if ent.TurretP2SelfDestructing == nil then
                    ent:Ignite(math.huge, 0)
                    ent:Fire("SelfDestruct")
                    ent.TurretP2SelfDestructing = true
                end
            end
        end
    end

    if shouldDoParticle and SERVER then
        local ed = EffectData()
        ed:SetOrigin(self.LastLaserHitPos or pos)
        ed:SetAngles((self.LastLaserHitNormal or vector_up):Angle())
        ed:SetNormal(self.LastLaserHitNormal or vector_up)
        ed:SetMagnitude(1)
        util.Effect("ElectricSpark", ed)
    end

    if self.ShineEndTime <= ct then
        self.Shining = false
    end

    return true
end

-----------------------------------------------------------------------
-- Draw (Client)
-----------------------------------------------------------------------

function ENT:Draw()
    self:DrawModel()

    if not self.Shining then return end

    local startPos = self:GetPos()
    local hitPos   = self.LastLaserHitPos or (startPos + self:GetAngles():Forward() * TRACE_DISTANCE)

    render.SetMaterial(Material("cable/redlaser"))
    render.DrawBeam(startPos, hitPos, LASER_BEAM_SIZE, 0, 0, color_white)
end

-----------------------------------------------------------------------
-- Laser Interaction
-----------------------------------------------------------------------

function ENT:OnShineByLaser(laser)
    -- if self.CubeType ~= 2 then return end -- 2 = Reflection (if you want that restriction again)
    self.ShineEndTime = CurTime() + 0.1
    if self.Shining then return end
    self.Shining = true
end
