Client = Class {

  init = function (self)
    self.comm = Comm()
    self.messages_queue = {}
    self.message_inhibit = 0

    self.comm:register_immediate_handlers({
        ping  = { handler = self.pong, context = self },
        close = { handler = self.connection_closed, context = self },
    })

    self.comm:register_message_handlers({
        multi            = { handler = self.handle_multi_message, context = self },

        set_game_links   = { handler = function () end, context = {} },
        html             = { handler = function () end, context = {} },
        show_dialog      = { handler = self.handle_dialog, context = self },
        hide_dialog      = { handler = self.hide_dialog, context = self },

        lobby_clear      = { handler = self.lobby_clear, context = self },
        lobby_entry      = { handler = self.lobby_entry, context = self },
        lobby_remove     = { handler = self.lobby_remove, context = self },
        lobby_complete   = { handler = self.lobby_complete, context = self },

        go_lobby         = { handler = self.go_lobby, context = self },
        login_required   = { handler = self.login_required, context = self },
        game_started     = { handler = self.crawl_started, context = self },
        game_ended       = { handler = self.crawl_ended, context = self },

        login_success    = { handler = self.logged_in, context = self },
        login_fail       = { handler = self.login_failed, context = self },
        login_cookie     = { handler = self.set_login_cookie, context = self },
        register_fail    = { handler = self.register_failed, context = self },

        watching_started = { handler = self.watching_started, context = self },

        rcfile_contents  = { handler = self.rcfile_contents, context = self },

        game_client      = { handler = self.receive_game_client, context = self },

        layer            = { handler = self.do_set_layer, context = self },
    })

    self.comm:connect('ws://localhost:8082/socket')
  end

}


function Client:receive()
  local message, opcode = self.comm.socket:receive()
  if message then
    print('* ' .. message)

    message = json.decode(message)
    local msgs = message.msgs
    if not msgs then
      msgs = message
    end

    for i = 1, #msgs do
      if not self.comm:handle_message_immediately(msgs[i]) then
        self.messages_queue[#self.messages_queue + 1] = msgs[i]
      end
    end

    self:handle_messages_backlog()
  end
end


function Client:handle_messages_backlog()
  while #self.messages_queue > 0 and self.message_inhibit == 0 do

    local msg = table.remove(self.messages_queue, 1)

    self.comm:handle_message(msg)

  end
end


function Client:handle_multi_message(data)
  for i = 1, #data.msgs do
    table.insert(self.messages_queue, 1, data.msgs[i])
  end
end


function Client:pong()
  self.comm:send('pong')
end


function Client:connection_closed()
  print('Connection closed')
end


function Client:handle_dialog()
end


function Client:hide_dialog()
end



function Client:lobby_clear()
end


function Client:lobby_entry()
end


function Client:lobby_remove()
end


function Client:lobby_complete()
end



function Client:go_lobby()
end


function Client:login_required()
end


function Client:crawl_started()
end


function Client:crawl_ended()
end



function Client:logged_in()
end


function Client:login_failed()
end


function Client:set_login_cookie()
end


function Client:register_failed()
end



function Client:watching_started()
end



function Client:rcfile_contents()

end


function Client:receive_game_client()
end


function Client:do_set_layer()
end
