-- example of an ability that deals direct damage
NissaSlow = {}
NissaSlow.__index = NissaSlow
setmetatable(NissaSlow, Ability)

function NissaSlow:new(user)
    -- true because targetable
    local nissaSlow = Ability:new(false)
    setmetatable(nissaSlow, NissaSlow)

    -- set x, y, width, height, cooldown (in seconds), and name
    nissaSlow:set(0, 0, 80, 80, 10, 'nissaslow')

    -- create description text
    nissaSlow.desc = font:printToCanvas('shoot a slowing blob and heal for 20% of your missing health', 189, 38, 'left')

    nissaSlow.character = user

    nissaSlow.damage = 7

    nissaSlow.effect = 'slow'
    nissaSlow.effectTimer = 5

    return nissaSlow
end

function NissaSlow:attach(character)
    Ability.attach(self, character)
end

function NissaSlow:use(dir)
    if Ability.use(self) then
        local angle = nil
        if self.character.isAI then 
            angle = dir 
        else 
            angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x) 
        end

        local ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.4, 'nissaslow.sprite', self.character.basicSpeed, angle, 0, self.effect, self.effectTimer)
        self.character.basicAttacks[ind] = basicAttack

        self.character:heal((self.character.maxHealth - self.character.curHealth) * 0.2)  
    end
end