class ExpressesController < ApplicationController
  def index
    if params[:search_name].present?
      @expresses = Express.where(employee_id: Employee.find_by_name(params[:search_name]).id).paginate page: params[:page], per_page: 18
    else
      @expresses = Express.all.paginate page: params[:page], per_page: 18
    end
    render layout: false
  end

  def new
    render layout: false
  end

  def batch_create
    expresses_type = params[:expresses_type]
    name_list_str = params[:name_list]
    @name_list = name_list_str.split(/,|，| /)
    @suc_name_list = []
    @err_name_list = []
    @name_list.each do |name|
      employee = Employee.find_by_name(name)
      if employee.present?
        LogService.i("[express_create] SUC: 新建快递记录成功，姓名:#{name}");
        Express.create(employee_id: employee.id, express_type: expresses_type)
        @suc_name_list.push name
      else
        @err_name_list.push name
        LogService.e("[express_create] ERR: 没有根据这个姓名:#{name}找到匹配的员工")
      end
    end

    render  :new, layout: false
  end
end
