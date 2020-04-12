function love.conf(t)
    -- utilities
    require('src/timer')

    --networking
    require('src/serverGame')
    require('src/serverSocket')

    -- set true for templating information to be shown
    temp = false

    -- set true for console output to be shown
    t.console = true

    -- disable flags for server compat
    t.modules.joystick = false
    t.modules.keyboard = false
    t.modules.mouse = false
    t.modules.touch = false
    t.modules.physics = false
    t.modules.graphics = false
    t.modules.audio = false
    t.modules.font = false
    t.modules.video = false
    t.modules.window = false
end