Entity = {}
Entity.__index = Entity

function Entity:new()
    local entity = {}
    setmetatable(entity, Entity)
    
    entity.x = 0 -- init x
    entity.y = 0 -- init y
    entity.w = 0 -- init width
    entity.h = 0 -- init height
    entity.objectQueue = {} -- table of objects to be added to the world
    entity.despawn = false 
    entity.movable = true

    return entity
end

function Entity:get_rect()
    return self.x, self.y, self.w, self.h -- return position and rect dimensions
end

function Entity:get_position()
    return self.x, self.y -- return position
end

function Entity:get_center()
    return self.x + self.w/2, self.y + self.h/2 -- return center
end