-- example particle for AbilityExampleAOEEffect

ParticleAbilityExampleAOEEffect = {}
ParticleAbilityExampleAOEEffect.__index = ParticleAbilityExampleAOEEffect
setmetatable(ParticleAbilityExampleAOEEffect, Particle)

function ParticleAbilityExampleAOEEffect:new(ind, x, y)
    -- initialize particle with duration of 3
    local particleAbilityExampleAOEEffect = Particle.new(self, ind, x, y, 3, 'particleAbilityExampleAOEEffect')
    setmetatable(particleAbilityExampleAOEEffect, ParticleAbilityExampleAOEEffect)

    return particleAbilityExampleAOEEffect
end

function ParticleAbilityExampleAOEEffect:update()
    if Particle.update(self) then
        for ind, val in pairs(stateList['battle'].ents) do
            -- if character is overlapping particle, apply 2 damage
            if math.abs(val.sprite.x - self.x) < 16 and math.abs(val.sprite.y - self.y) < 16 then
                val:takeDamage(2)
            end
        end
    end
end