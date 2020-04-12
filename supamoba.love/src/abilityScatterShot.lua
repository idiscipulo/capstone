-- example of an ability that deals direct damage

AbilityScatterShot = {}
AbilityScatterShot.__index = AbilityScatterShot
setmetatable(AbilityScatterShot, Ability)

function AbilityScatterShot:new(user)
    -- true because targetable
    local abilityScatterShot = Ability:new(false)
    setmetatable(abilityScatterShot, AbilityScatterShot)

    -- set x, y, width, height, cooldown (in seconds), and name
    abilityScatterShot:set(0, 0, 80, 80, 2, 'abilityExampleDirectDamage')

    -- create description text
    abilityScatterShot.desc = font:printToCanvas('deal 30 damage to the target.', 378, 76, 'left')

    abilityScatterShot.character = user

    return abilityScatterShot
end

function AbilityScatterShot:attach(character)
    Ability.attach(self, character)
end

function AbilityScatterShot:use()
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