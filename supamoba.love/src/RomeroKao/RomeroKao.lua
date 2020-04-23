RomeroKao = {}
RomeroKao.__index = RomeroKao
setmetatable(RomeroKao, Character)

function RomeroKao:new()
    local romeroKao = Character:new()
    setmetatable(romeroKao, RomeroKao)

    -- icon image
    romeroKao.icon = love.graphics.newImage('img/charExample.icon.png')

    -- max and current health
    romeroKao.maxHealth = 150
    romeroKao.curHealth = 150

    -- set move speed
    romeroKao.speed = 4

    -- basic attack stats
    romeroKao.basicSpeed = 8
    romeroKao.basicName = 'charExample.sprite' 
    romeroKao.basicCooldown = 1

    -- basic attack cooldown
    romeroKao.attackTimerMax = 1
    romeroKao.attackTimer = romeroKao.attackTimerMax

    -- set sprite location, size, and name for image file
    romeroKao.sprite:set(500, 250, 16, 16, 'charExample')

    -- set name
    romeroKao.textName = 'Romero Kao'
    romeroKao.name = font:printToCanvas('Romero Kao', 160, 10, 'center')

    -- initialize ability table
    romeroKao.abilities = {}
    
    -- add ability
    romeroKao:addAbility(RomeroScatterShot:new())
    romeroKao:addAbility(RomeroRapidAttack:new())
    romeroKao:addAbility(RomeroAOE:new())
    romeroKao:addAbility(AbilityExamplePassive:new())

    -- finish adding abilities
    romeroKao:endAbility()

    return romeroKao
end

function RomeroKao:update()
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

    if love.mouse.isDown(2) then -- right click to move
        self:setGoal(love.mouse.getPosition())
    end
    --move if character is not yet at goal
    if self.sprite.x ~= self.goalX or self.sprite.y ~= self.goalY then
        self:move() -- move
    end

    -- update sprite
    self.sprite:update()
end