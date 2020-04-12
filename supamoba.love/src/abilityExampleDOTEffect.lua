-- example of an ability with an dot effect

AbilityExampleDOTEffect = {}
AbilityExampleDOTEffect.__index = AbilityExampleDOTEffect
setmetatable(AbilityExampleDOTEffect, Ability)

function AbilityExampleDOTEffect:new(user)
    -- true because targetable
    local abilityExampleDOTEffect = Ability:new(true)
    setmetatable(abilityExampleDOTEffect, AbilityExampleDOTEffect)

    -- set x, y, width, height, cooldown (in seconds), and name
    abilityExampleDOTEffect:set(0, 0, 80, 80, 5, 'abilityExampleDOTEffect')

    -- create description text
    abilityExampleDOTEffect.desc = font:printToCanvas('poison the target, dealing damage equal to 15% of their maximum health over 3 seconds.', 378, 76, 'left')

    return abilityExampleDOTEffect
end

function AbilityExampleDOTEffect:attach(character)
    Ability.attach(self, character)
end

function AbilityExampleDOTEffect:use(target)
    -- get index of next available dot
    local ind = #target.dots + 1
    if Ability.use(self) then
        -- add dot to target
        target.dots[ind] = DotAbilityExampleDOTEffect:new(ind, target)
    end
end