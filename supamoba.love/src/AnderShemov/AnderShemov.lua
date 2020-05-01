AnderShemov = {}
AnderShemov.__index = AnderShemov
setmetatable(AnderShemov, Character)

function AnderShemov:new()
    local anderShemov = Character:new()
    setmetatable(anderShemov, AnderShemov)

    -- icon image
    anderShemov.icon = love.graphics.newImage('img/AnderShemov.icon.png')

    -- max and current health
    anderShemov.maxHealth = 150
    anderShemov.curHealth = 150

    -- set move speed
    anderShemov.speed = 2

    -- basic attack stats
    anderShemov.basicSpeed = 8
    anderShemov.basicName = 'basic.sprite' 
    anderShemov.basicCooldown = 1

    anderShemov.backstory = font:printToCanvas('fueled by magical rage, he rushes down foes with a vengance.', 189, 38, 'left')

    -- basic attack cooldown
    anderShemov.attackTimerMax = 1
    anderShemov.attackTimer = anderShemov.attackTimerMax

    -- dash timer
    anderShemov.dashTimerMax = 0.1
    anderShemov.dashTimer = anderShemov.dashTimerMax
    anderShemov.isDashing = false

    -- set sprite location, size, and name for image file
    anderShemov.sprite:set(500, 250, 16, 16, 'AnderShemov')

    -- set name
    anderShemov.textName = 'Ander Shemov'
    anderShemov.name = font:printToCanvas('Ander Shemov', 160, 10, 'center')

    -- initialize ability table
    anderShemov.abilities = {}
    
    -- add ability
    anderShemov:addAbility(AnderDash:new())
    anderShemov:addAbility(AnderArmorDebuff:new())
    anderShemov:addAbility(AnderPowerAttack:new())
    -- anderShemov:addAbility(AbilityExamplePassive:new())

    -- finish adding abilities
    anderShemov:endAbility()

    return anderShemov
end

function AnderShemov:update()
    Character.update(self)

    if self.isDashing then 
        self.dashTimer = self.dashTimer - timer.fps
        if self.dashTimer < 0 then 
            self.dashTimer = self.dashTimerMax
            self.speed = self.speed / 12
            self.isDashing = false 
        end
    end
end