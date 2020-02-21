Character = {}
Character.__index = Character
setmetatable(Character, Entity) -- inherit from entity

function Character:new(id)
    local character = Entity:new()
    setmetatable(character, Character)

    character.id = id -- set id

    character.speed = 3 -- speed for movement
    character.goal_x = 0 -- goal for movement
    character.goal_y = 0 -- goal for movement

    -- put a sprite object here (need to write that)

    return character
end

function Character:set_goal(x, y)
    self.goal_x = x
    self.goal_y = y
end

function Character:update()
    if self.x ~= self.goal_x or self.y ~= self.goal_y then
        self:move() -- move
    end
end

function Character:move()
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
end
