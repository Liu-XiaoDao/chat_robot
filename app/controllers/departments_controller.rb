class DepartmentsController < ApplicationController
  include ActionController::Live

  before_action :init_locals, :only => :update_department

  def index
    @departments = Department.all.paginate page: params[:page], per_page: 15
  end

  # def show
  #   response.headers['Content-Type'] = 'text/event-stream'
  #   response.headers['Cache-Control'] = 'no-cache'
  #   response.headers['Connection'] = 'keep-alive'
  #   10.times {
  #     response.stream.write "data: hello world\n\n"
  #     sleep 1
  #   }
  # ensure
  #   response.stream.close
  # end


  def show
    response.headers["Content-Type"] = "text/event-stream"
    response.headers['Cache-Control'] = 'no-cache'
    response.headers['Connection'] = 'keep-alive'
    data = '111111'
    10.times {
      response.stream.write("event: messages.create\n")
      response.stream.write("data: #{data}\n\n")
      sleep 1
     }
  rescue IOError
    logger.info "Stream closed"
  ensure
    response.stream.close
  end




  def update_department
    accessToken = @auth.getAccessToken()
    department_res = @departmentService.listDept(accessToken)
    if department_res["errmsg"] == "ok" && department_res["errcode"] == 0
      department_list = department_res["department"]
      department_list.each do |department|
        if Department.find_by_id(department["id"]).blank?
          Department.create(id: department["id"], name: department["name"], parentid: department["parentid"])
        else
          Department.find_by_id(department["id"]).update(name: department["name"], parentid: department["parentid"])
        end

      end
      return render plain: "共有部门#{department_list.count}个"
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
