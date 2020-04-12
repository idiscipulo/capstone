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
    serverSocket:recieve(self.input)    
    ----[[
    for index, value in pairs(self.input) do
        if self.client_list[index] == nil then
            print(index) --print new clientId onJoin
            self.client_list[index] = {}
            self.client_list[index].ip = value.ip
            self.client_list[index].port = value.port            
        else
            --print(index ..": " .. value.mouse_x.. "|"..value.mouse_y)
        end 
    end
    --]]--

    for index, value in pairs(self.character_list) do
        value:update()
    end
    
    --serverSocket:send(self) --TOADD  Just receiving packets for now
end
