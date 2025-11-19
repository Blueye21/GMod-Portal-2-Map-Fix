AddCSLuaFile()

ENT.Type      = "anim"
ENT.Base      = "base_anim"

ENT.PrintName = "Hard Light Bridge"
ENT.Category  = "Portal 2"
ENT.Spawnable = true

ENT.m_pLightBridge = nil
ENT.Enabled        = false

function ENT:AcceptInput(inp, activator, caller, data)
    inp = string.lower(inp)
    if inp == "enable" then
        self:SetEnabled(true)
    elseif inp == "disable" then
        self:SetEnabled(false)
    elseif inp == "toggle" then
        self:SetEnabled(not self.Enabled)
    end
end

function ENT:SetEnabled(state)
    state = tobool(state)
    if self.Enabled == state then return end
    self.Enabled = state

    if self.Enabled then
        if GetConVar("developer"):GetBool() then
            print("[HLB] Enabling Light Bridge")
        end
        self:CreateBridge()
        self:EmitSound("ambient/energy/whiteflash.wav", 75, 120)
    else
        if GetConVar("developer"):GetBool() then
            print("[HLB] Disabling Light Bridge")
        end
        if IsValid(self.m_pLightBridge) then
            self.m_pLightBridge:Remove()
            self.m_pLightBridge = nil
        end
        self:EmitSound("ambient/energy/whiteflash.wav", 75, 80)
    end
end

function ENT:CreateBridge()
    if IsValid(self.m_pLightBridge) then return self.m_pLightBridge end

    local bridge = ents.Create("projected_wall_entity")
    if not IsValid(bridge) then
        ErrorNoHalt("[HLB] Failed to create projected_wall_entity!\n")
        return nil
    end

    bridge:SetPos(self:GetPos())
    bridge:SetAngles(self:GetAngles())
    bridge:SetOwner(self)
    bridge:SetParent(self)
    bridge:SetCollisionGroup(COLLISION_GROUP_NONE)
    bridge:Spawn()

    self.m_pLightBridge = bridge
    return bridge
end

function ENT:Initialize()
    if CLIENT then return end

    self:SetModel("models/props/wall_emitter.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)

    -- Ensure bridge spawns if StartEnabled is true
    if self.Enabled then
        self:CreateBridge()
    end
end

function ENT:KeyValue(key, value)
    if key == "StartEnabled" then
        self.Enabled = tobool(value)
    end
end

function ENT:Think()
    if CLIENT then return end

    if self.Enabled and not IsValid(self.m_pLightBridge) then
        self:CreateBridge()
    elseif not self.Enabled and IsValid(self.m_pLightBridge) then
        self.m_pLightBridge:Remove()
        self.m_pLightBridge = nil
    end

    self:NextThink(CurTime() + 0.1) -- lower Think frequency to save performance
    return true
end
