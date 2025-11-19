AddCSLuaFile()

ENT.Type      = "anim"
ENT.Base      = "base_anim"

ENT.PrintName = "Laser Catcher"
ENT.Category  = "Portal 2"
ENT.Spawnable = true

ENT.Model         = "models/props/laser_catcher.mdl"
ENT.Shining       = false
ENT.ShineEndTime  = 0   -- fixed name (was ShingEndTime)

/*
    Related models:
    models/props/laser_emitter_center.mdl
    models/props/laser_emitter.mdl
*/

-- SERVER-SIDE INITIALIZATION
if SERVER then

    function ENT:Initialize()
        self:SetModel(self.Model or "models/props/laser_catcher.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_NONE)
        self:SetUseType(SIMPLE_USE)

        -- Ensure initial state
        self.Shining      = false
        self.ShineEndTime = 0
    end

    -- Hammer keyvalues / map I/O
    function ENT:KeyValue(k, v)
        -- Map I/O outputs
        if k == "OnPowered" or k == "OnUnpowered" then
            self:StoreOutput(k, v)
            return
        end

        -- Allow overriding the model from Hammer
        if k == "model" then
            self.Model = v
            self:SetModel(v)
            return
        end
    end

    -- Internal helper for starting/stopping shining
    function ENT:StartShining()
        if self.Shining then return end

        self.Shining      = true
        self.ShineEndTime = CurTime() + 0.1

        -- Wake up Think so we can turn off later
        self:NextThink(CurTime())
        self:TriggerOutput("OnPowered")
        print("[LaserCatcher] OnPowered fired.")
    end

    function ENT:StopShining()
        if not self.Shining then return end

        self.Shining      = false
        self.ShineEndTime = 0

        self:TriggerOutput("OnUnpowered")
    end

    -- Called by the laser
    function ENT:OnShineByLaser(laser)
        -- If someone external is still using the old field name, mirror it.
        if self.ShingEndTime then
            self.ShingEndTime = CurTime() + 0.1
        end

        -- Extend shine duration each time we are hit
        self.ShineEndTime = CurTime() + 0.1

        if not self.Shining then
            self:StartShining()
        else
            -- Ensure Think keeps running while extended
            self:NextThink(CurTime())
        end
    end

    function ENT:Think()
        if not self.Shining then
            -- No need to think if we are idle; do not reschedule.
            return
        end

        local ct = CurTime()

        -- Backwards compat: if someone still uses self.ShingEndTime, respect the latest of both
        if self.ShingEndTime then
            self.ShineEndTime = math.max(self.ShineEndTime, self.ShingEndTime or 0)
        end

        if ct >= (self.ShineEndTime or 0) then
            self:StopShining()
            return
        end

        -- Continue thinking while shining
        self:NextThink(ct)
        return true
    end

end

-- CLIENT-SIDE:
-- If you ever want to add visual effects (glow, sprite, etc.),
-- you can read ENT.Shining via NWVars or net messages here.