socket = require("socket") --import lua socket
local udp = socket.udp()
udp:settimeout(0)
udp:setsockname('*', 8080) --for now just one instance, will allow a host to start this later

SMSocket = {}
SMSocket.__index = SMSocket

function SMSocket:new()
    local sm_socket = {client_num = 0, client_ids = {}}
    setmetatable(sm_socket, SMSocket)

    return sm_socket
end--new()

function SMSocket:update()
	while true do --starts loop to listen
		--receive data
		local client_data = self.get_input()
        
        --broadcast to clients
        self:send_state(client_data[1], client_data[2])
        
        -- TODO
        -- send all state as one udp packet

		--FIXME
		--a way to close server
	end --while
end --update()

function SMSocket:get_input()
	local input ={}
	--receive data
	local data, ip, port = udp:receivefrom()
	if (data) then

	--split player movement data
	--Needed here if we run a game on the server side.
	--where we would then draw a square per client and match the data in p_movement to client_id in sm_socket[2]
	local p_movement = split(data, '-') --[player_pos_x, player_pos_y, mouse_x, mouse_y]

	--manage clients
	local client_id = ip..":"..port
	if not sm_socket[2][client_id] then --FIXME --is this correct way to access sm_socket? //Boice
		sm_socket[2][client_id] = {ip = ip, port = port} --KVP
	end--if
	table.insert(input, client_id)
	table.insert(input, data)
	return input
end --get_input()

function SMSocket:send_state(client_id, client_data)
	for _, c in pairs(sm_socket[2]) do
		udp:sendto(client_data..'-'.. client_id, c.ip, c.port)
	end --for
end --send_state() 

function split(s, delimiter) --[player_pos_x, player_pos_y, mouse_x, mouse_y, client_name]
	result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end --for
	return result
end --split
