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
    enums = require "enums"
    require "spritesheet"
    require "animation"
    require "textdisplay"
    require "assets"
    require "comm"
    require "client"
    require "map"
    require "map_knowledge"
    require "messages"
    require "unit"
    require "game"

    client = Client()
    game = Game()
    history = {}

    defaultFont = love.graphics.newImageFont('dat/tiles/fontbz-love.png', "☺☻♥♦♣♠•◘○◙♂♀♪♫☼►◄↕‼¶§▬↨↑↓→←∟↔▲▼!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~⌂ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜ¢£¥₧ƒáíóúñÑªº¿⌐¬½¼¡«»░▒▓│┤╡╢╖╕╣║╗╝╜╛┐└┴┬├─┼╞╟╚╔╩╦╠═╬╧╨╤╥╙╘╒╓╫╪┘┌█▄▌▐▀αßΓπΣσµτΦΘΩδ∞φε∩≡±≥≤⌠⌡÷≈°∙·√ⁿ²■ ")
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
end

-- Quitting
function love.quit()
    game:leave()
end
