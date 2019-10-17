local sti = require "libs.sti"

function love.load()
    math.randomseed(os.time())
    client_id = tostring(math.random())
    client_game = ClientGame:new(client_id) -- create game
    client_socket = ClientSocket:new() -- create socket
    client_socket:connect() -- connect to server

    timer_util = TimerUtil:new() -- init timer
    timer_util:set_fps(60) -- set 60fps

    map = sti('assets/first_map.lua')
    map:addCustomLayer("Sprite Layer", 3)

	local spriteLayer = map.layers["Sprite Layer"]
	spriteLayer.sprites = {
		CharacterDefault:new(1)
	}

	function spriteLayer:update(dt)
		for _, sprite in pairs(self.sprites) do
			sprite:update()
		end
	end

	function spriteLayer:draw()
		for _, sprite in pairs(self.sprites) do
			sprite:draw()
		end
	end
end

function love.update()
    map:update()
    timer_util:start_frame() -- start frame

    client_game:update() -- update game

    act_fps = timer_util:end_frame() -- end frame and get fps
end

function love.draw()
    map:draw()
    --client_game:draw() -- draw game
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.push('quit') -- quit on escape key
    end
end