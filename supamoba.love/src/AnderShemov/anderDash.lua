-- example of an ability that deals direct damage
AnderDash = {}
AnderDash.__index = AnderDash
setmetatable(AnderDash, Ability)

function AnderDash:new(user)
    -- true because targetable
    local anderDash = Ability:new(false)
    setmetatable(anderDash, AnderDash)

    -- set x, y, width, height, cooldown (in seconds), and name
    anderDash:set(0, 0, 80, 80, 5, 'anderdash')

    -- create description text
    anderDash.desc = font:printToCanvas('teleport a short distance towards your mouse', 189, 38, 'left')

    anderDash.character = user

    return anderDash
end

function AnderDash:attach(character)
    Ability.attach(self, character)
end

function AnderDash:use(dir)
    if Ability.use(self) then
        local dist = math.min(120, math.sqrt((self.character.sprite.x - mouse.x) ^ 2 + (self.character.sprite.y - mouse.y) ^ 2))
        local angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x)
        local x = self.character.sprite.x - math.cos(angle) * dist
        local y = self.character.sprite.y - math.sin(angle) * dist
        self.character.sprite.x = x
        self.character.sprite.y = y
    end
end