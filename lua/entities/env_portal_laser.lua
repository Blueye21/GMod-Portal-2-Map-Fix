AddCSLuaFile()

ENT.Type        = "anim"
ENT.Base        = "base_anim"

ENT.PrintName   = "Laser Emitter"
ENT.Category    = "Portal 2"
ENT.Spawnable   = true
ENT.RenderGroup = RENDERGROUP_BOTH

ENT.Model       = "models/props/laser_emitter.mdl"

-- Config
local LASER_MODEL        = "models/props/laser_emitter.mdl"
local LASER_OFFSET       = 14
local LASER_RANGE        = 25000
local LASER_BEAM_WIDTH   = 5
local LASER_DAMAGE       = 10
local LASER_DAMAGE_DELAY = 0.2

local LASER_MATERIAL     = Material("cable/redlaser")
local LASER_COLOR        = Color(255, 255, 255, 255)

if CLIENT then
    language.Add("env_portal_laser", "Laser Beam")
end

/*
    MODELS
    models/props/laser_emitter_center.mdl
    models/props/laser_emitter.mdl
*/

function ENT:Initialize()
    if CLIENT then
        -- Big render bounds so the beam is always considered visible
        self:SetRenderBounds(
            Vector(-32768, -32768, -32768),
            Vector( 32768,  32768,  32768)
        )
        return
    end

    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetUseType(SIMPLE_USE)

    self.NextDamageTime = 0
end

function ENT:KeyValue(key, value)
    if key == "model" then
        self.Model = value
    end
end

-- Centralized trace calculation so Think() and Draw() share logic
-- Returns startPos, traceResult
function ENT:GetLaserTrace()
    local startPos = self:GetPos()

    if self:GetModel() == LASER_MODEL then
        startPos = startPos - self:GetUp() * LASER_OFFSET
    end

    local tr = util.TraceLine({
        start  = startPos,
        endpos = startPos + self:GetForward() * LASER_RANGE,
        filter = self
    })

    return startPos, tr
end

function ENT:Think()
    local curTime = CurTime()

    local startPos, tr = self:GetLaserTrace()
    local hitEnt       = tr.Entity
    local hitPos       = tr.HitPos
    local hitNormal    = tr.HitNormal
    local shouldDoParticle = true

    if IsValid(hitEnt) then
        -- Let the hit entity optionally control whether spark effects play
        if hitEnt.OnShineByLaser ~= nil then
            shouldDoParticle = hitEnt:OnShineByLaser(self)
        end

        if SERVER and not hitEnt:IsWorld() and curTime >= (self.NextDamageTime or 0) then
            local isPlayer = hitEnt:IsPlayer()
            local isNPC    = hitEnt:IsNPC()
            local class    = isNPC and hitEnt:GetClass() or ""

            -- Players & NPCs (except floor turrets) take direct damage
            if ((isNPC and class ~= "npc_turret_floor") or isPlayer) then
                if hitEnt:Health() > 0 then
                    hitEnt:TakeDamage(LASER_DAMAGE, self, self)
                    hitEnt:EmitSound("HL2Player.BurnPain")
                    self.NextDamageTime = curTime + LASER_DAMAGE_DELAY
                end

            -- Floor turret special case: ignite and self destruct once
            elseif isNPC and class == "npc_turret_floor" then
                if not hitEnt.TurretP2SelfDestructing then
                    hitEnt:Ignite(math.huge, 0)
                    hitEnt:Fire("SelfDestruct")
                    hitEnt.TurretP2SelfDestructing = true
                end
            end
        end
    end

    -- Only spawn effects on the server so they get networked properly
    if SERVER and shouldDoParticle and hitPos and hitNormal then
        local ed = EffectData()
        ed:SetOrigin(hitPos)
        ed:SetAngles(hitNormal:Angle())
        ed:SetNormal(hitNormal)
        ed:SetMagnitude(1)
        util.Effect("ElectricSpark", ed, true, true)
    end

    self:NextThink(curTime)
    return true
end

function ENT:Draw()
    self:DrawModel()

    local startPos, tr = self:GetLaserTrace()
    if not tr or not tr.HitPos then return end

    render.SetMaterial(LASER_MATERIAL)
    render.DrawBeam(startPos, tr.HitPos, LASER_BEAM_WIDTH, 0, 1, LASER_COLOR)
end
