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

    -- invulnerability
    character.invulnerableTimerMax = nil
    character.invulnerableTimer = nil
    character.isInvulnerable = false

    -- can move
    character.canMoveTimerMax = nil
    character.canMoveTimer = nil
    character.canMove = true

    return character
end

function Character:move()
    if self.goalX ~= nil and self.goalY ~= nil and self.canMove then
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
    if not self.isInvulnerable then 
        -- deal damage
        self.curHealth = math.max(self.curHealth - amt, 0)

        -- get index for next open spot in numbers
        local ind = #stateList['battle'].numbers + 1

        -- add damage number to numbers
        stateList['battle'].numbers[ind] = Number:new(ind, self, amt, 'DAMAGE')
    end
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