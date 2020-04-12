-- example of a passive effect, applied by AbilityExamplePassive

DotAbilityExamplePassive = {}
DotAbilityExamplePassive.__index = DotAbilityExamplePassive
setmetatable(DotAbilityExamplePassive, Dot)

function DotAbilityExamplePassive:new(ind, character)
    -- note how no cooldown is given, will never delete
    local dotAbilityExamplePassive = Dot:new(ind, character)
    setmetatable(dotAbilityExamplePassive, DotAbilityExamplePassive)

    return dotAbilityExamplePassive
end

function DotAbilityExamplePassive:tick()
    if Dot.tick(self) then
        -- heal the character by 1
        self.character:heal(1)
    end
end