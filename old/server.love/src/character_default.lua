CharacterDefault = {}
CharacterDefault.__index = CharacterDefault
setmetatable(CharacterDefault, Character)

function CharacterDefault:new(id)
    local character_default = Character:new(id)
    setmetatable(character_default, CharacterDefault)

    character_default.w = 100
    character_default.h = 100

    return character_default
end

function CharacterDefault:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end