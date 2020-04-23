-- example of an ability that deals direct damage

RomeroRapidAttack = {}
RomeroRapidAttack.__index = RomeroRapidAttack
setmetatable(RomeroRapidAttack, Ability)

function RomeroRapidAttack:new(user)
    -- true because targetable
    local romeroRapidAttack = Ability:new(true)
    setmetatable(romeroRapidAttack, RomeroRapidAttack)

    -- set x, y, width, height, cooldown (in seconds), and name
    romeroRapidAttack:set(0, 0, 80, 80, 2, 'abilityExampleDirectDamage')

    -- create description text
    romeroRapidAttack.desc = font:printToCanvas('attack in rapid succession.', 378, 76, 'left')

    romeroRapidAttack.character = user

    return romeroRapidAttack
end

function RomeroRapidAttack:attach(character)
    Ability.attach(self, character)
end

function RomeroRapidAttack:use(target)
    if Ability.use(self) then
        local goalX, goalY = target.sprite.x, target.sprite.y
        local angle = math.atan2(self.character.sprite.y - goalY, self.character.sprite.x - goalX)
        self.character:addBasicAttack(angle)
        self.character:addBasicAttack(angle)
        self.character:addBasicAttack(angle)
    end
end