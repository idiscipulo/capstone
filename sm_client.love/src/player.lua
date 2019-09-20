Player = {}
Player.__index = Player

--Inheriting from Entity
setmetatable(Player, Entity)

function Player:new(x, y)
    local player = {}
    setmetatable(player, Player)
     
    player.x = x
    player.y = y

    player.img = love.graphics.newImage("/assets/red_square.png")
    player.w = player.img:getWidth()
    player.h = player.img:getHeight()

    player.speed = 3
    player.mouse_x = nil
    player.mouse_y = nil

    return player
end

function Player:update()
    if love.mouse.isDown(2) then
        self.mouse_x, self.mouse_y = love.mouse.getPosition()
    end

    self:move()
end

function Player:move() 
    if self.mouse_x and self.mouse_y then
        local angle = math.atan2(self.y - self.mouse_y, self.x - self.mouse_x)

        self.x = self.x - math.cos(angle) * self.speed
        self.y = self.y - math.sin(angle) * self.speed

        if math.abs(self.x - self.mouse_x) <= self.speed then
            self.x = self.mouse_x
        end
        if math.abs(self.y - self.mouse_y) <= self.speed then
            self.y = self.mouse_y
        end
    end
end

function Player:to_string()
    if self.mouse_x and self.mouse_y then 
        return math.floor(self.x + 0.5) .. '-' .. math.floor(self.y + 0.5) .. '-' .. math.floor(self.mouse_x + 0.5) .. '-' .. math.floor(self.mouse_y + 0.5)
    else
        return math.floor(self.x + 0.5) .. '-' .. math.floor(self.y + 0.5)
    end
end

function Player:draw()
    love.graphics.draw(self.img, self.x, self.y)
end  