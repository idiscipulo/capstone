Tower = {}
Tower.__index = Tower
setmetatable(Tower, Structure) -- inherit from Structure

function Tower:new(id)
    local tower = Structure:new()
    setmetatable(tower, Tower)

    return tower
end