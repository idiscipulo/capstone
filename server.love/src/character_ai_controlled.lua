Character_AI = {}
Character_AI.__index = Character_AI
setmetatable(Character_AI, NPC) -- inherit from NPC

function Character_AI:new(id)
    local character_ai = NPC:new()
    setmetatable(character_ai, Character_AI)

    return character_ai
end