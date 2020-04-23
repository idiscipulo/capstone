-- example of an ability that deals direct damage
AnderArmorDebuff = {}
AnderArmorDebuff.__index = AnderArmorDebuff
setmetatable(AnderArmorDebuff, Ability)

function AnderArmorDebuff:new(user)
    -- true because targetable
    local anderArmorDebuff = Ability:new(false)
    setmetatable(anderArmorDebuff, AnderArmorDebuff)

    -- set x, y, width, height, cooldown (in seconds), and name
    anderArmorDebuff:set(0, 0, 80, 80, 1, 'abilityExampleDirectDamage')

    -- create description text
    anderArmorDebuff.desc = font:printToCanvas('enemies take double damage for 2 seconds.', 189, 38, 'left')

    anderArmorDebuff.character = user

    anderArmorDebuff.damage = 0

    return anderArmorDebuff
end

function AnderArmorDebuff:attach(character)
    Ability.attach(self, character)
end

function AnderArmorDebuff:use()
    if Ability.use(self) then
        local angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x)

        local ind = #self.character.basicAttacks + 1
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.08, self.character.basicName, self.character.basicSpeed / 2, angle, 0, 'debuff', 2)
        self.character.basicAttacks[ind] = basicAttack
    end
end