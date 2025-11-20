-- ////////////////////////////////////  CONSTANTS //////////////////////////////////////////

-- ///////////////////////////////////  FUNCTION DEFINITIONS ////////////////////////////////  Functions need to be defined before they are called.  That's why CODE section is at the bottom.

function Think()
    if not Started then
        EntFire(self:GetName(), "CallScriptFunction", "SpawnPropsInBounds", 1)
        Started = true
        StartTime = Time()
    end

    LastThink = Time()

    if Time() < (StartTime + (NPROPS * SPAWN_DELAY) + 0.2) then
        return
    end

    local AllSorted = 0

    for t, propType in pairs(SP.Props) do
        local minx = WORLD_MAX
        local maxx = -WORLD_MAX
        local miny = WORLD_MAX
        local maxy = -WORLD_MAX

        for _, prop in ipairs(propType.items) do
            local v = prop:GetPos()

            if v.x < minx then minx = v.x end
            if v.x > maxx then maxx = v.x end

            if v.y < miny then miny = v.y end
            if v.y > maxy then maxy = v.y end
        end

        propType.min.x = minx
        propType.max.x = maxx
        propType.min.y = miny
        propType.max.y = maxy

        if DBG then
            local origin = Vector(0, 0, 0)
            DebugDrawBox(origin, propType.min, propType.max, 255, 255, 0, 1, 0.1)
        end

        if ((propType.max.x - propType.min.x) <= PILE_MAX) and ((propType.max.y - propType.min.y) <= PILE_MAX) then
            printll(t .. " sorted")
            AllSorted = AllSorted + 1
        end
    end

    if DBG then
        printll("Piles Sorted: " .. AllSorted .. " / " .. table.Count(SP.Props))
    end

    if AllSorted == table.Count(SP.Props) then
        for _, i in pairs(SP.Props) do
            for _, j in pairs(SP.Props) do
                if IntersectRect(i.min, i.max, j.min, j.max) then
                    return
                end
            end
        end

        printll("Success: All piles are sorted and separated!")
    end
end

function SpawnPropsInBounds()
    local randx
    local randy
    local randz

    for i = 0, NPROPS - 1 do
        for j, spawner in ipairs(SP.PropSpawners) do
            randx = math.Rand(SP.Bounds[MIN].x, SP.Bounds[MAX].x)
            randy = math.Rand(SP.Bounds[MIN].y, SP.Bounds[MAX].y)
            randz = math.Rand(SP.Bounds[MIN].z, SP.Bounds[MAX].z)

            local code = "Spawn(" .. randx .. "," .. randy .. "," .. randz .. ")"
            EntFire(spawner:GetName(), "RunScriptCode", code, (i * SPAWN_DELAY))
        end
    end
end

--[[ This function is useless because a and b are passed in as value, not as reference
function Swap(a, b)
    if DBG then printll("swapping " .. a .. " " .. b) end
    local temp = a
    a = b
    b = temp
end
]]

function IntersectRect(v1min, v1max, v2min, v2max)
    if (((v1min.x > v2min.x) and (v1min.x < v2max.x)) or ((v1max.x > v2min.x) and (v1max.x < v2max.x))) then
        if (((v1min.y > v2min.y) and (v1min.y < v2max.y)) or ((v1max.y > v2min.y) and (v1max.y < v2max.y))) then
            return true
        end
    elseif (((v1min.y > v2min.y) and (v1min.y < v2max.y)) or ((v1max.y > v2min.y) and (v1max.y < v2max.y))) then
        if (((v1min.x > v2min.x) and (v1min.x < v2max.x)) or ((v1max.x > v2min.x) and (v1max.x < v2max.x))) then
            return true
        end
    end

    return false
end

-- ////////////////////////////////////////// CODE ///////////////////////////////////////////// this code gets run when the entity activates

LastThink = CurTime()
Started = false