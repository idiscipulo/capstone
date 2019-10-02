--Player is an abstract class that serves as the base class for all player characters
Player = {}
Player.__index = Player

--Inheriting from Entity
setmetatable(Player, Entity)

function Player:new()
    local player = {}
    setmetatable(player, Player)

    return player
end

function Player:update()
    --does nothing by default
end

function Player:move() 
    if self.mouse_x and self.mouse_y then
        local center_x, center_y = self:get_center()
        local angle = math.atan2(center_y - self.mouse_y, center_x - self.mouse_x)

        self.x = self.x - math.cos(angle) * self.speed
        self.y = self.y - math.sin(angle) * self.speed

        if math.abs(center_x - self.mouse_x) <= self.speed then
            self.x = self.mouse_x - self.w/2
        end
        if math.abs(center_y - self.mouse_y) <= self.speed then
            self.y = self.mouse_y - self.h/2
        end
    end
end

function Player:draw()
    --does nothing by default
end  