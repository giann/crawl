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
        self.knowledge = nil

        self.unit = nil

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
    if self.code ~= 'empty' and self.width > 0 and self.height > 0 then
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

    if self.image and self.visible and self.code ~= 'empty' then --or self.explored then
        love.graphics.draw(self.image, x, y)
        love.graphics.setColor(255, 255, 255, 255)
    elseif self.code ~= 'empty' and not self.explored then 
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.rectangle('fill', x, y, self.width, self.height)
        love.graphics.setColor(255, 255, 255, 255)
    elseif self.image and self.code ~= 'empty' then
        love.graphics.setColor(90, 90, 90, 255)
        -- love.graphics.draw(self.imageBW, x, y)
        love.graphics.draw(self.image, x, y)
        love.graphics.setColor(255, 255, 255, 255)
    end

    if self.knowledge and self.knowledge.g then
        love.graphics.setColor(255, 255, 255, 255)

        if (self.knowledge.g == '#' and not self.castShadow) or (self.knowledge.g == '.' and self.castShadow) then
            love.graphics.setColor(255, 0, 0, 255)
        end
       
        love.graphics.print(self.knowledge.g, x + self.width/2, y + self.height/2)

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
        self.bounds = {
            left = 0,
            right = 0,
            top = 0,
            bottom = 0
        }
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

    self.bounds = self.map_knowledge.bounds
    
    -- self.map_knowledge:print()

    local main   = Assets.tile_info.main.spritesheet
    local player = Assets.tile_info.player.spritesheet
    local floor  = Assets.tile_info.floor.spritesheet
    local wall   = Assets.tile_info.wall.spritesheet
    local floor_normal  = Assets.tile_info.floor.spritesheet_normal
    local wall_normal   = Assets.tile_info.wall.spritesheet_normal
    local feat   = Assets.tile_info.feat.spritesheet
    local icons  = Assets.tile_info.icons.spritesheet
    local gui    = Assets.tile_info.gui.spritesheet

    local previous = nil
    local since_previous = 0
    for i = 1, #data.cells do
        local map_cell = data.cells[i]
        local cell = map_cell.t

        cell.fg = enums.prepare_fg_flags(cell.fg or 0)
        cell.bg = enums.prepare_bg_flags(cell.bg or 0)
        cell.cloud = enums.prepare_fg_flags(cell.cloud or 0)
        cell.flv = cell.flv or {}
        cell.flv.f = cell.flv.f or 0
        cell.flv.s = cell.flv.s or 0
        map_cell.g = map_cell.g or ' '

        -- print(json.encode(cell))

        if not map_cell.col then
            map_cell.col = 7
        end

        if map_cell.x and map_cell.y then
            previous = map_cell
            since_previous = 0
        elseif previous then
            since_previous = since_previous + 1
            map_cell.x = previous.x + since_previous
            map_cell.y = previous.y
        end

        -- TODO find background
        local bg_idx = self:getBackground(cell)
        local isFloor = bg_idx < FLOOR_MAX
        -- TODO find a better test
        local isWall = map_cell.g == '#' --bg_idx >= FLOOR_MAX and bg_idx < WALL_MAX

        if isFloor or isWall then
            self:setCell(Cell({
                image      = isFloor and floor.images[bg_idx] or wall.images[bg_idx - TILE_FLOOR_MAX + 1],
                normal     = isFloor and floor_normal.images[bg_idx] or wall_normal.images[bg_idx - TILE_FLOOR_MAX + 1],
                castShadow = isWall,
                passable   = isFloor,
                lightWorld = self.light,
                spriteCode = bg_idx,
                code       = isFloor and 'floor' or 'wall',
                visible    = true,
                explored   = true,
                knowledge  = map_cell
            }), map_cell.x, map_cell.y)
        end

        -- TODO overlays ? blood etc.

        -- TODO construct doll -> unit

        -- TODO find foreground

    end
end


function Map:getBackground(cell)
    local bg = cell.bg;
    local bg_idx = cell.bg.value

    if cell.mangrove_water and bg_idx > Assets.tile_info.floor.tileinfo.DNGN_UNSEEN then
        return Assets.tile_info.floor.tileinfo.DNGN_SHALLOW_WATER
    elseif (bg_idx >= Assets.tile_info.wall.tileinfo.DNGN_FIRST_TRANSPARENT) then
        return cell.flv.f-- f = floor
    end

    return bg_idx
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

function Map:drawTest()
    if self.bounds.right ~= 0 and self.bounds.bottom ~= 0 then
        for i = self.bounds.left, self.bounds.right do
            for j = self.bounds.top, self.bounds.bottom do
                local cell = self.map[i][j]
                if cell then
                    cell:draw(
                        (i - 1) * cell.width,
                        (j - 1) * cell.height
                    )
                end
            end
        end
    end
end

-- TODO: Draw only within viewport
function Map:drawBack(x, y, w, h)
    if self.bounds.right ~= 0 and self.bounds.bottom ~= 0 then
        local x = math.floor(x / 32) + 1
        local y = math.floor(y / 32) + 1

        if x < self.bounds.left then
            x = self.bounds.left
        end
        if y < self.bounds.top then
            y = self.bounds.top
        end

        local w = math.floor(w / 32) + 1
        local h = math.floor(h / 32) + 1

        for i = x, math.min(x + w, self.bounds.right) do
            for j = y, math.min(y + h, self.bounds.bottom) do
                local cell = self.map[i][j]
                if cell and not cell.castShadow then
                    cell:draw(
                        (i - 1) * cell.width,
                        (j - 1) * cell.height
                    )
                end
            end
        end
    end
end

function Map:drawExplored(x, y, w, h)
    if self.bounds.right ~= 0 and self.bounds.bottom ~= 0 then
        local x = math.floor(x / 32) + 1
        local y = math.floor(y / 32) + 1

        if x < self.bounds.left then
            x = self.bounds.left
        end
        if y < self.bounds.top then
            y = self.bounds.top
        end

        local w = math.floor(w / 32) + 1
        local h = math.floor(h / 32) + 1

        for i = x, math.min(x + w, self.bounds.right) do
            for j = y, math.min(y + h, self.bounds.bottom) do
                local cell = self.map[i][j]
                if cell and not cell.visible and cell.explored then
                    cell:draw(
                        (i - 1) * cell.width,
                        (j - 1) * cell.height
                    )
                end
            end
        end
    end
end

function Map:drawFront(x, y, w, h)
    if self.bounds.right ~= 0 and self.bounds.bottom ~= 0 then
        local x = math.floor(x / 32) + 1
        local y = math.floor(y / 32) + 1

        if x < self.bounds.left then
            x = self.bounds.left
        end
        if y < self.bounds.top then
            y = self.bounds.top
        end

        local w = math.floor(w / 32) + 1
        local h = math.floor(h / 32) + 1

        for i = x, math.min(x + w, self.bounds.right) do
            for j = y, math.min(y + h, self.bounds.bottom) do
                local cell = self.map[i][j]
                if cell and cell.castShadow then
                    cell:draw(
                        (i - 1) * cell.width,
                        (j - 1) * cell.height
                    )
                end
            end
        end
    end
end

function Map:setCell(cell, x, y)
    if not self.map[x] then
        self.map[x] = {}
    end

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
    return math.floor(x / 32),
        math.floor(y / 32)
end

function Map:pixelToMapRaw(x, y)
    return x / 32, y / 32
end
