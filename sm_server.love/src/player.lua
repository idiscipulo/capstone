local Entity = require 'src.entity'
Player = {}
Player.__index = Player

local player_img = love.graphics.newImage('/assets/red_square.png')

function Player.new(x, y)
    local player_instance = {
        img = player_img,
        x = x, 
        y = y, 
        w = player_img:getWidth(),
        h = player_img:getHeight(),
        speed = 250,
        mouse_x = nil,
        mouse_y = nil,
    }
    
    setmetatable(player_instance, Player)
    return player_instance
end

function Player:update(dt)
    if love.mouse.isDown(2) then
        self.mouse_x, self.mouse_y = love.mouse.getPosition()
    end
    self:move()
end

function Player:move() 
    if self.mouse_x and self.mouse_y then
        local dt = love.timer.getDelta()
        local angle = math.atan2(self.y - self.mouse_y, self.x - self.mouse_x)

        self.x = self.x - math.cos(angle) * self.speed * dt
        self.y = self.y - math.sin(angle) * self.speed * dt
    end
end

function Player:draw()
    love.graphics.draw(self.img, self.x, self.y)
end  

--Inheriting from Entity
setmetatable(Player, Entity)
return Player