Game = Class {

    init = function (self, save)

        love.mouse.setVisible(true)

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
            ambient = {150, 150, 150},
            refractionStrength = 10.0,
            reflectionVisibility = 0,
        })

        -- self.light.post_shader:addEffect('hdr_tv')
        self.light.post_shader:addEffect('bloom', {2.0})
        -- Awesome green screen effect
        -- self.light.post_shader:toggleEffect('pip')

        -- Map
        self.map = Map({
            light = self.light
        })

        -- Messages
        self.messages = Messages()

        -- temp
        self.player = {x = 0, y = 0}

        -- self.mouseLight = self.light:newLight(100, 100, 255, 255, 255, 300)
        -- self.mouseLight:setVisible(true)

    end

}

function Game:alpha(alpha)
    Timer.tween(0.5, self, {alphaTarget = alpha}, 'in-out-quad', function ()
        self:alpha(alpha < 50 and 50 or 25)
    end)
end

function Game:clear()

end

function Game:centerViewport(x, y)
    self.viewport.ox = -((x * self.viewport.scale) - self.viewport.width/2)
    self.viewport.oy = -((y * self.viewport.scale) - self.viewport.height/2)
end

function Game:setVisible(x, y, visibility)
    self.map:setVisible(x, y, visibility)
    local units = self.map:getUnits()

    for i = 1, #units do
        local u = units[i]

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
    local units = self.map:getUnits()

    for i = 1, #units do
        local u = units[i]

        units[i].outOfSight = not visibility

        if u ~= self.player then
            for j = 1, #u.lights do
                u.lights[j].light:setVisible(visibility)
            end
        end
    end
end

-- Order units by z index (relative to player z which is 0)
-- function Game:orderUnits()
--     table.sort(self.units, function (a, b)
--         return a.z < b.z
--     end)
-- end


function Game:drawUnits()
    local units = self.map:getUnits()

    for i = 1, #units do
        local u = units[i]

        u:draw()
    end
end

function Game:drawUnitReflections()
    local previous = love.graphics.getCanvas()

    love.graphics.setCanvas(self.reflectionCanvas)
    self.reflectionCanvas:clear()

    local units = self.map:getUnits()

    for i = 1, #units do
        local u = units[i]
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

    for x = self.map.bounds.left, self.map.bounds.right do
        for y = self.map.bounds.top, self.map.bounds.bottom do
            local cell = self.map.map[x] and self.map.map[x][y]
            if cell and cell.reflective then
                local img = cell.image
                local w = img:getWidth()
                local h = img:getHeight()
                love.graphics.setColor(0, 0, 0, 255)
                love.graphics.rectangle('fill', x - w/2, y - h/2, w, h)
                love.graphics.setColor(255, 255, 255, 255)
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

    for i = 1, #units do
        local u = units[i]
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
	local units = self.map:getUnits()

    for i = 1, #units do
        local u = units[i]

        u:drawBack()
    end
end

function Game:drawUnitsUi()
	local units = self.map:getUnits()

    for i = 1, #units do
        local u = units[i]

        u:drawUi()
    end
end

function Game:drawParticles()
    local units = self.map:getUnits()

    for i = 1, #units do
        local u = units[i]
        for j = 1, #u.particles do
            local p2 = u.particles[j]

            love.graphics.draw(p2)
        end
    end
end

function Game:updateLogic(dt)
  local vgrdc = self.map.map_knowledge.vgrdc

  self:centerViewport(
    vgrdc and self.map.map_knowledge.vgrdc.x * 32 or 0,
    vgrdc and self.map.map_knowledge.vgrdc.y * 32 or 0
  )
end

function Game:drawHUD()
    love.graphics.setColor(0, 0, 0, 150)
    love.graphics.rectangle(
        'fill',
        self.messages.display.x - 5,
        self.messages.display.y - 5,
        self.messages.display.limit - 5,
        love.window.getHeight() - self.messages.display.y + 5
    )

    love.graphics.setColor(255, 255, 255, 255)
    self.messages.display:draw()
end

function Game:drawGame()
    local vp = self.viewport
    local vgrdc = self.map.map_knowledge.vgrdc
    local map_dx = vgrdc and self.map.map_knowledge.vgrdc.x * 32 or 0
    local map_dy = vgrdc and self.map.map_knowledge.vgrdc.y * 32 or 0

    -- self.stars:draw()

    love.graphics.push()
    love.graphics.translate(vp.x, vp.y)
    love.graphics.scale(vp.scale)

    self.map:drawBack(map_dx - vp.width/2, map_dy - vp.height/2, vp.width, vp.height)

    self.map:drawFront(map_dx - vp.width/2, map_dy - vp.height/2, vp.width, vp.height)


    self:drawBackUnits()

    self:drawParticles()

    -- self:drawMouseHover()

    -- self:drawUnitReflections()

    self:drawUnits()

    if self.drawLights then
        local w, h = love.graphics.getDimensions()
        self.light:drawLights(vp.x, vp.y, w, h, vp.scale)
    end

    love.graphics.pop()
end

function Game:draw()
    local vp = self.viewport
    local vgrdc = self.map.map_knowledge.vgrdc
    local map_dx = vgrdc and self.map.map_knowledge.vgrdc.x * 32 or 0
    local map_dy = vgrdc and self.map.map_knowledge.vgrdc.y * 32 or 0

    love.graphics.setCanvas(self.light.render_buffer)
    self.light.render_buffer:clear()

    self:drawGame()

    love.graphics.setCanvas()

    love.graphics.setColor(255, 255, 255, 255)
    self.light.post_shader:drawWith(self.light.render_buffer, self.viewport.x, self.viewport.y, self.viewport.scale)

    love.graphics.push()
    love.graphics.translate(self.viewport.x, self.viewport.y)
    love.graphics.scale(self.viewport.scale)

    self.map:drawExplored(map_dx - vp.width/2, map_dy - vp.height/2, vp.width, vp.height)

    self:drawUnitsUi()

    love.graphics.pop()

    self:drawHUD()

    love.graphics.setColor(255, 255, 255, 255)
    local str = '(' .. math.floor(fps) .. '  FPS)  (' .. #self.light.body .. '  Bodies '  .. #self.light.lights .. '  Lights)'
    love.graphics.print(str, 5, love.graphics.getHeight() - love.graphics.getFont():getHeight() - 5)
    love.graphics.print('DCSS trunk',
    love.graphics.getWidth() - love.graphics.getFont():getWidth('DCSS trunk') - 5,
    love.graphics.getHeight() - love.graphics.getFont():getHeight() - 5)

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

    -- temp
    self.viewport.x = self.map.bounds.left * 32
    self.viewport.y = self.map.bounds.top * 32

    self.viewport.offX = math.random(0, self.viewport.shakeAmplitude)
    self.viewport.offY = math.random(0, self.viewport.shakeAmplitude)
    self.viewport.x = self.viewport.ox + self.viewport.offX
    self.viewport.y = self.viewport.oy + self.viewport.offY

    -- self.mouseLight:setPosition(love.mouse.getX() - self.viewport.x, love.mouse.getY() - self.viewport.y)

    -- Graphic update
    local units = self.map:getUnits()

    for i = 1, #units do
        local u = units[i]

        for j = 1, #u.particles do
            local p = u.particles[j]

            p:update(dt)
        end
    end

    for i = 1, #units do
        local u = units[i]

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
    if key == 'f6' then
        self.drawLights = not self.drawLights
    end

    if key == 'f7' then
        self.map.map_knowledge:print()
    end

    client.comm:send('input', {
        text = key
    })
end

function Game:keyreleased(key)
end

function Game:isFree(x, y)
    return self.map:isFree(x, y)
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
