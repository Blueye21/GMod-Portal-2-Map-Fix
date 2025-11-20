AddCSLuaFile()

ENT.Type      = "anim"
ENT.Base      = "base_anim"

ENT.PrintName = "Laser Catcher"
ENT.Category  = "Portal 2"
ENT.Spawnable = true

ENT.Model         = "models/props/laser_catcher.mdl"
ENT.Skin          = 0
ENT.LaserHoldTime = 0.1  -- how long after last hit it stays "powered"

ENT.Shining      = false
ENT.ShineEndTime = 0

--[[
    Other models you might use:
    models/props/laser_emitter_center.mdl
    models/props/laser_emitter.mdl
]]

function ENT:Initialize()
    if CLIENT then return end

    self:SetModel(self.Model or ENT.Model)

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(false)
    end

    self.Shining      = false
    self.ShineEndTime = 0

    self:NextThink(CurTime())
end

function ENT:KeyValue(k, v)
    -- Allow Hammer I/O
    if k == "OnPowered" or k == "OnUnpowered" then
        self:StoreOutput(k, v)
        return
    end

    -- Allow overriding model from Hammer
    if k == "model" then
        self.Model = v

        -- If we've already initialized serverside, apply immediately
        if SERVER then
            self:SetModel(v)
        end
    end
end

function ENT:Think()
    if CLIENT then return end

    if self.Shining and self.ShineEndTime <= CurTime() then
        self.Shining = false
        self:TriggerOutput("OnUnpowered")
        self:SetSkin(0)
        local anim = self:LookupSequence("idle")
        self:ResetSequence(anim)
    end

    -- Keep thinking every tick while simple, cheap logic
    self:NextThink(CurTime())
    return true
end

-- Called externally when the laser hits this catcher
function ENT:OnShineByLaser(laser)
    if CLIENT then return end

    local now = CurTime()
    self.ShineEndTime = now + (self.LaserHoldTime or 0.1)

    -- If we were already shining, just extend the time
    if self.Shining then return end

    self.Shining = true
    self:TriggerOutput("OnPowered")
    self:SetSkin(1)
    local anim = self:LookupSequence("spin")
    self:ResetSequence(anim)
end