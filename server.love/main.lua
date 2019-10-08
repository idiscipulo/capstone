function love.load()
    server_game = ServerGame:new(server_id) -- create game
    server_socket = ServerSocket:new() -- create socket
    server_socket:create() -- create recieving socket

    timer_util = TimerUtil:new() -- init timer
    timer_util:set_fps(60) -- set 60fps
end

function love.update()
    timer_util:start_frame() -- start frame

    server_game:update() -- update game

    act_fps = timer_util:end_frame() -- end frame and get fps
end

function love.draw()
    server_game:draw() -- draw game
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.push('quit') -- quit on escape key
    end
end