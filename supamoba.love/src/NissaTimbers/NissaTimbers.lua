NissaTimbers = {}
NissaTimbers.__index = NissaTimbers
setmetatable(NissaTimbers, Character)

function NissaTimbers:new()
    local nissaTimbers = Character:new()
    setmetatable(nissaTimbers, NissaTimbers)

    -- icon image
    nissaTimbers.icon = love.graphics.newImage('img/NissaTimbers.icon.png')

    -- max and current health
    nissaTimbers.maxHealth = 150
    nissaTimbers.curHealth = 150

    nissaTimbers.backstory = font:printToCanvas('a healing druid with a fey touched soul, she never wavers.', 189, 38, 'left')

    -- set move speed
    nissaTimbers.speed = 2

    -- basic attack stats
    nissaTimbers.basicSpeed = 8
    nissaTimbers.basicName = 'basic.sprite' 
    nissaTimbers.basicCooldown = 1

    -- basic attack cooldown
    nissaTimbers.attackTimerMax = 1
    nissaTimbers.attackTimer = nissaTimbers.attackTimerMax

    -- set sprite location, size, and name for image file
    nissaTimbers.sprite:set(500, 250, 16, 16, 'NissaTimbers')

    -- set name
    nissaTimbers.textName = 'Nissa Timbers'
    nissaTimbers.name = font:printToCanvas('Nissa Timbers', 160, 10, 'center')

    -- initialize ability table
    nissaTimbers.abilities = {}
    
    -- add ability
    nissaTimbers:addAbility(NissaHeal:new())
    nissaTimbers:addAbility(NissaBlind:new())
    nissaTimbers:addAbility(NissaSlow:new())
    -- nissaTimbers:addAbility(AbilityExamplePassive:new())

    -- finish adding abilities
    nissaTimbers:endAbility()

    return nissaTimbers
end

function NissaTimbers:update()
    Character.update(self)
end