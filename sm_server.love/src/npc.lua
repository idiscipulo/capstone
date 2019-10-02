--NPC is an abstract class that serves as the base class for all npc characters
NPC = {}
NPC.__index = NPC

--Inheriting from Entity
setmetatable(NPC, Entity)

function NPC:new()
    local npc = {}
    setmetatable(npc, NPC)

    return npc
end

function NPC:update()
    --does nothing by default
end

--a default movement function that will move the npc to the given coordinates
function NPC:move(goal_x, goal_y)
    if goal_x and goal_y then    
        local center_x, center_y = self:get_center()
        local angle = math.atan2(center_y - goal_y, center_x - goal_x)

        self.x = self.x - math.cos(angle) * self.speed
        self.y = self.y - math.sin(angle) * self.speed

        if math.abs(center_x - goal_x) <= self.speed then
            self.x = goal_x - self.w/2
        end
        if math.abs(center_y - goal_y) <= self.speed then
            self.y = goal_y - self.h/2
        end
    end
end

function NPC:draw()
    --does nothing by default
end  