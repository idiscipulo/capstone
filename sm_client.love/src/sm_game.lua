SMGame = {}
SMGame.__index = SMGame

function SMGame:new()
    local sm_game = {}
    setmetatable(sm_game, SMGame)

    return sm_game
end

function SMGame:update()
end

function SMGame:draw()
end