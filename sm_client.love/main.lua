function love.load()
    -- initialize love window
    if FULLSCREEN then
		suc = love.window.setMode(1, 1, {vsync = false, fullscreen = true})
	else
		suc = love.window.setMode(PIXEL_GAME_WIDTH, PIXEL_GAME_HEIGHT, {vsync = false, fullscreen = false})
	end
    
    -- calculate screen variables
	ACTUAL_SCREEN_WIDTH = love.graphics.getWidth()
    ACTUAL_SCREEN_HEIGHT = love.graphics.getHeight()
    SCALE = math.min(ACTUAL_SCREEN_WIDTH / PIXEL_GAME_WIDTH, ACTUAL_SCREEN_HEIGHT / PIXEL_GAME_HEIGHT)
    ACTUAL_GAME_WIDTH = PIXEL_GAME_WIDTH * SCALE
    ACTUAL_GAME_HEIGHT = PIXEL_GAME_HEIGHT * SCALE
    ACTUAL_X_OFFSET = math.max((ACTUAL_SCREEN_WIDTH / 2) - (ACTUAL_GAME_WIDTH / 2), 0)
    ACTUAL_Y_OFFSET = math.max((ACTUAL_SCREEN_HEIGHT / 2) - (ACTUAL_GAME_HEIGHT / 2), 0)

    -- set screen
    if FULLSCREEN then
		love.window.setMode(ACTUAL_GAME_WIDTH, ACTUAL_GAME_HEIGHT, {vsync = false, fullscreen = true})
	else
		love.window.setMode(PIXEL_GAME_WIDTH, PIXEL_GAME_HEIGHT, {vsync = false, fullscreen = false})
    end

    -- set nearest neighbor scaling
    love.graphics.setDefaultFilter( "nearest", "nearest", 1 )
    
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
    love.graphics.setCanvas()
        love.graphics.draw(sm_game.canvas, ACTUAL_X_OFFSET, ACTUAL_Y_OFFSET, 0, SCALE, SCALE)

    -- fps (testing)
    love.graphics.print({{1, 1, 1, 1}, math.floor(act_fps)}, 0, 0)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end