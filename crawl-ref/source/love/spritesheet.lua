SpriteSheet = Class {

    init = function (self, generate, options)
        self.image = nil
        self.tileinfo = nil
        self.images = {}
        self.x_scale = 1
        self.y_scale = 1

        Utils.assign(self, options)

        if self.image and self.tileinfo and generate then
            self:generateImages()
        end
    end

}


function SpriteSheet:generateImages()

    for i = 1, #self.tileinfo.tile_info do

        self.images[i] = self:getTileCanvas(i, false, true)

    end

end


function SpriteSheet:getDollTile(fg_idx, cell)
    local pCanvas = love.graphics.getCanvas()
    local canvas = love.graphics.newCanvas(32, 32)

    love.graphics.setCanvas(canvas)
    love.graphics.setColor(255, 255, 255, 255)

    if fg_idx + 1 >= MAIN_MAX and cell.doll and #cell.doll > 0 then
        local mcache_map = {}

        if cell.mcache then
            for i = 1, #cell.mcache do
                mcache_map[cell.mcache[i][1]] = i
            end
        end

        for i = 1, #cell.doll do
            local doll_part = cell.doll[i]
            local xofs = 0
            local yofs = 0
            if mcache_map[doll_part[1]] then
                local mind = mcache_map[doll_part[1]]
                xofs = cell.mcache[mind][2]
                yofs = cell.mcache[mind][3]
            end

            self:getTileCanvas(doll_part[1] - TILE_MAIN_MAX + 2, true, false, 0, 0, xofs, yofs, doll_part[2])
        end
    end

    if (fg_idx + 2 >= MCACHE_START) and cell.mcache and #cell.mcache > 0 then
        for i = 1, #cell.mcache do
            local mcache_part = cell.mcache[i]
            if mcache_part then
                self:getTileCanvas(mcache_part[1] - TILE_MAIN_MAX + 2, true, false, 0, 0, mcache_part[2], mcache_part[3])
            end
        end
    end

    love.graphics.setCanvas(pCanvas)

    return canvas
end


function SpriteSheet:getTileCanvas(i, adjust, onCanvas, x, y, ofsx, ofsy, y_max)
    local imageWidth = self.image:getWidth()
    local imageHeight = self.image:getHeight()

    local info = self.tileinfo.tile_info[i]
    local img = self.image

    local size_ox = 32 / 2 - info.w / 2
    local size_oy = 32 - info.h
    local pos_sy_adjust = (ofsy or 0) + info.oy + size_oy
    local pos_ey_adjust = pos_sy_adjust + info.ey - info.sy
    local sy = pos_sy_adjust
    local ey = pos_ey_adjust
    adjust = adjust and 1 or 0

    if y_max and y_max < ey then
        ey = y_max
    end

    if sy >= ey then
        return false
    end

    local total_x_offset = (ofsx or 0) + info.ox + size_ox

    -- if total_x_offset < self.current_left_overlap then
    --     self.current_left_overlap = total_x_offset
    -- end

    -- if sy < self.current_sy then
    --     self.current_sy = sy
    -- end

    local w = info.ex - info.sx
    local h = info.ey - info.sy

    local canvas = love.graphics.newCanvas(
        w * self.x_scale,
        (h + ey - pos_ey_adjust) * self.y_scale
    )

    local pCanvas = love.graphics.getCanvas()
    if onCanvas then
        love.graphics.setCanvas(canvas)
    end

    love.graphics.draw(
        self.image,
        love.graphics.newQuad(
            info.sx, info.sy + sy - pos_sy_adjust,
            w, h + ey - pos_ey_adjust,
            imageWidth, imageHeight
        ),
        (x or 0) + (total_x_offset * self.x_scale) * adjust,
        (y or 0) + (sy * self.y_scale) * adjust
    )

    if onCanvas then
        love.graphics.setCanvas(pCanvas)

        return canvas
    end
end