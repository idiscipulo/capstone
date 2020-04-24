Battle = {}
Battle.__index = Battle

function Battle:new(character, ents)
    local battle = {}
    setmetatable(battle, Battle)

    battle.winner = 0

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

    --[[
    --set the player's character
    --battle.character = character

    --list of all characters
    battle.characterList = {}
    battle.characterList[#battle.characterList + 1] = AnderShemov:new()
    battle.characterList[#battle.characterList + 1] = NissaTimbers:new()
    battle.characterList[#battle.characterList + 1] = PaeliasAmakir:new()
    battle.characterList[#battle.characterList + 1] = RhogarNemmonis:new()
    battle.characterList[#battle.characterList + 1] = RomeroKao:new()
    battle.characterList[#battle.characterList + 1] = ZainnaRaunor:new()

    -- populate teams with remaining characters
    for ind, val in pairs(battle.characterList) do 
        if battle.characterList[ind] == battle.character then 
            battle.characterList[ind] = nil 
        end
    end
    ]]--

    -- load character that this client controls
    --battle.character = AnderShemov:new()
    --battle.character = NissaTimbers:new()
    --battle.character = PaeliasAmakir:new()
    --battle.character = RhogarNemmonis:new()
    --battle.character = RomeroKao:new()
    battle.character = character
    battle.ents = ents

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

    --initialize towers
    battle.towers = {}
    battle.towers[#battle.towers + 1] = Tower:new(100, 175, 1) --x, y, team
    battle.towers[#battle.towers + 1] = Tower:new(100, 375, 1)
    battle.towers[#battle.towers + 1] = Tower:new(200, 275, 1)
    battle.towers[#battle.towers + 1] = Tower:new(1100, 175, 2) --x, y, team
    battle.towers[#battle.towers + 1] = Tower:new(1100, 375, 2)
    battle.towers[#battle.towers + 1] = Tower:new(1000, 275, 2)

    -- character icon health bar and health bar back
    battle.iconHealth = love.graphics.newImage('img/battle.icon.health.png')
    battle.iconHealthBack = love.graphics.newImage('img/battle.icon.health.back.png')

    -- track minutes and seconds
    battle.min = 0
    battle.sec = 0

    -- initialize time canvas
    battle.time = font:printToCanvas('', 38, 10, 'left')

    --[[
    -- temporary hardcoding of characters
    -- initialize table for allies
    battle.allies = {}

    -- add client character to allies
    battle.allies[#battle.allies + 1] = battle.character

    -- initialize table for enemies
    battle.enemies = {}
    battle.enemies[#battle.enemies + 1] = NissaTimbers:new()

    -- add characters from allies and enemies to ents for update and draw loops
    for ind, val in pairs(battle.allies) do
        val.team = 1
        -- battle.ents[#battle.ents + 1] = val
    end

    for ind, val in pairs(battle.enemies) do
        val.team = 2
        -- battle.ents[#battle.ents + 1] = val
    end
    ]]--
    

    for ind, val in pairs(battle.towers) do
        battle.ents[#battle.ents + 1] = val
    end

    return battle
end

function Battle:update()
    if self.winner == 0 then
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

        -- check if any team has won (all of their towers are dead)
        for ind, val in pairs(self.towers) do 
            if val.isDead then self.towers[ind] = nil end
        end
        local team1Alive, team2Alive = false, false
        for ind, val in pairs(self.towers) do 
            if val.team == 1 then team1Alive = true end 
            if val.team == 2 then team2Alive = true end
        end
        if not team1Alive then self.winner = 2 end 
        if not team2Alive then self.winner = 1 end

        -- update numbers
        for ind, val in pairs(self.numbers) do 
            val:update()
        end

        -- update particles
        for ind, val in pairs(self.particles) do
            val:update()
        end

        -- update characters
        for ind, val in pairs(self.ents) do

                -- update abilities
            for ind2, val2 in pairs(val.abilities) do
                val2:update()
            end
            -- update basic attacks
            for ind2, val2 in pairs(val.basicAttacks) do
                val2:update()
            end

            if val.deathTime == 0 then
                --update character
                val:update()
                
                if val == self.character then
                    -- create cooldown text for abilities with cooldowns
                    self.cooldowns = {}
                    for ind, val in pairs(val.abilities) do
                        self.cooldowns[#self.cooldowns + 1] = font:printToCanvas(''..1 + math.floor(val.maxCool - val.curCool), 40, 10, 'center')
                    end
                    if not val.isBlinded then
                        if love.mouse.isDown(2) and not self.character.isDashing then -- right click to move
                            val:setGoal(mouse.x, mouse.y)
                        end

                        if love.mouse.isDown(1) and val.canAttack then --left click to basic attack
                            local angle = math.atan2(val.sprite.y - mouse.y, val.sprite.x - mouse.x)
                            val:addBasicAttack(val.basicDamage, angle)
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
                    if not val.isTower then 
                        AIController:execute(val)
                    end
                end
            else
                if not val.isTower then
                    val.deathTime = math.max(0, val.deathTime - 1)

                    if val.deathTime == 0 then
                        val.curHealth = val.maxHealth
                        val.isRooted = false 
                        val.isBlinded = false 
                        val.isSlowed = false 
                        val.isInvulnerable = false 
                        val.isDebuffed = false 
                        val.isBuffed = false 
                        val.isDashing = false 

                        if val.team == 1 then
                            val.sprite.x = 48
                            val.sprite.y = 200
                        elseif val.team == 2 then
                            val.sprite.x = 1100
                            val.sprite.y = 200
                        end
                    end
                end
            end
        end
    elseif self.winner == 1 then
    elseif self.winner == 2 then
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

    local indAlly = 1
    local indEnemy = 1
    -- draw icons and health bars
    for ind, val in pairs(self.ents) do
        if val.team == 1 and not val.isTower then 
            love.graphics.draw(val.icon, 12 + ((indAlly - 1) * 80), 10)

            if val.deathTime > 0 then
                love.graphics.draw(self.iconGrey, 12 + ((indAlly - 1) * 80), 10)
                love.graphics.draw(self.iconHealthBack, 12 + ((indAlly - 1) * 80), 66)
            else
                healthFactor = val.curHealth / val.maxHealth
                love.graphics.draw(self.iconHealthBack, 12 + ((indAlly - 1) * 80), 66)
                love.graphics.draw(self.iconHealth, 12 + ((indAlly - 1) * 80), 66, 0, healthFactor, 1)
            end

            indAlly = indAlly + 1
        end
        if val.team == 2 and not val.isTower then
            love.graphics.draw(val.icon, 980 + ((indEnemy - 1) * 80), 10)
            
            if val.deathTime > 0 then
                love.graphics.draw(self.iconGrey, 980 + ((indEnemy - 1) * 80), 10)
                love.graphics.draw(self.iconHealthBack, 980 + ((indEnemy - 1) * 80), 66)
            else
                healthFactor = val.curHealth / val.maxHealth
                love.graphics.draw(self.iconHealthBack, 980 + ((indEnemy - 1) * 80), 66)
                love.graphics.draw(self.iconHealth, 980 + ((indEnemy - 1) * 80), 66, 0, healthFactor, 1)
            end

            indEnemy = indEnemy + 1
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
        if val.deathTime == 0 then
            val.sprite:draw()

            healthFactor = val.curHealth / val.maxHealth
            love.graphics.draw(self.spriteHealthBack, val.sprite.x, val.sprite.y + 18)
            love.graphics.draw(self.spriteHealth, val.sprite.x, val.sprite.y + 18, 0, healthFactor, 1)

        end

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