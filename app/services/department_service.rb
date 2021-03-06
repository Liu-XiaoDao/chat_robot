class DepartmentService

  def initialize
    @http = HttpService.new
  end

  def createDept(accessToken, dept)
    response = @http.post("/department/create?", {access_token: accessToken}, dept.to_json)
    return response
  end

  def listDept(accessToken)
    response = @http.get("/department/list?", {access_token: accessToken})
    return response
  end

  def list_ids(accessToken)
    response = @http.get("/department/list_ids?", {access_token: accessToken})
    return response
  end

  def department_info(accessToken)
    response = @http.get("/department/get?", {access_token: accessToken,id: 66950253})
    return response
  end

  def deleteDept(accessToken, id)
    response = @http.get("/department/delete?",{access_token: accessToken, id: id})
    return response
  end

end
