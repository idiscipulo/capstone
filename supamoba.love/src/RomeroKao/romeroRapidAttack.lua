-- example of an ability that deals direct damage

RomeroRapidAttack = {}
RomeroRapidAttack.__index = RomeroRapidAttack
setmetatable(RomeroRapidAttack, Ability)

function RomeroRapidAttack:new(user)
    -- true because targetable
    local romeroRapidAttack = Ability:new(false)
    setmetatable(romeroRapidAttack, RomeroRapidAttack)

    -- set x, y, width, height, cooldown (in seconds), and name
    romeroRapidAttack:set(0, 0, 80, 80, 2, 'romerorapidattack')

    -- create description text
    romeroRapidAttack.desc = font:printToCanvas('attack in rapid succession', 189, 38, 'left')

    romeroRapidAttack.character = user

    romeroRapidAttack.damage = 4

    return romeroRapidAttack
end

function RomeroRapidAttack:attach(character)
    Ability.attach(self, character)
end

function RomeroRapidAttack:use(dir)
    if Ability.use(self) then
        local angle = nil
        if self.character.isAI then angle = dir 
        else angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x) end
        
        local ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'romerorapidattack.sprite', self.character.basicSpeed, angle, 0.00)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'romerorapidattack.sprite', self.character.basicSpeed, angle, 0.06)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'romerorapidattack.sprite', self.character.basicSpeed, angle, 0.12)
        self.character.basicAttacks[ind] = basicAttack
    end
end