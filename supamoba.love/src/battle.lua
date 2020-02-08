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
    battle.character = CharExample:new()

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

    -- initialize table for enemies
    battle.enemies = {}

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

    -- update client character abilities
    for ind, val in pairs(self.character.abilities) do
        val:update()
    end

    -- create cooldown text for abilities with cooldowns
    self.cooldowns = {}
    for ind, val in pairs(self.character.abilities) do
        self.cooldowns[#self.cooldowns + 1] = font:printToCanvas(''..1 + math.floor(val.maxCool - val.curCool), 40, 10, 'center')
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
        end

        -- if q pressed
        if love.keyboard.isDown('q') then
            -- if ability is targetable check for target before casting
            if self.character.abilities[1].targetable then
                for ind, val in pairs(self.ents) do
                    if val.sprite.isHover then
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
                for ind, val in pairs(self.ents) do
                    if val.sprite.isHover then
                        self.character.abilities[2]:use(val)
                    end
                end
            -- otherwise just cast
            else
                self.character.abilities[1]:use()
            end
        -- if e is pressed
        elseif love.keyboard.isDown('e') then
            -- if ability is targetable check for target before casting
            if self.character.abilities[3].targetable then
                for ind, val in pairs(self.ents) do
                    if val.sprite.isHover then
                        self.character.abilities[3]:use(val)
                    end
                end
            -- otherwise just cast
            else
                self.character.abilities[3]:use()
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
    love.graphics.draw(self.time, 580, 20, 0, 2, 2)

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
        love.graphics.draw(val.icon, 975 + ((ind - 1) * 80), 10)
        
        if val.deathTime > 0 then
            love.graphics.draw(self.iconGrey, 975 + ((ind - 1) * 80), 10)
            love.graphics.draw(self.iconHealthBack, 975 + ((ind - 1) * 80), 66)
        else
            healthFactor = val.curHealth / val.maxHealth
            love.graphics.draw(self.iconHealthBack, 975 + ((ind - 1) * 80), 66)
            love.graphics.draw(self.iconHealth, 975 + ((ind - 1) * 80), 66, 0, healthFactor, 1)
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
            love.graphics.draw(self.abilityInfo, 436, 510)
            love.graphics.draw(val.desc, 440, 514)
        end
    end

    -- draw particles
    for ind, val in pairs(self.particles) do
        val:draw()
    end

    -- draw sprite health bars
    for ind, val in pairs(self.ents) do
        val.sprite:draw()
        healthFactor = self.character.curHealth / self.character.maxHealth
        love.graphics.draw(self.spriteHealthBack, val.sprite.x, val.sprite.y + 18)
        love.graphics.draw(self.spriteHealth, val.sprite.x, val.sprite.y + 18, 0, healthFactor, 1)
    end

    -- draw numbers
    for ind, val in pairs(self.numbers) do 
        val:draw()
    end
end