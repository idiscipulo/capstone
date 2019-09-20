Player = {}
Player.__index = Player

--Inheriting from Entity
setmetatable(Player, Entity)

function Player:new(x, y)
    local player = {}
    setmetatable(player, Player)
     
    player.x = x
    player.y = y

    player.img = love.graphics.newImage("/assets/mage.png")
    player.w = player.img:getWidth()
    player.h = player.img:getHeight()

    player.speed = 1.5
    player.mouse_x = nil
    player.mouse_y = nil

    return player
end

function Player:update()
    if love.mouse.isDown(2) then
        self.mouse_x, self.mouse_y = love.mouse.getPosition()

        -- adjust mouse coordinates if fullscreen
        self.mouse_x = (self.mouse_x - ACTUAL_X_OFFSET) / SCALE
        self.mouse_y = (self.mouse_y - ACTUAL_Y_OFFSET) / SCALE

        -- center mouse coordinates for image
        self.mouse_x = self.mouse_x - (self.w / 2)
        self.mouse_y = self.mouse_y - (self.h / 4) * 3
    end

    self:move()
end

function Player:move() 
    if self.mouse_x and self.mouse_y then
        -- calculate movement angle
        local angle = math.atan2(self.y - self.mouse_y, self.x - self.mouse_x)

        -- move
        self.x = self.x - math.cos(angle) * self.speed
        self.y = self.y - math.sin(angle) * self.speed

        -- stop moving
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