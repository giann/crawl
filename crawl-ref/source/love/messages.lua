Messages = Class {
    
    init = function (self, options)
        self.messages = {}

        self.display = TextDisplay({
            x = 20,
            y = love.window.getHeight() - 90
        })

        Utils.assign(self, options)

        client.comm:register_message_handlers({
            msgs = { handler = self.handle_messages, context = self }
        })
    end

}


function Messages:handle_messages(data)

    for i = 1, #data.messages do
        local message = data.messages[i]

        table.insert(self.messages, {
            text = string.gsub(message.text, '</?[a-z]+>', ''), -- we strip color tags for now
            turn = message.turn,
            channel = message.channel
        })
    end

    self.display.text = ''
    for i = math.max(1, #self.messages - 7), #self.messages do
        self.display.text = self.display.text .. self.messages[i].text .. '\n'
    end

end