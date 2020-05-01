RomeroAOE = {}
RomeroAOE.__index = RomeroAOE
setmetatable(RomeroAOE, Ability)

function RomeroAOE:new()
    -- false because not targetable
    local romeroAOE = Ability:new(false)
    setmetatable(romeroAOE, RomeroAOE)

    -- set x, y, width, height, cooldown (in seconds), and name
    romeroAOE:set(0, 0, 80, 80, 4, 'abilityExampleAOEEffect')

    -- create description text
    romeroAOE.desc = font:printToCanvas('burn the ground, dealing damage over time', 189, 38, 'left')

    -- for aoe abilities, a matrix of the aoe shape, with 1's for active tiles
    romeroAOE.map = {{0, 1, 0},
                     {1, 1, 1},
                     {0, 1, 0}}

    return romeroAOE
end

function RomeroAOE:attach(character)
    Ability.attach(self, character)
end

function RomeroAOE:use(dir)
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
                    stateList['battle'].particles[ind] = ParticleAbilityExampleAOEEffect:new(ind, x + ((indx - 1) * 16), y + ((indy - 1) * 16))
                    
                    -- increment index in particle list
                    ind = #stateList['battle'].particles + 1
                end
            end
        end
    end
end