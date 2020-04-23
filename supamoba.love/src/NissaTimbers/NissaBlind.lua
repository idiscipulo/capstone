-- example of an ability that deals direct damage
NissaBlind = {}
NissaBlind.__index = NissaBlind
setmetatable(NissaBlind, Ability)

function NissaBlind:new(user)
    -- true because targetable
    local nissaBlind = Ability:new(false)
    setmetatable(nissaBlind, NissaBlind)

    -- set x, y, width, height, cooldown (in seconds), and name
    nissaBlind:set(0, 0, 80, 80, 5, 'abilityExampleDirectDamage')

    -- create description text
    nissaBlind.desc = font:printToCanvas('blind an enemy so that they cannot use abilites', 378, 76, 'left')

    nissaBlind.character = user

    nissaBlind.damage = 4

    nissaBlind.effect = 'blind'
    nissaBlind.effectTimer = 5

    return nissaBlind
end

function NissaBlind:attach(character)
    Ability.attach(self, character)
end

function NissaBlind:use()
    if Ability.use(self) then
        local goalX = mouse.x
        local goalY = mouse.y
        local angle = math.atan2(self.character.sprite.y - goalY, self.character.sprite.x - goalX)
        self.character:addBasicAttack(self.damage, angle, 0.5, 0, self.effect, self.effectTimer)
    end
end