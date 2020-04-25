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
    nissaBlind.desc = font:printToCanvas('blind an enemy so that they cannot use abilites', 189, 38, 'left')

    nissaBlind.character = user

    nissaBlind.damage = 4

    nissaBlind.effect = 'blind'
    nissaBlind.effectTimer = 5

    return nissaBlind
end

function NissaBlind:attach(character)
    Ability.attach(self, character)
end

function NissaBlind:use(dir)
    if Ability.use(self) then
        local angle = nil
        if self.character.isAI then angle = dir 
        else angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x) end
        self.character:addBasicAttack(self.damage, angle, 0.5, 0, self.effect, self.effectTimer)
    end
end