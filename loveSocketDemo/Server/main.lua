local socket = require('socket')
udp = socket.udp()
udp:setsockname('*', 12346)
udp:settimeout(0)

local greenX, greenY = '100', '100'
local redX, redY = '400', '100'
local blueX, blueY = '300', '300'
local clientNum = 1
local serverID = 0
local client1ip= ''
local client1port = ''
local client2ip= ''
local client2port = ''

function love.draw()
	love.graphics.setColor(0, 1, 0)
	love.graphics.rectangle("fill", greenX, greenY, 50, 50)

	love.graphics.setColor(1, 0, 0)
	love.graphics.rectangle("fill", redX, redY, 50, 50)

	love.graphics.setColor(0, 0, 1)
	love.graphics.rectangle("fill", blueX, blueY, 50, 50)
end

function love.update()
	greenX, greenY = love.mouse.getPosition()
	data, msg_or_ip, port_or_nil = udp:receivefrom()	
	print(data)
	if data then
		local p = split(data, '-')
		if tostring(p[1]) == 'connect' then --This branch will trigger by initial send from client
			udp:sendto('clientNum'..'-'..tostring(clientNum), msg_or_ip, port_or_nil) --should in theory give proper client number
			if clientNum == 1 then
				client1ip = msg_or_ip
				client1port = port_or_nil
			else
				client2ip = msg_or_ip
				client2port = port_or_nil
			end
			clientNum = clientNum + 1			
		else
			if p[3] == 1 then --if data received is from clientID 1
				redX, redY = p[1], p[2]
				udp:sendto(tostring(greenX)..'-'..tostring(greenY)..'-'..tostring(serverID), msg_or_ip, port_or_nil)
				msg_or_ip = client2ip
				port_or_nil = client2port
				udp:sendto(tostring(redX)..'-'..tostring(redY)..'-'..tostring(p[3]), msg_or_ip, port_or_nil)
			else --if data received is from clientID 2 "will scale in future" "hopefully wont have to hardcode everything"
				 -- "planning to use a datastructure to scale at least up to 6"
				blueX, blueY = p[1], p[2]
				udp:sendto(tostring(greenX)..'-'..tostring(greenY)..'-'..tostring(serverID), msg_or_ip, port_or_nil) 
				msg_or_ip = client1ip
				port_or_nil = client1port
				udp:sendto(tostring(blueX)..'-'..tostring(blueY)..'-'..tostring(p[3]), msg_or_ip, port_or_nil)
			end
		end
	end
end

function split(s, delimiter) --hopefully works for more than 2
	result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end