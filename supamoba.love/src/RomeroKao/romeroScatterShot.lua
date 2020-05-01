-- example of an ability that deals direct damage

RomeroScatterShot = {}
RomeroScatterShot.__index = RomeroScatterShot
setmetatable(RomeroScatterShot, Ability)

function RomeroScatterShot:new(user)
    -- true because targetable
    local romeroScatterShot = Ability:new(false)
    setmetatable(romeroScatterShot, RomeroScatterShot)

    -- set x, y, width, height, cooldown (in seconds), and name
    romeroScatterShot:set(0, 0, 80, 80, 2, 'romeroscattershot')

    -- create description text
    romeroScatterShot.desc = font:printToCanvas('spray a deadly arc of projectiles', 189, 38, 'left')

    romeroScatterShot.character = user

    romeroScatterShot.damage = 12

    return romeroScatterShot
end

function RomeroScatterShot:attach(character)
    Ability.attach(self, character)
end

function RomeroScatterShot:use(dir)
    if Ability.use(self) then
        local angle1 = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x)
        local angle2 = angle1 - math.pi/4
        local angle3 = angle1 - math.pi/8
        local angle4 = angle1 + math.pi/8
        local angle5 = angle1 + math.pi/4

        local ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'romeroscattershot.sprite', self.character.basicSpeed, angle1, 0.06)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'romeroscattershot.sprite', self.character.basicSpeed, angle2, 0.12)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'romeroscattershot.sprite', self.character.basicSpeed, angle3, 0.09)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'romeroscattershot.sprite', self.character.basicSpeed, angle4, 0.03)
        self.character.basicAttacks[ind] = basicAttack

        ind = #self.character.basicAttacks + 1
                                           --damage, char, ind, x, y, cooldown, name, speed, angle, delay, effect, effectTimer
        local basicAttack = BasicAttack:new(self.damage, self.character, ind, self.character.sprite.x, self.character.sprite.y, 0.5, 'romeroscattershot.sprite', self.character.basicSpeed, angle5, 0.0)
        self.character.basicAttacks[ind] = basicAttack        
    end
end