Character = {}
Character.__index = Character
setmetatable(Character, Entity) -- inherit from entity

function Character:new(id)
    local character = Entity:new()
    setmetatable(character, Character)

    character.id = id -- set id

    character.speed = 2 -- speed for movement
    character.goal_x = 0 -- goal for movement
    character.goal_y = 0 -- goal for movement

    character.cur_path_node = nil
    character.list_path_nodes = {}

    character.adj_x = 0
    character.adj_y = 0

    -- put a sprite object here (need to write that)

    return character
end

function Character:get_current_node()
    local x = math.floor(0.5 + (self.x / 16)) + 1
    local y = math.floor(0.5 + (self.y / 16)) + 1
    local col = client_game.map.layers['Tile Layer 1'].data[y][x].properties.collidable

    return Node:new(x, y, 0, nil, nil)
end

function Character:create_path(x, y)
    local ind_x = math.floor(0.5 + (x / 16))
    local ind_y = math.floor(0.5 + (y / 16))


    local head = self:get_current_node()
    local cur_node = head
    local new_node = nil
    print('>>> START')
    while cur_node.x ~= ind_x or cur_node.y ~= ind_y do
        print('>>> LOOP')
        new_node = Node:new(cur_node.x, cur_node.y, 0, cur_node, nil)

        if new_node.x < ind_x then
            new_node.x = new_node.x + 1
        elseif new_node.x > ind_x then
            new_node.x = new_node.x - 1
        end

        if new_node.y < ind_y then
            new_node.y = new_node.y + 1
        elseif new_node.y > ind_y then
            new_node.y = new_node.y - 1
        end

        for ind, val in pairs(cur_node.path) do
            new_node.path[#new_node.path + 1] = val
        end
        new_node.path[#new_node.path + 1] = new_node

        cur_node = new_node
    end

    self.list_path_nodes = {}
    for ind, val in pairs(cur_node.path) do
        local n = #self.list_path_nodes + 1
        self.list_path_nodes[n] = {}
        self.list_path_nodes[n].goal_x = (val.x * 16) - (self.w / 2)
        self.list_path_nodes[n].goal_y = (val.y  * 16) - (self.h / 2)
    end

    --[[
    local node = self:get_current_node()

    local open = {}
    local closed = {}
    local seen = {}
    local s = true
    local cur_node = nil
    local nn = 0

    open[1] = node

    while #open > 0 do
        cur_node = table.remove(open)
        closed[#closed + 1] = cur_node
        for i = cur_node[2] - 1, cur_node[2] + 1 do
            for j = cur_node[1] - 1, cur_node[1] + 1 do
                if (i ~= cur_node[2] or j ~= cur_node[1]) and (0 < i and i < 51) and (0 < j and j < 76) then
                    for ind, value in pairs(seen) do
                        s = true
                        if value[1] == j and value[2] == i then
                            s = false
                            break
                        end
                    end

                    if s == true then
                        nn = #seen + 1
                        seen[nn] = {j, i}

                        if client_game.map.layers['Tile Layer 1'].data[i][j].properties.collidable == false then
                            nn = #open + 1
                            open[nn] = {j, i}
                        
                            if i == adj_y and j == adj_x then
                                self.list_path_nodes = {}
                                for ind, val in pairs(closed) do
                                    print(val[1]..','..val[2])
                                    self.list_path_nodes[#self.list_path_nodes + 1] = {val[1] * 16, val[2] * 16}
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    ]]--
end

function Character:update()
    self.adj_x = math.floor(0.5 + (self.x / 16))
    self.adj_y = math.floor(0.5 + (self.y / 16))

    if love.mouse.isDown(2) then -- right click
        self:create_path(love.mouse.getPosition())
        self.cur_path_node = table.remove(self.list_path_nodes)
    end

    if self.cur_path_node ~= nil then
        if self.x == self.cur_path_node.goal_x and self.y == self.cur_path_node.goal_y then
            if #self.list_path_nodes > 0 then
                self.cur_path_node = table.remove(self.list_path_nodes)
            else
                self.cur_path_node = nil
            end
        else
            self:move() -- move
        end
    end
end

function Character:move()
    local speed = 0
    if self.y ~= self.cur_path_node.goal_y and self.x ~= self.cur_path_node.goal_x then
        speed = self.speed / math.sqrt(2)
    else
        speed = self.speed
    end

    if self.y < self.cur_path_node.goal_y then
        if self.cur_path_node.goal_y - self.y < speed then
            self.y = self.y + (self.cur_path_node.goal_y - self.y)
        else
            self.y = self.y + speed
        end
    elseif self.y > self.cur_path_node.goal_y then
        if self.y - self.cur_path_node.goal_y < speed then
            self.y = self.y - (self.y - self.cur_path_node.goal_y)
        else
            self.y = self.y - speed
        end
    end

    if self.x < self.cur_path_node.goal_x then
        if self.cur_path_node.goal_x - self.x < speed then
            self.x = self.x + (self.cur_path_node.goal_x - self.x)
        else
            self.x = self.x + speed
        end
    elseif self.x > self.cur_path_node.goal_x then
        if self.x - self.cur_path_node.goal_x < speed then
            self.x = self.x - (self.x - self.cur_path_node.goal_x)
        else
            self.x = self.x - speed
        end
    end
end
