--Every object in the game will be an entity
Entity = {}
Entity.__index = Entity

--Contructor
function Entity.new(x, y, w, h)
    local entity_instance = {
        x = x,
        y = y,
        w = w,
        h = h
    }

    setmetatable(entity_instance, Entity)
    return entity_instance
end

function Entity:get_rect()
    return self.x, self.y, self.w, self.h
end

function Entity:get_position()
    return self.x, self.y
end

function Entity:get_x()
    return self.x 
end

function Entity:get_y()
    return self.y
end

return Entity 