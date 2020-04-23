-- parent class for basicAttacks, lasting aoe effects and basic attacks

BasicAttack = {}
BasicAttack.__index = BasicAttack
--setmetatable(BasicAttack, Particle)

function BasicAttack:new(damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer)
    local basicAttack = {}
    setmetatable(basicAttack, BasicAttack)

    basicAttack.damage = damage

    -- set index in basicAttack table and x, y positions
    basicAttack.ind = ind
    basicAttack.x = x
    basicAttack.y = y

    -- set speed
    basicAttack.speed = speed

    -- set effect
    if effect == nil then 
        basicAttack.effect = 'none'
    else
        basicAttack.effect = effect 
    end

    -- set effect timer
    if effectTimer == nil then
        basicAttack.effectTimer = 0
    else
        basicAttack.effectTimer = effectTimer
    end

    -- track duration
    -- cooldown is antiquated
    
    if cooldown == nil then
        dist = math.min(char.basicRange, math.sqrt((char.sprite.x - mouse.x) ^ 2 + (char.sprite.y - mouse.y) ^ 2))
        basicAttack.cooldown = (dist / (speed * 60))
    else
        basicAttack.cooldown = cooldown
    end

    basicAttack.totalSec = 0
    if delay == nil then
        basicAttack.sec = 0
    else
        basicAttack.sec = -delay
    end

    basicAttack.goalX = mouse.x
    basicAttack.goalY = mouse.y

    basicAttack.hit = {}

    -- angle of attack
    basicAttack.angle = angle

    basicAttack.character = char

    -- set image
    basicAttack.img = love.graphics.newImage('img/'..name..'.png')

    return basicAttack
end

function BasicAttack:update()
    -- increment timer
    self.sec = self.sec + timer.fps

    if self.sec > 0 then
        -- update position
        self:move()

        self:detectCollision()
        
        -- returns true if dot effect applies (2x per second)
        if self.sec > self.cooldown then
            --stateList['battle'].particles[self.ind] = nil
            self.character.basicAttacks[self.ind] = nil
        end
    end
end

function BasicAttack:detectCollision()
    for ind, val in pairs(stateList['battle'].ents) do
        if val.type ~= self.character.type then
            if self.hit[ind] ~= nil then
                -- pass
            else
                if math.abs(self.x - val.sprite.x) < 15 and math.abs(self.y - val.sprite.y) < 15 then 
                    -- explostion effect
                    local ind2 = #stateList['battle'].particles + 1
                    stateList['battle'].particles[ind2] = Particle:new(ind2, (self.x + val.sprite.x) / 2, (self.y + val.sprite.y) / 2, 0.1, 'basic.explosion')

                    val:damage(self.damage)
                    
                    if self.effect ~= 'none' then 
                        val:applyEffect(self.effect, self.effectTimer)
                    end
                    if self.effect == 'lifesteal' then 
                        self.character:heal(self.damage)
                    end

                    self.hit[ind] = val
                end
            end
        elseif self.effect == 'heal' then
            if val ~= self.character and val.type == self.character.type then 
                if self.hit[ind] ~= nil then
                    -- pass
                elseif math.abs(self.x - val.sprite.x) < 15 and math.abs(self.y - val.sprite.y) < 15 then 
                    val:heal(self.damage)
                    self.hit[ind] = val
                end
            end
        end
    end
end

function BasicAttack:move()
    self.x = self.x - math.cos(self.angle) * self.speed -- new x
    self.y = self.y - math.sin(self.angle) * self.speed -- new y
end

function BasicAttack:draw()
    love.graphics.draw(self.img, self.x, self.y)
end