function love.load()

    websocket  = require "websocket"
    json       = require "lib/json"
    deflatelua = require "lib/deflatelua"
    Class      = require "lib/hump.class"
    Gamestate  = require "lib/hump.gamestate"
    Signal     = require "lib/hump.signal"
    Timer      = require "lib/hump.timer"

    LightWorld = require "lib/light"

    bit = require "websocket/bit"

    require "utils"
    require "spritesheet"
    require "assets"
    require "comm"
    require "client"
    require "map"
    require "map_knowledge"
    require "unit"
    require "game"

    client = Client()
    game = Game()
    history = {}

    local defaultFont = love.graphics.newImageFont('fontbz-love.png', "☺☻♥♦♣♠•◘○◙♂♀♪♫☼►◄↕‼¶§▬↨↑↓→←∟↔▲▼!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~⌂ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜ¢£¥₧ƒáíóúñÑªº¿⌐¬½¼¡«»░▒▓│┤╡╢╖╕╣║╗╝╜╛┐└┴┬├─┼╞╟╚╔╩╦╠═╬╧╨╤╥╙╘╒╓╫╪┘┌█▄▌▐▀αßΓπΣσµτΦΘΩδ∞φε∩≡±≥≤⌠⌡÷≈°∙·√ⁿ²■ ")
    defaultFont:setLineHeight(1)
    love.graphics.setFont(defaultFont)

    -- TOREMOVE: quick connect and start
    client.comm:send('login', {
        username = 'giann',
        password = 'je0316je'
    })

    client.comm:send('play', {
        game_id = 'dcss-web-trunk'
    })

    client.comm.socket.timeout = 0
    client.comm.socket.sock:settimeout(0)

end


-- Called continuously
function love.update(dt)
    client:receive()
    game:update(dt)
end

-- Mouse pressed
function love.mousepressed(x, y, button)
    game:mousepressed(x, y, button)
end

-- Mouse released
function love.mousereleased(x, y, button)
    game:mousereleased(x, y, button)
end

-- Key pressed
function love.keypressed(key)

    if key == "escape" then
        love.event.quit()
    end

    game:keypressed(key)

end

-- Key released
function love.keyreleased(key)
    game:keyreleased(key)
end

-- Text entered
function love.textinput(t)
    game:textinput(t)
end

-- Drawing
function love.draw()
    game:draw()

    love.graphics.setCanvas()
    love.graphics.setColor(255, 255, 255)

    local log = ''
    for i = 1, math.min(#history, 10) do
        log = log .. '\n' .. history[i]
    end

    love.graphics.print(log, 10, 10)

    for i = 10, 20 do
        if Assets.tile_info.main.spritesheet.images[i] then
            love.graphics.draw(Assets.tile_info.main.spritesheet.images[i], 10 + 32*i, 10)
        end

        if Assets.tile_info.player.spritesheet.images[i] then
            love.graphics.draw(Assets.tile_info.player.spritesheet.images[i], 10 + 32*i, 50)
        end

        if Assets.tile_info.floor.spritesheet.images[i] then
            love.graphics.draw(Assets.tile_info.floor.spritesheet.images[i], 10 + 32*i, 100)
        end

        if Assets.tile_info.wall.spritesheet.images[i] then
            love.graphics.draw(Assets.tile_info.wall.spritesheet.images[i], 10 + 32*i, 150)
        end

        if Assets.tile_info.feat.spritesheet.images[i] then
            love.graphics.draw(Assets.tile_info.feat.spritesheet.images[i], 10 + 32*i, 200)
        end

        if Assets.tile_info.icons.spritesheet.images[i] then
            love.graphics.draw(Assets.tile_info.icons.spritesheet.images[i], 10 + 32*i, 250)
        end

        if Assets.tile_info.gui.spritesheet.images[i] then
            love.graphics.draw(Assets.tile_info.gui.spritesheet.images[i], 10 + 32*i, 300)
        end
    end
end

-- Quitting
function love.quit()
    game:leave()
end
