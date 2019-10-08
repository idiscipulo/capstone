local socket = require('socket')

ServerSocket = {}
ServerSocket.__index = ServerSocket

function ServerSocket:new()
    local server_socket = {}
    setmetatable(server_socket, ServerSocket)

    server_socket.conn = socket.udp() -- create connector
    server_socket.address = nil -- init
    server_socket.port = 0 -- init

    return server_socket
end

function ServerSocket:create()
    self.address = '*' -- set address
    self.port = 8080 -- set port
    self.conn:setsockname(self.address, self.port) -- create socket
    self.conn:settimeout(0) -- set timeout
end

function ServerSocket:recieve(input)
    local packet, ip, port = self.conn:receivefrom()
    if packet then 
        self:decode_packet(packet, ip, port, input)
    end
end

function ServerSocket:send(game)
    local packet = self:encode_packet(game)

    for index, value in pairs(game.client_list) do
        self.conn:sendto(packet, value.ip, value.port)
    end
end

function ServerSocket:decode_packet(packet, ip, port, input)
    local decode = {}
    for match in packet:gmatch('(.-)-') do
        decode[#decode + 1] = match -- split packet
    end

    local id = decode[1] -- create input table for id
    input[id] = {}
    input[id].ip = ip
    input[id].port = port
    input[id].mouse_x = decode[2] -- save mouse x coord
    input[id].mouse_y = decode[3] -- save mouse y coord
end

function ServerSocket:encode_packet(game)
    local packet = ''
    
    for index, value in pairs(game.character_list) do
        packet = packet..value.id..'-'..value.x..'-'..value.y..'-'..value.goal_x..'-'..value.goal_y..'-;'
    end

    return packet
end

