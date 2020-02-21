CharacterDefault = {}
CharacterDefault.__index = CharacterDefault
setmetatable(CharacterDefault, Character)

function CharacterDefault:new(id)
    local character_default = Character:new(id)
    setmetatable(character_default, CharacterDefault)

    character_default.w = 64
    character_default.h = 64

    character_default.img = love.graphics.newImage("/assets/mage_frames.png")
    character_default.frames = {
        love.graphics.newQuad(0, 0, character_default.w, character_default.h, character_default.img:getDimensions()),
        love.graphics.newQuad(0, 64, character_default.w, character_default.h, character_default.img:getDimensions())
    }
    character_default.cur_frame = character_default.frames[1]

    return character_default
end

function CharacterDefault:update()
    if love.mouse.isDown(2) then -- right click
        self:set_goal(love.mouse.getPosition())
    end
    if self.x ~= self.goal_x or self.y ~= self.goal_y then
        self:move() -- move
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
    love.graphics.draw(self.img, self.cur_frame, self.x, self.y)
end  