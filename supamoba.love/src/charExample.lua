-- example of a character

CharExample = {}
CharExample.__index = CharExample
setmetatable(CharExample, Character)

function CharExample:new()
    local charExample = Character:new()
    setmetatable(charExample, CharExample)

    -- icon image
    charExample.icon = love.graphics.newImage('img/charExample.icon.png')

    -- max and current health
    charExample.maxHealth = 150
    charExample.curHealth = 150

    -- set move speed
    charExample.speed = 3

    -- basic attack stats
    charExample.basicSpeed = 4
    charExample.basicName = 'charExample.sprite' 
    charExample.basicCooldown = 1

    -- basic attack cooldown
    charExample.attackTimerMax = 1
    charExample.attackTimer = charExample.attackTimerMax

    -- set sprite location, size, and name for image file
    charExample.sprite:set(500, 250, 16, 16, 'charExample')

    -- set name
    charExample.name = font:printToCanvas('example character', 160, 10, 'center')

    -- initialize ability table
    charExample.abilities = {}
    
    -- add ability
    charExample:addAbility(AbilityExampleDirectDamage:new())
    charExample:addAbility(AbilityExampleDOTEffect:new())
    charExample:addAbility(AbilityExampleAOEEffect:new())
    -- charExample:addAbility(AbilityExamplePassive:new())

    -- finish adding abilities
    charExample:endAbility()

    return charExample
end

function CharExample:update()
    -- update dots
    for ind, val in pairs(self.dots) do
        val:tick()
    end

    if love.mouse.isDown(1) and self.canAttack then --left click to basic attack
        local goalX = mouse.x
        local goalY = mouse.y
        local angle = math.atan2(self.sprite.y - goalY, self.sprite.x - goalX)
        self:addBasicAttack(5, angle)
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
        self:setGoal(mouse.x, mouse.y)
    end
    --move if character is not yet at goal
    if self.sprite.x ~= self.goalX or self.sprite.y ~= self.goalY then
        self:move() -- move
    end

    -- update sprite
    self.sprite:update()
end