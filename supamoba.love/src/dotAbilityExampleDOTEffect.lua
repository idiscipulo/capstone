-- example of a dot effect, applied by AbilityExampleDOTEffect

DotAbilityExampleDOTEffect = {}
DotAbilityExampleDOTEffect.__index = DotAbilityExampleDOTEffect
setmetatable(DotAbilityExampleDOTEffect, Dot)

function DotAbilityExampleDOTEffect:new(ind, character)
    -- create dot with cooldown of 3
    local dotAbilityExampleDOTEffect = Dot:new(ind, character, 3)
    setmetatable(dotAbilityExampleDOTEffect, DotAbilityExampleDOTEffect)

    return dotAbilityExampleDOTEffect
end

function DotAbilityExampleDOTEffect:tick()
    if Dot.tick(self) then
        -- compute damage, this is an example of percent health damage
        local amt = self.character.maxHealth * 0.025

        -- deal damage
        self.character:damage(amt)
    end
end