-- example of an ability with a passive effect

AbilityExamplePassive = {}
AbilityExamplePassive.__index = AbilityExamplePassive
setmetatable(AbilityExamplePassive, Ability)

function AbilityExamplePassive:new(user)
    -- true because targetable
    local abilityExamplePassive = Ability:new(true) 
    setmetatable(abilityExamplePassive, AbilityExamplePassive)

    -- set x, y, width, height, cooldown (in seconds), and name
    abilityExamplePassive:set(0, 0, 80, 80, 2, 'abilityExamplePassive')

    -- create description text
    abilityExamplePassive.desc = font:printToCanvas('regain 1 health every 0.5 seconds [passive].', 189, 38, 'left')

    return abilityExamplePassive
end

function AbilityExamplePassive:attach(character)
    Ability.attach(self, character)

    -- when attaching
    -- get index of next available dot
    local ind = #character.dots + 1

    -- add dot to character
    character.dots[ind] = DotAbilityExamplePassive:new(ind, character)
end

function AbilityExamplePassive:use()
    -- pass
end