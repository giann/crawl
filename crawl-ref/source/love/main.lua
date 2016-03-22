function love.load()

  local websocket = require "websocket"
  local json      = require "json"

  local client = websocket.client.sync({timeout=2})

  -- connect to the server:

  local ok,err = client:connect('ws://localhost:8082/socket','echo')
  if not ok then
    print('could not connect',err)
  end

  -- send data:

  local ok = client:send('{ "msg": "login", "username" : "giann", "password" : "je0316je" }')
  if ok then
    print('msg sent')
  else
    print('connection closed')
  end

  -- receive data:

  local message,opcode = client:receive()
  if message then
    print(message)
    print(json.decode(message)["msgs"][1]["msg"])
  else
    print('connection closed')
  end

  -- close connection:

  local close_was_clean,close_code,close_reason = client:close(4001,'lost interest')

  love.event.quit()

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
