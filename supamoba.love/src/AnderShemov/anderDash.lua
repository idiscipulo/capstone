-- example of an ability that deals direct damage
AnderDash = {}
AnderDash.__index = AnderDash
setmetatable(AnderDash, Ability)

function AnderDash:new(user)
    -- true because targetable
    local anderDash = Ability:new(false)
    setmetatable(anderDash, AnderDash)

    -- set x, y, width, height, cooldown (in seconds), and name
    anderDash:set(0, 0, 80, 80, 1, 'anderdash')

    -- create description text
    anderDash.desc = font:printToCanvas('dash quickly towards your mouse.', 189, 38, 'left')

    anderDash.character = user

    return anderDash
end

function AnderDash:attach(character)
    Ability.attach(self, character)
end

function AnderDash:use(dir)
    if Ability.use(self) then
        self.character:setGoal(mouse.x, mouse.y)
        self.character.speed = self.character.speed * 12
        self.character.isDashing = true 
    end
end