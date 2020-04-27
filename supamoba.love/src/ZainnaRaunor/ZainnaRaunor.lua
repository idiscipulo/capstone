ZainnaRaunor = {}
ZainnaRaunor.__index = ZainnaRaunor
setmetatable(ZainnaRaunor, Character)

function ZainnaRaunor:new()
    local zainnaRaunor = Character:new()
    setmetatable(zainnaRaunor, ZainnaRaunor)

    -- icon image
    zainnaRaunor.icon = love.graphics.newImage('img/ZainnaRaunor.icon.png')

    -- max and current health
    zainnaRaunor.maxHealth = 150
    zainnaRaunor.curHealth = 150

    -- set move speed
    zainnaRaunor.speed = 2

    -- basic attack stats
    zainnaRaunor.basicSpeed = 8
    zainnaRaunor.basicName = 'basic.sprite' 
    zainnaRaunor.basicCooldown = 1

    -- buff
    zainnaRaunor.isBuffed = false
    zainnaRaunor.isBuffedTimerMax = 4
    zainnaRaunor.isBuffedTimer = zainnaRaunor.isBuffedTimerMax

    -- basic attack cooldown
    zainnaRaunor.attackTimerMax = 0.5
    zainnaRaunor.attackTimer = zainnaRaunor.attackTimerMax

    -- set sprite location, size, and name for image file
    zainnaRaunor.sprite:set(500, 250, 16, 16, 'ZainnaRaunor')

    -- set name
    zainnaRaunor.textName = 'Zainna Raunor'
    zainnaRaunor.name = font:printToCanvas('Zainna Raunor', 160, 10, 'center')

    -- initialize ability table
    zainnaRaunor.abilities = {}
    
    -- add ability
    zainnaRaunor:addAbility(ZainnaBloodDamage:new())
    zainnaRaunor:addAbility(ZainnaBuff:new())
    zainnaRaunor:addAbility(ZainnaLifesteal:new())
    -- zainnaRaunor:addAbility(AbilityExamplePassive:new())

    -- finish adding abilities
    zainnaRaunor:endAbility()

    return zainnaRaunor
end

function ZainnaRaunor:update()
    Character.update(self)

    --run buff timer
    if self.isBuffed then 
        self.isBuffedTimer = self.isBuffedTimer - timer.fps 
        if self.isBuffedTimer < 0 then 
            self.speed = self.speed / self.abilities[2].moveMultiplier
            self.basicSpeed = self.basicSpeed / self.abilities[2].attackMultiplier
            self.isBuffedTimer = self.isBuffedTimerMax 
            self.isBuffed = false 
        end
    end
end