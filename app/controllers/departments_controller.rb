class DepartmentsController < ApplicationController
  include ActionController::Live

  before_action :init_locals, :only => :update_department

  def index
    @departments = Department.all.paginate page: params[:page], per_page: 15
  end

  def show
    response.headers['Content-Type'] = 'text/event-stream'
    10.times {
      response.stream.write "hello world\n"
      sleep 1
    }
  ensure
    response.stream.close
  end

  def update_department
    accessToken = @auth.getAccessToken()
    department_res = @departmentService.listDept(accessToken)
    if department_res["errmsg"] == "ok" && department_res["errcode"] == 0
      department_list = department_res["department"]
      department_list.each do |department|
        if Department.find(department["id"]).blank?
          Department.create(id: department["id"], name: department["name"], parentid: department["parentid"])
        else
          Department.find(department["id"]).update(name: department["name"], parentid: department["parentid"])
        end

      end
      return render plain: "共有部门#{department_list.count}个，更新个部门"
    else
      return render plain: department_res["errmsg"]
    end
  end

  def init_locals
    @auth = AuthService.new
    @user = UserService.new
    @departmentService = DepartmentService.new
  end

end
