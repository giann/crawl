Game = Class {

    init = function (self, save)

      love.mouse.setVisible(false)

      local w, h = love.graphics.getDimensions()
      local s = 1

      self.viewport = {
        -- Actual viewport x,y
        x = 0,
        y = 0,
        -- Reference viewport x,y
        ox = 0,
        oy = 0,
        -- Offset applied on reference viewport to get actual viewport
        offX = 0,
        offY = 0,
        shakeAmplitude = 0,
        width = w / s,
        height = h / s,
        scale = s
      }

      self.alphaTarget = 50
      self:alpha(0)

      self.reflectionCanvas = love.graphics.newCanvas(self.viewport.width, self.viewport.height)

      self.cursorColor = {41, 255, 12, 255}

      self.turn = 1
      self.turnSpeed = 0.10

      -- Lights
      self.drawLights = true

      self.light = LightWorld({
          ambient = {70, 70, 70},
          refractionStrength = 10.0,
          reflectionVisibility = 0,
      })

      -- self.light.post_shader:addEffect('hdr_tv')
      self.light.post_shader:addEffect('bloom', {2.0})
      -- Awesome green screen effect
      -- self.light.post_shader:toggleEffect('pip')

      self.lights = {}
      -- Particles
      self.particles = {}

      -- Units
      self.units = {}

      -- Map
      self.map = Map()

      -- temp
      self.player = {x = 0, y = 0}

    end

}

function Game:alpha(alpha)
    Timer.tween(0.5, self, {alphaTarget = alpha}, 'in-out-quad', function ()
        self:alpha(alpha < 50 and 50 or 25)
    end)
end

function Game:clear()
    self.units = {}
    self.lights = {}
    self.particles = {}
end

function Game:centerViewport(x, y)
    self.viewport.ox = -((x * self.viewport.scale) - self.viewport.width/2)
    self.viewport.oy = -((y * self.viewport.scale) - self.viewport.height/2)
end

function Game:setVisible(x, y, visibility)
    self.map:setVisible(x, y, visibility)

    for i = 1, #self.units do
        local u = self.units[i]

        local px = math.floor(u.x / 32) + 1
        local py = math.floor(u.y / 32) + 1

        if px == x and py == y then
            u.outOfSight = not visibility

            if u ~= self.player and u.outOfSight then
                u.seen = false
            end
        end

        local count = 0
        for j = 1, #u.lights do
            local l = u.lights[j].light
            local lx = math.floor(l.x / 32) + 1
            local ly = math.floor(l.y / 32) + 1

            -- Light on if visible point in range of light
            if u ~= self.player and Utils.distance(x, y, px, py) < l.range / 32 then
                l:setVisible(visibility)
            end
        end
    end
end

function Game:setAllVisible(visibility)
    self.map:setAllVisible(visibility)

    for i = 1, #self.units do
        local u = self.units[i]

        self.units[i].outOfSight = not visibility

        if u ~= self.player then
            for j = 1, #u.lights do
                u.lights[j].light:setVisible(visibility)
            end
        end
    end
end


function Game:addLight(light)
    table.insert(self.lights, light)
end

function Game:addUnit(unit)
    local already = false
    for i = 1, #self.units do
        if self.units[i] == unit then
            return false
        end
    end

    if not already then
        unit.game = self

        if not unit.populated then
            unit:populate(self)
        end

        table.insert(self.units, 1, unit)

        -- unit:initLight()

        self:orderUnits()

        return true
    end

    return false
end

function Game:addUnits(units)
    for i = 1, #units do
        local unit = units[i]

        local already = false
        for i = 1, #self.units do
            if self.units[i] == unit then
                return false
            end
        end

        if not already then
            unit.game = self
            table.insert(self.units, 1, unit)
        end
    end

    self:orderUnits()
end

-- Order units by z index (relative to player z which is 0)
function Game:orderUnits()
    table.sort(self.units, function (a, b)
        return a.z < b.z
    end)
end

function Game:removeUnit(unit)
    for i = 1, #self.units do
        if self.units[i] == unit then
            local u = self.units[i]

            if u.light then
                self.light:remove(u.light)
                u.light = nil
            end

            for j = 1, #u.lights do
                self.light:remove(u.lights[j].light)
            end

            self.map:removeUnit(unit)

            table.remove(self.units, i)

            break
        end
    end
end

function Game:addParticle(system)
    table.insert(self.particles, system)
end

function Game:drawUnits()
    for i = 1, #self.units do
        local u = self.units[i]

        u:draw()
    end
end

function Game:drawUnitReflections()
    local previous = love.graphics.getCanvas()

    love.graphics.setCanvas(self.reflectionCanvas)
    self.reflectionCanvas:clear()

    for i = 1, #self.units do
        local u = self.units[i]
        if u.reflective then
            if u.name == 'Reflect' then
                local img = u.animation:frame()
                local w = img:getWidth()
                local h = img:getHeight()
                love.graphics.setColor(0, 0, 0, 255)
                love.graphics.rectangle('fill', u.x - w/2, u.y - h/2, w, h)
                love.graphics.setColor(255, 255, 255, 255)
            else
                u:draw()
            end
        end
    end

    love.graphics.setCanvas(previous)

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setStencil(function ()
        love.graphics.setShader(Assets.shaders.alphaDiscard)
        love.graphics.draw(self.reflectionCanvas, -self.viewport.x, -self.viewport.y)
        love.graphics.setShader()
    end)

    for i = 1, #self.units do
        local u = self.units[i]
        if not u.reflective then
            local py = u.y
            local overlayAlpha = u.overlayColor[4]
            u.overlayColor[4] = 75
            u.y = u.y + u.animation:frame():getHeight()
            u.animation:setDirection(u.animation.direction == 'left' and 'right' or 'left')

            u:draw(math.rad(180))

            u.overlayColor[4] = overlayAlpha
            u.animation:setDirection(u.animation.direction == 'left' and 'right' or 'left')
            u.y = py
        end
    end

    love.graphics.setColor(255, 255, 255, 255)

    love.graphics.setStencil()
end

function Game:drawBackUnits()
    for i = 1, #self.units do
        local u = self.units[i]

        u:drawBack()
    end
end

function Game:drawUnitsUi()
    for i = 1, #self.units do
        local u = self.units[i]

        u:drawUi()
    end
end

function Game:drawParticles()
    for i = 1, #self.particles do
        local p = self.particles[i]

        love.graphics.draw(p)
    end

    for i = 1, #self.units do
        local u = self.units[i]
        for j = 1, #u.particles do
            local p2 = u.particles[j]

            love.graphics.draw(p2)
        end
    end
end

function Game:updateLogic(dt)
    self:centerViewport(self.player.x, self.player.y)
end

function Game:drawHUD()

end

function Game:drawGame()
    local vp = self.viewport

    -- self.stars:draw()

    love.graphics.push()
    love.graphics.translate(vp.x, vp.y)
    love.graphics.scale(vp.scale)

    self.map:drawBack(self.player.x - vp.width/2, self.player.y - vp.height/2, vp.width, vp.height)

    self.map:drawFront(self.player.x - vp.width/2, self.player.y - vp.height/2, vp.width, vp.height)


    self:drawBackUnits()

    self:drawParticles()

    -- self:drawMouseHover()

    self:drawUnitReflections()

    self:drawUnits()

    if self.drawLights then
        local w, h = love.graphics.getDimensions()
        self.light:drawLights(vp.x, vp.y, w, h, vp.scale)
    end

    love.graphics.pop()
end

function Game:draw()
    local vp = self.viewport

    love.graphics.setCanvas(self.light.render_buffer)
    self.light.render_buffer:clear()

    self:drawGame()

    love.graphics.setCanvas()

    love.graphics.setColor(255, 255, 255, 255)
    self.light.post_shader:drawWith(self.light.render_buffer, self.viewport.x, self.viewport.y, self.viewport.scale)

    love.graphics.push()
    love.graphics.translate(self.viewport.x, self.viewport.y)
    love.graphics.scale(self.viewport.scale)

    self.map:drawExplored(self.player.x - vp.width/2, self.player.y - vp.height/2, vp.width, vp.height)

    self:drawUnitsUi()

    love.graphics.pop()

    self:drawHUD()

    Utils.drawScanlines(love.graphics.getDimensions())
end

function Game:update(dt)

    love.audio.setPosition(self.player.x, self.player.y, 0)

    -- Reset dt to 0 in order to ignore loading time
    if not self.gameStarted then
        self.gameStarted = true
        dt = 0
    end

    -- self.stars:update(dt)

    -- Game logic update
    self:updateLogic(dt)

    self.viewport.offX = math.random(0, self.viewport.shakeAmplitude)
    self.viewport.offY = math.random(0, self.viewport.shakeAmplitude)
    self.viewport.x = self.viewport.ox + self.viewport.offX
    self.viewport.y = self.viewport.oy + self.viewport.offY

    -- Graphic update
    for i = 1, #self.particles do
        local p = self.particles[i]

        p:update(dt)
    end

    for i = 1, #self.units do
        local u = self.units[i]

        for j = 1, #u.particles do
            local p = u.particles[j]

            p:update(dt)
        end
    end

    for i = 1, #self.units do
        local u = self.units[i]

        if u then
            u:update(dt)
        end
    end

end


function Game:mousepressed(x, y, button)

end

function Game:mousereleased(x, y, button)
end

function Game:keypressed(key, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    if key == 'f6' then
        self.drawLights = not self.drawLights
    end
end


function Game:isFree(x, y)
    return self.map:isFree(x, y)
end

function Game:getUnitAt(x, y)
    for i = 1, #self.units do
        local u = self.units[i]
        local ux = math.floor(u.rx / 32) + 1
        local uy = math.floor(u.ry / 32) + 1

        if ux == x and uy == y then
            return u
        end
    end

    return nil
end

function Game:getUnitsAt(x, y)
    local units = {}

    for i = 1, #self.units do
        local u = self.units[i]
        local ux = math.floor(u.rx / 32) + 1
        local uy = math.floor(u.ry / 32) + 1

        if ux == x and uy == y then
            table.insert(units, u)
        end
    end

    return units
end

function Game:getHostileUnitsAt(x, y)
    local units = self:getUnitsAt(x, y)
    local hostiles = {}

    for i = 1, #units do
        local u = units[i]

        if u.hostile then
            table.insert(hostiles, u)
        end
    end

    return hostiles
end

function Game:neighbors(x, y)
    return {
        up        = self:getUnitAt(x, y - 1),
        down      = self:getUnitAt(x, y + 1),
        left      = self:getUnitAt(x - 1, y),
        right     = self:getUnitAt(x + 1, y),
        leftUp    = self:getUnitAt(x - 1, y - 1),
        rightUp   = self:getUnitAt(x + 1, y - 1),
        leftDown  = self:getUnitAt(x - 1, y + 1),
        rightDown = self:getUnitAt(x + 1, y + 1),
    }
end


function Game:textinput(t)

end

function Game:resume()
    print('[Game] resume')
end

function Game:leave()
    print('[Game] leave')
end

function Game:shakeFor(amplitude, duration)
    self.viewport.shakeAmplitude = amplitude

    Timer.add(duration, function ()
        self.viewport.shakeAmplitude = 0
    end)
end
