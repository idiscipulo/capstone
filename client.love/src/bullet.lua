Bullet = {}
Bullet.__index = Bullet
setmetatable(Bullet, Entity) -- inherit from entity

function Bullet:new(x, y, goal_x, goal_y)
    local bullet = Entity:new()
    setmetatable(bullet, Bullet)

    bullet.img = love.graphics.newImage("/assets/bullet.png")
    bullet.w = 9
    bullet.h = 9

    bullet.speed = 5

    bullet.x = x 
    bullet.y = y
    bullet.goal_x = goal_x
    bullet.goal_y = goal_y

    return bullet
end

function Bullet:update()
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

    if math.abs(center_x - self.goal_x) <= self.speed and math.abs(center_y - self.goal_y) <= self.speed then 
        self.despawn = true
    end

end

function Bullet:draw()
    love.graphics.draw(self.img, self.x, self.y)
end