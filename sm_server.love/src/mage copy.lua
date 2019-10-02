Mage = {}
Mage.__index = Mage

--Inheriting from Player
setmetatable(Mage, Player)

function Mage:new(x, y)
    local mage = {}
    setmetatable(mage, Mage)
    
    mage.x = x
    mage.y = y
    mage.img = love.graphics.newImage("/assets/mage_frames.png")
    mage.w = 64
    mage.h = 64

    mage.frames = {
        love.graphics.newQuad(0, 0, mage.w, mage.h, mage.img:getDimensions()),
        love.graphics.newQuad(0, 64, mage.w, mage.h, mage.img:getDimensions())
    }
    mage.cur_frame = mage.frames[1]

    mage.speed = 3
    mage.mouse_x = nil
    mage.mouse_y = nil

    return mage
end

function Mage:update()
    if love.mouse.isDown(2) then
        self.mouse_x, self.mouse_y = love.mouse.getPosition()
    end

    self:move()
    self:animate()
end

local elapsed_time = 0
function Mage:animate()
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

function Mage:draw()
    love.graphics.draw(self.img, self.cur_frame, self.x, self.y)
end  