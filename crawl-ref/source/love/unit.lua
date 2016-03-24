Unit = Class {

    init = function (self, options)
        self.name = name or nil
        
        self.lightWorld = nil
        self.light = nil
        self.ox = nil
        self.oy = nil
        self.x = 0
        self.y = 0
        self.z = -1 -- 0 is player
        self.angle = 0
        -- left, right, up, down, leftUp, leftDown, rigthUp, rightDown
        self.direction = 'left'
        -- If false, will not set angle along destination
        self.angleAware = true
        self.lights = {}
        self.refraction = nil
        self.particles = {}
        self.outOfSight = true
        self.hide = false
        self.hostile = true
        self.blockVision = false
        self.reflective = false

        -- One time flag
        self.seen = false

        -- One time populated flag
        self.populated = false

        self.castShadow = true

        self.animation = nil

        self.overlayColor = {255, 255, 255, 255}

        -- Cancelable tween (only movement)
        self.cancelableTween = nil

        Utils.assign(self, options)

        -- Where the unit is regardless of its current movement tween
        self.rx = self.x
        self.ry = self.y

    end

}

function Unit:populate()
    if not self.populated then

        if #self.lights > 0 then
            for j = 1, #self.lights do
                local light = self.lights[j].light

                self.lights[j].light = self.lightWorld:newLight(light[1], light[2], light[3], light[4], light[5], light[6])
                self.lights[j].light:setVisible(false)
                self.lights[j].light.initInfo = light
            end
        end

        if #self.particles > 0 then
            for j = 1, #self.particles do
                local particle = self.particles[j]

                self.particles[j] = Utils.getPS(require(particle[1]), love.graphics.newImage(particle[2]))
                self.particles[j]:stop()
            end
        end

        self.populated = true
    else
        if #self.lights > 0 then
            for j = 1, #self.lights do
                local light = self.lights[j].light.initInfo

                self.lights[j].light = self.lightWorld:newLight(light[1], light[2], light[3], light[4], light[5], light[6])
                self.lights[j].light:setVisible(false)
                self.lights[j].light.initInfo = light
            end
        end
    end
end

function Unit:registerEvents()
end

function Unit:initLight()
    -- if self.castShadow then
    -- TODO: rename to body
    self.light = self.lightWorld:newImage(self.animation:frame(), self.x, self.y)
    self.light.name = self.name
    self.light:setShadowType('image')

    self.light:setShadow(self.castShadow)

    local normal = self.animation:normalFrame()
    if not self.animation.normal then
        print('This unit has no normal map:', self.id)
    end

    if normal then
        self.light:setNormalMap(normal)
    end
    -- end
end

function Unit:flash(color, duration)
    local previous = self.overlayColor
    self.overlayColor = color
    Timer.add(duration, function ()
        self.overlayColor = {255, 255, 255, previous[4]}
    end)
end

function Unit:getPosition()
    return self.x - self.animation:frame():getWidth() * 0.5, self.y - self.animation:frame():getHeight() * 0.5
end


function Unit:addParticle(system)
    system:stop()
    table.insert(self.particles, system)
end

function Unit:startParticles()
    for i = 1, #self.particles do
        self.particles[i]:start()
    end
end

function Unit:stopParticles()
    for i = 1, #self.particles do
        self.particles[i]:stop()
    end
end

function Unit:setPosition(x, y)
    if not self.ox or not self.oy then
        self.ox = x
        self.oy = y
    end

    self.x = x
    self.y = y

    if self.light then
        self.light:setPosition(self.x, self.y)
    end
end

function Unit:adjustPosition(dx, dy)
    self:setPosition(self.x + dx, self.y + dy)
end

function Unit:update(dt)
    if self.refraction then
        self.refraction:setPosition(self.x, self.y)
        self.refraction:setNormalTileOffset(math.random(0, 100), math.random(0, 100))
    end

    if self.light then
        self.light.visible = not self.outOfSight and not self.hide
    end

    if self.light and self.light.visible then
        local frame = self.animation:frame()
        local glow = self.animation:glowFrame()
        local normal = self.animation:normalFrame()
        if self.light:getImage() ~= frame then
            self.light:setImage(frame)
        --     self.light.shadowMesh = nil
            if normal then
                self.light.normal = normal
            end
        --     self.light:setShadowType('image')
        end
        self.light:setPosition(self.x, self.y)
    end

    for i = 1, #self.lights do
        local l = self.lights[i]
        -- TODO: make difference between out of sight and volontary on/off
        -- l.light:setVisible(self.light and self.light.visible or true)
        l.light:setPosition(self.x + l.x, self.y + l.y)
    end

    -- Particles needs to be translated via love.graphics.translate
    for i = 1, #self.particles do
        self.particles[i]:setPosition(self.x, self.y)
    end

    if self.light and self.light.visible then        
        self:startParticles()
    elseif self.light and not self.light.visible then
        self:stopParticles()
    end

end

function Unit:setAngle(angle)
    self.angle = angle

    -- if self.light then
    --     self.light:setGlowAngle(self.angle)
    -- end
end

function Unit:draw(angle)
    if not self.light and not self.outOfSight and not self.hide then
        self:initLight()
    end

    if not self.outOfSight and not self.hide then
        local image = self.animation:frame()
        local imageWidth = image:getWidth()
        local imageHeight = image:getHeight()

        love.graphics.setColor(unpack(self.overlayColor))

        love.graphics.draw(
            image,
            self.x,
            self.y,
            angle or self.angle,
            1, 1,
            imageWidth/2,
            imageHeight/2
        )
    end

end

function Unit:drawBack()

end

function Unit:drawUi()

end


function Unit:die()
end

function Unit:is(class)
    return Class.instanceOf(self, class)
end
