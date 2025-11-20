AddCSLuaFile()

ENT.Type      = "anim"
ENT.Base      = "base_anim"
ENT.PrintName = "Test-chamber Door"
ENT.Category  = "Portal 2"
ENT.Spawnable = true

ENT.AutomaticFrameAdvance = true          -- Keep animations running

------------------------------------------------------------------------------------------------------------------------
-- SERVER-side only from here on
------------------------------------------------------------------------------------------------------------------------
if CLIENT then return end

local OPEN_SOUND  = Sound("plats/door_round_blue_unlock_01.wav")
local CLOSE_SOUND = Sound("plats/door_round_blue_lock_01.wav")

function ENT:Initialize()
    self:SetModel("models/props/portal_door_combined.mdl")
    self:ResetSequence(self:LookupSequence("idleclose"))
end

------------------------------------------------------------------------------------------------------------------------
-- Hammer I/O
------------------------------------------------------------------------------------------------------------------------
function ENT:KeyValue(key, value)
    if key == "OnOpen" or key == "OnClose" then
        self:StoreOutput(key, value)
    end
end

function ENT:AcceptInput(name, activator, caller, data)
    name = name:lower()

    if name == "open" then
        self:Open()
        return true
    elseif name == "close" then
        self:Close()
        return true
    end
end

------------------------------------------------------------------------------------------------------------------------
-- Public API
------------------------------------------------------------------------------------------------------------------------
function ENT:Open()
    self:ResetSequence(self:LookupSequence("Open"))
    self:EmitSound(OPEN_SOUND)
    self:TriggerOutput("OnOpen")
end

function ENT:Close()
    self:ResetSequence(self:LookupSequence("Close"))
    self:EmitSound(CLOSE_SOUND)
    self:TriggerOutput("OnClose")
end

------------------------------------------------------------------------------------------------------------------------
-- Animation tick
------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
    self:NextThink(CurTime())
    return true
end