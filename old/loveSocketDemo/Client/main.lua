local socket = require "socket"
local address, port = "localhost", 12346
udp = socket.udp()
udp:setpeername(address, port)
udp:settimeout(0)

local greenX, greenY = '100', '100'
local redX, redY = '400', '100'
local blueX, blueY = '300', '300'
local clientID = 0

function love.load()
	--send an initial connect message to get back a clientID
	udp:send('connect')
end

function love.draw()
	love.graphics.setColor(0, 1, 0)
	love.graphics.rectangle("fill", greenX, greenY, 50, 50)

	love.graphics.setColor(1, 0, 0)
	love.graphics.rectangle("fill", redX, redY, 50, 50)

	love.graphics.setColor(0, 0, 1)
	love.graphics.rectangle("fill", blueX, blueY, 50, 50)
end

function love.update()
	--first receive will give clientID then should act as giving the other squares position from server
	data = udp:receive()
	print(data)
	if data then
		local p = split(data, '-')
		if p[1] == 'clientNum' then
			clientID = p[2]
		elseif clientID == 1 then			
			if p[3] == 0 then				
				greenX, greenY = p[1], p[2]
			else
				blueX, blueY = p[1], p[2]
			end
		elseif clientID == 2 then
			if p[3] == 0 then				
				greenX, greenY = p[1], p[2]
			else
				redX, redY = p[1], p[2]
			end
		end
	end
	--sending mouse position depending on id
	if clientID == 1 then
		redX, redY = love.mouse.getPosition()
		udp:send(tostring(redX)..'-'..tostring(redY)..'-'..tostring(clientID))
	elseif clientID == 2 then
		blueX, blueY = love.mouse.getPosition()
		udp:send(tostring(blueX)..'-'..tostring(blueY)..'-'..tostring(clientID))
	end 
end

function split(s, delimiter)
	result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end