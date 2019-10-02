Square = {}
Square.__index = Square

--Inheriting from NPC
setmetatable(Square, NPC)

function Square:new(x, y)
    local square = {}
    setmetatable(square, Square)
    
    square.x = x
    square.y = y
    
    square.img = love.graphics.newImage("/assets/red_square.png")
    square.w = square.img:getWidth()
    square.h = square.img:getHeight()

    square.speed = 2

    return square
end

function Square:update()
    self:move()
end

function Square:draw()
    love.graphics.draw(self.img, self.x, self.y)
end  