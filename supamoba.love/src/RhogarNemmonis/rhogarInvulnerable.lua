-- example of an ability that deals direct damage
RhogarInvulnerable = {}
RhogarInvulnerable.__index = RhogarInvulnerable
setmetatable(RhogarInvulnerable, Ability)

function RhogarInvulnerable:new(user)
    -- true because targetable
    local rhogarInvulnerable = Ability:new(false)
    setmetatable(rhogarInvulnerable, RhogarInvulnerable)

    -- set x, y, width, height, cooldown (in seconds), and name
    rhogarInvulnerable:set(0, 0, 80, 80, 5, 'abilityExampleDirectDamage')

    -- create description text
    rhogarInvulnerable.desc = font:printToCanvas('become invulnerable to all damage for a short time', 378, 76, 'left')

    rhogarInvulnerable.character = user

    return rhogarInvulnerable
end

function RhogarInvulnerable:attach(character)
    Ability.attach(self, character)
end

function RhogarInvulnerable:use()
    if Ability.use(self) then
        self.character.isInvulnerable = true
    end
end