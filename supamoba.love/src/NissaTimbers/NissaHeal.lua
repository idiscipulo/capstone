-- example of an ability that deals direct damage
NissaHeal = {}
NissaHeal.__index = NissaHeal
setmetatable(NissaHeal, Ability)

function NissaHeal:new(user)
    -- true because targetable
    local nissaHeal = Ability:new(false)
    setmetatable(nissaHeal, NissaHeal)

    -- set x, y, width, height, cooldown (in seconds), and name
    nissaHeal:set(0, 0, 80, 80, 5, 'nissaheal')

    -- create description text
    nissaHeal.desc = font:printToCanvas('supamoba', 189, 38, 'left')

    nissaHeal.character = user

    nissaHeal.damage = 15 --(heal)

    nissaHeal.effect = 'heal'

    return nissaHeal
end

function NissaHeal:attach(character)
    Ability.attach(self, character)
end

function NissaHeal:use(dir)
    if Ability.use(self) then
        local angle = nil
        if self.character.isAI then 
            angle = dir 
        else 
            angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x) 
        end

        local ind = #self.character.basicAttacks + 1
                                            --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.4, 'nissaheal.sprite', self.character.basicSpeed, angle, 0, self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack
    end
end