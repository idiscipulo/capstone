-- example of an ability that deals direct damage

AbilityExampleDirectDamage = {}
AbilityExampleDirectDamage.__index = AbilityExampleDirectDamage
setmetatable(AbilityExampleDirectDamage, Ability)

function AbilityExampleDirectDamage:new(user)
    -- true because targetable
    local abilityExampleDirectDamage = Ability:new(true)
    setmetatable(abilityExampleDirectDamage, AbilityExampleDirectDamage)

    -- set x, y, width, height, cooldown (in seconds), and name
    abilityExampleDirectDamage:set(0, 0, 80, 80, 2, 'abilityExampleDirectDamage')

    -- create description text
    abilityExampleDirectDamage.desc = font:printToCanvas('deal 30 damage to the target.', 378, 76, 'left')

    return abilityExampleDirectDamage
end

function AbilityExampleDirectDamage:attach(character)
    Ability.attach(self, character)
end

function AbilityExampleDirectDamage:use(target)
    if Ability.use(self) then
        local amt = 30
        -- deal 30 damage to the target
        target:damage(amt)
    end
end