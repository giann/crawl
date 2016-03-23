Comm = Class {

  init = function (self)
    self.url = nil
    self.socket = nil

    self.message_handlers = {}
    self.immediate_handlers = {}
  end

}


function Comm:connect(url)
  self.socket = websocket.client.sync({timeout = nil})

  local connected, err = self.socket:connect(url, 'echo')
  if not connected then
    print('Could not connect to ' .. url .. ': ' .. err)

    return false
  end

  self.url = url
  print('Connected to ' .. url)

  return true
end


function Comm:close()
  print('Closing websocket...')
  local close_was_clean, close_code, close_reason = self.socket:close(4001,'lost interest')

  return close_was_clean
end


function Comm:send(msg, data)
  print('Send: ' .. msg)
  data = data or {}
  data.msg = msg
  self.socket:send(json.encode(data))
end


function Comm:register_message_handlers(dict)
  self.message_handlers = table.merge(self.message_handlers, dict)
end


function Comm:register_immediate_handlers(dict)
  self.immediate_handlers = table.merge(self.immediate_handlers, dict)
end


function Comm:handle_message(msg)
  local handler = self.message_handlers[msg.msg]

  if not handler then
    print('Unknown message type: ' .. msg.msg)
    return false
  end

  print('Handling ' .. msg.msg)
  handler.handler(handler.context, msg)
end


function Comm:handle_message_immediately(msg)
  local handler = self.immediate_handlers[msg.msg]

  if not handler then
    return false
  end

  handler.handler(handler.context, msg)

  return true
end
