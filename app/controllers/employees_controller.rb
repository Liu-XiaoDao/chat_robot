class EmployeesController < ApplicationController
  before_action :init_locals, :only => :update_employee

  def index
    @employees =  Employee.all.paginate page: params[:page], per_page: 15
  end

  def show

  end

  def update_employee
    accessToken = @auth.getAccessToken() #获取token
    @msg = ""

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

        @msg = "#{@msg} - #{department_employee_lists.count}"
      else
        @msg = "#{@msg} - error"
      end
    end

    return render plain: @msg
  end

  def init_locals
    @auth = AuthService.new
    @user = UserService.new
  end

  def parse_employee(employee)
    {
      position: employee["position"],
      department_id: employee["department"].join(","),
      unionid: employee["unionid"],
      userid: employee["userid"],
      dingid: employee["dingId"],
      name: employee["name"],
      isleader: employee["isLeader"],
      active: employee["active"],
      openid: employee["openId"],
      avatar: employee["avatar"],
      isadmin: employee["isAdmin"]
    }
  end
end
