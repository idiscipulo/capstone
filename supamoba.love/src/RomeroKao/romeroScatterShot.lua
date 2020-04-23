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

    return romeroScatterShot
end

function RomeroScatterShot:attach(character)
    Ability.attach(self, character)
end

function RomeroScatterShot:use()
    if Ability.use(self) then
        local goalX, goalY = love.mouse.getPosition()
        local angle1 = math.atan2(self.character.sprite.y - goalY, self.character.sprite.x - goalX)
        local angle2 = angle1 - math.pi/4
        local angle3 = angle1 - math.pi/8
        local angle4 = angle1 + math.pi/8
        local angle5 = angle1 + math.pi/4
        self.character:addBasicAttack(angle1)
        self.character:addBasicAttack(angle2)
        self.character:addBasicAttack(angle3)
        self.character:addBasicAttack(angle4)
        self.character:addBasicAttack(angle5)
    end
end