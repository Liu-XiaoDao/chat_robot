class UserService

  def initialize
    @http = HttpService.new
  end

  def getUserInfo(accessToken, code)
    response = @http.get("/user/getuserinfo", {access_token: accessToken, code: code});
    return response;
  end

  def get(accessToken, userId)
    response = @http.get("/user/get", {access_token: accessToken, userid: userId});
    return response;
  end

  def simplelist(accessToken,deptId)
    response = @http.get("/user/simplelist", {access_token: accessToken,department_id: deptId});
    return response;
  end
end
