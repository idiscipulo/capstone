local Player = require 'src.player'
local Entities = require 'src.entities'

function love.load()
    local players = {
        player1 = Player.new(100, 100),
        player2 = Player.new(300, 300)
    }
    Entities:add_many(players)

end

function love.update(dt)
    Entities:update(dt)
end

function love.draw()
    Entities:draw()
end