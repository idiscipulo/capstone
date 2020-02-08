Creep = {}
Creep.__index = Creep
setmetatable(Creep, NPC) -- inherit from NPC

function Creep:new(id)
    local creep = Creep:new()
    setmetatable(creep, Creep)

    return creep
end