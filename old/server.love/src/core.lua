Core = {}
Core.__index = Core
setmetatable(Core, Structure) -- inherit from Structure

function Core:new(id)
    local core = Structure:new()
    setmetatable(core, Core)

    return core
end