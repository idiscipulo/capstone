TimerUtil = {}
TimerUtil.__index = TimerUtil

function TimerUtil:new()
    local timer_util = {}
    setmetatable(timer_util, TimerUtil)

    self.fps = 0

    self.start_time = 0
    self.delta = 0

    return timer_util
end

function TimerUtil:set_fps(t)
    self.fps = 1 / t
end

function TimerUtil:start_frame()
    self.start_time = love.timer.getTime()
end

function TimerUtil:end_frame()
    self.delta = love.timer.getTime() - self.start_time
	if self.delta < self.fps then
		love.timer.sleep(self.fps - self.delta)
	end

	self.delta = love.timer.getTime() - self.start_time
    return 1 / self.delta
end

