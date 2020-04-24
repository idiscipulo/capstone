AIController = {}
AIController.__index = AIController

function AIController:execute(char)
    for ind, val in pairs(stateList['battle'].ents) do
        if val.team ~= char.team then
            if char.canAttack then
                local goalX = val.sprite.x
                local goalY = val.sprite.y
                local angle = math.atan2(char.sprite.y - goalY, char.sprite.x - goalX)

                local dist = math.min(char.basicRange, math.sqrt((char.sprite.x - goalX) ^ 2 + (char.sprite.y - goalY) ^ 2))
                local cooldown = (dist / (char.basicSpeed * 60))

                char:addBasicAttack(3, angle, cooldown, 0)
                char.canAttack = false
            end
        end
    end
    char:setGoal(char.sprite.x + (20 * (2 - (stateList['battle'].sec % 4))), char.sprite.y + (50 * (1 - (stateList['battle'].sec % 2))))
end