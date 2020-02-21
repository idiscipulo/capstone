Structure = {}
Structure.__index = Structure
setmetatable(Structure, Entity) -- inherit from entity

function Structure:new(id)
    local structure = Entity:new()
    setmetatable(structure, Structure)

    return structure
end