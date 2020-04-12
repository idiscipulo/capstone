-- parent class for abilities

Ability = {}
Ability.__index = Ability

function Ability:new(targetable)
    local ability = {}
    setmetatable(ability, Ability)

    -- true if mouse is over ability button
    ability.isHover = false

    -- icon and description
    ability.icon = nil
    ability.desc = nil

    -- character ability belongs to
    ability.character = nil

    -- tracks ability cooldown
    ability.curCool = 0
    ability.maxCool = 0

    -- true if ability is on cooldown
    ability.locked = false

    -- ability icon location and dimensions
    ability.x = 0
    ability.y = 0
    ability.w = 0
    ability.h = 0

    -- true if the ability requires mouse-over-target
    ability.targetable = targetable

    return ability
end

function Ability:set(x, y, w, h, maxCool, name)
    -- set icon location and dimensions
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    -- set length of cooldown
    self.maxCool = maxCool

    -- set icon from ability name
    self.icon = love.graphics.newImage('img/'..name..'.icon.png')
end

function Ability:update()
    -- check if mouse if hovering over ability icon
    if (self.x < mouse.x and mouse.x < self.x + self.w) and (self.y < mouse.y and mouse.y < self.y + self.h) then
        self.isHover = true
    else
        self.isHover = false
    end

    -- if ability is on cooldown, decrease the cooldown
    if self.locked then
        self.curCool = self.curCool + timer.fps
        if self.curCool > self.maxCool then
            self.curCool = 0
            self.locked = false
        end
    end
end

function Ability:draw()
    -- TESTING START
    if temp then
        love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    end
    -- TESTING END

    -- draw the ability icon
    love.graphics.draw(self.icon, self.x, self.y)
end

-- called when ability is added to a character
function Ability:attach(character)
    self.character = character
end

-- called when ability is used, returns true if able to use
function Ability:use()
    if self.locked == false then
        self.locked = true
        return true
    end
    return false
end