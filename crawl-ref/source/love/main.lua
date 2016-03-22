function love.load()

  --require "lib/cupid"

  websocket  = require "websocket"
  json       = require "lib/json"
  deflatelua = require "lib/deflatelua"
  Class      = require "lib/hump.class"
  Gamestate  = require "lib/hump.gamestate"
  Signal     = require "lib/hump.signal"
  Timer      = require "lib/hump.timer"

  LightWorld = require "lib/light"

  require "utils"
  require "comm"
  require "client"
  require "map"

  light = LightWorld({
      ambient = {70, 70, 70},
      refractionStrength = 10.0,
      reflectionVisibility = 0,
  })
  client = Client()
  map = Map()


  -- TOREMOVE: quick connect and start
  client.comm:send('login', {
    username = 'giann',
    password = 'je0316je'
  })

  client.comm:send('play', {
    game_id = 'dcss-web-trunk'
  })

  client.comm.socket.sock:settimeout(0)

end


-- Called continuously
function love.update(dt)
  client:receive()
end

-- Mouse pressed
function love.mousepressed(x, y, button)

end

-- Mouse released
function love.mousereleased(x, y, button)

end

-- Key pressed
function love.keypressed(key)

    if key == "escape" then
        love.event.quit()
    end

end

-- Key released
function love.keyreleased(key)

end

-- Text entered
function love.textinput(t)

end

-- Drawing
function love.draw()
  love.graphics.print(client.history[1] .. '\n' .. (client.history[2] or '') .. '\n' .. (client.history[3] or ''), 10, 10)
end

-- Quitting
function love.quit()

end
