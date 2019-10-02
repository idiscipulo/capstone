--Every object in the game will be an entity
Entity = {}
Entity.__index = Entity

--Contructor
function Entity:new(x, y, w, h)
    local entity = {}
    setmetatable(entity_instance, Entity)
    
    entity.x = x
    entity.y = y
    entity.w = w
    entity.h = h

    return entity
end

function Entity:get_rect()
    return self.x, self.y, self.w, self.h
end

function Entity:get_position()
    return self.x, self.y
end

function Entity:get_center()
    return self.x + self.w/2, self.y + self.h/2
end

function Entity:to_string()
    if self.x and self.y then 
        return self:round(self.x) .. '-' .. self:round(self.y)
    end
end

function Entity:get_y()
    return self.y
end

function Entity:round(num)
    return num + 0.5 - (num + 0.5) % 1
end