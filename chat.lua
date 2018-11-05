local chat = {}

function chat.listen()
    local _, username, message = os.pullEvent('chat_message')
    return username, message
end

return chat
