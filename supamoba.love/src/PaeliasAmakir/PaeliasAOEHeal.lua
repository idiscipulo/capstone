PaeliasAOEHeal = {}
PaeliasAOEHeal.__index = PaeliasAOEHeal
setmetatable(PaeliasAOEHeal, Ability)

function PaeliasAOEHeal:new()
    -- false because not targetable
    local paeliasAOEHeal = Ability:new(false)
    setmetatable(paeliasAOEHeal, PaeliasAOEHeal)

    -- set x, y, width, height, cooldown (in seconds), and name
    paeliasAOEHeal:set(0, 0, 80, 80, 10, 'paeliasheal')

    -- create description text
    paeliasAOEHeal.desc = font:printToCanvas('sanctify an area to heal your allies', 189, 38, 'left')

    -- for aoe abilities, a matrix of the aoe shape, with 1's for active tiles
    paeliasAOEHeal.map = {{0, 1, 1},
                          {1, 1, 1},
                          {1, 1, 0}}

    return paeliasAOEHeal
end

function PaeliasAOEHeal:attach(character)
    Ability.attach(self, character)
end

function PaeliasAOEHeal:use(dir)
    if Ability.use(self) then
        local x, y = nil, nil
        if self.character.isAI then 
            x, y = self.character:getClosestEnemy()
        else
            local dist = math.min(120, math.sqrt((self.character.sprite.x - mouse.x) ^ 2 + (self.character.sprite.y - mouse.y) ^ 2))
            local angle = math.atan2(self.character.sprite.y - mouse.y, self.character.sprite.x - mouse.x)
            x = (self.character.sprite.x - math.cos(angle) * dist) - ((#self.map[1] / 2) * 16)
            y = (self.character.sprite.y - math.sin(angle) * dist) - ((#self.map / 2) * 16)
        end

        -- get index for next spot in particle list
        local ind = #stateList['battle'].particles + 1

        -- iterate through shape map
        for indy, val in pairs(self.map) do
            for indx, val2 in pairs(val) do
                if val2 == 1 then
                    -- if value in aoe matrix is 1, spawn a unique particle at that spot
                    -- pass index in particle list (for later deleting), x coord, and y coord
                    stateList['battle'].particles[ind] = ParticleAbilityHeal:new(ind, x + ((indx - 1) * 16), y + ((indy - 1) * 16))
                    
                    -- increment index in particle list
                    ind = #stateList['battle'].particles + 1
                end
            end
        end
    end
end