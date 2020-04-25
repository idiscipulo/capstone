AIController = {}
AIController.__index = AIController

function AIController:execute(char)
    for ind, val in pairs(stateList['battle'].ents) do 
        if val.team ~= char.team and char.canAttack and not val.isDead then 
            local distance = math.sqrt( (char.sprite.x - val.sprite.x)^2 + (char.sprite.y - val.sprite.y)^2 )
            if distance < char.range then 
                local angle = math.atan2(char.sprite.y - val.sprite.y, char.sprite.x - val.sprite.x)

                local cooldown = (distance / (char.basicSpeed * 60))

                char:addBasicAttack(char.basicDamage, angle, cooldown, 0)
                char.canAttack = false
            end
        end
    end
    char:setGoal(char.sprite.x + (20 * (2 - (stateList['battle'].sec % 4))), char.sprite.y + (50 * (1 - (stateList['battle'].sec % 2))))
end