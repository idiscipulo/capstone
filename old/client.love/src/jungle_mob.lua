Jungle_Mob = {}
Jungle_Mob.__index = Jungle_Mob
setmetatable(Jungle_Mob, NPC) -- inherit from NPC

function Jungle_Mob:new(id)
    local jungle_mob = NPC:new()
    setmetatable(jungle_mob, Jungle_Mob)

    return jungle_mob
end