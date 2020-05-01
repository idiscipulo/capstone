-- parent class for characters 

Character = {}
Character.__index = Character

function Character:new()
    local character = {}
    setmetatable(character, Character)

    -- icon
    character.icon = nil

    character.isAI = true

    -- sprite
    character.sprite = Sprite:new()

    character.backstory = font:printToCanvas('Backstory: my family was killed', 189, 38, 'left')

    character.range = 120

    -- max and current health
    character.maxHealth = 0
    character.curHealth = 0

    -- death tracker
    character.isDead = false
    character.deathTime = 0

    character.team = nil

    -- goal x and y
    character.goalX = nil 
    character.goalY = nil

    -- dots table
    character.dots = {}

    -- name
    character.name = nil

    -- table of all active basic attacks
    character.basicAttacks = {}

    --move speed
    character.speed = 1.5

    -- basic attack stats
    character.basicDamage = 3
    character.basicSpeed = nil
    character.basicRange = 120
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

    --damage cooldown
    character.damageCooldownTimerMax = 0.03
    character.damageCooldownTimer = character.damageCooldownTimerMax
    character.canTakeDamage = true

    -- root a character in place
    character.isRootedTimer = nil
    character.isRootedTimerMax = nil
    character.isRooted = false

    -- blind a character (cannot use abilities)
    character.isBlindedTimer = nil 
    character.isBlinded = false

    -- slow character movement
    character.isSlowedTimer = nil
    character.isSlowed = false

    -- armor debuff (take more damage)
    character.isDebuffedTimer = nil
    character.isDebuffed = false

    character.isBuffed = false

    -- dash
    character.isDashing = false

    return character
end

function Character:update()
    -- update dots
    for ind, val in pairs(self.dots) do
        val:tick()
    end

    -- if self.curHealth <= 0 then self.isDead = true end

    --run basic attack cooldown timer
    if not self.canAttack then 
        self.attackTimer = self.attackTimer - timer.fps
        if self.attackTimer < 0 then 
            self.attackTimer = self.attackTimerMax
            self.canAttack = true
        end
    end

    --run root timer 
    if self.isRooted then 
        self.isRootedTimer = self.isRootedTimer - timer.fps 
        if self.isRootedTimer < 0 then 
            self.isRootedTimer = self.isRootedTimerMax 
            self.isRooted = false 
        end
    end

    --run blind timer
    if self.isBlinded then 
        self.isBlindedTimer = self.isBlindedTimer - timer.fps 
        if self.isBlindedTimer < 0 then 
            self.isBlindedTimer = nil 
            self.isBlinded = false 
        end
    end

    --run slow timer
    if self.isSlowed then 
        self.isSlowedTimer = self.isSlowedTimer - timer.fps 
        if self.isSlowedTimer < 0 then 
            self.isSlowedTimer = nil 
            self.speed = self.speed * 4.0
            self.isSlowed = false 
        end
    end

    --run debuff timer
    if self.isDebuffed then 
        self.isDebuffedTimer = self.isDebuffedTimer - timer.fps 
        if self.isDebuffedTimer < 0 then 
            self.isDebuffedTimer = nil 
            self.isDebuffed = false 
        end
    end

    if not self.canTakeDamage then 
        self.damageCooldownTimer = self.damageCooldownTimer - timer.fps
        if self.damageCooldownTimer < 0 then 
            self.canTakeDamage = true 
            self.damageCooldownTimer = self.damageCooldownTimerMax
        end
    end
    
    --move if character is not yet at goal
    if self.sprite.x ~= self.goalX or self.sprite.y ~= self.goalY then
        self:move() -- move
    end

    -- update sprite
    self.sprite:update()
end

function Character:move()
    if self.goalX ~= nil and self.goalY ~= nil and not self.isRooted then
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
        --if self.sprite.y < nil and self.sprite.y > nil then 

            if gy < self.sprite.y then
                self.sprite.y = math.max(gy, self.sprite.y - sp)
            elseif self.sprite.y < gy then
                self.sprite.y = math.min(gy, self.sprite.y + sp)
            end
            if self.sprite.x == gx and self.sprite.y == gy then
                self.goalX = nil
                self.goalY = nil
            end
        --end
    end
end

function Character:setGoal(x, y)
    self.goalX = math.max(35, math.min(x, 1149))
    self.goalY = math.max(113, math.min(y, 434))
end

function Character:addBasicAttack(damage, angle, cooldown, delay, effect, effectTimer)
    local ind = #self.basicAttacks + 1
                                      --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
    local basicAttack = BasicAttack:new(damage, self, ind, self.sprite.x, self.sprite.y, cooldown, self.basicName, self.basicSpeed, angle, delay, effect, effectTimer)
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

function Character:takeDamage(amt)
 
    if self.deathTime == 0 then
        if self.isBuffed then amt = amt / 2 end 
        if self.isDebuffed then amt = amt * 2 end 

        if not self.isInvulnerable and self.canTakeDamage then 
            self.canTakeDamage = false
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

function Character:applyEffect(effect, effectTimer)
    if effect == 'root' then 
        self.isRootedTimer = effectTimer
        self.isRooted = true
    end
    if effect == 'blind' then 
        self.isBlindedTimer = effectTimer
        self.isBlinded = true
    end
    if effect == 'slow' and not self.isSlowed then 
        self.isSlowedTimer = effectTimer
        self.speed = self.speed / 4.0
        self.isSlowed = true 
    end
    if effect == 'debuff' then 
        self.isDebuffedTimer = effectTimer
        self.isDebuffed = true 
    end
end

function Character:getClosestEnemy() --returns x, y of nearest enemy
    local enemyDistances = {}
    local enemyList = {}
    for ind, val in pairs(stateList['battle'].ents) do 
        if val.team ~= self.team and not val.isDead then 
            local enemyDistance = math.sqrt((self.sprite.x - val.sprite.x)^2 + (self.sprite.y - val.sprite.y)^2)
            enemyDistances[#enemyDistances + 1] = enemyDistance
            enemyList[#enemyList + 1] = val
        end
    end
    local key = 1
    local min = enemyDistances[1]
    for ind, val in pairs(enemyDistances) do
        if val < min then
            key = ind
            min = val
        end
    end
    return enemyList[key].sprite.x, enemyList[key].sprite.y
end

function Character:getClosestAlly() --returns x, y of nearest enemy
    local allyDistances = {}
    local allyList = {}
    for ind, val in pairs(stateList['battle'].ents) do 
        if val.team == self.team and not val.isDead and not val.isTower then 
            local allyDistance = math.sqrt((self.sprite.x - val.sprite.x)^2 + (self.sprite.y - val.sprite.y)^2)
            allyDistances[#allyDistances + 1] = allyDistance
            allyList[#allyList + 1] = val
        end
    end
    local key = 1
    local min = allyDistances[1]
    for ind, val in pairs(allyDistances) do
        if val < min then
            key = ind
            min = val
        end
    end
    return allyList[key].sprite.x, allyList[key].sprite.y
end