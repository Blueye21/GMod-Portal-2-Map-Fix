AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Testchamber Door"
ENT.Category = "Portal 2"
ENT.Spawnable = true

-- Hammer Keyvalues
ENT.AreaPortalWindow = ""
ENT.UseAreaPortalFade = false 
ENT.AreaPortalFadeStart = 0.0
ENT.AreaPortalFadeEnd = 0.0
-- Logic Variables
ENT.Locked = false

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel("models/props/portal_door_combined.mdl")
    self:SetSequence("idleclose")
end

function ENT:KeyValue(k,v)
    if k == "AreaPortalWindow" then self.AreaPortalWindow = v end
    if k == "UseAreaPortalFade" then self.UseAreaPortalFade = v == "1" end
    if k == "AreaPortalFadeStart" then self.AreaPortalFadeStart = tonumber(v) end
    if k == "AreaPortalFadeEnd" then self.AreaPortalFadeEnd = tonumber(v) end
    if k == "OnOpen" or k == "OnClose" or k == "OnFullyOpen" or k == "OnFullyClosed" then
        self:StoreOutput(k, v)
    end
end

function ENT:AcceptInput(inp,act,call,data)
    if inp == "Open" then
        self:Open()
    end
    if inp == "Close" then
        self:Close()
    end
    if inp == "LockOpen" then
        self:Open()
        self.Locked = true 
    end
    if inp == "Lock" then
        self.Locked = true 
    end
    if inp == "Unlock" then
        self.Locked = false
    end
end

function ENT:Open()
    self:ResetSequenceInfo()
    self:ResetSequence("Open")
    self:EmitSound("plats/door_round_blue_unlock_01.wav")
    self:TriggerOutput("OnOpen")
    timer.Simple(self:SequenceDuration(), function()
        if IsValid(self) then
            self:TriggerOutput("OnFullyOpen")
        end
    end)
end

function ENT:Close()
    self:ResetSequenceInfo()
    self:ResetSequence("Close")
    self:EmitSound("plats/door_round_blue_lock_01.wav")
    self:TriggerOutput("OnClose")
    timer.Simple(self:SequenceDuration(), function()
        if IsValid(self) then
            self:TriggerOutput("OnFullyClosed")
        end
    end)
end

ENT.AutomaticFrameAdvance = true
function ENT:Think()
    self:NextThink(CurTime())
    return true
end