-- example of an ability that deals direct damage
RhogarRootAttack = {}
RhogarRootAttack.__index = RhogarRootAttack
setmetatable(RhogarRootAttack, Ability)

function RhogarRootAttack:new(user)
    -- true because targetable
    local rhogarRootAttack = Ability:new(false)
    setmetatable(rhogarRootAttack, RhogarRootAttack)

    -- set x, y, width, height, cooldown (in seconds), and name
    rhogarRootAttack:set(0, 0, 80, 80, 5, 'rhogarroot')

    -- create description text
    rhogarRootAttack.desc = font:printToCanvas('hit an enemy and root them to the ground', 189, 38, 'left')

    rhogarRootAttack.character = user

    rhogarRootAttack.damage = 10

    return rhogarRootAttack
end

function RhogarRootAttack:attach(character)
    Ability.attach(self, character)
end

function RhogarRootAttack:use(dir)
    if Ability.use(self) then
        local angle = nil
        if self.character.isAI then angle = dir 
        else angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x) end
        --self.character:addBasicAttack(self.damage, angle, 0.4, 0, 'root', 2)
        local ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.4, 'rhogarroot.sprite', self.character.basicSpeed, angle, 0, 'root', 2)
        self.character.basicAttacks[ind] = basicAttack
    end
end