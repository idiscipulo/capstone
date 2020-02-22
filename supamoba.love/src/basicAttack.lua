-- parent class for basicAttacks, lasting aoe effects and basic attacks

BasicAttack = {}
BasicAttack.__index = BasicAttack
--setmetatable(BasicAttack, Particle)

function BasicAttack:new(char, ind, x, y, cooldown, name, speed, goalX, goalY)
    local basicAttack = {}
    setmetatable(basicAttack, BasicAttack)

    -- set index in basicAttack table and x, y positions
    basicAttack.ind = ind
    basicAttack.x = x
    basicAttack.y = y

    -- set speed
    basicAttack.speed = speed

    -- goal coordinates
    basicAttack.goalX = goalX 
    basicAttack.goalY = goalY

    -- track duration
    basicAttack.sec = 0
    basicAttack.totalSec = 0
    basicAttack.cooldown = cooldown

    -- angle of attck
    basicAttack.angle = nil

    basicAttack.character = char

    -- set image
    basicAttack.img = love.graphics.newImage('img/'..name..'.png')

    return basicAttack
end

function BasicAttack:update()
    -- update position
    self:move()

    -- increment timer
    self.sec = self.sec + timer.fps
    
    -- returns true if dot effect applies (2x per second)
    if self.sec >= 0.5 then
        if self.cooldown == nil then
            self.sec = 0
        else
            self.totalSec = self.totalSec + self.sec
            self.sec = 0
            -- if duration reached delete basicAttack from table
            if self.totalSec > self.cooldown then
                --stateList['battle'].particles[self.ind] = nil
                self.character.basicAttacks[self.ind] = nil
            end
        end
        return true
    end
    return false
end

function BasicAttack:move()
    if self.goalX ~= nil and self.goalY ~= nil then
        if self.angle == nil then  
            self.angle = math.atan2(self.y - self.goalY, self.x - self.goalX) -- calc movement angle
        end
        self.x = self.x - math.cos(self.angle) * self.speed -- new x
        self.y = self.y - math.sin(self.angle) * self.speed -- new y
    end
end

function BasicAttack:draw()
    love.graphics.draw(self.img, self.x, self.y)
end