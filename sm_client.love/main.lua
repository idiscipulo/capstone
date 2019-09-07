function love.load()
    timer_util = TimerUtil:new()
    timer_util:set_fps(60)
end

function love.update()
    timer_util:start_frame()

    act_fps = timer_util:end_frame()
end

function love.draw()
    print(act_fps)
    love.graphics.print({{1, 1, 1, 1}, math.floor(act_fps)}, 0, 0)
end