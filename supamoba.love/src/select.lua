Select = {}
Select.__index = Select

function Select:new()
    local select = {}
    setmetatable(select, Select)

    select.chars = {}
    select.chars[1] = AnderShemov:new()
    select.chars[2] = NissaTimbers:new()
    select.chars[3] = PaeliasAmakir:new()
    select.chars[4] = RhogarNemmonis:new()
    select.chars[5] = RomeroKao:new()
    select.chars[6] = ZainnaRaunor:new()

    select.character = select.chars[1]

    -- background image
    select.back = love.graphics.newImage('img/select.back.png')

    select.health = love.graphics.newImage('img/battle.health.png')
    select.healthBack = love.graphics.newImage('img/battle.health.back.png')

    select.abilityInfo = love.graphics.newImage('img/battle.ability.info.png')

    return select
end

function Select:update()
    for ind, val in pairs(self.character.abilities) do
        val:update()
    end

    if love.mouse.isDown(1) then
        if 429 < mouse.x and mouse.x < 429 + 105 and 141 < mouse.y and mouse.y < 141 + 105 then
            self.character = self.chars[1]
        elseif 549 < mouse.x and mouse.x < 549  + 105 and 141 < mouse.y and mouse.y < 141 + 105 then
            self.character = self.chars[2]
        elseif 669 < mouse.x and mouse.x < 669 + 105 and 141 < mouse.y and mouse.y < 141 + 105 then
            self.character = self.chars[3]
        elseif 429 < mouse.x and mouse.x < 429 + 105 and 263 < mouse.y and mouse.y < 263 + 105 then
            self.character = self.chars[4]
        elseif 549 < mouse.x and mouse.x < 549 + 105 and 263 < mouse.y and mouse.y < 263 + 105 then
            print('test')
            self.character = self.chars[5]
        elseif 669 < mouse.x and mouse.x < 669 + 105 and 263 < mouse.y and mouse.y < 263 + 105 then 
            self.character = self.chars[6]
        elseif 500 < mouse.x and mouse.x < 500 + 200 and 420 < mouse.y and mouse.y < 420 + 50 then
            self:startGame()
        end
    end
        
end

function Select:draw()
    -- draw background
    love.graphics.draw(self.back, 0, 0)

    -- draw big health bar for client character
    if self.character.deathTime > 0 then
        love.graphics.draw(self.healthBack, 850, 510)
    else
        healthFactor = self.character.curHealth / self.character.maxHealth
        love.graphics.draw(self.healthBack, 850, 505)
        love.graphics.draw(self.health, 850, 505, 0, healthFactor, 1)
    end

    for ind, val in pairs(self.chars) do
        love.graphics.draw(val.icon, 434 + (120 * ((ind - 1) % 3)), 146 + (122 * math.floor((ind - 1) / 3)), 0, 2)
    end

    --start button
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle('fill', 500, 420, 200, 50)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print('Start', 565, 430, 0, 2, 2)
    

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
end

function Select:startGame()
    print(self.character.textName)
    self.character.team = 1

    local rList = {1, 1, 2, 2, 2}
    --shuffle
    math.randomseed(os.time())
    for i = #rList, 2, -1 do
        local j = math.random(i)
        rList[i], rList[j] = rList[j], rList[i]
    end 

    local ind2 = 1
    for ind, val in pairs(self.chars) do 
        if val ~= self.character then 
            val.team = rList[ind2]
            ind2 = ind2 + 1
        end
    end
    stateList['battle'] = Battle:new(self.character, self.chars)

    state.parent = 'battle'
end
