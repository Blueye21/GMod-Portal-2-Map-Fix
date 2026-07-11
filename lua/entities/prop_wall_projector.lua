AddCSLuaFile()

ENT.Type      = "anim"
ENT.Base      = "base_anim"

ENT.PrintName = "Hard Light Bridge"
ENT.Category  = "Portal 2"
ENT.Spawnable = true

ENT.AutomaticFrameAdvance = true

-- Tuning
ENT.RepairInterval = 0.5
ENT.BridgeClass    = "projected_wall_entity"
ENT.ToggleSound    = "ambient/energy/whiteflash.wav"
ENT.SoundVol       = 75
ENT.skin           = 0

local function DevLog(self, msg)
    local cv = GetConVar("developer")
    if cv and cv:GetBool() then
        print(("[HLB:%d] %s"):format(self:EntIndex(), msg))
    end
end

function ENT:SetupDataTables()
    -- Networked so client tools/UI can read state later if needed.
    self:NetworkVar("Bool", 0, "Enabled")
end

function ENT:KeyValue(key, value)
    -- Map keyvalues come in before Initialize; stash desired state.
    if key == "skin" then
        self.skin = tonumber(value)
    elseif key == "StartEnabled" then
        self._startEnabled = tobool(value)
    end
end

function ENT:Initialize()
    if CLIENT then return end

    self:SetModel("models/props/wall_emitter.mdl")
    self:SetSkin(self.skin)

    -- This entity is basically a static emitter. We still give it solid so it behaves in-world.
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)

    self._bridge = nil
    self._nextRepair = 0

    -- Default off unless StartEnabled set.
    self:SetEnabled(self._startEnabled == true)

    if self:GetEnabled() then
        self:EnsureBridge()
    end
end

function ENT:OnRemove()
    if SERVER then
        self:RemoveBridge()
    end
end

function ENT:CreateBridge()
    if IsValid(self._bridge) then return self._bridge end

    local bridge = ents.Create(self.BridgeClass)
    if not IsValid(bridge) then
        ErrorNoHalt(("[HLB:%d] Failed to create %s!\n"):format(self:EntIndex(), tostring(self.BridgeClass)))
        return nil
    end

    bridge:SetPos(self:GetPos())
    bridge:SetAngles(self:GetAngles())

    -- Ownership/parenting so it follows the emitter if moved/parented by a map.
    bridge:SetOwner(self)
    bridge:SetParent(self)

    bridge:SetCollisionGroup(COLLISION_GROUP_NONE)
    bridge:Spawn()

    self._bridge = bridge
    DevLog(self, "Bridge created")
    return bridge
end

function ENT:RemoveBridge()
    if IsValid(self._bridge) then
        self._bridge:Remove()
        self._bridge = nil
        DevLog(self, "Bridge removed")
    end
end

function ENT:EnsureBridge()
    if not self:GetEnabled() then return end
    if IsValid(self._bridge) then return end
    self:CreateBridge()
end

function ENT:PlayToggleSound(pitch)
    -- Server-safe; replicates.
    self:EmitSound(self.ToggleSound, self.SoundVol or 75, pitch or 100, 1)
end

function ENT:SetEnabledState(state, activator)
    state = tobool(state)
    if self:GetEnabled() == state then return end

    self:SetEnabled(state)

    if state then
        self:EnsureBridge()
        self:PlayToggleSound(120)
    else
        self:RemoveBridge()
        self:PlayToggleSound(80)
    end
end

function ENT:AcceptInput(name, activator, caller, data)
    if name == "Enable" then
        self:SetEnabledState(true, activator)
        return true
    elseif name == "Disable" then
        self:SetEnabledState(false, activator)
        return true
    end
end

function ENT:Think()
    if CLIENT then return end

    if self:GetEnabled() and (not IsValid(self._bridge)) then
        local now = CurTime()
        if now >= (self._nextRepair or 0) then
            self._nextRepair = now + (self.RepairInterval or 0.5)
            DevLog(self, "Bridge missing, recreating...")
            self:EnsureBridge()
        end
    end

    self:NextThink(CurTime() + (self.RepairInterval or 0.5))
    return true
end

