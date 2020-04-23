-- example of an ability that deals direct damage
RhogarRootAttack = {}
RhogarRootAttack.__index = RhogarRootAttack
setmetatable(RhogarRootAttack, Ability)

function RhogarRootAttack:new(user)
    -- true because targetable
    local rhogarRootAttack = Ability:new(false)
    setmetatable(rhogarRootAttack, RhogarRootAttack)

    -- set x, y, width, height, cooldown (in seconds), and name
    rhogarRootAttack:set(0, 0, 80, 80, 5, 'abilityExampleDirectDamage')

    -- create description text
    rhogarRootAttack.desc = font:printToCanvas('hit an enemy and root them to the ground', 378, 76, 'left')

    rhogarRootAttack.character = user

    rhogarRootAttack.damage = 10

    return rhogarRootAttack
end

function RhogarRootAttack:attach(character)
    Ability.attach(self, character)
end

function RhogarRootAttack:use()
    if Ability.use(self) then
        local goalX = mouse.x
        local goalY = mouse.y
        local angle = math.atan2(self.character.sprite.y - goalY, self.character.sprite.x - goalX)
        self.character:addBasicAttack(self.damage, angle, 0.4, 0, 'root', 2)
    end
end