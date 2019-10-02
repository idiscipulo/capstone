SMGame = {}
SMGame.__index = SMGame

function SMGame:new()
    local sm_game = {}
    setmetatable(sm_game, SMGame)

    sm_game.entities = Entities:new()

    sm_game.entities:add(Mage:new(100, 100))
    sm_game.entities:add(Square:new(0, 200))
    sm_game.socket = SMSocket:new(sm_game.entities.entityList[1])

    return sm_game
end

function SMGame:update()
    self.entities:update()
    --this is a temporary hack. We will need to figure out a cleaner way to pass player info into npc functions
    self.entities.entityList[2]:move(self.entities.entityList[1]:get_center())
    self.socket:update()
end

function SMGame:draw()
    self.entities:draw()
end