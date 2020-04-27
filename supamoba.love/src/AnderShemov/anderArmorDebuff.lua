-- example of an ability that deals direct damage
AnderArmorDebuff = {}
AnderArmorDebuff.__index = AnderArmorDebuff
setmetatable(AnderArmorDebuff, Ability)

function AnderArmorDebuff:new(user)
    -- true because targetable
    local anderArmorDebuff = Ability:new(false)
    setmetatable(anderArmorDebuff, AnderArmorDebuff)

    -- set x, y, width, height, cooldown (in seconds), and name
    anderArmorDebuff:set(0, 0, 80, 80, 1, 'anderarmordebuff')

    -- create description text
    anderArmorDebuff.desc = font:printToCanvas('enemies take double damage for 2 seconds.', 189, 38, 'left')

    anderArmorDebuff.character = user

    anderArmorDebuff.damage = 0

    return anderArmorDebuff
end

function AnderArmorDebuff:attach(character)
    Ability.attach(self, character)
end

function AnderArmorDebuff:use(dir)
    if Ability.use(self) then
        local angle = nil
        if self.character.isAI then angle = dir 
        else angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x) end 

        local ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.1, 'anderarmordebuff.sprite', self.character.basicSpeed / 2, math.pi, 0, 'debuff', 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
        basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.1, 'anderarmordebuff.sprite', self.character.basicSpeed / 2, math.pi / 3, 0, 'debuff', 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
        basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.1, 'anderarmordebuff.sprite', self.character.basicSpeed / 2, 2 * math.pi / 3, 0, 'debuff', 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
        basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.1, 'anderarmordebuff.sprite', self.character.basicSpeed / 2, 2 * math.pi, 0, 'debuff', 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
        basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.1, 'anderarmordebuff.sprite', self.character.basicSpeed / 2, 4 * math.pi / 3, 0, 'debuff', 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
        basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.1, 'anderarmordebuff.sprite', self.character.basicSpeed / 2, 5 * math.pi / 3, 0, 'debuff', 2)
        self.character.basicAttacks[ind] = basicAttack
    end
end