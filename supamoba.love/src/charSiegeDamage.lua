

CharSiegeDamage = {}
CharSiegeDamage.__index = CharSiegeDamage
setmetatable(CharSiegeDamage, Character)

function CharSiegeDamage:new()
    local charSiegeDamage = Character:new()
    setmetatable(charSiegeDamage, CharSiegeDamage)

    -- icon image
    charSiegeDamage.icon = love.graphics.newImage('img/charExample.icon.png')

    -- max and current health
    charSiegeDamage.maxHealth = 150
    charSiegeDamage.curHealth = 150

    -- set move speed
    charSiegeDamage.speed = 4

    -- basic attack stats
    charSiegeDamage.basicSpeed = 4
    charSiegeDamage.basicName = 'charExample.sprite' 
    charSiegeDamage.basicCooldown = 1

    -- basic attack cooldown
    charSiegeDamage.attackTimerMax = 1
    charSiegeDamage.attackTimer = charSiegeDamage.attackTimerMax

    -- set sprite location, size, and name for image file
    charSiegeDamage.sprite:set(500, 250, 16, 16, 'charExample')

    -- set name
    charSiegeDamage.name = font:printToCanvas('example character', 160, 10, 'center')

    -- initialize ability table
    charSiegeDamage.abilities = {}
    
    -- add ability
    charSiegeDamage:addAbility(AbilityScatterShot:new())
    charSiegeDamage:addAbility(AbilityExampleDOTEffect:new())
    charSiegeDamage:addAbility(AbilityExampleAOEEffect:new())
    charSiegeDamage:addAbility(AbilityExamplePassive:new())

    -- finish adding abilities
    charSiegeDamage:endAbility()

    return charSiegeDamage
end