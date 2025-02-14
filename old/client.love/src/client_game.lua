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
    client_game.map.layers['Sprite Layer'].sprites = client_game.character_list

    return client_game
end

function ClientGame:update()
    self.map:update()

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

    --[[for index, value in pairs(self.character_list) do
        if self.client_id == index then
            value:update()
        end
    end]]
end

function ClientGame:draw()
    --[[love.graphics.clear()
    for index, value in pairs(self.character_list) do
        value:draw() -- draw characters
    end]]
    self.map:draw()
end