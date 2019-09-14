-- here every active entity will be placed in a table
-- so that they can all be easily accessed and updated
Entities = {}
Entities.__index = Entities

function Entities:new()
    local entities = {}
    setmetatable(entities, Entities)

    entities.entityList = {}

    return entities
end

function Entities:add(entity)
    
    table.insert(self.entityList, entity)
end

function Entities:add_many(entities)
    for i, entity in pairs(entities) do
        table.insert(self.entityList, entity)
    end
end

function Entities:remove(entity)
    for i, e in ipairs(self.entityList) do
        if e == entity then
            table.remove(self.entityList, i)
            return
        end
    end
end

function Entities:clear()  
    self.entityList = {}
end

function Entities:draw()
    for i, e in ipairs(self.entityList) do
        e:draw(i)
    end
end

function Entities:update(dt)
    for i, e in ipairs(self.entityList) do
        e:update(dt, i)
    end
end