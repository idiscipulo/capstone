-- parent class for numbers

Number = {}
Number.__index = Number

function Number:new(ind, character, amt, type)
    local number = {}
    setmetatable(number, Number)

    -- set index in number list and attached character
    number.ind = ind
    number.character = character

    -- track duration
    number.sec = 0
    number.dur = 1.5

    -- set healing or damage
    number.type = type

    -- create canvas
    number.text = font:printToCanvas(''..math.ceil(amt), 32, 10, 'center')

    return number
end

function Number:update()
    -- increment timer
    self.sec = self.sec + timer.fps
    if self.sec > self.dur then
        -- if duration expired, delete
        stateList['battle'].numbers[self.ind] = nil
    end
end

function Number:draw()
    local x, y = 0
    if self.type == 'DAMAGE' then
        -- if damage, set red color mask that fades to transparent
        love.graphics.setColor(1, 0, 0, (self.dur - self.sec) / self.dur)

        -- compute x and y, drifiting up and side-to-side
        x = (self.character.sprite.x - 4) + (math.sin((self.sec / self.dur) * 5) - 0.5) * 10
        y = self.character.sprite.y - ((self.sec / self.dur) * 16)
    elseif self.type == 'HEAL' then
        -- if healing, set green color mask that fades to transparent
        love.graphics.setColor(0, 1, 0, (self.dur - self.sec) / self.dur)

        -- compute x and y, drifiting up and side-to-side (opposite of damage)
        x = (self.character.sprite.x - 4) - (math.sin((self.sec / self.dur) * 5) + 0.5) * 10
        y = self.character.sprite.y - ((self.sec / self.dur) * 16)
    end

    -- draw number
    love.graphics.draw(self.text, x, y)

    -- set color mask to normal
    love.graphics.setColor(1, 1, 1, 1)
end