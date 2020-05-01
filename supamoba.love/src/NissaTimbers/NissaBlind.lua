-- example of an ability that deals direct damage
NissaBlind = {}
NissaBlind.__index = NissaBlind
setmetatable(NissaBlind, Ability)

function NissaBlind:new(user)
    -- true because targetable
    local nissaBlind = Ability:new(false)
    setmetatable(nissaBlind, NissaBlind)

    -- set x, y, width, height, cooldown (in seconds), and name
    nissaBlind:set(0, 0, 80, 80, 5, 'nissablind')

    -- create description text
    nissaBlind.desc = font:printToCanvas('blind an enemy so that they cannot use abilites', 189, 38, 'left')

    nissaBlind.character = user

    nissaBlind.damage = 15

    nissaBlind.effect = 'blind'
    nissaBlind.effectTimer = 5

    return nissaBlind
end

function NissaBlind:attach(character)
    Ability.attach(self, character)
end

function NissaBlind:use(dir)
    if Ability.use(self) then
        local angle = nil
        if self.character.isAI then 
            angle = dir 
        else 
            angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x) 
        end

        local ind = #self.character.basicAttacks + 1
                                            --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.4, 'nissablind.sprite', self.character.basicSpeed, angle, 0, self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack
    end
end