socket = require("socket") --import lua socket
local address, port = "localhost", 8080
udp = socket.udp()
udp:setpeername(address, port)

SMSocket = {}
SMSocket.__index = SMSocket

function SMSocket:new(player)
	local sm_socket = {}
	sm_socket.player = player
    setmetatable(sm_socket, SMSocket)

    return sm_socket
end

function SMSocket:update()
	while true do --starts loop to listen
		--receive data
		local server_data = self.get_input()        
        --send to server
		self:send_state(client_data)
	end	
end


function SMSocket:send_input()
	udp:send(self.player:to_string())
end

function SMSocket:get_state()
	--receive data
	local data, ip, port = udp:receivefrom()
	if(data) then

		local p_movement = split(data, '-') --[player_pos_x, player_pos_y, mouse_x, mouse_y]

		--manage clients
		--clients need to keep track of clients that are not themselves
		local client_id = ip..":"..port
		--if not this clients ip and port
			--stick in table or not if it exists already
			--use p_movement to update that client's position
		--else --it is our client_id

	end--if
	return data
end

function split(s, delimiter) --[player_pos_x, player_pos_y, mouse_x, mouse_y, client_name]
	result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end --for
	return result
end --split

return SMSocket