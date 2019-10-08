function love.conf(t)
    require('src/entity')
    require('src/character')
    require('src/character_default')
    require('src/server_game')
    require('src/server_socket')
    require('src/entity')
    require('src/timer_util')

    t.window.title = 's e r v e r'
    t.console = true
end