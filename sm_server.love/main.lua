function love.load()
    sm_game = SMGame:new()

    timer_util = TimerUtil:new()
    timer_util:set_fps(60)
end

function love.update()
    timer_util:start_frame()
    
    sm_game:update()

    act_fps = timer_util:end_frame()
end

function love.draw()
    sm_game:draw()

    -- fps (testing)
    love.graphics.print({{1, 1, 1, 1}, math.floor(act_fps)}, 0, 0)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end