class EmployeesController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "Abcam123", only: [:index, :show_phone_number, :set_phone_number]
  before_action :init_locals, :only => :update_employee
  layout 'library', only: [:borrow_record, :return_record, :borrow_book, :book_praise_rubbish, :book_comment]

  def index
    @employees =  Employee.all.paginate page: params[:page], per_page: 15
  end

  def show
    #金点子在使用
    @employee =  Employee.find params[:id]
    render layout: 'golden_idea'
  end

  def phone_number
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

  # 下面是图书管理相关
  def borrow_record
    @employee =  Employee.find params[:id]
    @borrow_records = @employee.borrow_records.paginate page: params[:page], per_page: 8
  end

  def return_record
    @employee =  Employee.find params[:id]
    @return_records = @employee.return_records.paginate page: params[:page], per_page: 8
  end

  def borrow_book
    @employee =  Employee.find params[:id]
    @books = @employee.books.paginate page: params[:page], per_page: 8
  end

  def book_praise_rubbish
    @employee =  Employee.find params[:id]
    @praise_rubbishs = @employee.count_records.paginate page: params[:page], per_page: 10
  end

  def book_comment
    @employee =  Employee.find params[:id]
    @comments = @employee.comments.paginate page: params[:page], per_page: 8
  end

  #金点子相关
  def golden_ideas
    @employee = Employee.find params[:id]
    @golden_ideas = @employee.golden_ideas
    render layout: "golden_idea"
  end

  def exchange_records
    @employee = Employee.find params[:id]
    @exchange_records = @employee.exchange_records
    render layout: "golden_idea"
  end

  def assign_score_records
    @employee = Employee.find params[:id]
    @assign_score_records = @employee.assign_score_records
    render layout: "golden_idea"
  end

  def score
    @employee = Employee.find params[:id]
    render layout: "golden_idea"
  end

  def score_lists
    @employees = Employee.ransack(params[:q]).result(distinct: true)
    @employees = @employees.paginate page: params[:page], per_page: 15
    render layout: "golden_idea"
  end

  def update_employee
    accessToken = @auth.getAccessToken() #获取token
    @msg = ""
    @departments = Department.all
    Employee.all.update_all(is_leave: 1)

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
    hired_date = Time.at(employee["hiredDate"].present? ? employee["hiredDate"]/1000 : 0)
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
      isadmin: employee["isAdmin"],
      hired_date: hired_date,
      is_leave: 0
    }
  end
end
