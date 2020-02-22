-- parent class for characters 

Character = {}
Character.__index = Character

function Character:new()
    local character = {}
    setmetatable(character, Character)

    -- icon
    character.icon = nil

    -- sprite
    character.sprite = Sprite:new()

    -- max and current health
    character.maxHealth = 0
    character.curHealth = 0

    -- death tracker
    character.deathTime = 0

    -- goal x and y
    character.goalX = nil 
    character.goalY = nil

    -- dots table
    character.dots = {}

    -- name
    character.name = nil

    -- table of all active basic attacks
    character.basicAttacks = {}

    -- basic attack stats
    character.basicSpeed = nil 
    character.basicName = nil 
    character.basicCooldown = nil --time until the attack despawns

    -- basic attack timer
    character.attackTimerMax = nil --time until character can basic attack again
    character.attackTimer = nil 
    character.canAttack = true

    -- abilities table
    character.abilities = {}

    return character
end

function Character:update()
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

function Character:move()
    if self.goalX ~= nil and self.goalY ~= nil then
        local gx = self.goalX
        local gy = self.goalY
        local sp = self.speed
        if self.sprite.x ~= gx and self.sprite.y ~= gy then
            sp = math.sqrt(2 * (self.speed))
        end
        if gx < self.sprite.x then
            self.sprite.x = math.max(gx, self.sprite.x - sp)
        elseif self.sprite.x < gx then
            self.sprite.x = math.min(gx, self.sprite.x + sp)
        end
        
        if gy < self.sprite.y then
            self.sprite.y = math.max(gy, self.sprite.y - sp)
        elseif self.sprite.y < gy then
            self.sprite.y = math.min(gy, self.sprite.y + sp)
        end
        if self.sprite.x == gx and self.sprite.y == gy then
            self.goalX = nil
            self.goalY = nil
        end
    end
end

function Character:setGoal(x, y)
    self.goalX = x 
    self.goalY = y
end

function Character:addBasicAttack(angle)
    local ind = #self.basicAttacks + 1
    local basicAttack = BasicAttack:new(self, ind, self.sprite.x, self.sprite.y, self.basicCooldown, self.basicName, self.basicSpeed, angle)
    self.basicAttacks[ind] = basicAttack
end

function Character:endAbility()
    -- set proper x and y coordinates for ability icons based on order
    for ind, val in pairs(self.abilities) do
        val.x = 12 + ((ind - 1) * 102)
        val.y = 510
    end
end

function Character:addAbility(ab)
    -- add and attach ability
    self.abilities[#self.abilities + 1] = ab
    ab:attach(self)
end

function Character:damage(amt)
    -- deal damage
    self.curHealth = math.max(self.curHealth - amt, 0)

    -- get index for next open spot in numbers
    local ind = #stateList['battle'].numbers + 1

    -- add damage number to numbers
    stateList['battle'].numbers[ind] = Number:new(ind, self, amt, 'DAMAGE')
end

function Character:heal(amt)
    -- check if character is missing health
    if self.curHealth < self.maxHealth then
        -- heal
        self.curHealth = math.min(self.curHealth + amt, self.maxHealth)

        -- get index for next open spot in numbers
        local ind = #stateList['battle'].numbers + 1

        -- add healing number to numbers
        stateList['battle'].numbers[ind] = Number:new(ind, self, amt, 'HEAL')
    end
end