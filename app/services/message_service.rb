class MessageService

  def initialize
    @http = HttpService.new
  end

  def sendToConversation(accessToken, opt)
    response = @http.post("/message/send_to_conversation?", {access_token: accessToken}, opt.to_json)
    return response
  end

  def send(accessToken, opt)
    response = @http.post("/message/send",{access_token: accessToken}, opt.to_json)
    return response
  end
end
