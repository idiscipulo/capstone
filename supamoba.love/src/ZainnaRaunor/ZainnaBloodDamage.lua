-- example of an ability that deals direct damage
ZainnaBloodDamage = {}
ZainnaBloodDamage.__index = ZainnaBloodDamage
setmetatable(ZainnaBloodDamage, Ability)

function ZainnaBloodDamage:new(user)
    -- true because targetable
    local zainnaBloodDamage = Ability:new(false)
    setmetatable(zainnaBloodDamage, ZainnaBloodDamage)

    -- set x, y, width, height, cooldown (in seconds), and name
    zainnaBloodDamage:set(0, 0, 80, 80, 6, 'abilityExampleDirectDamage')

    -- create description text
    zainnaBloodDamage.desc = font:printToCanvas('do incredible damage for a price', 189, 38, 'left')

    zainnaBloodDamage.character = user

    zainnaBloodDamage.damage = 20

    return zainnaBloodDamage
end

function ZainnaBloodDamage:attach(character)
    Ability.attach(self, character)
end

function ZainnaBloodDamage:use(dir)
    if Ability.use(self) then
        local angle = nil
        if self.character.isAI then angle = dir 
        else angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x) end
        self.character:takeDamage(self.damage / 4)
        self.character:addBasicAttack(self.damage, angle, 0.4, 0)
    end
end