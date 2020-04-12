-- utility class for setting fps

Timer = {}
Timer.__index = Timer

function Timer:new()
    local timer = {}
    setmetatable(timer, Timer)
    
    -- fps
    self.fps = 0

    -- frame time information
    self.startTime = 0
    self.delta = 0

    return timer
end

function Timer:setFps(t)
    -- set fps and convert to increment
    self.fps = 1 / t
end

function Timer:start()
    -- get frame start time
    self.startTime = love.timer.getTime()
end

function Timer:finish()
    -- get frame running time
    self.delta = love.timer.getTime() - self.startTime

    -- if less than fps, pause to maintain fps
	if self.delta < self.fps then
		love.timer.sleep(self.fps - self.delta)
	end

    -- returns actual fps
	self.delta = love.timer.getTime() - self.startTime
    return 1 / self.delta
end

