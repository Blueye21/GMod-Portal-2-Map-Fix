AddCSLuaFile()

ENT.Type        = "anim"
ENT.Base        = "base_anim"

ENT.PrintName   = "Testchamber Door"
ENT.Category    = "Portal 2"
ENT.Spawnable   = true

ENT.AutomaticFrameAdvance = true

function ENT:Initialize()
    if CLIENT then return end

    self:SetModel("models/props/portal_door_combined.mdl")
    self:ResetSequence("idleclose")
end

function ENT:KeyValue(key, value)
    if key == "OnOpen" or key == "OnClose" then
        self:StoreOutput(key, value)
    end
end

function ENT:AcceptInput(inputName, activator, caller, data)
    if inputName == "Open" then
        self:Open()
    elseif inputName == "Close" then
        self:Close()
    end
end

function ENT:Open()
    self:ResetSequenceInfo()
    self:ResetSequence("Open")
    self:EmitSound("plats/door_round_blue_unlock_01.wav")
    self:TriggerOutput("OnOpen", self)
end

function ENT:Close()
    self:ResetSequenceInfo()
    self:ResetSequence("Close")
    self:EmitSound("plats/door_round_blue_lock_01.wav")
    self:TriggerOutput("OnClose", self)
end

function ENT:Think()
    self:NextThink(CurTime())
    return true
end