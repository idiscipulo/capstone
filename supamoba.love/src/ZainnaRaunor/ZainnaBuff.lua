-- example of an ability that deals direct damage
ZainnaBuff = {}
ZainnaBuff.__index = ZainnaBuff
setmetatable(ZainnaBuff, Ability)

function ZainnaBuff:new(user)
    -- true because targetable
    local zainnaBuff = Ability:new(false)
    setmetatable(zainnaBuff, ZainnaBuff)

    -- set x, y, width, height, cooldown (in seconds), and name
    zainnaBuff:set(0, 0, 80, 80, 14, 'zainnabuff')

    -- create description text
    zainnaBuff.desc = font:printToCanvas('increase movement and attack speed', 189, 38, 'left')

    zainnaBuff.character = user

    zainnaBuff.moveMultiplier = 2
    zainnaBuff.attackMultiplier = 5

    return zainnaBuff
end

function ZainnaBuff:attach(character)
    Ability.attach(self, character)
end

function ZainnaBuff:use(dir)
    if Ability.use(self) then
        self.character.isBuffed = true
        self.character:takeDamage(15)
        self.character.speed = self.character.speed * self.moveMultiplier
        self.character.attackTimerMax = self.character.attackTimerMax / self.attackMultiplier
    end
end