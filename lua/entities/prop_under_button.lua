AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Underground Button"
ENT.Category = "Portal 2"
ENT.Spawnable = true

ENT.AutomaticFrameAdvance = true

ENT.delay = 1
ENT.istimer = false
ENT.preventfastreset = false
ENT.skin = 0
ENT.locked = false

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel("models/props_underground/underground_testchamber_button.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetUseType(SIMPLE_USE)
end

function ENT:AcceptInput(inputName, activator, caller, param)
    string.lower(inputName)
    if inputName == "press" then
        ENT:Use(activator)
    end
    if inputName == "lock" then
        self.locked = true
    end
    if inputName == "unlock" then
        self.locked = false 
    end
    if inputname == "cancelpress" then
        self:ResetSequence( "Release" )
        self.Timing = false
    end
end

function ENT:KeyValue(k, v)
    string.lower(k)
    if k == "delay" then
        self.Delay = tonumber(v)
    end
    if k == "istimer" then
        self.istimer = v
    end
    if k == "preventfastreset" then
        self.preventfastreset = v
    end
    if k == "skin" then
        self:SetSkin(tonumber(v))
    end
    if k == "OnPressed" or k == "OnPressedBlue" or k == "OnPressedOrange" or k == "OnButtonReset" then
        self:StoreOutput(k, v)
    end
end

function ENT:Use(activator)
    if self.locked then return end
    if self.Timing then return end
    self:ResetSequence( "Press" )
    self:TriggerOutput("OnPressed",activator)
    self.Timing = true
    self.ResetTime = CurTime() + self.Delay
end

function ENT:Think()
    if self.Timing and self.Delay >= 0 then
        if self.ResetTime <= CurTime() then
            self:ResetSequence( "Release" )
            self:TriggerOutput("OnButtonReset",self)
            self.Timing = false
        end 
    end
    self:NextThink(CurTime())
    return true
end