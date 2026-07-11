AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Button"
ENT.Category = "Portal 2"
ENT.Spawnable = true

ENT.Delay = 1.0
ENT.istimer = false
ENT.skin = 0

ENT.Timing = false
ENT.ResetTime = 0

function ENT:KeyValue(k, v)
    if k == "OnPressed" or k == "OnButtonReset" then
        self:StoreOutput(k, v)
    end
    if k == "Delay" then
        self.Delay = tonumber(v)
    elseif k == "istimer" then
        self.istimer = v
    elseif k == "skin" then
        self.skin = tonumber(v)
    end
end

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel("models/props/switch001.mdl")
    self:SetSkin(self.skin)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetUseType(SIMPLE_USE)
end

function ENT:Use(activator)
    if self.Timing then return end
    self:ResetSequence(self:LookupSequence("down"))
    self:TriggerOutput("OnPressed",activator)
    self:EmitSound("buttons/button_synth_positive_01.wav")
    self.Timing = true
    self.ResetTime = CurTime() + self.Delay
end

ENT.AutomaticFrameAdvance = true
function ENT:Think()
    self:OnCustomThink()
    self:NextThink(CurTime())
    return true
end

function ENT:OnCustomThink()
    if self.Timing and self.Delay >= 0 then
        if CurTime() > self.ResetTime then
            self:ResetSequence(self:LookupSequence("up"))
            self:EmitSound("buttons/button_synth_negative_02.wav")
            self:TriggerOutput("OnButtonReset",self)
            self.Timing = false
        end 
    end
end