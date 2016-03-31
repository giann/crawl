TextDisplay = Class {
    
    init = function (self, options)

        self.text = ""
        self.x = 0
        self.y = love.graphics.getHeight() * 0.4
        self.limit = love.graphics.getWidth()
        self.align = 'left'
        -- self.font = defaultFont
        self.r = 0
        self.sx = 1
        self.sy = 1
        self.ox = 0
        self.oy = 0
        self.kx = 0
        self.ky = 0

        self.color = {255, 255, 255, 255}
        self.shadowColor = {0, 0, 0, 100}

        self.container = false

        self.tween = nil

        self.available = true

        Utils.assign(self, options)

        self:registerEvents()

    end

}

function TextDisplay:update(dt)
end

function TextDisplay:draw()
    -- love.graphics.setFont(self.font)

    love.graphics.setColor(self.shadowColor)
    love.graphics.printf(self.text, self.x + 1, self.y + 1, self.limit, self.align, self.r, self.sx, self.sy, self.ox, self.oy, self.kx, self.ky)

    love.graphics.setColor(255, 255, 255, 255)

    love.graphics.setColor(self.color)
    love.graphics.printf(self.text, self.x, self.y, self.limit, self.align, self.r, self.sx, self.sy, self.ox, self.oy, self.kx, self.ky)

    love.graphics.setColor(255, 255, 255, 255)

    -- love.graphics.setFont(defaultFont)
end

function TextDisplay:registerEvents()

end