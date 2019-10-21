Character = {}
Character.__index = Character
setmetatable(Character, Entity) -- inherit from entity

function Character:new(id)
    local character = Entity:new()
    setmetatable(character, Character)

    character.id = id -- set id

    character.speed = 2 -- speed for movement
    character.goal_x = 0 -- goal for movement
    character.goal_y = 0 -- goal for movement

    self.adj_x = 0
    self.adj_y = 0

    -- put a sprite object here (need to write that)

    return character
end

function Character:set_goal(x, y)
    self.goal_x = x - (self.w / 2)
    self.goal_y = y - (self.h / 2)
end

function Character:update()
    self.adj_x = math.floor(0.5 + (self.x / 16))
    self.adj_y = math.floor(0.5 + (self.y / 16))

    if love.mouse.isDown(2) then -- right click
        self:set_goal(love.mouse.getPosition())
    end
    if self.x ~= self.goal_x or self.y ~= self.goal_y then
        self:move() -- move
    end
end

function Character:move()
    local speed = 0
    if self.y ~= self.goal_y and self.x ~= self.goal_x then
        speed = self.speed / math.sqrt(2)
    else
        speed = self.speed
    end

    if self.y < self.goal_y then
        if self.goal_y - self.y < speed then
            self.y = self.y + (self.goal_y - self.y)
        else
            self.y = self.y + speed
        end
    elseif self.y > self.goal_y then
        if self.y - self.goal_y < speed then
            self.y = self.y - (self.y - self.goal_y)
        else
            self.y = self.y - speed
        end
    end

    if self.x < self.goal_x then
        if self.goal_x - self.x < speed then
            self.x = self.x + (self.goal_x - self.x)
        else
            self.x = self.x + speed
        end
    elseif self.x > self.goal_x then
        if self.x - self.goal_x < speed then
            self.x = self.x - (self.x - self.goal_x)
        else
            self.x = self.x - speed
        end
    end
    --[[
    local center_x, center_y = self:get_center() -- get center
    local angle = math.atan2(center_y - self.goal_y, center_x - self.goal_x) -- calc movement angle

    self.x = self.x - math.cos(angle) * self.speed -- new x
    self.y = self.y - math.sin(angle) * self.speed -- new y

    if math.abs(center_x - self.goal_x) <= self.speed then
        self.x = self.goal_x - self.w/2 -- set x coord equal if close enough
    end
    if math.abs(center_y - self.goal_y) <= self.speed then
        self.y = self.goal_y - self.h/2 -- set x coord equal if close enough
    end
    ]]
end
