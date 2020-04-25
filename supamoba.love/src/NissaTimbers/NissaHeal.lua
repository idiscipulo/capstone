-- example of an ability that deals direct damage
NissaHeal = {}
NissaHeal.__index = NissaHeal
setmetatable(NissaHeal, Ability)

function NissaHeal:new(user)
    -- true because targetable
    local nissaHeal = Ability:new(false)
    setmetatable(nissaHeal, NissaHeal)

    -- set x, y, width, height, cooldown (in seconds), and name
    nissaHeal:set(0, 0, 80, 80, 5, 'abilityExampleDirectDamage')

    -- create description text
    nissaHeal.desc = font:printToCanvas('heal an ally', 189, 38, 'left')

    nissaHeal.character = user

    nissaHeal.damage = 15 --(heal)

    return nissaHeal
end

function NissaHeal:attach(character)
    Ability.attach(self, character)
end

function NissaHeal:use(dir)
    if Ability.use(self) then
        local angle = nil
        if self.character.isAI then angle = dir 
        else angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x) end
        self.character:addBasicAttack(self.damage, angle, 0.5, 0, 'heal', 0)
    end
end