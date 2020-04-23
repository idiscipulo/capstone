-- example of an ability that deals direct damage
ZainnaLifesteal = {}
ZainnaLifesteal.__index = ZainnaLifesteal
setmetatable(ZainnaLifesteal, Ability)

function ZainnaLifesteal:new(user)
    -- true because targetable
    local zainnaLifesteal = Ability:new(false)
    setmetatable(zainnaLifesteal, ZainnaLifesteal)

    -- set x, y, width, height, cooldown (in seconds), and name
    zainnaLifesteal:set(0, 0, 80, 80, 14, 'abilityExampleDirectDamage')

    -- create description text
    zainnaLifesteal.desc = font:printToCanvas('regain damage dealt as health', 189, 38, 'left')

    zainnaLifesteal.character = user

    zainnaLifesteal.damage = 10

    return zainnaLifesteal
end

function ZainnaLifesteal:attach(character)
    Ability.attach(self, character)
end

function ZainnaLifesteal:use()
    if Ability.use(self) then
        local angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x)
        self.character:addBasicAttack(self.damage, angle, 0.4, 0, 'lifesteal', 0)
    end
end