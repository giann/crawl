function love.load()

  websocket  = require "websocket"
  json       = require "lib/json"
  deflatelua = require "lib/deflatelua"

  client = websocket.client.sync({timeout=nil})

  -- connect to the server:

  local ok,err = client:connect('ws://localhost:8082/socket','echo')
  if not ok then
    print('could not connect',err)
  end

  -- send data:
  local message, opcode

  print('->go_lobby')
  client:send(json.encode({
    msg = 'go_lobby'
  }))

  message, opcode = client:receive()
  print(message)

  print('->pong')
  client:send(json.encode({
    msg = 'pong'
  }))

  message, opcode = client:receive()
  print(message)

  print('->login')
  client:send(json.encode({
    msg = 'login',
    username = 'giann',
    password = 'je0316je'
  }))

  repeat
    message, opcode = client:receive()
    print('# ' .. message)
  until json.decode(message)["msgs"][1]["msg"] == 'login_success'

  print('->go_lobby')
  client:send(json.encode({
    msg = 'go_lobby'
  }))

  message, opcode = client:receive()
  print(message)

  print('->play')
  client:send(json.encode({
    msg = 'play',
    game_id = 'dcss-web-trunk'
  }))

  message, opcode = client:receive()
  print(message)

  -- we don't block while reading the server
  client.sock:settimeout(0)

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
