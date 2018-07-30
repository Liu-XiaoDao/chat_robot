class ChatService

  def initialize
    @http = HttpService.new
  end

  def createChat(accessToken, chatOpt)
    response = @http.post("/chat/create?", {access_token: accessToken}, chatOpt.to_json)
    return response
  end

  def bindChat(accessToken, chatid,agentid)
   response = @http.get("/chat/bind?",{access_token: accessToken,chatid: chatid,agentid: agentid})
   return response
  end

  def sendmsg(accessToken, opt)
    response = @http.post("/chat/send?", {access_token: accessToken}, opt.to_json)
    return response
  end

  # def callback(accessToken, opt)
  #   response = $this->http->post("/call_back/register_call_back", {access_token: accessToken}, opt.to_json)
  #   return response
  # end
end
