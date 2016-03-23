Utils = {}

function Utils.countOccurence(string, pattern)
    count = 0

    for occurence in string.gmatch(string, pattern) do
        count = count + 1
    end

    return count
end

-- Do amount number in goal seconds, if dt > goal adds extra
function Utils.getExtra(amount, goal, dt)
    if dt > goal then
        local extra = dt - goal
        if extra < 0 then
            extra = 0
        end
        extra = (extra * amount) / (goal)

        return extra
    end

    return 0
end

function Utils.translatePolygon(dx, dy, polygon)
    local translated = {}

    for i = 1, #polygon do
        if i % 2 ~= 0 then
            translated[i] = dx + polygon[i]
        else
            translated[i] = dy + polygon[i]
        end
    end
    
    return translated
end

function Utils.rotatePolygon(ox, oy, angle, polygon)
    local translated = {}
    local angle = angle + math.rad(90)

    for i = 1, #polygon-1, 2 do
        local pr = rotate(polygon[i], polygon[i+1], ox, oy, angle)
        table.insert(translated, math.floor(pr.x))
        table.insert(translated, math.floor(pr.y))
    end

    return translated
end

function Utils.scalePolygon(scale, polygon)
    local scaled = {}

    for i = 1, #polygon do
        table.insert(scaled, polygon[i] * scale)
    end

    return scaled
end

function Utils.rotate(x, y, ox, oy, angle)
    x3 = x * math.cos(angle) - y * math.sin(angle)
    y3 = x * math.sin(angle) + y * math.cos(angle)

    return {x = x3, y = y3}
end

function Utils.partialEmpty(table, first, last)
    for i = first, last do
        table.remove(table, first)
    end
end

function Utils.shallowCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function table.slice(values, i1, i2)
    local res = {}
    local n = #values

    -- default values for range
    i1 = i1 or 1
    i2 = i2 or n
    if i2 < 0 then
        i2 = n + i2 + 1
    elseif i2 > n then
        i2 = n
    end

    if i1 < 1 or i1 > n then
        return {}
    end

    local k = 1
    for i = i1,i2 do
        res[k] = values[i]
        k = k + 1
    end

    return res
end

function table.join(t1, t2)
    local res = {}

    for i = 1, #t1 do
        table.insert(res, t1[i])
    end

    for i = 1, #t2 do
        table.insert(res, t2[i])
    end

    return res
end

function table.merge(t1, t2)
  local t = {}

  for k,v in pairs(t1) do
    t[k] = v
  end

  for k,v in pairs(t2) do
    t[k] = v
  end

  return t
end

function Utils.atan2(y, x)
    return 2 * math.atan(
        y / (math.sqrt(x*x + y*y) + x)
    )
end

function Utils.flickering(light, min, max, tmin, tmax)

    return Timer.tween(math.random(tmin or 0.5, tmax or 1), light, {range = math.random(min, max)}, 'in-out-quad', function()
        Utils.flickering(light, min, max)
    end)

end

function Utils.flashing(light, time, sound)

    light.visible = not light.visible

    Timer.add(time or math.random(0.1, 0.15), function ()
        light.visible = not light.visible
    end)

end

function Utils.randomFlashing(light, rate)

    return Timer.add(math.random(1, 5 * (1-rate)), function()
        Utils.flashing(light)

        Utils.randomFlashing(light, rate)
    end)

end

function Utils.stringToSeed(str)
    
    local seed = 0

    for i = 1, #str do
        seed = seed + string.byte(str, i)
    end

    return seed
end

function Utils.startsWith(self, piece)
  return string.sub(self, 1, string.len(piece)) == piece
end
 
rawset(_G.string, "startsWith", startsWith)

function Utils.getPS(conf, image)
    local ps_data = conf
    local particle_settings = {}
    particle_settings["colors"] = {}
    particle_settings["sizes"] = {}
    for k, v in pairs(ps_data) do
        if k == "colors" then
            local j = 1
            for i = 1, #v , 4 do
                local color = {v[i], v[i+1], v[i+2], v[i+3]}
                particle_settings["colors"][j] = color
                j = j + 1
            end
        elseif k == "sizes" then
            for i = 1, #v do particle_settings["sizes"][i] = v[i] end
        else particle_settings[k] = v end
    end
    local ps = love.graphics.newParticleSystem(image, particle_settings["buffer_size"])
    ps:setAreaSpread(string.lower(particle_settings["area_spread_distribution"]), particle_settings["area_spread_dx"] or 0 , particle_settings["area_spread_dy"] or 0)
    ps:setBufferSize(particle_settings["buffer_size"] or 1)
    local colors = {}
    for i = 1, 8 do 
        if particle_settings["colors"][i][1] ~= 0 or particle_settings["colors"][i][2] ~= 0 or particle_settings["colors"][i][3] ~= 0 or particle_settings["colors"][i][4] ~= 0 then
            table.insert(colors, particle_settings["colors"][i][1] or 0)
            table.insert(colors, particle_settings["colors"][i][2] or 0)
            table.insert(colors, particle_settings["colors"][i][3] or 0)
            table.insert(colors, particle_settings["colors"][i][4] or 0)
        end
    end
    ps:setColors(unpack(colors))
    ps:setColors(unpack(colors))
    ps:setDirection(math.rad(particle_settings["direction"] or 0))
    ps:setEmissionRate(particle_settings["emission_rate"] or 0)
    ps:setEmitterLifetime(particle_settings["emitter_lifetime"] or 0)
    ps:setInsertMode(string.lower(particle_settings["insert_mode"]))
    ps:setLinearAcceleration(particle_settings["linear_acceleration_xmin"] or 0, particle_settings["linear_acceleration_ymin"] or 0, 
                             particle_settings["linear_acceleration_xmax"] or 0, particle_settings["linear_acceleration_ymax"] or 0)
    if particle_settings["offsetx"] ~= 0 or particle_settings["offsety"] ~= 0 then
        ps:setOffset(particle_settings["offsetx"], particle_settings["offsety"])
    end
    ps:setParticleLifetime(particle_settings["plifetime_min"] or 0, particle_settings["plifetime_max"] or 0)
    ps:setRadialAcceleration(particle_settings["radialacc_min"] or 0, particle_settings["radialacc_max"] or 0)
    ps:setRotation(math.rad(particle_settings["rotation_min"] or 0), math.rad(particle_settings["rotation_max"] or 0))
    ps:setSizeVariation(particle_settings["size_variation"] or 0)
    local sizes = {}
    local sizes_i = 1 
    for i = 1, 8 do 
        if particle_settings["sizes"][i] == 0 then
            if i < 8 and particle_settings["sizes"][i+1] == 0 then
                sizes_i = i
                break
            end
        end
    end
    if sizes_i > 1 then
        for i = 1, sizes_i do table.insert(sizes, particle_settings["sizes"][i] or 0) end
        ps:setSizes(unpack(sizes))
    end
    ps:setSpeed(particle_settings["speed_min"] or 0, particle_settings["speed_max"] or 0)
    ps:setSpin(math.rad(particle_settings["spin_min"] or 0), math.rad(particle_settings["spin_max"] or 0))
    ps:setSpinVariation(particle_settings["spin_variation"] or 0)
    ps:setSpread(math.rad(particle_settings["spread"] or 0))
    ps:setTangentialAcceleration(particle_settings["tangential_acceleration_min"] or 0, particle_settings["tangential_acceleration_max"] or 0)
    return ps
end

function love.graphics.roundrectangle(x, y, width, height, radius)
    if width > 0 then
        local pStyle = love.graphics.getLineStyle()
        love.graphics.setLineStyle('smooth')

        --RECTANGLES
        love.graphics.rectangle('fill', x + radius, y + radius, width - (radius * 2), height - radius * 2)
        love.graphics.rectangle('fill', x + radius, y, width - (radius * 2), radius)
        love.graphics.rectangle('fill', x + radius, y + height - radius, width - (radius * 2), radius)
        love.graphics.rectangle('fill', x, y + radius, radius, height - (radius * 2))
        love.graphics.rectangle('fill', x + (width - radius), y + radius, radius, height - (radius * 2))
        
        --ARCS
        love.graphics.arc('fill', x + radius, y + radius, radius, math.rad(-180), math.rad(-90))
        love.graphics.arc('fill', x + width - radius , y + radius, radius, math.rad(-90), math.rad(0))
        love.graphics.arc('fill', x + radius, y + height - radius, radius, math.rad(-180), math.rad(-270))
        love.graphics.arc('fill', x + width - radius , y + height - radius, radius, math.rad(0), math.rad(90))

        love.graphics.setLineStyle(pStyle)
    end
end

function love.graphics.tiltedrectangle(x, y, width, height, tilt, direction)

    local polygon = nil
    if direction then
        polygon = {
            x, y + height,
            x + tilt, y,
            x + tilt + width, y,
            x + width, y + height
        }
    else
        polygon = {
            x + tilt, y + height,
            x, y,
            x + width, y,
            x + tilt + width, y + height
        }
    end

    love.graphics.setLineStyle('smooth')
    love.graphics.setLineWidth(2)

    love.graphics.polygon('fill', polygon)
    love.graphics.polygon('line', polygon)

    love.graphics.setLineWidth(1)
end

function love.graphics.gradientline(x, y, x2, y2, c1, c2, peak)
    local dist = math.floor(distance(x, y, x2, y2))
    local d1 = math.min(dist, peak)
    local d2 = math.max(dist, peak)

    for i = 1, d1 do
        local pX, pY = Path.pointAlong(nil, x, y, x2, y2, i)
        local color = Colors.colorBetween(c1, c2, i/d1)
        local pWidth = 1--1 + 1 * i/d1

        love.graphics.setPointSize(pWidth)
        love.graphics.setColor(unpack(color))
        love.graphics.point(pX, pY)
    end

    for i = d1, d2 do
        local pX, pY = Path.pointAlong(nil, x, y, x2, y2, i)
        local color = Colors.colorBetween(c2, c1, i/d2)
        local pWidth = 1--2 - 1 * i/d2

        love.graphics.setPointSize(pWidth)
        love.graphics.setColor(unpack(color))
        love.graphics.point(pX, pY)
    end
end

function love.graphics.gradientrect(x, y, x2, y2, c1, c2, peak, height)
    local dist = math.floor(distance(x, y, x2, y2))
    local d1 = math.min(dist, peak)
    local d2 = math.max(dist, peak)

    for i = 1, d1 do
        local pX, pY = Path.pointAlong(nil, x, y, x2, y2, i)
        local color = Colors.colorBetween(c1, c2, i/d1)
        
        love.graphics.setColor(unpack(color))
        love.graphics.rectangle('fill', pX, pY, 1, pY + height)
    end

    for i = d1, d2 do
        local pX, pY = Path.pointAlong(nil, x, y, x2, y2, i)
        local color = Colors.colorBetween(c2, c1, i/d2)
        
        love.graphics.setColor(unpack(color))
        love.graphics.rectangle('fill', pX, pY, 1, pY + height)
    end
end

function love.graphics.gradientcircleline(centerX, centerY, radius, c1, c2, peak)
    local perimeter = 2 * math.pi * radius
    local d1 = math.min(perimeter, peak) + 1
    local d2 = math.max(perimeter, peak)

    for i = 1, d1 do
        local pX, pY = Path.pointToward(nil, centerX, centerY, (i*360)/perimeter, radius)
        local color = Colors.colorBetween(c1, c2, i/d1)
        local pWidth = 1.5 + 1 * i/d1

        love.graphics.setPointSize(pWidth)
        love.graphics.setColor(unpack(color))
        love.graphics.point(pX, pY)
    end

    for i = d1, d2 do
        local pX, pY = Path.pointToward(nil, centerX, centerY, (i*360)/perimeter, radius)
        local color = Colors.colorBetween(c2, c1, i/d2)
        local pWidth = 2.5 - 1 * i/d2

        love.graphics.setPointSize(pWidth)
        love.graphics.setColor(unpack(color))
        love.graphics.point(pX, pY)
    end
end

function Utils.drawScanlines(w, h, strength)
    love.graphics.setColor(0, 0, 0, strength or 25)
    love.graphics.setLineStyle('rough')
    for i = 0, h, 2 do
        love.graphics.line(0, i, w, i)
    end

    love.graphics.setLineStyle('smooth')
end

function Utils.assign(object, options)
    options = options or {}
    for k, v in pairs(options) do
        object[k] = v
    end
end

function Utils.mirrorH(image)
    local data = image:getData()
    local width = image:getWidth()
    local height = image:getHeight()
    local canvas = love.graphics.newCanvas(width, height)
    local pCanvas = love.graphics.getCanvas()

    love.graphics.setCanvas(canvas)
    love.graphics.setPointStyle('rough')
    love.graphics.setPointSize(1)

    for i = width - 1, 0, -1 do
        for j = 0, height - 1 do
            love.graphics.setColor(data:getPixel(i, j))
            love.graphics.point(width - i, j)
        end
    end

    love.graphics.setCanvas()

    return love.graphics.newImage(canvas:getImageData())
end

function Utils.mirrorCoordinatesH(coordinates, totalWidth)
    local mirrored = {}

    for key, coordinate in pairs(coordinates) do
        mirrored[key] = {x = totalWidth - coordinate.x + 1, y = coordinate.y}
    end

    return mirrored
end

function Utils.distance(x, y, x2, y2)
    return math.sqrt(math.pow(x2 - x, 2) + math.pow(y2 - y, 2))
end

function Utils.fadeOutSource(source, time)
    local volume = source:getVolume()
    local oVolume = volume
    local handle = nil
    
    handle = Timer.do_for(time, function (dt)
        volume = volume - oVolume * (dt/time)
        source:setVolume(volume)

        if volume <= 0 then
            love.audio.stop(source)
            Timer.cancel(handle)
        else
            source:setVolume(volume)
        end
    end)
end

function Utils.fadeInSource(source, time, target)
    source:setVolume(0)
    love.audio.play(source)
    local volume = 0

    Timer.do_for(time, function (dt)
        volume = volume + target * (dt/time)

        source:setVolume(volume)
    end)
end

function love.graphics.tiltedrectangle(mode, x, y, width, height, tilt, direction)

    local polygon = nil
    if direction then
        polygon = {
            x, y + height,
            x + tilt, y,
            x + tilt + width, y,
            x + width, y + height
        }
    else
        polygon = {
            x + tilt, y + height,
            x, y,
            x + width, y,
            x + tilt + width, y + height
        }
    end

    love.graphics.setLineStyle('smooth')
    love.graphics.polygon(mode, polygon)
end

function love.graphics.grayscale(image)
    local colored = image:getData()
    local width = image:getWidth()
    local height = image:getHeight()
    local gray = love.image.newImageData(width, height)

    for x = 0, width - 1 do
        for y = 0, height - 1 do
            local r, g, b, a = colored:getPixel(x, y)

            local gr = (r + g + b) / 3

            gray:setPixel(x, y, gr, gr, gr, a)
        end
    end

    return love.graphics.newImage(gray)
end

function Utils.tlength(table)
    local count = 0

    for _ in pairs(table) do
        count = count + 1
    end
    
    return count
end

function isNaN(n)
    return type(n) ~= 'number' or n ~= n
end