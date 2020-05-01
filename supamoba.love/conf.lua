function love.conf(t)
    -- utilities
    require('src/font')
    require('src/timer')
    require('src/AIController')

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
    require('src/particleAbilityRoot')
    

    -- sprite class
    require('src/sprite')

    -- parent class for characters
    require('src/character')

    -- list characters below
    require('src/charExample')

    --Tower
    require('src/tower')
    
    --Romero Kao
    require('src/RomeroKao/RomeroKao')
    require('src/RomeroKao/romeroScatterShot')
    require('src/RomeroKao/romeroRapidAttack')
    require('src/RomeroKao/romeroAOE')

    --Rhogar Nemmonis
    require('src/RhogarNemmonis/RhogarNemmonis')
    require('src/RhogarNemmonis/rhogarRootAttack')
    require('src/RhogarNemmonis/rhogarInvulnerable')
    require('src/RhogarNemmonis/rhogarReflectAttack')

    --Nissa Timbers
    require('src/NissaTimbers/NissaTimbers')
    require('src/NissaTimbers/NissaHeal')
    require('src/NissaTimbers/NissaBlind')
    require('src/NissaTimbers/NissaSlow')

    --Paelias Amakir
    require('src/PaeliasAmakir/PaeliasAmakir')
    require('src/PaeliasAmakir/PaeliasAOERoot')
    require('src/PaeliasAmakir/PaeliasBuff')
    require('src/PaeliasAmakir/PaeliasAOEHeal')
    require('src/particleAbilityHeal')
    --require('src/PaeliasAmakir/')

    --Ander Shemov
    require('src/AnderShemov/AnderShemov')
    require('src/AnderShemov/anderDash')
    require('src/AnderShemov/anderArmorDebuff')
    require('src/AnderShemov/anderPowerAttack')

    --Zainna Raunor
    require('src/ZainnaRaunor/ZainnaRaunor')
    require('src/ZainnaRaunor/ZainnaBloodDamage')
    require('src/ZainnaRaunor/ZainnaBuff')
    require('src/ZainnaRaunor/ZainnaLifesteal')

    -- list states below
    require('src/select')
    require('src/battle')

    -- set true for templating information to be shown
    temp = false

    debug = 0

    -- set true for console output to be shown
    t.console = true
end