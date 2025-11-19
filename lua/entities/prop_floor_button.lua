AddCSLuaFile()

ENT.Type            = "anim"
ENT.Base            = "base_anim"

ENT.PrintName       = "Floor Button"
ENT.Category        = "Portal 2"
ENT.Spawnable       = true

ENT.Downed          = false
ENT.AutomaticFrameAdvance = true
ENT.NextToggleTime   = 0

-- Optional: define skins
ENT.SkinUp           = 0
ENT.SkinDown         = 1

function ENT:Initialize()
    self:SetModel("models/props/portal_button.mdl")
    self:SetMoveType(MOVETYPE_NONE)

    -- Use model bounds for collision
    local mins, maxs = self:GetModelBounds()
    self:SetCollisionBounds(Vector(-24, -24, -6), Vector(24, 24, 6))
    self:SetSolid(SOLID_BBOX)

    -- Default skin
    self:SetSkin(self.SkinUp)
end

function ENT:KeyValue(key, value)
    if key == "OnPressed" or key == "OnUnPressed" then
        self:StoreOutput(key, value)
    end
end

function ENT:Down(activator)
    if self.Downed or CurTime() < self.NextToggleTime then return end
    self.Downed = true
    self.NextToggleTime = CurTime() + 0.1 -- Slight delay to avoid spam

    self:ResetSequence("down")
    self:SetSkin(self.SkinDown)
    self:EmitSound("buttons/portal_button_down_01.wav")
    self:TriggerOutput("OnPressed", activator)
    self:Fire("OnUser1")
end

function ENT:Up()
    if not self.Downed or CurTime() < self.NextToggleTime then return end
    self.Downed = false
    self.NextToggleTime = CurTime() + 0.1

    self:ResetSequence("up")
    self:SetSkin(self.SkinUp)
    self:EmitSound("buttons/portal_button_up_01.wav")
    self:TriggerOutput("OnUnPressed", self)
    self:Fire("OnUser2")
end

function ENT:Think()
    if CLIENT then return end
    self:OnCustomThink()

    local mins, maxs = self:GetCollisionBounds()
    local worldMin, worldMax = self:LocalToWorld(mins), self:LocalToWorld(maxs)
    local entities = ents.FindInBox(worldMin, worldMax)

    local pressed = false
    local activator = nil

    for _, ent in ipairs(entities) do
        if ent ~= self then
            if ent:IsPlayer() and ent:Alive() then
                pressed = true
                activator = ent
                break
            elseif ent:GetClass() == "prop_weighted_cube" then
                local phys = ent:GetPhysicsObject()
                if IsValid(phys) and phys:GetMass() > 10 then
                    pressed = true
                    activator = ent
                    break
                end
            elseif ent:GetMoveType() == MOVETYPE_STEP or ent:GetMoveType() == MOVETYPE_WALK then
                -- Covers NPCs or walking entities
                pressed = true
                activator = ent
                break
            end
        end
    end

    if pressed then
        self:Down(activator)
    else
        self:Up()
    end

    self:NextThink(CurTime())
    return true
end

function ENT:Draw()
    self:DrawModel()

    if GetConVar("developer"):GetBool() then
        local mins, maxs = self:GetCollisionBounds()
        render.DrawWireframeBox(
            self:GetPos(),
            Angle(0, 0, 0),
            mins,
            maxs,
            color_white,
            false
        )
    end
end

function ENT:OnCustomThink()
    self:NextThink(CurTime())
    return true
end
