function love.conf(t)
    require("src/entity")
    require("src/entities")
    require("src/player")
    require("src/sm_socket")
    require("src/sm_game")
    require("src/timer_util")

    -- game variables
    FULLSCREEN = true
    PIXEL_GAME_WIDTH = 320
    PIXEL_GAME_HEIGHT = 224

    t.console = true
end