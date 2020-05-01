-- example of an ability that deals direct damage
AnderPowerAttack = {}
AnderPowerAttack.__index = AnderPowerAttack
setmetatable(AnderPowerAttack, Ability)

function AnderPowerAttack:new(user)
    -- true because targetable
    local anderPowerAttack = Ability:new(false)
    setmetatable(anderPowerAttack, AnderPowerAttack)

    -- set x, y, width, height, cooldown (in seconds), and name
    anderPowerAttack:set(0, 0, 80, 80, 5, 'anderpowerattack')

    -- create description text
    anderPowerAttack.desc = font:printToCanvas('a really high damage attack', 189, 38, 'left')

    anderPowerAttack.character = user

    anderPowerAttack.damage = 20

    return anderPowerAttack
end

function AnderPowerAttack:attach(character)
    Ability.attach(self, character)
end

function AnderPowerAttack:use(dir)
    if Ability.use(self) then
        local goalX = mouse.x
        local goalY = mouse.y
        local angle = math.atan2(self.character.sprite.y - goalY, self.character.sprite.x - goalX)
        
        local ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.2, 'anderpowerattack.sprite', self.character.basicSpeed / 2, math.pi, 0, 'debuff', 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
        basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.2, 'anderpowerattack.sprite', self.character.basicSpeed / 2, math.pi / 3, 0, 'debuff', 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
        basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.2, 'anderpowerattack.sprite', self.character.basicSpeed / 2, 2 * math.pi / 3, 0, 'debuff', 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
        basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.2, 'anderpowerattack.sprite', self.character.basicSpeed / 2, 2 * math.pi, 0, 'debuff', 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
        basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.2, 'anderpowerattack.sprite', self.character.basicSpeed / 2, 4 * math.pi / 3, 0, 'debuff', 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
        basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.2, 'anderpowerattack.sprite', self.character.basicSpeed / 2, 5 * math.pi / 3, 0, 'debuff', 2)
        self.character.basicAttacks[ind] = basicAttack
    end
end