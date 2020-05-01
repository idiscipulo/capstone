RhogarNemmonis = {}
RhogarNemmonis.__index = RhogarNemmonis
setmetatable(RhogarNemmonis, Character)

function RhogarNemmonis:new()
    local rhogarNemmonis = Character:new()
    setmetatable(rhogarNemmonis, RhogarNemmonis)

    -- icon image
    rhogarNemmonis.icon = love.graphics.newImage('img/RhogarNemmonis.icon.png')

    -- max and current health
    rhogarNemmonis.maxHealth = 150
    rhogarNemmonis.curHealth = 150

    -- set move speed
    rhogarNemmonis.speed = 2.8

    -- basic attack stats
    rhogarNemmonis.basicSpeed = 5
    rhogarNemmonis.basicName = 'basic.sprite' 
    rhogarNemmonis.basicCooldown = 1

    -- basic attack cooldown
    rhogarNemmonis.attackTimerMax = 0.7
    rhogarNemmonis.attackTimer = rhogarNemmonis.attackTimerMax

    -- set sprite location, size, and name for image file
    rhogarNemmonis.sprite:set(500, 250, 16, 16, 'RhogarNemmonis')

    -- set name
    rhogarNemmonis.textName = 'Rhogar Nemmonis'
    rhogarNemmonis.name = font:printToCanvas('Rhogar Nemmonis', 160, 10, 'center')

    rhogarNemmonis.backstory = font:printToCanvas('an unbreakable champion who fears neither man nor tower.', 189, 38, 'left')

    -- initialize ability table
    rhogarNemmonis.abilities = {}

    rhogarNemmonis.invulnerableTimerMax = 3
    rhogarNemmonis.invulnerableTimer = rhogarNemmonis.invulnerableTimerMax
    
    -- add ability
    rhogarNemmonis:addAbility(RhogarRootAttack:new())
    rhogarNemmonis:addAbility(RhogarReflectAttack:new())
    rhogarNemmonis:addAbility(RhogarInvulnerable:new())
    -- rhogarNemmonis:addAbility(AbilityExamplePassive:new())

    -- finish adding abilities
    rhogarNemmonis:endAbility()

    return rhogarNemmonis
end

function RhogarNemmonis:update()
    Character.update(self)

    --run invulnerable ability timer
    if self.isInvulnerable then 
        self.invulnerableTimer = self.invulnerableTimer - timer.fps
        if self.invulnerableTimer < 0 then 
            self.invulnerableTimer = self.invulnerableTimerMax
            self.isInvulnerable = false
        end
    end

    if self.abilities[2].isActive then 
        self.abilities[2].timer = self.abilities[2].timer - timer.fps
        if self.abilities[2].timer < 0 then 
            self.abilities[2].timer = self.abilities[2].timerMax 
            self.abilities[2].isActive = false
        end
    end
end

function RhogarNemmonis:takeDamage(amt)
    if self.deathTime == 0 then
        if self.abilities[2].isActive then 
            local goalX, goalY = self:getClosestEnemy()
            local angle = math.atan2(self.sprite.y - goalY, self.sprite.x - goalX)
            self:addBasicAttack(amt, angle, nil)
            self.basicAttacks[#self.basicAttacks].goalX, self.basicAttacks[#self.basicAttacks].goalY = goalX, goalY
        elseif not self.isInvulnerable then 
            -- deal damage
            self.curHealth = math.max(self.curHealth - amt, 0)
            -- get index for next open spot in numbers
            local ind = #stateList['battle'].numbers + 1
            -- add damage number to numbers
            stateList['battle'].numbers[ind] = Number:new(ind, self, amt, 'DAMAGE')
        end

        if self.curHealth == 0 then
            self.deathTime = 300
            self.isDead = true
        end
    end
end