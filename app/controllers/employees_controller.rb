class EmployeesController < ApplicationController
  before_action :init_locals, :only => :update_employee

  def index
    @departments = Department.all
    # @employees =
  end

  def show

  end

  def update_employee
    accessToken = @auth.getAccessToken()
    department_res = @user.simplelist(accessToken,1)

    binding.pry




    # department_res = @departmentService.listDept(accessToken)
    # if department_res["errmsg"] == "ok" && department_res["errcode"] == 0
    #   department_list = department_res["department"]
    #   department_list.each do |department|
    #     if Department.find(department["id"]).blank?
    #       Department.create(id: department["id"], name: department["name"], parentid: department["parentid"])
    #     else
    #       Department.find(department["id"]).update(name: department["name"], parentid: department["parentid"])
    #     end
    #
    #   end
    #   return render plain: "共有部门#{department_list.count}个，更新个部门"
    # else
    #   return render plain: department_res["errmsg"]
    # end
  end

  def init_locals
    @auth = AuthService.new
    @user = UserService.new
  end
end
