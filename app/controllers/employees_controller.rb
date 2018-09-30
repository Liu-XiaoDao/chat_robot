class EmployeesController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "Abcam123", only: [:index, :show_phone_number, :set_phone_number]
  before_action :init_locals, :only => :update_employee

  def index
    @employees =  Employee.all.paginate page: params[:page], per_page: 15
  end

  def show

  end

  def phone_number
    # @users = RedisService.new.get_value(:users)
    # if @users.blank?
    #   @users = User.all
    #   RedisService.new.set_value(:users,@users)
    # end
    @employees =  Employee.all
    render layout: false
  end

  def set_phone_number
    @employee =  Employee.find params[:id]
    if params[:type] == "extension_number"
      @employee.extension_number = params[:number]
    else
      @employee.linear_telephone = params[:number]
    end
    @employee.save
  end

  def show_phone_number
    @employees =  Employee.all.paginate page: params[:page], per_page: 15
  end

  def set_my_phone_number
    @employee =  Employee.find_by_name params[:employee_name]
    if @employee.blank?
      redirect_to set_my_phone_number_page_employees_path, notice: "姓名输入有误，请重新设置"
    else
      @employee.extension_number = params[:extension_number]
      @employee.linear_telephone = params[:linear_telephone]
      @employee.save
      redirect_to phone_number_employees_path
    end
  end

  def set_my_phone_number_page
    render layout: false
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

        @msg = "#{@msg} - #{department.name}:#{department_employee_lists.count}"
      else
        @msg = "#{@msg} - #{department.name}:error"
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
