class DepartmentsController < ApplicationController

  def initialize
    @auth = AuthService.new
    @user = UserService.new
    @departmentService = DepartmentService.new
  end

  def index
    @departments = Department.all
  end

  def show

  end

  def update_department
    accessToken = @auth.getAccessToken()
    department_res = @departmentService.listDept(accessToken)
    if department_res["errmsg"] == "ok" && department_res["errcode"] == 0
      department_list = department_res["department"]
      department_list.each do |department|
        Department.create(id: department["id"], name: department["name"], parentid: department["parentid"])
      end
      return render plain: "共有部门#{department_list.count}个，更新个部门"
    else
      return render plain: department_res["errmsg"]
    end
  end

end
