socket = require("socket") --import lua socket
local udp = socket.udp()
udp:settimeout(0)
udp:setsockname('*', 8080) --for now just one instance, will allow a host to start this later

SMSocket = {}
SMSocket.__index = SMSocket

function SMSocket:new()
    local sm_socket = {}
    setmetatable(sm_socket, SMSocket)

    sm_socket.client_num = 0
    sm_socket.client_ids = {}
    

    return sm_socket
end--new()

function SMSocket:update()
	--we don't need a loop here because its called on a loop in sm_game
	--receive data
	local client_data = self:get_input()

	--broadcast to clients
	if client_data[1] and client_data[2] then
		sm_game.entities.entityList[1]:move(split(client_data[1], '-')[1],  split(client_data[1], '-')[2])
		self:send_state(client_data[1], client_data[2])
	end
	
	-- TODO
	-- send all state as one udp packet

	--FIXME
	--a way to close server

end --update()

function SMSocket:get_input()
	local input = {}
	local client_id_iter = nil
	--receive data
	local data, ip, port = udp:receivefrom()
	--print(data)
	if (data) then
		--split player movement data
		--Needed here if we run a game on the server side.
		local p_movement = split(data, '-') --[player_pos_x, player_pos_y, mouse_x, mouse_y]

		--manage clients
		client_id_iter = ip..":"..port
		if self.client_ids == nil or not self.client_ids[client_id_iter] then
			self.client_ids[client_id_iter] = {ip = ip, port = port}
		end
	end--if
	table.insert(input, data)
	table.insert(input, client_id_iter)
	return input
end --get_input()

function SMSocket:send_state(client_data, client_id)
	for _, c in pairs(self.client_ids) do
		udp:sendto(client_data..'-'.. client_id, c.ip, c.port)
	end --for
end --send_state() 

function split(s, delimiter) --[player_pos_x, player_pos_y, mouse_x, mouse_y, client_id]
	result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end --for
	return result
end --split
