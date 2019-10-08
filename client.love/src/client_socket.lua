local socket = require('socket')

ClientSocket = {}
ClientSocket.__index = ClientSocket

function ClientSocket:new()
    local client_socket = {}
    setmetatable(client_socket, ClientSocket)

    client_socket.conn = socket.udp() -- create connector
    client_socket.address = nil -- init
    client_socket.port = 0 -- init

    return client_socket
end

function ClientSocket:connect()
    self.address = 'localhost' -- set address
    self.port = 8080 -- set port
    self.conn:setpeername(self.address, self.port) -- create connection
    self.conn:settimeout(0) -- set timeout
end

function ClientSocket:send(packet)
    self.conn:send(packet)
end

function ClientSocket:receive()
    local packet = self.conn:receive()
    local decode = {}
    if packet then 
        decode = self:decode_packet(packet)
    end
    return decode
end

function ClientSocket:encode_packet(id, x, y)
    local packet = ''
    packet = id..'-'..x..'-'..y..'-' -- create packet

    return packet
end

function ClientSocket:decode_packet(packet)
    local decode = {}
    local sub_decode = {}
    local id = 0

    for match in packet:gmatch('(.-);') do
        sub_decode = {}
        for m in match:gmatch('(.-)-') do
            sub_decode[#sub_decode + 1] = m -- split packet
        end
        id = sub_decode[1]
        decode[id] = {}
        decode[id].x = sub_decode[2]
        decode[id].y = sub_decode[3]
        decode[id].goal_x = sub_decode[4]
        decode[id].goal_y = sub_decode[5]
    end

    return decode
end
