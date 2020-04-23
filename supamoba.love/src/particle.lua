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

    particle.goalX = nil
    particle.goalY = nil
    particle.speed = 1

    -- set image
    particle.img = love.graphics.newImage('img/'..name..'.png')

    return particle
end

function Particle:move()
    if self.goalX ~= nil and self.goalY ~= nil then
        local gx = self.goalX
        local gy = self.goalY

        local sp = self.speed
        if self.x ~= gx and self.y ~= gy then
            sp = math.sqrt(2 * (self.speed ^ 2))
        end

        if gx < self.x then
            self.x = math.max(gx, self.x - sp)
        elseif self.x < gx then
            self.x = math.min(gx, self.x + sp)
        end
        
        if gy < self.y then
            self.y = math.max(gy, self.y - sp)
        elseif self.y < gy then
            self.y = math.min(gy, self.y + sp)
        end

        if self.x == gx and self.y == gy then
            self.state = 'hit'
            self:use()
        end
    end
end

function Particle:update()
    -- increment timer
    self.sec = self.sec + timer.fps
    self.totalSec = self.totalSec + timer.fps

    -- if duration reached delete particle from table
    if self.totalSec > self.cooldown then
        stateList['battle'].particles[self.ind] = nil
    end
    
    -- returns true if dot effect applies (2x per second)
    if self.sec >= 0.5 then
        self.sec = 0
        return true
    end
    return false
end

function Particle:SetGoal(x, y)
end

function Particle:draw()
    love.graphics.draw(self.img, self.x, self.y)
end