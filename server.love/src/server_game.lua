ServerGame = {}
ServerGame.__index = ServerGame

function ServerGame:new(server_id)
    local server_game = {}
    setmetatable(server_game, ServerGame)

    server_game.input = {}
    server_game.client_list = {}
    server_game.character_list = {}

    return server_game
end

function ServerGame:update()
    server_socket:recieve(self.input)

    for index, value in pairs(self.input) do
        if self.client_list[index] == nil then
            self.client_list[index] = {}
            self.client_list[index].ip = value.ip
            self.client_list[index].port = value.port

            self.character_list[index] = CharacterDefault:new(index)
            self.character_list[index]:set_goal(value.mouse_x, value.mouse_y)
        else
            self.character_list[index]:set_goal(value.mouse_x, value.mouse_y)
        end
    end

    for index, value in pairs(self.character_list) do
        value:update()
    end
    
    server_socket:send(self)
end

function ServerGame:draw()
    for index, value in pairs(self.character_list) do
        value:draw() -- draw characters
    end
end