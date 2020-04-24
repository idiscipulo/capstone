-- example particle for AbilityExampleAOEEffect

ParticleAbilityRoot = {}
ParticleAbilityRoot.__index = ParticleAbilityRoot
setmetatable(ParticleAbilityRoot, Particle)

function ParticleAbilityRoot:new(ind, x, y)
    -- initialize particle with duration of 3
    local particleAbilityRoot = Particle.new(self, ind, x, y, 5, 'particleAbilityExampleAOEEffect')
    setmetatable(particleAbilityRoot, ParticleAbilityRoot)

    return particleAbilityRoot
end

function ParticleAbilityRoot:update()
    if Particle.update(self) then
        for ind, val in pairs(stateList['battle'].enemies) do
            -- if character is overlapping particle, apply 2 damage
            if math.abs(val.sprite.x - self.x) < 16 and math.abs(val.sprite.y - self.y) < 16 then
                val:takeDamage(0.5)
            end
        end
    end

    for ind, val in pairs(stateList['battle'].enemies) do
        -- if character is overlapping particle, apply 2 damage
        if math.abs(val.sprite.x - self.x) < 16 and math.abs(val.sprite.y - self.y) < 16 then
            if not val.isRooted then
                val:applyEffect('root', 5)
            end
        end
    end
end