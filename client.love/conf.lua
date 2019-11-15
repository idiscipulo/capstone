function love.conf(t)
    require('src/entity')
    require('src/character')
    require('src/character_default')
    require('src/client_game')
    require('src/client_socket')
    require('src/timer_util')
    require('src/bullet')

    t.window.title = 'C13NT'
    t.console = true
end