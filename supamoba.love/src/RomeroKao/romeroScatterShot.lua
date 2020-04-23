-- example of an ability that deals direct damage

RomeroScatterShot = {}
RomeroScatterShot.__index = RomeroScatterShot
setmetatable(RomeroScatterShot, Ability)

function RomeroScatterShot:new(user)
    -- true because targetable
    local romeroScatterShot = Ability:new(false)
    setmetatable(romeroScatterShot, RomeroScatterShot)

    -- set x, y, width, height, cooldown (in seconds), and name
    romeroScatterShot:set(0, 0, 80, 80, 2, 'abilityExampleDirectDamage')

    -- create description text
    romeroScatterShot.desc = font:printToCanvas('shoot a wide scatter shot.', 378, 76, 'left')

    romeroScatterShot.character = user

    romeroScatterShot.damage = 3

    return romeroScatterShot
end

function RomeroScatterShot:attach(character)
    Ability.attach(self, character)
end

function RomeroScatterShot:use()
    if Ability.use(self) then
        local goalX = mouse.x
        local goalY = mouse.y
        local angle1 = math.atan2(self.character.sprite.y - goalY, self.character.sprite.x - goalX)
        local angle2 = angle1 - math.pi/4
        local angle3 = angle1 - math.pi/8
        local angle4 = angle1 + math.pi/8
        local angle5 = angle1 + math.pi/4
        self.character:addBasicAttack(self.damage, angle1, 0.5, 0.06)
        self.character:addBasicAttack(self.damage, angle2, 0.5, 0.12)
        self.character:addBasicAttack(self.damage, angle3, 0.5, 0.09)
        self.character:addBasicAttack(self.damage, angle4, 0.5, 0.03)
        self.character:addBasicAttack(self.damage, angle5, 0.5, 0.0)
    end
end