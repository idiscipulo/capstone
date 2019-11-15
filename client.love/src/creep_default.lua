Creep_Default = {}
Creep_Default.__index = Creep_Default
setmetatable(Creep_Default, Entity) -- inherit from Entity (temporary)

function Creep_Default:new(id, x, y, speed)
    local creep_default = Entity:new()
    setmetatable(creep_default, Creep_Default)

    creep_default.id = id 
    creep_default.is_creep = true

    creep_default.x = x
    creep_default.y = y
    creep_default.speed = speed 

    creep_default.goal_x = nil
    creep_default.goal_y = nil

    creep_default.img = love.graphics.newImage("/assets/creep.png")
    creep_default.w = 16
    creep_default.h = 16
    creep_default.frames = {
        love.graphics.newQuad(0, 0, creep_default.w, creep_default.h, creep_default.img:getDimensions()),
        love.graphics.newQuad(16, 0, creep_default.w, creep_default.h, creep_default.img:getDimensions()),
        love.graphics.newQuad(32, 0, creep_default.w, creep_default.h, creep_default.img:getDimensions()),
        love.graphics.newQuad(48, 0, creep_default.w, creep_default.h, creep_default.img:getDimensions()),
        love.graphics.newQuad(64, 0, creep_default.w, creep_default.h, creep_default.img:getDimensions()),
        love.graphics.newQuad(80, 0, creep_default.w, creep_default.h, creep_default.img:getDimensions())
    }
    creep_default.cur_frame = 1
    creep_default.active_frame = creep_default.frames[creep_default.cur_frame]

    return creep_default
end

function Creep_Default:update(player_x, player_y)
    if player_x and player_y then 
        self.goal_x = player_x - 32
        self.goal_y = player_y

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
    self:animate()
end

local elapsed_time = 0
function Creep_Default:animate()
    local dt = love.timer.getDelta()
    elapsed_time = elapsed_time + dt
    if elapsed_time > 1 then
        if self.cur_frame == 6 then 
            self.cur_frame = 1
        else 
            self.cur_frame = self.cur_frame + 1
        end
        elapsed_time = 0
    end
    self.active_frame = self.frames[self.cur_frame]
end

function Creep_Default:draw()
    love.graphics.draw(self.img, self.active_frame, self.x, self.y)
end