class DepartmentsController < ApplicationController

  def index
    @departments = Department.all
  end

  def show

  end

  def update_department
    render plain: "同步完成"
  end

end
