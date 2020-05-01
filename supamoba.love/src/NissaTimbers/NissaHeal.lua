-- example of an ability that deals direct damage
NissaHeal = {}
NissaHeal.__index = NissaHeal
setmetatable(NissaHeal, Ability)

function NissaHeal:new(user)
    -- true because targetable
    local nissaHeal = Ability:new(false)
    setmetatable(nissaHeal, NissaHeal)

    -- set x, y, width, height, cooldown (in seconds), and name
    nissaHeal:set(0, 0, 80, 80, 7, 'nissaheal')

    -- create description text
    nissaHeal.desc = font:printToCanvas('shoot an volley of healing energy', 189, 38, 'left')

    nissaHeal.character = user

    nissaHeal.damage = 7 --(heal)

    nissaHeal.effect = 'heal'

    return nissaHeal
end

function NissaHeal:attach(character)
    Ability.attach(self, character)
end

function NissaHeal:use(dir)
    if Ability.use(self) then
       --local angle = nil
        local angle1, angle2, angle3, angle4, angle5
        if self.character.isAI then 
            allyX, allyY = self.character:getClosestAlly()
            --angle = math.atan2(self.character.sprite.y - allyY, self.character.sprite.x - allyX) 
            angle1 = math.atan2(self.character.sprite.y - allyY, self.character.sprite.x - allyX)
            angle2 = angle1 - math.pi/10
            angle3 = angle1 - math.pi/8
            angle4 = angle1 + math.pi/8
            angle5 = angle1 + math.pi/12
            angle6 = angle1 - math.pi/6
            angle7 = angle1 + math.pi/6
            angle8 = angle1 + math.pi/10
        else 
            angle1 = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x)
            angle2 = angle1 - math.pi/10
            angle3 = angle1 - math.pi/8
            angle4 = angle1 + math.pi/8
            angle5 = angle1 + math.pi/12
            angle6 = angle1 - math.pi/6
            angle7 = angle1 + math.pi/6
            angle8 = angle1 + math.pi/10
        end

        --local ind = #self.character.basicAttacks + 1
                                            --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        --local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.4, 'nissaheal.sprite', self.character.basicSpeed, angle, 0, self.effect, 2)
        --self.character.basicAttacks[ind] = basicAttack
        local delayList = {0.06, 0.12, 0.09, 0.03, 0.0, 0.15, 0.18, 0.21}
        --shuffle
        math.randomseed(os.time())
        for i = #delayList, 2, -1 do
            local j = math.random(i)
            delayList[i], delayList[j] = delayList[j], delayList[i]
        end

        local ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'nissaheal.sprite', self.character.basicSpeed, angle1, delayList[1], self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'nissaheal.sprite', self.character.basicSpeed, angle2, delayList[2], self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'nissaheal.sprite', self.character.basicSpeed, angle3, delayList[3], self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'nissaheal.sprite', self.character.basicSpeed, angle4, delayList[4], self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'nissaheal.sprite', self.character.basicSpeed, angle5, delayList[5], self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack    

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'nissaheal.sprite', self.character.basicSpeed, angle6, delayList[6], self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'nissaheal.sprite', self.character.basicSpeed, angle7, delayList[7], self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack   

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'nissaheal.sprite', self.character.basicSpeed, angle8, delayList[8], self.effect, 2)
        self.character.basicAttacks[ind] = basicAttack  
    end
end