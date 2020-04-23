-- example of an ability that deals direct damage
PaeliasBuff = {}
PaeliasBuff.__index = PaeliasBuff
setmetatable(PaeliasBuff, Ability)

function PaeliasBuff:new(user)
    -- true because targetable
    local paeliasBuff = Ability:new(false)
    setmetatable(paeliasBuff, PaeliasBuff)

    -- set x, y, width, height, cooldown (in seconds), and name
    paeliasBuff:set(0, 0, 80, 80, 14, 'abilityExampleDirectDamage')

    -- create description text
    paeliasBuff.desc = font:printToCanvas('take half damage for a short time', 378, 76, 'left')

    paeliasBuff.character = user

    return paeliasBuff
end

function PaeliasBuff:attach(character)
    Ability.attach(self, character)
end

function PaeliasBuff:use()
    if Ability.use(self) then
        self.character.isBuffed = true
    end
end