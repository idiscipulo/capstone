SMGame = {}
SMGame.__index = SMGame

function SMGame:new()
    local sm_game = {}
    setmetatable(sm_game, SMGame)

    sm_game.entities = Entities:new()

    sm_game.entities:add(Player:new(100, 100))
    sm_game.socket = SMSocket:new()

    return sm_game
end

function SMGame:update(dt)
    self.entities:update(dt)
    self.socket:update()
end

function SMGame:draw()
    self.entities:draw()
end