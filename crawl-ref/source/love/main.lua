function love.load()

  local websocket = require "websocket"

  local client = websocket.client.copas({timeout=2})

  -- connect to the server:

  local ok,err = client:connect('ws://localhost:12345','echo')
  if not ok then
    print('could not connect',err)
  end

  -- send data:

  local ok = client:send('{ "msg" : { "token_login" : { "cookie" : "giann%2065640670665145144475876701010573309577" } } }\n')
  if ok then
    print('msg sent')
  else
    print('connection closed')
  end

  -- receive data:

  local message,opcode = client:receive()
  if message then
    print('msg',message,opcode)
  else
    print('connection closed')
  end

  -- close connection:

  local close_was_clean,close_code,close_reason = client:close(4001,'lost interest')

end


-- Called continuously
function love.update(dt)
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

end
