class SessionsController < ApplicationController
  # http_basic_authenticate_with name: "admin", password: "Abcam123"
  layout 'golden_idea_login'

  def new
  end

  def create
      @employee = Employee.from_omniauth(request.env["omniauth.auth"])      #这是通过ldap认证后,返回邮箱,再用邮箱找到用户,在返回用户
      sign_in @employee
      redirect_back_or root_path
  end

  def destroy
    # session[:admin] = 0
    # redirect_to root_path
  end

  private
    def session_param(attribute)
      params[:session][attribute]
    end
end
