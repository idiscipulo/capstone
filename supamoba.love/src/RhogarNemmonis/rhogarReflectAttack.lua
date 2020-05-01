-- example of an ability that deals direct damage
RhogarReflectAttack = {}
RhogarReflectAttack.__index = RhogarReflectAttack
setmetatable(RhogarReflectAttack, Ability)

function RhogarReflectAttack:new(user)
    -- true because targetable
    local rhogarReflectAttack = Ability:new(false)
    setmetatable(rhogarReflectAttack, RhogarReflectAttack)

    -- set x, y, width, height, cooldown (in seconds), and name
    rhogarReflectAttack:set(0, 0, 80, 80, 10, 'rhogarreflect')

    -- create description text
    rhogarReflectAttack.desc = font:printToCanvas('reflect an attack to the nearest enemy', 189, 38, 'left')

    rhogarReflectAttack.character = user

    rhogarReflectAttack.isActive = false
    rhogarReflectAttack.timerMax = 5
    rhogarReflectAttack.timer = rhogarReflectAttack.timerMax

    return rhogarReflectAttack
end

function RhogarReflectAttack:attach(character)
    Ability.attach(self, character)
end

function RhogarReflectAttack:use(dir)
    if Ability.use(self) then
        self.isActive = true
    end
end