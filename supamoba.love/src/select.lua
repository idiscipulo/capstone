Select = {}
Select.__index = Select

function Select:new()
    local select = {}
    setmetatable(select, Select)

    return select
end

function Select:update()
end

function Select:draw()
end