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
    nissaHeal.desc = font:printToCanvas('shoot an arc of healing energy', 189, 38, 'left')

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
            allyX, allyY = self.character:getClosestAlly()
            angle = math.atan2(self.character.sprite.y - allyY, self.character.sprite.x - allyX) 
        else 
            angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x) 
        end

        --local ind = #self.character.basicAttacks + 1
                                            --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        --local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.4, 'nissaheal.sprite', self.character.basicSpeed, angle, 0, self.effect, 2)
        --self.character.basicAttacks[ind] = basicAttack
        local angle1 = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x)
        local angle2 = angle1 - math.pi/4
        local angle3 = angle1 - math.pi/8
        local angle4 = angle1 + math.pi/8
        local angle5 = angle1 + math.pi/4

        local ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'nissaheal.sprite', self.character.basicSpeed, angle1, 0.06, self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'nissaheal.sprite', self.character.basicSpeed, angle2, 0.12, self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'nissaheal.sprite', self.character.basicSpeed, angle3, 0.09, self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'nissaheal.sprite', self.character.basicSpeed, angle4, 0.03, self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'nissaheal.sprite', self.character.basicSpeed, angle5, 0.0, self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack    
    end
end