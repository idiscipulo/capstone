function love.conf(t)
    require("src/entity")
    require("src/entities")
    require("src/player")
    require("src/mage")
    require("src/npc")
    require("src/square_npc")
    require("src/sm_socket")
    require("src/sm_game")
    require("src/timer_util")
    t.window.title = "Client"
    t.console = true
end