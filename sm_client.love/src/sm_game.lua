SMGame = {}
SMGame.__index = SMGame

function SMGame:new()
    local sm_game = {}
    setmetatable(sm_game, SMGame)

    -- game canvas
    sm_game.canvas = love.graphics.newCanvas(PIXEL_GAME_WIDTH, PIXEL_GAME_HEIGHT)

    sm_game.entities = Entities:new()

    sm_game.entities:add(Player:new(100, 100))

    return sm_game
end

function SMGame:update(dt)
    self.entities:update(dt)

    -- draw game to canvas
    love.graphics.setCanvas(self.canvas)
        -- love.graphics.clear()
        self.entities:draw()
    love.graphics.setCanvas()
end

-- maybe depricated
function SMGame:draw()
end