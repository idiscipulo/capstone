socket = require("socket") --import lua socket
local address, port = "localhost", 8080
udp = socket.udp()
udp:setpeername(address, port)
udp:settimeout(0)

SMSocket = {}
SMSocket.__index = SMSocket

function SMSocket:new(player)
	local sm_socket = {}
	sm_socket.player = player
    setmetatable(sm_socket, SMSocket)

    return sm_socket
end

function SMSocket:update()
	--we cant't have loops in here because update gets called on a loop in sm_game
	--send to server
	self:send_state()
	--receive data
	local server_data = self:get_state()      
	
end


function SMSocket:send_state()
	udp:send(self.player:to_string())
end

function SMSocket:get_state()
	--receive data
	local data = udp:receive()  --program is stalling here
	if(data) then
		print(data)
		local p_movement = split(data, '-') --[player_pos_x, player_pos_y, mouse_x, mouse_y, client_id]

	end--if
	return data
end

function split(s, delimiter) --[player_pos_x, player_pos_y, mouse_x, mouse_y, client_id]
	result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end --for
	return result
end --split

return SMSocket