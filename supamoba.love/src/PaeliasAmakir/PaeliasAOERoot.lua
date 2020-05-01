PaeliasAOERoot = {}
PaeliasAOERoot.__index = PaeliasAOERoot
setmetatable(PaeliasAOERoot, Ability)

function PaeliasAOERoot:new()
    -- false because not targetable
    local paeliasAOERoot = Ability:new(false)
    setmetatable(paeliasAOERoot, PaeliasAOERoot)

    -- set x, y, width, height, cooldown (in seconds), and name
    paeliasAOERoot:set(0, 0, 80, 80, 10, 'paeliasroot')

    -- create description text
    paeliasAOERoot.desc = font:printToCanvas('lay down a trap that roots enemies in place', 189, 38, 'left')

    -- for aoe abilities, a matrix of the aoe shape, with 1's for active tiles
    paeliasAOERoot.map = {{1, 0, 1},
                          {1, 0, 1},
                          {1, 0, 1}}

    return paeliasAOERoot
end

function PaeliasAOERoot:attach(character)
    Ability.attach(self, character)
end

function PaeliasAOERoot:use(dir)
    if Ability.use(self) then
        local x, y = nil, nil
        if self.character.isAI then 
            x, y = self.character:getClosestEnemy()
        else
            x = mouse.x - (#self.map[1] / 2) * 16
            y = mouse.y - (#self.map / 2) * 16
        end

        -- get index for next spot in particle list
        local ind = #stateList['battle'].particles + 1

        -- iterate through shape map
        for indy, val in pairs(self.map) do
            for indx, val2 in pairs(val) do
                if val2 == 1 then
                    -- if value in aoe matrix is 1, spawn a unique particle at that spot
                    -- pass index in particle list (for later deleting), x coord, and y coord
                    stateList['battle'].particles[ind] = ParticleAbilityRoot:new(ind, x + ((indx - 1) * 16), y + ((indy - 1) * 16))
                    
                    -- increment index in particle list
                    ind = #stateList['battle'].particles + 1
                end
            end
        end
    end
end