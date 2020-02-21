Wall = {}
Wall.__index = Wall
setmetatable(Wall, Structure) -- inherit from Structure

function Wall:new(id)
    local wall = Structure:new()
    setmetatable(wall, Wall)

    return wall
end