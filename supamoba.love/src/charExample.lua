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
    charExample.speed = 4

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
    charExample:addAbility(AbilityExamplePassive:new())

    -- finish adding abilities
    charExample:endAbility()

    return charExample
end