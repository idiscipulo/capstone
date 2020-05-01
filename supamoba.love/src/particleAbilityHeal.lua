-- example particle for AbilityExampleAOEEffect

ParticleAbilityHeal = {}
ParticleAbilityHeal.__index = ParticleAbilityHeal
setmetatable(ParticleAbilityHeal, Particle)

function ParticleAbilityHeal:new(ind, x, y, char)
    -- initialize particle with duration of 3
    local particleAbilityHeal = Particle.new(self, ind, x, y, 5, 'paeliashealparticle')
    setmetatable(particleAbilityHeal, ParticleAbilityHeal)

    particleAbilityHeal.char = char

    return particleAbilityHeal
end

function ParticleAbilityHeal:update()
    if Particle.update(self) then
        for ind, val in pairs(stateList['battle'].ents) do
            -- if character is overlapping particle, apply 2 damage
            if val.team == self.char.team and math.abs(val.sprite.x - self.x) < 16 and math.abs(val.sprite.y - self.y) < 16 then
                val:heal(4)
            end
        end
    end
end