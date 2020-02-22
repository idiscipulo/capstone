function love.conf(t)
    -- utilities
    require('src/font')
    require('src/timer')

    -- floating numbers
    require('src/number')

    -- parent class for aoe effects, called "particles"
    require('src/particle')

    -- basic attack
    require('src/basicAttack')

    -- list particles below
    require('src/particleAbilityExampleAOEEffect')

    -- parent class for buffs/debuffs, called "dots"
    require('src/dot')

    -- list dots below
    require('src/dotAbilityExamplePassive')
    require('src/dotAbilityExampleDOTEffect')

    -- parent class for abilities
    require('src/ability')

    -- list abilities below
    require('src/abilityExamplePassive')
    require('src/abilityExampleDOTEffect')
    require('src/abilityExampleAOEEffect')
    require('src/abilityExampleDirectDamage')
    require('src/abilityScatterShot')

    -- sprite class
    require('src/sprite')

    -- parent class for characters
    require('src/character')

    -- list characters below
    require('src/charExample')
    require('src/charSiegeDamage')

    -- list states below
    require('src/select')
    require('src/battle')

    -- set true for templating information to be shown
    temp = false

    -- set true for console output to be shown
    t.console = true
end