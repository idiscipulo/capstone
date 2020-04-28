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


    for ind, val in pairs(stateList['battle'].ents) do 
        local distance = math.sqrt( (char.sprite.x - val.sprite.x)^2 + (char.sprite.y - val.sprite.y)^2 )
        if val.team ~= char.team and char.canAttack and not val.isDead and distance < char.range then --attack
            local angle = math.atan2(char.sprite.y - val.sprite.y, char.sprite.x - val.sprite.x)
            local cooldown = (distance / (char.basicSpeed * 60))
            char:addBasicAttack(char.basicDamage, angle, cooldown, 0)
            char.canAttack = false

            -- % chance to use a random ability
            randNum = love.math.random(10)
            if randNum == 1 then 
                randNum = love.math.random(3)
                char.abilities[randNum]:use(angle)
            end
        end
    end
    -- random movement, but biased so that teams move towards the opposite towers
    randNum = love.math.random(25)
    if randNum == 1 then 
        local randX, randY = love.math.random(-200, 200), love.math.random(-100, 100)
        if char.team == 1 then 
            while randX < -50 and math.abs(randY) < 25 do 
                randX, randY = love.math.random(-200, 200), love.math.random(-100, 100)
            end
        end
        if char.team == 2 then 
            while randX > 50 and math.abs(randY) < 25 do 
                randX, randY = love.math.random(-200, 200), love.math.random(-100, 100)
            end
        end
        char:setGoal(char.sprite.x + randX, char.sprite.y + randY)
        --char:setGoal(char.sprite.x + (20 * (2 - (stateList['battle'].sec % 4))), char.sprite.y + (50 * (1 - (stateList['battle'].sec % 2))))
    end
end

