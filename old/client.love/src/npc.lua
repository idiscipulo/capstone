NPC = {}
NPC.__index = NPC
setmetatable(NPC, Entity) -- inherit from entity

function NPC:new(id)
    local npc = Entity:new()
    setmetatable(npc, NPC)

    return npc
end
