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
    nissaHeal.desc = font:printToCanvas('heal for an ally', 378, 76, 'left')

    nissaHeal.character = user

    nissaHeal.damage = 15 --(heal)

    return nissaHeal
end

function NissaHeal:attach(character)
    Ability.attach(self, character)
end

function NissaHeal:use()
    if Ability.use(self) then
        local goalX = mouse.x
        local goalY = mouse.y
        local angle = math.atan2(self.character.sprite.y - goalY, self.character.sprite.x - goalX)
        self.character:addBasicAttack(self.damage, angle, 0.5, 0, 'heal', 0)
    end
end