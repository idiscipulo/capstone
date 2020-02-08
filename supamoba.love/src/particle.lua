-- parent class for particles, lasting aoe effects

Particle = {}
Particle.__index = Particle

function Particle:new(ind, x, y, cooldown, name)
    local particle = {}
    setmetatable(particle, Particle)

    -- set index in particle table and x, y positions
    particle.ind = ind
    particle.x = x
    particle.y = y

    -- track duration
    particle.sec = 0
    particle.totalSec = 0
    particle.cooldown = cooldown

    -- set image
    particle.img = love.graphics.newImage('img/'..name..'.png')

    return particle
end

function Particle:update()
    -- increment timer
    self.sec = self.sec + timer.fps
    
    -- returns true if dot effect applies (2x per second)
    if self.sec >= 0.5 then
        if self.cooldown == nil then
            self.sec = 0
        else
            self.totalSec = self.totalSec + self.sec
            self.sec = 0
            -- if duration reached delete particle from table
            if self.totalSec > self.cooldown then
                stateList['battle'].particles[self.ind] = nil
            end
        end
        return true
    end
    return false
end

function Particle:draw()
    love.graphics.draw(self.img, self.x, self.y)
end