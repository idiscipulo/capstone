Tower = {}
Tower.__index = Tower
setmetatable(Tower, Character)

function Tower:new(x, y, team)
    local tower = Character:new()
    setmetatable(tower, Tower)

    --set team
    tower.team = team

    -- icon image
    tower.icon = love.graphics.newImage('img/RomeroKao.icon.png')

    -- max and current health
    tower.maxHealth = 150
    tower.curHealth = 150

    -- set move speed
    tower.speed = 0

    tower.damage = 10

    -- set tower range
    tower.range = 150

    tower.isTower = true

    -- basic attack stats
    tower.basicSpeed = 8
    tower.basicName = 'basic.sprite' 
    tower.basicCooldown = 1

    -- basic attack cooldown
    tower.attackTimerMax = 1
    tower.attackTimer = tower.attackTimerMax

    -- set sprite location, size, and name for image file
    tower.sprite:set(x, y, 16, 16, 'RomeroKao')
    
    -- set name
    tower.textName = 'Tower'
    tower.name = font:printToCanvas('Tower', 160, 10, 'center')

    return tower
end

function Tower:update()
    Character.update(self)
    --run basic attack cooldown timer
    if not self.canAttack then 
        self.attackTimer = self.attackTimer - timer.fps
        if self.attackTimer < 0 then 
            self.attackTimer = self.attackTimerMax
            self.canAttack = true
        end
    end

    for ind, val in pairs(stateList['battle'].ents) do 
        if val.team ~= self.team and self.canAttack then 
            local distance = math.sqrt( (self.sprite.x - val.sprite.x)^2 + (self.sprite.y - val.sprite.y)^2 )
            if distance < self.range then 
                local angle = math.atan2(self.sprite.y - val.sprite.y, self.sprite.x - val.sprite.x)
                self:addBasicAttack(self.damage, angle, nil, 0)
                self.canAttack = false
            end
        end
    end

    -- update sprite
    self.sprite:update()

    -- update dots
    for ind, val in pairs(self.dots) do
        val:tick()
    end

    if self.curHealth <= 0 then self.isDead = true end
end

function Tower:takeDamage(amt)
    if self.isDebuffed then amt = amt * 2 end 

    if not self.isInvulnerable then 
        -- deal damage
        self.curHealth = math.max(self.curHealth - amt, 0)

        -- get index for next open spot in numbers
        local ind = #stateList['battle'].numbers + 1

        -- add damage number to numbers
        stateList['battle'].numbers[ind] = Number:new(ind, self, amt, 'DAMAGE')
    end
end