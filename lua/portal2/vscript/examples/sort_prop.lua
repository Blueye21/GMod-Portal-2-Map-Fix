-- ////////////////////////////////////  CONSTANTS //////////////////////////////////////////

-- ///////////////////////////////////  FUNCTION DEFINITIONS ////////////////////////////////  Functions need to be defined before they are called.  That's why CODE section is at the bottom.

function RegisterProp()
    if not SP.Props[self:GetName()] then
        SP.Props[self:GetName()] = {
            items = {},
            min = Vector(WORLD_MAX, WORLD_MAX, 16),
            max = Vector(-WORLD_MAX, -WORLD_MAX, 40)
        }
    end

    table.insert(SP.Props[self:GetName()].items, self)

    if DBG then
        printl("Registered prop: " .. self:GetName() .. " " .. #SP.Props[self:GetName()].items)
    end
end

-- ////////////////////////////////////////// CODE ///////////////////////////////////////////// this code gets run when the entity activates

RegisterProp()