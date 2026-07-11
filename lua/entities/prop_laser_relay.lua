AddCSLuaFile()

ENT.Type      = "anim"
ENT.Base      = "base_anim"
ENT.PrintName = "Laser Relay"
ENT.Category  = "Portal 2"
ENT.Spawnable = true

-- Default model (can still be overridden by Hammer keyvalue)
ENT.Model     = "models/props/laser_receptacle.mdl"

-- State
ENT.Shining     = false
ENT.ShineExpire = 0          -- renamed for clarity

function ENT:Initialize()
    if SERVER then
        self:SetModel(self.Model)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_NONE)
        self:SetUseType(SIMPLE_USE)
    end
end

-- Hammer I/O ----------------------------------------------------------
function ENT:KeyValue(key, value)
    key = key:lower()

    if key == "OnPowered" or key == "OnUnpowered" then
        self:StoreOutput(key, value)
    elseif key == "model" and value ~= "" then
        self.Model = value
    end
end
-----------------------------------------------------------------------

-- Think --------------------------------------------------------------
function ENT:Think()
    if SERVER and self.Shining and CurTime() >= self.ShineExpire then
        self.Shining = false
        self:TriggerOutput("OnUnpowered")
        if self:LookupSequence("idle") then
            self:SetSequence(self:LookupSequence("idle"))
        end
    end
end
-----------------------------------------------------------------------

-- Public API ---------------------------------------------------------
function ENT:OnShineByLaser(laser)
    if CLIENT then return end

    local now = CurTime()
    self.ShineExpire = now + 0.1

    if self.Shining then return end
    self.Shining = true
    self:TriggerOutput("OnPowered")
    if self:LookupSequence("spin") then
        self:SetSequence(self:LookupSequence("spin"))
    end
end
-----------------------------------------------------------------------