-- example of an ability that deals direct damage
RhogarReflectAttack = {}
RhogarReflectAttack.__index = RhogarReflectAttack
setmetatable(RhogarReflectAttack, Ability)

function RhogarReflectAttack:new(user)
    -- true because targetable
    local rhogarReflectAttack = Ability:new(true)
    setmetatable(rhogarReflectAttack, RhogarReflectAttack)

    -- set x, y, width, height, cooldown (in seconds), and name
    rhogarReflectAttack:set(0, 0, 80, 80, 5, 'abilityExampleDirectDamage')

    -- create description text
    rhogarReflectAttack.desc = font:printToCanvas('reflect an attack to the nearest enemy', 378, 76, 'left')

    rhogarReflectAttack.character = user

    return rhogarReflectAttack
end

function RhogarReflectAttack:attach(character)
    Ability.attach(self, character)
end

function RhogarReflectAttack:use()
    if Ability.use(self) then
        
    end
end