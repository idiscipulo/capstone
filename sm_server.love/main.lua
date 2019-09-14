function love.load()
    sm_game = SMGame:new()

    timer_util = TimerUtil:new()
    timer_util:set_fps(60)
end

function love.update()
    timer_util:start_frame()
    
    sm_game:update()

    timer_util:end_frame()
end

function love.draw()
    sm_game:draw()
end