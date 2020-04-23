-- example of an ability that deals direct damage

RomeroRapidAttack = {}
RomeroRapidAttack.__index = RomeroRapidAttack
setmetatable(RomeroRapidAttack, Ability)

function RomeroRapidAttack:new(user)
    -- true because targetable
    local romeroRapidAttack = Ability:new(false)
    setmetatable(romeroRapidAttack, RomeroRapidAttack)

    -- set x, y, width, height, cooldown (in seconds), and name
    romeroRapidAttack:set(0, 0, 80, 80, 2, 'abilityExampleDirectDamage')

    -- create description text
    romeroRapidAttack.desc = font:printToCanvas('attack in rapid succession', 189, 38, 'left')

    romeroRapidAttack.character = user

    romeroRapidAttack.damage = 3

    return romeroRapidAttack
end

function RomeroRapidAttack:attach(character)
    Ability.attach(self, character)
end

function RomeroRapidAttack:use()
    if Ability.use(self) then
        local goalX = mouse.x
        local goalY = mouse.y
        local angle = math.atan2(self.character.sprite.y - goalY, self.character.sprite.x - goalX)
        self.character:addBasicAttack(self.damage, angle, nil, 0)
        self.character:addBasicAttack(self.damage, angle, nil, 0.06)
        self.character:addBasicAttack(self.damage, angle, nil, 0.12)
    end
end