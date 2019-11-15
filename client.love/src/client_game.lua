ClientGame = {}
ClientGame.__index = ClientGame

function ClientGame:new(client_id, map)
    local client_game = {}
    setmetatable(client_game, ClientGame)
    
    client_game.client_id = client_id
    client_game.map = map

    client_game.mouse_x = nil -- mouse x coord
    client_game.mouse_y = nil -- mouse y coord
    client_game.mouse_x_last = nil -- previous mouse x coord
    client_game.mouse_y_last = nil -- previous mouse y coord

    client_game.character_list = {} -- list of characters 
    client_game.character_list[client_game.client_id] = CharacterDefault:new(client_game.client_id) -- index by id
    client_game.map.layers.sprite_layer.sprites = client_game.character_list

    --collision demo --temporary
    client_game.collidable_list = {} --list of collidable objects
    client_game.collidable_list[1] = client_game.character_list[client_game.client_id]
    client_game.collidable_list[2] = Wall:new(526,396,20,20)
    client_game.collidable_list[3] = Wall:new(526,356,20,20)

    return client_game
end

function ClientGame:update()
    if love.mouse.isDown(2) then -- right click
        self.mouse_x, self.mouse_y = love.mouse.getPosition() -- get mouse coords
    end

    if self.mouse_x == self.mouse_x_last and self.mouse_y == self.mouse_y_last then
        self.mouse_x = nil -- ignore input if already processed
        self.mouse_y = nil -- ignore input if already processed
    end

    if self.mouse_x and self.mouse_y then
        self.mouse_x_last = self.mouse_x -- set previous values
        self.mouse_y_last = self.mouse_y -- set previous values

        local packet = client_socket:encode_packet(self.client_id, self.mouse_x, self.mouse_y) -- create packet
        client_socket:send(packet) -- send packet

        self.character_list[self.client_id]:set_goal(self.mouse_x, self.mouse_y)
    end

    local decode = client_socket:receive() -- recieve packet
    for index, value in pairs(decode) do
        if self.character_list[index] == nil then
            self.character_list[index] = CharacterDefault:new(index)
            self.character_list[index].x = value.x
            self.character_list[index].y = value.y
            self.character_list[index].goal_x = value.goal_x
            self.character_list[index].goal_y = value.goal_y
        else
            self.character_list[index].x = value.x
            self.character_list[index].y = value.y
            self.character_list[index].goal_x = value.goal_x
            self.character_list[index].goal_y = value.goal_y
        end
    end

    for index, value in pairs(self.map.layers['sprite_layer'].sprites) do
        if value.is_creep then 
            value:update(self.character_list[self.client_id]:get_position())
        else
            value:update()
        end

        if value.objectQueue ~= nil then 
            for _, object in pairs(value.objectQueue) do 
                table.insert(self.map.layers.sprite_layer.sprites, object)
            end
        end
    end
    for index, value in pairs(self.map.layers.sprite_layer.sprites) do 
        if value.despawn then self.map.layers.sprite_layer.sprites[index] = nil end
    end
    
    --check circle collisions for collidable objects in self.collidable_list[]    
    for i=1, #self.collidable_list-1 do
        local partA = self.collidable_list[i]
        for j=i+1, #self.collidable_list do
            local partB = self.collidable_list[j]
            self:collisionDetect(partA, partB)
        end
    end
end

function ClientGame:checkCircleDist(charObj1, charObj2)
    local dist = (charObj1.x - charObj2.x)^2 + (charObj1.y - charObj2.y)^2
    return dist <= ((charObj1.w/2) + (charObj2.w/2))^2
end

function ClientGame:collisionDetect(charObj1, charObj2)              
    if(self:checkCircleDist(charObj1, charObj2)) then
        --prevents overlap "sticky collision"  
        local midpointX = (charObj1.x + charObj2.x)/2
        local midpointY = (charObj1.y + charObj1.y)/2
        local dist = math.sqrt((charObj1.x - charObj2.x)^2 + (charObj1.y - charObj2.y)^2)
        if(charObj1.movable) then
            charObj1.x = midpointX + (charObj1.w/2) * (charObj1.x - charObj2.x)/dist
            charObj1.goal_x = charObj1.x
            charObj1.y = midpointY + (charObj1.w/2) * (charObj1.y - charObj2.y)/dist
            charObj1.goal_y = charObj1.y
        end
        if(charObj2.movable) then
            charObj2.x = midpointX + (charObj2.w/2) * (charObj2.x - charObj1.x)/dist
            charObj2.goal_x = charObj2.x
            charObj2.y = midpointY + (charObj2.w/2) * (charObj2.y - charObj1.y)/dist
            charObj2.goal_y = charObj2.y
        end
    end
end

function ClientGame:draw()
    love.graphics.clear()
    self.map:draw()
    self.collidable_list[2]:draw() --temporary
    self.collidable_list[3]:draw()  --temporary
end

