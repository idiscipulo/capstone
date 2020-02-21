function love.conf(t)
    require('src/entity')
    require('src/character')
    require('src/character_default')
    require('src/server_game')
    require('src/server_socket')
    require('src/entity')
    require('src/timer_util')

    t.window.title = 's e r v e r'
	--For server deployment, no GUI
	t.window=nil
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
    --t.console = true
end