Battle = {}
Battle.__index = Battle

function Battle:new()
    local battle = {}
    setmetatable(battle, Battle)

    -- template image
    battle.temp = love.graphics.newImage('img/temp.battle.main.png')

    -- background image
    battle.back = love.graphics.newImage('img/battle.back.png')

    -- semi-transparent character icon cover
    battle.iconGrey = love.graphics.newImage('img/battle.icon.grey.png')

    -- large health bar and health bar back
    battle.health = love.graphics.newImage('img/battle.health.png')
    battle.healthBack = love.graphics.newImage('img/battle.health.back.png')

    -- character health bar and health bar back
    battle.spriteHealth = love.graphics.newImage('img/battle.sprite.health.png')
    battle.spriteHealthBack = love.graphics.newImage('img/battle.sprite.health.back.png')

    -- load character that this client controls
    --battle.character = AnderShemov:new()
    --battle.character = NissaTimbers:new()
    --battle.character = PaeliasAmakir:new()
    --battle.character = RhogarNemmonis:new()
    --battle.character = RomeroKao:new()
    battle.character = RomeroKao:new()

    -- background for ability info
    battle.abilityInfo = love.graphics.newImage('img/battle.ability.info.png')

    -- semi-transparent ability icon cover
    battle.abilityGrey = love.graphics.newImage('img/battle.ability.grey.png')

    -- initialize table for cooldowns
    battle.cooldowns = {}

    -- initialize table for particles
    battle.particles = {}

    -- initialize table for numbers
    battle.numbers = {}

    -- temporary hardcoding of characters
    -- initialize table for allies
    battle.allies = {}

    -- add client character to allies
    battle.allies[#battle.allies + 1] = battle.character
    --battle.allies[#battle.allies + 1] = RhogarNemmonis:new()
    --battle.allies[2].type = 1
    battle.character.type = 1

    -- initialize table for enemies
    battle.enemies = {}
    battle.enemies[#battle.enemies + 1] = NissaTimbers:new()
    battle.enemies[1].type = 2

    -- character icon health bar and health bar back
    battle.iconHealth = love.graphics.newImage('img/battle.icon.health.png')
    battle.iconHealthBack = love.graphics.newImage('img/battle.icon.health.back.png')

    -- track minutes and seconds
    battle.min = 0
    battle.sec = 0

    -- initialize time canvas
    battle.time = font:printToCanvas('', 38, 10, 'left')

    -- add characters from allies and enemies to ents for update and draw loops
    battle.ents = {}
    for ind, val in pairs(battle.allies) do
        battle.ents[#battle.ents + 1] = val
    end

    for ind, val in pairs(battle.enemies) do
        battle.ents[#battle.ents + 1] = val
    end

    return battle
end

function Battle:update()
    -- update time
    self.sec = self.sec + timer.fps

    if self.sec >= 60 then
        self.sec = 0
        self.min = math.min(self.min + 1, 99)
    end

    local str = ''
    if self.min < 10 then
        str = str..'0'..math.floor(self.min)..':'
    else
        str = str..math.floor(self.min)..':'
    end

    if self.sec < 10 then
        str = str..'0'..math.floor(self.sec)
    else
        str = str..math.floor(self.sec)
    end

    -- update time canvas with new time
    self.time = font:printToCanvas(str, 38, 10, 'left')

    for ind, val in pairs(self.ents) do
        -- update client character abilities
        for ind2, val2 in pairs(val.abilities) do
            val2:update()
        end

        if val.isDead then self.ents[ind] = nil end 

        -- update client basic attacks
        for ind2, val2 in pairs(val.basicAttacks) do
            val2:update()
        end

        if val == self.character then
            -- create cooldown text for abilities with cooldowns
            self.cooldowns = {}
            for ind, val in pairs(val.abilities) do
                self.cooldowns[#self.cooldowns + 1] = font:printToCanvas(''..1 + math.floor(val.maxCool - val.curCool), 40, 10, 'center')
            end
        end
    end

    -- update numbers
    for ind, val in pairs(self.numbers) do 
        val:update()
    end

    -- update particles
    for ind, val in pairs(self.particles) do
        val:update()
    end

    if state.child == 'main' then
        -- update characters
        for ind, val in pairs(self.ents) do
            val:update()
       
            if val == self.character then
                if not val.isBlinded then
                    if love.mouse.isDown(2) and not self.character.isDashing then -- right click to move
                        val:setGoal(mouse.x, mouse.y)
                    end

                    if love.mouse.isDown(1) and val.canAttack then --left click to basic attack
                        local goalX = mouse.x
                        local goalY = mouse.y
                        local angle = math.atan2(val.sprite.y - goalY, val.sprite.x - goalX)
                        val:addBasicAttack(3, angle)
                        val.canAttack = false
                    end

                    -- if q pressed
                    if love.keyboard.isDown('q') then
                        -- if ability is targetable check for target before casting
                        if self.character.abilities[1].targetable then
                            for ind2, val2 in pairs(self.ents) do
                                if val2.sprite.isHover then
                                    self.character.abilities[1]:use(val)
                                end
                            end
                        -- otherwise just cast
                        else
                            self.character.abilities[1]:use()
                        end
                    -- if w is pressed
                    elseif love.keyboard.isDown('w') then
                        -- if ability is targetable check for target before casting
                        if self.character.abilities[2].targetable then
                            for ind2, val2 in pairs(self.ents) do
                                if val2.sprite.isHover then
                                    self.character.abilities[2]:use(val)
                                end
                            end
                        -- otherwise just cast
                        else
                            self.character.abilities[2]:use()
                        end
                    -- if e is pressed
                    elseif love.keyboard.isDown('e') then
                        -- if ability is targetable check for target before casting
                        if self.character.abilities[3].targetable then
                            for ind2, val2 in pairs(self.ents) do
                                if val2.sprite.isHover then
                                    self.character.abilities[3]:use(val)
                                end
                            end
                        -- otherwise just cast
                        else
                            self.character.abilities[3]:use()
                        end
                    end
                end
            else
                AIController:execute(val)
            end
        end
    end
end

function Battle:draw()
    
    -- TESTING START
    if temp then
        love.graphics.draw(self.temp, 0, 0)
    end
    -- TESTING END

    -- draw background
    love.graphics.draw(self.back, 0, 0)
    
    -- draw time
    love.graphics.draw(self.time, 562, 20, 0, 2, 2)

    -- init health factor
    local healthFactor = 0

    -- draw ally icons and health bars
    for ind, val in pairs(self.allies) do
        love.graphics.draw(val.icon, 12 + ((ind - 1) * 80), 10)

        if val.deathTime > 0 then
            love.graphics.draw(self.iconGrey, 12 + ((ind - 1) * 80), 10)
            love.graphics.draw(self.iconHealthBack, 12 + ((ind - 1) * 80), 66)
        else
            healthFactor = val.curHealth / val.maxHealth
            love.graphics.draw(self.iconHealthBack, 12 + ((ind - 1) * 80), 66)
            love.graphics.draw(self.iconHealth, 12 + ((ind - 1) * 80), 66, 0, healthFactor, 1)
        end
    end
    
    -- draw enemy icons and health bars
    for ind, val in pairs(self.enemies) do
        love.graphics.draw(val.icon, 980 + ((ind - 1) * 80), 10)
        
        if val.deathTime > 0 then
            love.graphics.draw(self.iconGrey, 980 + ((ind - 1) * 80), 10)
            love.graphics.draw(self.iconHealthBack, 980 + ((ind - 1) * 80), 66)
        else
            healthFactor = val.curHealth / val.maxHealth
            love.graphics.draw(self.iconHealthBack, 980 + ((ind - 1) * 80), 66)
            love.graphics.draw(self.iconHealth, 980 + ((ind - 1) * 80), 66, 0, healthFactor, 1)
        end
    end

    -- draw big health bar for client character
    if self.character.deathTime > 0 then
        love.graphics.draw(self.healthBack, 850, 510)
    else
        healthFactor = self.character.curHealth / self.character.maxHealth
        love.graphics.draw(self.healthBack, 850, 505)
        love.graphics.draw(self.health, 850, 505, 0, healthFactor, 1)
    end

    -- draw character name
    love.graphics.draw(self.character.name, 836, 574, 0, 2, 2)

    for ind, val in pairs(self.character.abilities) do
        val:draw()

        -- draw cooldowns on abilities
        if val.locked then
            love.graphics.draw(self.abilityGrey, 12 + ((ind - 1) * 102), 510)
            love.graphics.draw(self.cooldowns[ind], 12 + ((ind - 1) * 102), 540, 0, 2, 2)
        end

        -- draw info text if ability icon is hover
        if val.isHover then
            love.graphics.draw(self.abilityInfo, 407, 504)
            love.graphics.draw(val.desc, 413, 510, 0, 2)
        end
    end

    -- draw particles
    for ind, val in pairs(self.particles) do
        val:draw()
    end

    -- draw sprite health bars
    for ind, val in pairs(self.ents) do
        val.sprite:draw()
        healthFactor = val.curHealth / val.maxHealth
        love.graphics.draw(self.spriteHealthBack, val.sprite.x, val.sprite.y + 18)
        love.graphics.draw(self.spriteHealth, val.sprite.x, val.sprite.y + 18, 0, healthFactor, 1)

            --draw basic attacks
        for ind2, val2 in pairs(val.basicAttacks) do 
            val2:draw()
        end
    end

    -- draw numbers
    for ind, val in pairs(self.numbers) do 
        val:draw()
    end

end