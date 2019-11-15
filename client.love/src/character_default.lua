CharacterDefault = {}
CharacterDefault.__index = CharacterDefault
setmetatable(CharacterDefault, Character)

function CharacterDefault:new(id)
    local character_default = Character:new(id)
    setmetatable(character_default, CharacterDefault)

    character_default.w = 16
    character_default.h = 16

    character_default.img = love.graphics.newImage("/assets/mage_frames.png")
    character_default.frames = {
        love.graphics.newQuad(0, 0, character_default.w, character_default.h, character_default.img:getDimensions()),
        love.graphics.newQuad(0, 16, character_default.w, character_default.h, character_default.img:getDimensions())
    }
    character_default.cur_frame = character_default.frames[1]

    character_default.can_shoot = true
    character_default.shot_timer_max = 0.25
    character_default.shot_timer = character_default.shot_timer_max

    character_default.has_creep = false

    return character_default
end

function CharacterDefault:update()
    self.adj_x = math.floor(0.5 + (self.x / 16))
    self.adj_y = math.floor(0.5 + (self.y / 16))

    if love.mouse.isDown(2) then -- right click
        self:set_goal(love.mouse.getPosition())
    end
    if self.x ~= self.goal_x or self.y ~= self.goal_y then
        self:move() -- move
    end

    if love.keyboard.isDown('q') and self.can_shoot then 
        table.insert(self.objectQueue, Bullet:new(self.x, self.y, love.mouse.getPosition()))
        self.can_shoot = false
    end

    if not self.can_shoot then 
        local dt = love.timer.getDelta()
        self.shot_timer = self.shot_timer - (1 * dt)
        if self.shot_timer < 0 then 
            self.shot_timer = self.shot_timer_max
            self.can_shoot = true 
        end
    end

    if love.keyboard.isDown('space') and not self.has_creep then 
        table.insert(self.objectQueue, Creep_Default:new(self.id, self.x - 32, self.y, self.speed))
        self.has_creep = true 
    end

    self:animate()
end

local elapsed_time = 0
function CharacterDefault:animate()
    --using dt for now 
    local dt = love.timer.getDelta()
    elapsed_time = elapsed_time + dt 
    if elapsed_time > 0.5 then 
        if self.cur_frame == self.frames[1] then 
            self.cur_frame = self.frames[2]
        else 
            self.cur_frame = self.frames[1]
        end
        elapsed_time = 0
    end
end

function CharacterDefault:draw()
    love.graphics.rectangle('fill', self.adj_x * 16, self.adj_y * 16, 16, 16)
    love.graphics.draw(self.img, self.cur_frame, self.x, self.y)
end  