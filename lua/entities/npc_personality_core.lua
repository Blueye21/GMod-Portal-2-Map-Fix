AddCSLuaFile()

ENT.Type            = "ai"
ENT.Base            = "base_anim"

ENT.PrintName       = "Personality Core"
ENT.Category        = "Portal 2"
ENT.Spawnable       = true
ENT.AutomaticFrameAdvance = true

ENT.altmodel        = 0

if CLIENT then
    language.Add("npc_personality_core", "Personality Core")
end

function ENT:KeyValue(key, value)
    if key == "ModelSkin" then
        local num = tonumber(value)
        if num then self:SetSkin(num) end
    elseif key == "altmodel" then
        self.altmodel = value
    end
end

function ENT:Initialize()
    if CLIENT then return end

    -- Choose model based on altmodel value
    if tostring(self.altmodel) == "1" then
        self:SetModel("models/npcs/personality_sphere/personality_sphere_skins.mdl")
    else
        self:SetModel("models/npcs/personality_sphere/personality_sphere.mdl")
    end

    self:ResetSequence("sphere_idle_neutral")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysWake()
    self:SetUseType(SIMPLE_USE)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE)
end

function ENT:Use(activator, caller)
    if IsValid(activator) and activator:IsPlayer() then
        activator:PickupObject(self)
    end
end

function ENT:AcceptInput(name, activator, caller, data)
    if name == "SetIdleSequence" then
        if isstring(data) and data ~= "" then
            self:ResetSequence(data)
        end
    elseif name == "ClearIdleSequence" then
        self:ResetSequence("sphere_idle_neutral")
    elseif name == "PlayAttach" then
        self:ResetSequence("sphere_plug_attach")
    elseif name == "PlayLock" then
        self:ResetSequence("sphere_plug_lock")
    end
end

function ENT:Think()
    self:NextThink(CurTime())
    return true
end

function ENT:PhysicsCollide(data, collider)
    -- Play impact sound only on meaningful collisions
    if data.Speed >= 150 then
        local volume = math.Clamp(data.Speed / 1000, 0.2, 1)
        self:EmitSound("P2SolidMetal.ImpactHard", 65, 100, volume)
    end
end
