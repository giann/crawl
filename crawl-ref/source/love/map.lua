Cell = Class {

    init = function (self, options)
        self.image = nil
        self.imageBW = nil
        self.imageUI = nil
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
        self.reflective = false
        self.knowledge = nil

        self.units = {}

        Utils.assign(self, options)

        if self.image then
            self.width = self.image:getWidth()
            self.height = self.image:getHeight()
        end
    end

}

function Cell:initLight(x, y)
    if self.width > 0 then
        self.body = self.lightWorld:newRectangle(x and x + self.width/2 or 0, y and y + self.height/2 or 0, self.width, self.height)
        self.body:setVisible(false)

        self.body:setShadow(self.castShadow)

        if self.normal then
            self.body:setNormalMap(self.normal)
        end

        if self.shadowColor then
            self.body:setColor(self.shadowColor)
        end

        self.body.floor = self.castShadow
    end
end

function Cell:draw(x, y)
    if not self.body then
        self:initLight(x, y)
    end

    if self.body then
        self.body.visible = self.visible
        self.body:setPosition(x + self.width/2, y + self.height/2)
    end

    if self.image and self.visible then --or self.explored then
        love.graphics.draw(self.image, x, y)
        love.graphics.setColor(255, 255, 255, 255)
    elseif not self.explored then
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.rectangle('fill', x, y, self.width, self.height)
        love.graphics.setColor(255, 255, 255, 255)
    elseif self.image then
        love.graphics.setColor(90, 90, 90, 255)
        if self.imageBW then
            love.graphics.draw(self.imageBW, x, y)
        else
            love.graphics.draw(self.image, x, y)
        end
        love.graphics.setColor(255, 255, 255, 255)
    end

end

function Cell:drawUI(x, y)

    if self.imageUI then
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(self.imageUI, x, y)
    end

end

function Cell:setVisible(visible)
    self.visible = visible
end

function Cell:generateUI()
    self.imageUI  = love.graphics.newCanvas(32, 32)

    local fg      = self.knowledge.t.fg
    local bg      = self.knowledge.t.bg
    local icons   = Assets.tile_info.icons.spritesheet
    local pCanvas = love.graphics.getCanvas()

    love.graphics.setCanvas(self.imageUI)
    love.graphics.setColor(255, 255, 255, 255)

    if (fg.NET) then
        icons:getTileCanvas(TRAP_NET, true, false, 0, 0)
    end

    if (fg.WEB) then
        icons:getTileCanvas(TRAP_WEB, true, false, 0, 0)
    end

    if (fg.S_UNDER) then
        icons:getTileCanvas(SOMETHING_UNDER, true, false, 0, 0)
    end

    local status_shift = 0
    if (fg.MIMIC_INEPT) then
        icons:getTileCanvas(INEPT_MIMIC, true, false, 0, 0)
    elseif (fg.MIMIC) then
        icons:getTileCanvas(MIMIC, true, false, 0, 0)
    elseif (fg.MIMIC_RAVEN) then
        icons:getTileCanvas(RAVENOUS_MIMIC, true, false, 0, 0)
    end

    --The berserk icon is in the lower right, so status_shift doesn't need changing.
    if (fg.BERSERK) then
        icons:getTileCanvas(BERSERK, true, false, 0, 0)
    end

    -- Pet mark
    if (fg.PET) then
        icons:getTileCanvas(HEART, true, false, 0, 0)
        status_shift = status_shift + 10
    elseif (fg.GD_NEUTRAL) then
        icons:getTileCanvas(GOOD_NEUTRAL, true, false, 0, 0)
        status_shift = status_shift + 7
    elseif (fg.NEUTRAL) then
        icons:getTileCanvas(NEUTRAL, true, false, 0, 0)
        status_shift = status_shift + 7
    end

    if (fg.STAB) then
        icons:getTileCanvas(STAB_BRAND, true, false, 0, 0)
        status_shift = status_shift + 12
    elseif (fg.MAY_STAB) then
        icons:getTileCanvas(MAY_STAB_BRAND, true, false, 0, 0)
        status_shift = status_shift + 7
    elseif (fg.FLEEING) then
        icons:getTileCanvas(FLEEING, true, false, 0, 0)
        status_shift = status_shift + 3
    end

    if (fg.POISON) then
        icons:getTileCanvas(POISON, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 5
    end
    if (fg.STICKY_FLAME) then
        icons:getTileCanvas(STICKY_FLAME, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 7
    end
    if (fg.INNER_FLAME) then
        icons:getTileCanvas(INNER_FLAME, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 7
    end
    if (fg.CONSTRICTED) then
        icons:getTileCanvas(CONSTRICTED, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 11
    end
    if (fg.GLOWING) then
        icons:getTileCanvas(GLOWING, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 8
    end
    if (fg.HASTED) then
        icons:getTileCanvas(HASTED, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 6
    end
    if (fg.SLOWED) then
        icons:getTileCanvas(SLOWED, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 6
    end
    if (fg.MIGHT) then
        icons:getTileCanvas(MIGHT, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 6
    end
    if (fg.DRAIN) then
        icons:getTileCanvas(DRAIN, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 6
    end
    if (fg.PAIN_MIRROR) then
        icons:getTileCanvas(PAIN_MIRROR, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 7
    end
    if (fg.PETRIFYING) then
        icons:getTileCanvas(PETRIFYING, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 6
    end
    if (fg.PETRIFIED) then
        icons:getTileCanvas(PETRIFIED, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 6
    end
    if (fg.BLIND) then
        icons:getTileCanvas(BLIND, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 10
    end
    if (fg.DEATHS_DOOR) then
        icons:getTileCanvas(DEATHS_DOOR, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 10
    end
    if (fg.RECALL) then
        icons:getTileCanvas(RECALL, true, false, 0, 0, -status_shift, 0)
        status_shift = status_shift + 9
    end

    -- Anim. weap. and summoned might overlap, but that's okay
    if (fg.ANIM_WEP) then
        icons:getTileCanvas(ANIMATED_WEAPON, true, false, 0, 0)
    end
    if (fg.SUMMONED) then
        icons:getTileCanvas(SUMMONED, true, false, 0, 0)
    end
    if (fg.PERM_SUMMON) then
        icons:getTileCanvas(PERM_SUMMON, true, false, 0, 0)
    end

    if (bg.UNSEEN and (bg.value or fg.value)) then
        icons:getTileCanvas(MESH, true, false, 0, 0)
    end

    if (bg.OOR and (bg.value or fg.value)) then
        icons:getTileCanvas(OOR_MESH, true, false, 0, 0)
    end

    if (bg.MM_UNSEEN and (bg.value or fg.value)) then
        icons:getTileCanvas(MAGIC_MAP_MESH, true, false, 0, 0)
    end

    -- Don't let the "new stair" icon cover up any existing icons, but
    -- draw it otherwise.
    if (bg.NEW_STAIR and status_shift == 0) then
        icons:getTileCanvas(NEW_STAIR, true, false, 0, 0)
    end

    if (bg.EXCL_CTR and bg.UNSEEN) then
        icons:getTileCanvas(TRAVEL_EXCLUSION_CENTRE_FG, true, false, 0, 0)
    elseif (bg.TRAV_EXCL and bg.UNSEEN) then
        icons:getTileCanvas(TRAVEL_EXCLUSION_FG, true, false, 0, 0)
    end

    -- Tutorial cursor takes precedence over other cursors.
    if (bg.TUT_CURSOR) then
        icons:getTileCanvas(TUTORIAL_CURSOR, true, false, 0, 0)
    elseif (bg.CURSOR1) then
        icons:getTileCanvas(CURSOR, true, false, 0, 0)
    elseif (bg.CURSOR2) then
        icons:getTileCanvas(CURSOR2, true, false, 0, 0)
    elseif (bg.CURSOR3) then
        icons:getTileCanvas(CURSOR3, true, false, 0, 0)
    end

    -- if (cell.travel_trail & 0xF) then
    --     icons:getTileCanvas(TRAVEL_PATH_FROM  true, false,+
    --                    (cell.travel_trail & 0xF) - 1, 0, 0)
    -- end
    -- if (cell.travel_trail & 0xF0) then
    --     icons:getTileCanvas(TRAVEL_PATH_TO  true, false,+
    --                    ((cell.travel_trail & 0xF0) >> 4) - 1, 0, 0)
    -- end

    if (fg.MDAM_LIGHT) then
        icons:getTileCanvas(MDAM_LIGHTLY_DAMAGED, true, false, 0, 0)
    elseif (fg.MDAM_MOD) then
        icons:getTileCanvas(MDAM_MODERATELY_DAMAGED, true, false, 0, 0)
    elseif (fg.MDAM_HEAVY) then
        icons:getTileCanvas(MDAM_HEAVILY_DAMAGED, true, false, 0, 0)
    elseif (fg.MDAM_SEV) then
        icons:getTileCanvas(MDAM_SEVERELY_DAMAGED, true, false, 0, 0)
    elseif (fg.MDAM_ADEAD) then
        icons:getTileCanvas(MDAM_ALMOST_DEAD, true, false, 0, 0)
    end

    -- if (options.get("tile_show_demon_tier") === true) then
        if (fg.DEMON_1) then
            icons:getTileCanvas(DEMON_NUM1, true, false, 0, 0)
        elseif (fg.DEMON_2) then
            icons:getTileCanvas(DEMON_NUM2, true, false, 0, 0)
        elseif (fg.DEMON_3) then
            icons:getTileCanvas(DEMON_NUM3, true, false, 0, 0)
        elseif (fg.DEMON_4) then
            icons:getTileCanvas(DEMON_NUM4, true, false, 0, 0)
        elseif (fg.DEMON_5) then
            icons:getTileCanvas(DEMON_NUM5, true, false, 0, 0)
        end
    -- end

    love.graphics.setCanvas(pCanvas)
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

-- TODO clean that up !
function Map:handle_map_message(data)
    if data.clear then
        self:clear()
    end

    -- update map knowledge
    self.map_knowledge:merge(data.cells)
    self.map_knowledge.vgrdc = data.vgrdc or self.map_knowledge.vgrdc

    self.bounds = self.map_knowledge.bounds

    -- self.map_knowledge:print()

    local main          = Assets.tile_info.main.spritesheet
    local main_normal   = Assets.tile_info.main.spritesheet_normal
    local player        = Assets.tile_info.player.spritesheet
    local player_normal = Assets.tile_info.player.spritesheet_normal
    local floor         = Assets.tile_info.floor.spritesheet
    local floor_bw      = Assets.tile_info.floor.spritesheet_bw
    local floor_normal  = Assets.tile_info.floor.spritesheet_normal
    local wall          = Assets.tile_info.wall.spritesheet
    local wall_bw       = Assets.tile_info.wall.spritesheet_bw
    local wall_normal   = Assets.tile_info.wall.spritesheet_normal
    local feat          = Assets.tile_info.feat.spritesheet
    local feat_bw       = Assets.tile_info.feat.spritesheet_bw
    local feat_normal   = Assets.tile_info.feat.spritesheet_normal
    local icons         = Assets.tile_info.icons.spritesheet
    local gui           = Assets.tile_info.gui.spritesheet

    local previous = nil
    local since_previous = 0
    for i = 1, #data.cells do
        local map_cell = data.cells[i]
        local cell = map_cell.t

        if cell then
            cell.fg = enums.prepare_fg_flags(cell.fg or 0)
            cell.bg = enums.prepare_bg_flags(cell.bg or 0)
            cell.cloud = enums.prepare_fg_flags(cell.cloud or 0)
            cell.flv = cell.flv or {}
            cell.flv.f = cell.flv.f or 0
            cell.flv.s = cell.flv.s or 0
            map_cell.g = map_cell.g or ' '

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

            -- Background
            local bg_idx = cell.bg.value--self:getBackground(cell)
            local fg_idx = cell.fg.value
            local base_idx = cell.base

            -- TODO find out why i have to correct with -1/+3/+2, also is the test right ?
            local isFloor = bg_idx + 3 < TILE_FLOOR_MAX
            local isWall = bg_idx + 2 >= FLOOR_MAX and bg_idx + 2 < WALL_MAX
            local isFeat = bg_idx + 3 >= WALL_MAX

            local floorIdx = bg_idx + 3
            local floorFeatIdx = cell.flv.f + 2
            local wallIdx = bg_idx - TILE_FLOOR_MAX + 2
            local featIdx = bg_idx - TILE_WALL_MAX + 3

            if isFloor or isWall or isFeat then
                local gen_cell = Cell({
                    image      = isFloor and floor.images[floorIdx] or isWall and wall.images[wallIdx] or floor.images[floorFeatIdx],
                    normal     = isFloor and floor_normal.images[floorIdx] or isWall and wall_normal.images[wallIdx] or floor_normal.images[floorFeatIdx],
                    imageBW    = isFloor and floor_bw.images[floorIdx] or isWall and wall_bw.images[wallIdx] or floor_bw.images[floorFeatIdx],
                    castShadow = isWall,
                    passable   = isFloor,
                    lightWorld = self.light,
                    spriteCode = bg_idx,
                    code       = isFloor and floorIdx or isWall and wallIdx or floorFeatIdx,
                    visible    = self.map_knowledge:visible(map_cell),
                    explored   = true,
                    knowledge  = map_cell,
                    reflective = true
                })

                -- TODO overlays ? blood etc.
                if bg_idx > DNGN_UNSEEN then

                    if bg_idx <= WALL_MAX then
                        -- blood
                    end

                    -- TODO must not be drawn on originals images
                    if cell.ov and false then
                        for i = 1, #cell.ov do
                            local overlay = cell.ov[i]

                            if overlay and (bg_idx < DNGN_FIRST_TRANSPARENT or overlay > FLOOR_MAX) then
                                local image, normal = nil, nil
                                if overlay < FLOOR_MAX then
                                    image = floor.images[overlay + 3]
                                    normal = floor_normal.images[overlay + 3]
                                elseif overlay < WALL_MAX then
                                    image = wall.images[overlay - TILE_FLOOR_MAX + 2]
                                    normal = wall_normal.images[overlay - TILE_FLOOR_MAX + 2]
                                else
                                    image = wall.images[overlay - TILE_WALL_MAX + 3]
                                    normal = wall_normal.images[overlay - TILE_WALL_MAX + 3]
                                end

                                if image then
                                    -- TODO draw it instead of adding units
                                    local pCanvas = love.graphics.getCanvas()
                                    love.graphics.setCanvas(gen_cell.image)

                                    love.graphics.setColor(255, 0, 0, 255)
                                    love.graphics.draw(image, 0, 0)

                                    love.graphics.setCanvas(pCanvas)
                                else
                                    print('not ok', overlay, WALL_MAX, FLOOR_MAX)
                                end

                            end
                        end
                    end

                end

                if isFeat and feat.images[featIdx] then
                    table.insert(gen_cell.units, Unit({
                        lightWorld = self.light,
                        x          = map_cell.x * 32 - 32/2,
                        y          = map_cell.y * 32 - 32/2,
                        outOfSight = false,
                        castShadow = false,
                        animation  = Animation({
                                frames = {
                                feat.images[featIdx]
                            },
                            normal = {
                                feat_normal.images[featIdx]
                            }
                        })
                    }))
                elseif isFeat or map_cell.g == '>' then
                    print('Feat not found', featIdx)
                end

                if fg_idx then
                    -- TODO find foreground
                    -- if (base_idx) then
                    --     this.draw_main(base_idx, x, y)
                    -- if base_idx and main.images[base_idx + 1] then
                    --     table.insert(gen_cell.units, Unit({
                    --         lightWorld = self.light,
                    --         x          = map_cell.x * 32 - 32/2,
                    --         y          = map_cell.y * 32 - 32/2,
                    --         outOfSight = false,
                    --         castShadow = false,
                    --         animation  = Animation({
                    --             frames = {
                    --                 main.images[base_idx + 1]
                    --             },
                    --             normal = {
                    --                 main_normal.images[base_idx + 1]
                    --             }
                    --         })
                    --     }))
                    -- elseif base_idx then
                    --     print('Base not found', base_idx + 1)
                    -- end

                    if fg_idx > 0 and fg_idx + 1 < MAIN_MAX and main.images[fg_idx + 1] then
                        table.insert(gen_cell.units, Unit({
                            lightWorld = self.light,
                            x          = map_cell.x * 32 - 32/2,
                            y          = map_cell.y * 32 - 32/2,
                            outOfSight = false,
                            castShadow = false,
                            animation  = Animation({
                                frames = {
                                    main.images[fg_idx + 1]
                                },
                                normal = {
                                    main_normal.images[fg_idx + 1]
                                }
                            })
                        }))
                    elseif fg_idx > 0 and fg_idx < MAIN_MAX then
                        print('Main not found', fg_idx)
                    end

                    if cell.doll then
                        local doll = Unit({
                            name = map_cell.g or '.',
                            lightWorld = self.light,
                            x          = map_cell.x * 32 - 32/2,
                            y          = map_cell.y * 32 - 32/2,
                            outOfSight = false,
                            castShadow = true,
                            animation  = Animation({
                                frames = {
                                    player:getDollTile(fg_idx, cell)
                                },
                                normal = {
                                    player_normal:getDollTile(fg_idx, cell)
                                }
                            }),
                            doll = fg_idx
                        })

                        if map_cell.g == '@' then
                            table.insert(doll.lights, {
                                light = self.light:newLight(100, 100, 255, 255, 255, 300),
                                x = 0,
                                y = 0
                            })
                        end

                        if cell.halo and map_cell.g ~= '@' then
                            table.insert(doll.lights, {
                                light = self.light:newLight(100, 100, 217, 85, 86, 40),
                                x = 0,
                                y = 0
                            })
                        end

                        table.insert(gen_cell.units, doll)
                    end
                else
                    print('Something wrong here', json.encode(cell.fg))
                end

                gen_cell:generateUI()

                self:setCell(gen_cell, map_cell.x, map_cell.y)
            end
        end
    end
end


function Map:getBackground(cell)
    local backgrounds = {}
    local bg = cell.bg
    local bg_idx = cell.bg.value

    if cell.mangrove_water and bg_idx > DNGN_UNSEEN then
        table.insert(backgrounds, DNGN_SHALLOW_WATER)
    elseif (bg_idx >= DNGN_FIRST_TRANSPARENT) then
        table.insert(backgrounds, cell.flv.f)

        if cell.ov then
            for i = 1, #cell.ov do
                local overlay = cell.ov[i]

                if overlay and overlay <= FLOOR_MAX - 1 then
                    table.insert(backgrounds, overlay)
                end
            end
        end
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

function Map:getUnits()
    local units = {}


    for i = self.bounds.left, self.bounds.right do
        for j = self.bounds.top, self.bounds.bottom do
            local cell = self.map[i] and self.map[i][j]
            local cell_units = cell and cell.units or nil

            if cell_units then
                units = table.join(units, cell_units)
            end
        end
    end

    return units
end

function Map:removeUnit(u)
    if u.light then
        self.light:remove(u.light)
        u.light = nil
    end

    for j = 1, #u.lights do
        self.light:remove(u.lights[j].light)
    end

    u.animation:destroy()
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
                local cell = self.map[i] and self.map[i][j]
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
                local cell = self.map[i] and self.map[i][j]
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
                local cell = self.map[i] and self.map[i][j]
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

function Map:drawUI(x, y, w, h)
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
                local cell = self.map[i] and self.map[i][j]
                if cell then
                    cell:drawUI(
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
    else
        self:resetCell(x, y)
    end

    self.map[x][y] = cell
end


function Map:resetCell(x, y)
    -- TODO compare knowledge: if no .g maybe keep units ?

    -- TODO put some stuff in the cache here
    if self.map[x] and self.map[x][y] then
        local cell = self.map[x][y]

        if cell.body then
            self.light:remove(cell.body)
        end

        for i = 1, #cell.units do
            cell.units[i]:stopParticles()
            self:removeUnit(cell.units[i])
        end

        cell.units = {}
    end
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
