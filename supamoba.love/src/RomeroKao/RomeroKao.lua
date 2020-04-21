

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
    romeroKao.name = font:printToCanvas('Romero Kao', 160, 10, 'center')

    -- initialize ability table
    romeroKao.abilities = {}
    
    -- add ability
    romeroKao:addAbility(AbilityScatterShot:new())
    romeroKao:addAbility(AbilityRapidAttack:new())
    romeroKao:addAbility(AbilityExampleAOEEffect:new())
    romeroKao:addAbility(AbilityExamplePassive:new())

    -- finish adding abilities
    romeroKao:endAbility()

    return romeroKao
end