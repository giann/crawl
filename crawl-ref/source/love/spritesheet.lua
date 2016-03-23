SpriteSheet = Class {

    init = function (self, options)
        self.image = nil
        self.tileinfo = nil
        self.images = {}

        Utils.assign(self, options)

        if self.image and self.tileinfo then
            self:generateImages()
        end
    end

}


function SpriteSheet:generateImages()
    local imageWidth = self.image:getWidth()
    local imageHeight = self.image:getHeight()

    self.x_scale = 1
    self.y_scale = 1

    for i = 1, #self.tileinfo.tile_info do

        local info = self.tileinfo.tile_info[i]
        local img = self.image
        if not info then
            print("Tile not found: " .. i)

            return false
        end

        local size_ox = 32 / 2 - info.w / 2
        local size_oy = 32 - info.h
        local pos_sy_adjust = info.oy + size_oy
        local pos_ey_adjust = pos_sy_adjust + info.ey - info.sy
        local sy = pos_sy_adjust
        local ey = pos_ey_adjust

        if sy >= ey then
            return false
        end

        local total_x_offset = info.ox + size_ox

        -- if total_x_offset < self.current_left_overlap then
        --     self.current_left_overlap = total_x_offset
        -- end

        -- if sy < self.current_sy then
        --     self.current_sy = sy
        -- end

        local w = info.ex - info.sx
        local h = info.ey - info.sy

        local canvas = love.graphics.newCanvas(
            w,
            h + ey - pos_ey_adjust
        )
        love.graphics.setCanvas(canvas)
        love.graphics.draw(
            self.image,
            love.graphics.newQuad(
                info.sx, info.sy + sy - pos_sy_adjust,
                w, h + ey - pos_ey_adjust,
                imageWidth, imageHeight
            ),
            0, 0
        )
        love.graphics.setCanvas()

        self.images[i] = canvas

    end

end
