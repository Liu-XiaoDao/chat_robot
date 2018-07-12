class EmployeesController < ApplicationController
  before_action :init_locals, :only => :update_employee

  def index
    @employees =  Employee.all
  end

  def show

  end

  def update_employee
    accessToken = @auth.getAccessToken() #获取token

    @departments = Department.all
    @departments.each do |department|
      department_employees = @user.list(accessToken,department.id)
      if department_employees["errmsg"] == "ok" && department_employees["errcode"] == 0
        department_employee_lists = department_employees["userlist"]

        department_employee_lists.each do |employee|
          if Employee.find_by_userid(employee["userid"]).blank?
            Employee.create(parse_employee(employee))
          else
            Employee.find_by_userid(employee["userid"]).update(parse_employee(employee))
          end
        end
        flash[:success] = "更新员工成功"
      else
        flash[:danger] = department_employees["errmsg"]
      end
    end
    redirect_to :index
  end

  def init_locals
    @auth = AuthService.new
    @user = UserService.new
  end

  def parse_employee(employee)
    {
      position: employee["position"],
      department: employee["department"],
      unionid: employee["unionid"],
      userid: employee["userid"],
      dingid: employee["dingid"],
      name: employee["name"],
      isleader: employee["isleader"],
      active: employee["active"],
      openid: employee["openid"],
      avatar: employee["avatar"],
      isadmin: employee["isadmin"]
    }
  end
end
