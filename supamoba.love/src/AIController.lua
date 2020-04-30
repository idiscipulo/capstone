AIController = {}
AIController.__index = AIController

function AIController:execute(char)
    local randNum = 1
    --tower locations and center
    if char.team == 1 then 
        local t1x, t1y = 100, 175
        local t2x, t2y = 100, 375
        local t3x, t3y = 200, 275
        local centerx, centery = 150, 275
    else
        local t1x, t1y = 1100, 175
        local t2x, t2y = 1100, 375
        local t3x, t3y = 1000, 275
        local centerx, centery = 1050, 275
    end

    --attack enemies if they are within range
    for ind, val in pairs(stateList['battle'].ents) do 
        local distance = math.sqrt( (char.sprite.x - val.sprite.x)^2 + (char.sprite.y - val.sprite.y)^2 )
        if val.team ~= char.team and char.canAttack and not val.isDead and distance < char.range then --attack
            local angle = math.atan2(char.sprite.y - val.sprite.y, char.sprite.x - val.sprite.x)
            local cooldown = (distance / (char.basicSpeed * 60))
            char:addBasicAttack(char.basicDamage, angle, cooldown, 0)
            char.canAttack = false

            -- % chance to use a random ability
            randNum = love.math.random(5)
            if randNum == 1 then 
                randNum = love.math.random(3)
                char.abilities[randNum]:use(angle)
            end
        end
    end
    -- random movement, but biased so that teams move towards the opposite towers
    randNum = love.math.random(25)
    if randNum == 1 then 
        local randX, randY
        --if stateList['battle'].min == 0 and stateList['battle'].sec < 8 then --when the game is just starting, move more quickly to other side
        if char.team == 1 then 
            if char.sprite.x < 400 then 
                randX, randY = love.math.random(-20, 200), love.math.random(-50, 50)
            elseif char.sprite.x >= 400 and char.sprite.x < 800 then 
                randX, randY = love.math.random(-150, 200), love.math.random(-100, 100)
            else
                randX, randY = love.math.random(-200, 150), love.math.random(-100, 100)
            end
        elseif char.team == 2 then
            if char.sprite.x > 800 then 
                randX, randY = love.math.random(-200, 20), love.math.random(-50, 50)
            elseif char.sprite.x <= 800 and char.sprite.x > 400 then 
                randX, randY = love.math.random(-200, 150), love.math.random(-100, 100)
            else 
                randX, randY = love.math.random(-150, 200), love.math.random(-100, 100)
            end 
        end
        
        char:setGoal(char.sprite.x + randX, char.sprite.y + randY)
    end
end

