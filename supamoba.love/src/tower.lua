Tower = {}
Tower.__index = Tower
setmetatable(Tower, Character)

function Tower:new(x, y, team)
    local tower = Character:new()
    setmetatable(tower, Tower)

    --set team
    tower.team = team

    -- icon image
    tower.icon = love.graphics.newImage('img/tower.icon.png')

    -- max and current health
    tower.maxHealth = 200
    tower.curHealth = 200

    -- set move speed
    tower.speed = 0

    tower.damage = 10

    -- set tower range
    tower.range = 150

    tower.isTower = true

    -- basic attack stats
    tower.basicSpeed = 8
    tower.basicName = 'tower.basic' 
    tower.basicCooldown = 1

    -- basic attack cooldown
    tower.attackTimerMax = 1
    tower.attackTimer = tower.attackTimerMax

    -- set sprite location, size, and name for image file
    tower.sprite:set(x, y, 16, 16, 'tower')
    
    -- set name
    tower.textName = 'Tower'
    tower.name = font:printToCanvas('Tower', 160, 10, 'center')

    return tower
end

function Tower:update()
    Character.update(self)
    --run basic attack cooldown timer

    for ind, val in pairs(stateList['battle'].ents) do 
        if val.team ~= self.team and self.canAttack and not val.isDead then 
            local distance = math.sqrt( (self.sprite.x - val.sprite.x)^2 + (self.sprite.y - val.sprite.y)^2 )
            if distance < self.range then 
                local angle = math.atan2(self.sprite.y - val.sprite.y, self.sprite.x - val.sprite.x)

                local cooldown = (distance / (self.basicSpeed * 60))

                self:addBasicAttack(self.damage, angle, cooldown, 0)
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