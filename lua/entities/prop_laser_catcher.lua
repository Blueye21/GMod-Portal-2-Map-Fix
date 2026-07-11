AddCSLuaFile()

ENT.Type      = "anim"
ENT.Base      = "base_anim"

ENT.PrintName = "Laser Catcher"
ENT.Category  = "Portal 2"
ENT.Spawnable = true

ENT.Skin          = 0
ENT.Model         = "models/props/laser_catcher.mdl"
ENT.LaserHoldTime = 0.1

ENT.Shining      = false
ENT.ShineEndTime = 0

function ENT:KeyValue(k, v)
    if k == "OnPowered" or k == "OnUnpowered" then
        self:StoreOutput(k, v)
        return
    end

    if k == "model" then
        self.Model = v
    elseif k == "skin" then
        self.Skin = tonumber(v)
    end
end

function ENT:Initialize()
    if CLIENT then return end

    self:SetModel(self.Model)
    self:SetSkin(self.Skin)
    local rust = false
    if self.Skin == 2 then
        rust = true
    end
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

function ENT:Think()
    if CLIENT then return end

    if self.Shining and self.ShineEndTime <= CurTime() then
        self.Shining = false
        self:TriggerOutput("OnUnpowered")
        if rust then 
            self:SetSkin(2)
        else
            self:SetSkin(0)
        end
        self:SetSequence(self:LookupSequence("idle"))
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
    if rust then
        self:SetSkin(3)
    else
        self:SetSkin(1)
    end
    self:SetSequence(self:LookupSequence("spin"))
end