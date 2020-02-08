CharacterDefault = {}
CharacterDefault.__index = CharacterDefault
setmetatable(CharacterDefault, Character)

function CharacterDefault:new(id)
    local character_default = Character:new(id)
    setmetatable(character_default, CharacterDefault)

    character_default.w = 16
    character_default.h = 16

    character_default.img = love.graphics.newImage("/assets/mage_frames.png")
    character_default.frames = {
        love.graphics.newQuad(0, 0, character_default.w, character_default.h, character_default.img:getDimensions()),
        love.graphics.newQuad(0, 16, character_default.w, character_default.h, character_default.img:getDimensions())
    }
    character_default.cur_frame = character_default.frames[1]


    return character_default
end

function CharacterDefault:update()
    self.adj_x = math.floor(0.5 + (self.x / 16))
    self.adj_y = math.floor(0.5 + (self.y / 16))

    if love.mouse.isDown(2) then -- right click
        self:create_path(love.mouse.getPosition())
        self.cur_path_node = table.remove(self.list_path_nodes, 1)
    end

    if self.cur_path_node ~= nil then
        if self.x == self.cur_path_node.goal_x and self.y == self.cur_path_node.goal_y then
            if #self.list_path_nodes > 0 then
                self.cur_path_node = table.remove(self.list_path_nodes, 1)
                print(self.cur_path_node.goal_x..','..self.cur_path_node.goal_y)
            else
                self.cur_path_node = nil
            end
        else
            self:move() -- move
        end
    end
    self:animate()
end

local elapsed_time = 0
function CharacterDefault:animate()
    --using dt for now 
    local dt = love.timer.getDelta()
    elapsed_time = elapsed_time + dt 
    if elapsed_time > 0.5 then 
        if self.cur_frame == self.frames[1] then 
            self.cur_frame = self.frames[2]
        else 
            self.cur_frame = self.frames[1]
        end
        elapsed_time = 0
    end
end

function CharacterDefault:draw()
    for ind, value in pairs(self.list_path_nodes) do
        love.graphics.rectangle('fill', value.goal_x, value.goal_y, 16, 16)
    end

    love.graphics.draw(self.img, self.cur_frame, self.x, self.y)
end  