function love.load()

  websocket  = require "websocket"
  json       = require "lib/json"
  deflatelua = require "lib/deflatelua"
  Class      = require "lib/hump.class"
  Gamestate  = require "lib/hump.gamestate"
  Signal     = require "lib/hump.signal"
  Timer      = require "lib/hump.timer"

  require "utils"
  require "comm"

end


-- Called continuously
function love.update(dt)
  local message, opcode = client:receive()
  if message then
    print('* ' .. message)
    --print(json.decode(message)["msgs"][1]["msg"])
  end
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

end

-- Quitting
function love.quit()
  local close_was_clean,close_code,close_reason = client:close(4001,'lost interest')
end
