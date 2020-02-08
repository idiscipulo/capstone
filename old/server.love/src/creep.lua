Creep = {}
Creep.__index = Creep
setmetatable(Creep, NPC) -- inherit from NPC

function Creep:new(id)
    local creep = NPC:new()
    setmetatable(creep, Creep)

    return creep
end