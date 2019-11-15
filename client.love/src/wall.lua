Wall = {}
Wall.__index = Wall
setmetatable(Wall, Structure) -- inherit from Structure 

function Wall:new(x, y, w, h)
    local wall = Structure:new()
    setmetatable(wall, Wall)

    wall.x = x
    wall.y = y
    wall.w = w
    wall.h = h
    wall.id = "wall" --for collidable_table --TOIMPROVE -> have this value in entity??

    return wall
end

function Wall:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end  