Animation = Class {

    init = function (self, options)
        self.frames = {}
        self.mirrored = {}

        self.glow = {}
        self.glowMirrored = {}

        self.normal = {}
        self.normalMirrored = {}

        -- self.gray = {}
        -- self.grayMirrored = {}

        self.speed = 0.2
        self.current = 1
        self.loop = true
        self.timer = nil
        self.direction = 'left'

        Utils.assign(self, options)

        if not self.mirrored or #self.mirrored <= 0 then
            for i = 1, #self.frames do
                self.mirrored[i] = Utils.mirrorH(self.frames[i])
            end
        end

        for i = 1, #self.glow do
            self.glowMirrored[i] = Utils.mirrorH(self.glow[i])
        end

        if not self.normalMirrored or #self.normalMirrored <= 0 then
            for i = 1, #self.normal do
                self.normalMirrored[i] = Utils.mirrorH(self.normal[i])
            end
        end

        -- for i = 1, #self.frames do
        --     self.gray[i] = love.graphics.grayscale(self.frames[i])
        -- end

        -- for i = 1, #self.frames do
        --     self.grayMirrored[i] = love.graphics.grayscale(self.mirrored[i])
        -- end

        Timer.add(math.random(0, 0.5), function ()
            self:start()
        end)
    end

}

function Animation:destroy()
    for i = 1, #self.frames do
        love.graphics.cacheCanvas(self.frames[i])
    end

    for i = 1, #self.mirrored do
        love.graphics.cacheCanvas(self.mirrored[i])
    end

    for i = 1, #self.glow do
        love.graphics.cacheCanvas(self.glow[i])
    end

    for i = 1, #self.normal do
        love.graphics.cacheCanvas(self.normal[i])
    end

    for i = 1, #self.glowMirrored do
        love.graphics.cacheCanvas(self.glowMirrored[i])
    end

    for i = 1, #self.normalMirrored do
        love.graphics.cacheCanvas(self.normalMirrored[i])
    end
end

function Animation:start()
    self.timer = Timer.addPeriodic(self.speed, function ()
        self.current = self.current + 1

        if self.current > #self.frames then
            if self.loop then
                self.current = 1
            else
                self:stop()
            end
        end
    end)
end

function Animation:stop()
    if self.timer then
        Timer.cancel(self.timer)
        self.timer = nil
        self.current = 1
    end
end

function Animation:isStopped()
    return self.timer == nil
end

function Animation:pause()
    if self.timer then
        Timer.cancel(self.timer)
        self.timer = nil
        self.current = 1
    end
end

function Animation:resume()
    self:start()
end

function Animation:frame()
    return self.frames[self.current]
end

function Animation:grayFrame()
    return self.gray[self.current]
end

function Animation:glowFrame()
    return self.glow[self.current]
end

function Animation:normalFrame()
    if self.normal then
        return self.normal[self.current]
    else
        return nil
    end
end

function Animation:setDirection(direction)
    if self.direction ~= direction then
        self.direction = direction

        local temp = self.frames
        self.frames = self.mirrored
        self.mirrored = temp

        -- TODO: works on pc not on mac ?
        temp = self.normal
        self.normal = self.normalMirrored
        self.normalMirrored = temp

        temp = self.gray
        self.gray = self.grayMirrored
        self.grayMirrored = temp
    end
end
