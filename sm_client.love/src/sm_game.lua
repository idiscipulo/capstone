SMGame = {}
SMGame.__index = SMGame

function SMGame:new()
    local sm_game = {}
    setmetatable(sm_game, SMGame)

    sm_game.entities = Entities:new()

    sm_game.entities:add(Player:new(100, 100))
    sm_game.socket = SMSocket:new(sm_game.entities.entityList[1])

    return sm_game
end

function SMGame:update(dt)
    self.entities:update(dt)
end

function SMGame:draw()
    self.entities:draw()
end