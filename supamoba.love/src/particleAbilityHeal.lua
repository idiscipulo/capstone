-- example particle for AbilityExampleAOEEffect

ParticleAbilityHeal = {}
ParticleAbilityHeal.__index = ParticleAbilityHeal
setmetatable(ParticleAbilityHeal, Particle)

function ParticleAbilityHeal:new(ind, x, y)
    -- initialize particle with duration of 3
    local particleAbilityHeal = Particle.new(self, ind, x, y, 5, 'paeliasHealparticle')
    setmetatable(particleAbilityHeal, ParticleAbilityHeal)

    return particleAbilityHeal
end

function ParticleAbilityHeal:update()
    if Particle.update(self) then
        for ind, val in pairs(stateList['battle'].ents) do
            -- if character is overlapping particle, apply 2 damage
            if val.team == 1 and math.abs(val.sprite.x - self.x) < 16 and math.abs(val.sprite.y - self.y) < 16 then
                val:heal(2)
            end
        end
    end
end