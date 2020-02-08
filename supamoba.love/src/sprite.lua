-- sprite class for drawing characters

Sprite = {}
Sprite.__index = Sprite

function Sprite:new()
    local sprite = {}
    setmetatable(sprite, Sprite)

    -- true if mouse if over sprite
    sprite.isHover = false

    -- icon and description
    sprite.icon = nil
    sprite.desc = nil

    -- character
    sprite.character = nil

    -- x, y, width, and height
    sprite.x = 0
    sprite.y = 0
    sprite.w = 0
    sprite.h = 0

    return sprite
end

function Sprite:set(x, y, w, h, name)
    -- set location and dimensions
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    -- set image
    self.img = love.graphics.newImage('img/'..name..'.sprite.png')
end

function Sprite:update()
    -- check if hovered
    if (self.x < mouse.x and mouse.x < self.x + self.w) and (self.y < mouse.y and mouse.y < self.y + self.h) then
        self.isHover = true
    else
        self.isHover = false
    end
end

function Sprite:draw()
    -- TESTING START
    if temp then
        love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    end
    -- TESTING END

    -- draw sprite
    love.graphics.draw(self.img, self.x, self.y)
end

function Sprite:attach(character)
    -- attach to character
    self.character = character
end