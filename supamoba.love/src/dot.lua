-- parent class for dots, which function as buffs/debuffs

Dot = {}
Dot.__index = Dot

function Dot:new(ind, character, cooldown, args)
    local dot = {}
    setmetatable(dot, Dot)

    -- index in dot table and character attached to
    dot.ind = ind
    dot.character = character

    -- duration timers
    dot.sec = 0
    dot.totalSec = 0
    dot.cooldown = cooldown

    return dot
end

function Dot:tick()
    -- increment timer
    self.sec = self.sec + timer.fps
    
    -- returns true if dot effect applies (2x per second)
    if self.sec >= 0.5 then
        if self.cooldown == nil then
            self.sec = 0
        else
            self.totalSec = self.totalSec + self.sec
            self.sec = 0
            -- if duration reached delete dot from table
            if self.totalSec > self.cooldown then
                self.character.dots[self.ind] = nil
            end
        end
        return true
    end
    return false
end
