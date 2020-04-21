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
    rhogarNemmonis.speed = 4

    -- basic attack stats
    rhogarNemmonis.basicSpeed = 8
    rhogarNemmonis.basicName = 'charExample.sprite' 
    rhogarNemmonis.basicCooldown = 1

    -- basic attack cooldown
    rhogarNemmonis.attackTimerMax = 1
    rhogarNemmonis.attackTimer = rhogarNemmonis.attackTimerMax

    -- set sprite location, size, and name for image file
    rhogarNemmonis.sprite:set(500, 250, 16, 16, 'charExample')

    -- set name
    rhogarNemmonis.name = font:printToCanvas('Rhogar Nemmonis', 160, 10, 'center')

    -- initialize ability table
    rhogarNemmonis.abilities = {}
    
    -- add ability
    rhogarNemmonis:addAbility(AbilityScatterShot:new())
    rhogarNemmonis:addAbility(AbilityRapidAttack:new())
    rhogarNemmonis:addAbility(AbilityExampleAOEEffect:new())
    rhogarNemmonis:addAbility(AbilityExamplePassive:new())

    -- finish adding abilities
    rhogarNemmonis:endAbility()

    return rhogarNemmonis
end