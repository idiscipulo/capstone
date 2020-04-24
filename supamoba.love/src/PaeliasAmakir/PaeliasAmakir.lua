PaeliasAmakir = {}
PaeliasAmakir.__index = PaeliasAmakir
setmetatable(PaeliasAmakir, Character)

function PaeliasAmakir:new()
    local paeliasAmakir = Character:new()
    setmetatable(paeliasAmakir, PaeliasAmakir)

    -- icon image
    paeliasAmakir.icon = love.graphics.newImage('img/RomeroKao.icon.png')

    -- max and current health
    paeliasAmakir.maxHealth = 150
    paeliasAmakir.curHealth = 150

    -- set move speed
    paeliasAmakir.speed = 4

    -- basic attack stats
    paeliasAmakir.basicSpeed = 8
    paeliasAmakir.basicName = 'basic.sprite' 
    paeliasAmakir.basicCooldown = 1

    -- basic attack cooldown
    paeliasAmakir.attackTimerMax = 1
    paeliasAmakir.attackTimer = paeliasAmakir.attackTimerMax

    -- buff
    paeliasAmakir.isBuffedTimerMax = 7
    paeliasAmakir.isBuffedTimer = paeliasAmakir.isBuffedTimerMax
    paeliasAmakir.isBuffed = false

    -- set sprite location, size, and name for image file
    paeliasAmakir.sprite:set(500, 250, 16, 16, 'RomeroKao')

    -- set name
    paeliasAmakir.textName = 'Paelias Amakir'
    paeliasAmakir.name = font:printToCanvas('Paelias Amakir', 160, 10, 'center')

    -- initialize ability table
    paeliasAmakir.abilities = {}
    
    -- add ability
    paeliasAmakir:addAbility(PaeliasAOERoot:new())
    paeliasAmakir:addAbility(PaeliasBuff:new())
    paeliasAmakir:addAbility(NissaSlow:new())
    -- paeliasAmakir:addAbility(AbilityExamplePassive:new())

    -- finish adding abilities
    paeliasAmakir:endAbility()

    return paeliasAmakir
end

function PaeliasAmakir:update()
    Character.update(self)

    --run buff timer
    if self.isBuffed then 
        self.isBuffedTimer = self.isBuffedTimer - timer.fps 
        if self.isBuffedTimer < 0 then 
            self.isBuffedTimer = self.isBuffedTimerMax 
            self.isBuffed = false 
        end
    end
end

function PaeliasAmakir:takeDamage(amt)

    if self.isBuffed then amt = amt / 2 end 

    if not self.isInvulnerable then 
        -- deal damage
        self.curHealth = math.max(self.curHealth - amt, 0)

        -- get index for next open spot in numbers
        local ind = #stateList['battle'].numbers + 1

        -- add damage number to numbers
        stateList['battle'].numbers[ind] = Number:new(ind, self, amt, 'DAMAGE')
    end
end