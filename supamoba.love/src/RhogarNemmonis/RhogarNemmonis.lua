RhogarNemmonis = {}
RhogarNemmonis.__index = RhogarNemmonis
setmetatable(RhogarNemmonis, Character)

function RhogarNemmonis:new()
    local rhogarNemmonis = Character:new()
    setmetatable(rhogarNemmonis, RhogarNemmonis)

    -- icon image
    rhogarNemmonis.icon = love.graphics.newImage('img/charExample.icon.png')

    -- max and current health
    rhogarNemmonis.maxHealth = 150
    rhogarNemmonis.curHealth = 150

    -- set move speed
    rhogarNemmonis.speed = 2.8

    -- basic attack stats
    rhogarNemmonis.basicSpeed = 5
    rhogarNemmonis.basicName = 'charExample.sprite' 
    rhogarNemmonis.basicCooldown = 1

    -- basic attack cooldown
    rhogarNemmonis.attackTimerMax = 1
    rhogarNemmonis.attackTimer = rhogarNemmonis.attackTimerMax

    -- set sprite location, size, and name for image file
    rhogarNemmonis.sprite:set(500, 250, 16, 16, 'charExample')

    -- set name
    rhogarNemmonis.textName = 'Rhogar Nemmonis'
    rhogarNemmonis.name = font:printToCanvas('Rhogar Nemmonis', 160, 10, 'center')

    -- initialize ability table
    rhogarNemmonis.abilities = {}

    rhogarNemmonis.invulnerableTimerMax = 3
    rhogarNemmonis.invulnerableTimer = rhogarNemmonis.invulnerableTimerMax
    
    -- add ability
    rhogarNemmonis:addAbility(RhogarRootAttack:new())
    rhogarNemmonis:addAbility(RhogarReflectAttack:new())
    rhogarNemmonis:addAbility(RhogarInvulnerable:new())
    rhogarNemmonis:addAbility(AbilityExamplePassive:new())

    -- finish adding abilities
    rhogarNemmonis:endAbility()

    return rhogarNemmonis
end

function RhogarNemmonis:update()
    -- update dots
    for ind, val in pairs(self.dots) do
        val:tick()
    end

    if love.mouse.isDown(1) and self.canAttack then --left click to basic attack
        local goalX, goalY = love.mouse.getPosition()
        local angle = math.atan2(self.sprite.y - goalY, self.sprite.x - goalX)
        self:addBasicAttack(angle)
        self.canAttack = false
    end

    --run basic attack cooldown timer
    if not self.canAttack then 
        self.attackTimer = self.attackTimer - timer.fps
        if self.attackTimer < 0 then 
            self.attackTimer = self.attackTimerMax
            self.canAttack = true
        end
    end

    --run invulnerable ability timer
    if self.isInvulnerable then 
        self.invulnerableTimer = self.invulnerableTimer - timer.fps
        if self.invulnerableTimer < 0 then 
            self.invulnerableTimer = self.invulnerableTimerMax
            self.isInvulnerable = false
        end
    end

    if love.mouse.isDown(2) then -- right click to move
        self:setGoal(love.mouse.getPosition())
    end
    
    --move if character is not yet at goal
    if self.sprite.x ~= self.goalX or self.sprite.y ~= self.goalY then
        --self:move() -- move
    end

    -- update sprite
    self.sprite:update()
end