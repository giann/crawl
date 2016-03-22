Cell = Class {
    
    init = function (self, options)
        self.image = nil
        self.castShadow = true
        self.width = 0
        self.height = 0
        self.lightWorld = nil
        self.body = nil
        self.shadowColor = nil
        self.visible = false
        self.explored = false
        self.code = 'empty'
        self.target = nil
        self.passable = true

        Utils.assign(self, options)

        if self.image then
            self.width = self.image:getWidth()
            self.height = self.image:getHeight()

            if self.spriteCode then
                -- self.imageBW = Assets.decorBW:getNamedSprite(self.spriteCode)
            end
        end
    end

}

function Cell:initLight(x, y)
    if self.code ~= 'empty' then
        self.body = self.lightWorld:newRectangle(x and x + self.width/2 or 0, y and y + self.height/2 or 0, self.width, self.height)
        self.body:setVisible(false)

        self.body:setShadow(self.castShadow)

        if self.normal then
            self.body:setNormalMap(self.normal)
        end

        if self.shadowColor then
            self.body:setColor(self.shadowColor)
        end

        -- if Utils.startsWith(self.code, 'floor') then
        --     self.body.floor = true
        -- else
        --     self.body.floor = false
        -- end
    end
end

function Cell:draw(x, y)
    if not self.body then
        self:initLight(x, y)
    end

    if self.body then
        self.body.visible = self.visible and self.code ~= 'empty'
        self.body:setPosition(x + self.width/2, y + self.height/2)
    end

    if self.visible and self.code ~= 'empty' then --or self.explored then
        love.graphics.draw(self.image, x, y)
        love.graphics.setColor(255, 255, 255, 255)
    elseif self.code ~= 'empty' and not self.explored then 
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.rectangle('fill', x, y, self.width, self.height)
        love.graphics.setColor(255, 255, 255, 255)
    elseif self.code ~= 'empty' then
        love.graphics.setColor(90, 90, 90, 255)
        love.graphics.draw(self.imageBW, x, y)
        love.graphics.setColor(255, 255, 255, 255)
    end
end

function Cell:setVisible(visible)
    self.visible = visible
end


Map = Class {
    
    init = function (self, options)

        self.name = nil
        self.width = 0
        self.height = 0
        self.map = {}
        self.light = nil

        self.map_knowledge = MapKnowledge()

        Utils.assign(self, options)

        client.comm:register_message_handlers({
            map = { handler = self.handle_map_message, context = self }
        })
    end

}

function Map:handle_map_message(data)
  if data.clear then
    self:clear()
  end

  -- update map knowledge
  self.map_knowledge:merge(data.cells)

  self.map_knowledge:print()
end

function Map:clear()
end

function Map:initBodies()
    for i = 1, self.width do
        for j = 1, self.height do
            self.map[i][j].lightWorld = self.light
            self.map[i][j].body = nil

            self.map[i][j]:initLight()
        end
    end
end

function Map:setVisible(x, y, visible)
    if self.map[x] and self.map[x][y] then
        self.map[x][y].visible = visible
    end
end

function Map:setExplored(x, y, explored)
    if self.map[x] and self.map[x][y] then
        if explored and not self.map[x][y].explored then
            self.map[x][y].newlyExplored = true
        end

        self.map[x][y].explored = explored
    end
end

function Map:setAllVisible(visible)
    for i = 1, self.width do
        for j = 1, self.height do
            self.map[i][j]:setVisible(visible)
        end
    end
end

-- TODO: Draw only within viewport
function Map:drawBack(x, y, w, h)
    local x = math.floor(x / self.decor.spriteWidth) + 1
    local y = math.floor(y / self.decor.spriteHeight) + 1

    if x < 1 then
        x = 1
    end
    if y < 1 then
        y = 1
    end

    local w = math.floor(w / self.decor.spriteWidth) + 1
    local h = math.floor(h / self.decor.spriteHeight) + 1

    for i = x, math.min(x + w, self.width) do
        for j = y, math.min(y + h, self.height) do
            local cell = self.map[i][j]
            if cell and not cell.castShadow then
                cell:draw((i - 1) * cell.width, (j - 1) * cell.height)
            end
        end
    end
end

function Map:drawExplored(x, y, w, h)
    local x = math.floor(x / self.decor.spriteWidth) + 1
    local y = math.floor(y / self.decor.spriteHeight) + 1

    if x < 1 then
        x = 1
    end
    if y < 1 then
        y = 1
    end

    local w = math.floor(w / self.decor.spriteWidth) + 1
    local h = math.floor(h / self.decor.spriteHeight) + 1

    for i = x, math.min(x + w, self.width) do
        for j = y, math.min(y + h, self.height) do
            local cell = self.map[i][j]
            if cell and not cell.visible and cell.explored then
                cell:draw((i - 1) * cell.width, (j - 1) * cell.height)
            end
        end
    end
end

function Map:drawFront(x, y, w, h)
    local x = math.floor(x / self.decor.spriteWidth) + 1
    local y = math.floor(y / self.decor.spriteHeight) + 1

    if x < 1 then
        x = 1
    end
    if y < 1 then
        y = 1
    end

    local w = math.floor(w / self.decor.spriteWidth) + 1
    local h = math.floor(h / self.decor.spriteHeight) + 1

    for i = x, math.min(x + w, self.width) do
        for j = y, math.min(y + h, self.height) do
            local cell = self.map[i][j]
            if cell and cell.castShadow then
                cell:draw((i - 1) * cell.width, (j - 1) * cell.height)
            end
        end
    end
end

function Map:setCell(cell, x, y)
    self.map[x][y] = cell
end


function Map.surrounded(map, x, y)
    local neighbors = Map.neighbors(map, x, y)

    return (neighbors.up or neighbors.up == nil)
        and (neighbors.down or neighbors.down == nil)
        and (neighbors.left or neighbors.left == nil)
        and (neighbors.right or neighbors.right == nil)
        and (neighbors.leftUp or neighbors.leftUp == nil)
        and (neighbors.leftDown or neighbors.leftDown == nil)
        and (neighbors.rightUp or neighbors.rightUp == nil)
        and (neighbors.rightDown or neighbors.rightDown == nil)
end

function Map:currentNeighbors(x, y)
    local map = self.map
    local left = nil
    local right = nil
    local up = nil
    local down = nil
    local leftUp = nil
    local leftDown = nil
    local rightUp = nil
    local rightDown = nil
    local width = #map
    local height = #map[1]

    -- Check left
    if x - 1 > 0 then
        left = map[x - 1][y]

        -- Check left and up
        if y - 1 > 0 then
            leftUp = map[x - 1][y - 1]
        end

        -- Check left and down
        if y + 1 <= height then
            leftDown = map[x - 1][y + 1]
        end
    end

    -- Check right
    if x + 1 <= width then
        right = map[x + 1][y]

        -- Check right and up
        if y - 1 > 0 then
            rightUp = map[x + 1][y - 1]
        end

        -- Check right and down
        if y + 1 <= height then
            rightDown = map[x + 1][y + 1]
        end
    end

    -- Check up
    if y - 1 > 0 then
        up = map[x][y - 1]
    end

    -- Check down
    if y + 1 <= height then
        down = map[x][y + 1]
    end

    return {
        left = left,
        right = right,
        up = up,
        down = down,
        leftUp = leftUp,
        leftDown = leftDown,
        rightUp = rightUp,
        rightDown = rightDown
    }
end

function Map.neighbors(map, x, y)
    local left = nil
    local right = nil
    local up = nil
    local down = nil
    local leftUp = nil
    local leftDown = nil
    local rightUp = nil
    local rightDown = nil
    local width = #map
    local height = #map[1]

    -- Check left
    if x - 1 > 0 then
        left = map[x - 1][y] ~= 0

        -- Check left and up
        if y - 1 > 0 then
            leftUp = map[x - 1][y - 1] ~= 0
        end

        -- Check left and down
        if y + 1 <= height then
            leftDown = map[x - 1][y + 1] ~= 0
        end
    end

    -- Check right
    if x + 1 <= width then
        right = map[x + 1][y] ~= 0

        -- Check right and up
        if y - 1 > 0 then
            rightUp = map[x + 1][y - 1] ~= 0
        end

        -- Check right and down
        if y + 1 <= height then
            rightDown = map[x + 1][y + 1] ~= 0
        end
    end

    -- Check up
    if y - 1 > 0 then
        up = map[x][y - 1] ~= 0
    end

    -- Check down
    if y + 1 <= height then
        down = map[x][y + 1] ~= 0
    end

    return {
        left = left,
        right = right,
        up = up,
        down = down,
        leftUp = leftUp,
        leftDown = leftDown,
        rightUp = rightUp,
        rightDown = rightDown
    }
end

function Map:isFree(x, y)
    return x > 0 and x <= self.width and y > 0 and y <= self.height and self.map[x][y].code == 'floor' and self.map[x][y].passable
end

function Map:pixelToMap(x, y)
    return math.floor(x / self.decor.spriteWidth),
        math.floor(y / self.decor.spriteHeight)
end

function Map:pixelToMapRaw(x, y)
    return x / self.decor.spriteWidth, y / self.decor.spriteHeight
end
