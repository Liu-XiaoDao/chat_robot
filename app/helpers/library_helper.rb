module LibraryHelper
  def sign_in(employee)
    session[:employee_name] = employee.name
  end

  def signed_in?  #检测当前用户，返回是否登录
    !current_employee.nil?
  end

  def current_employee   #设置并返回当前用户
    return Employee.find 1
    if employee_name = session[:employee_name]
      @current_employee ||= Employee.find_by name: employee_name  # ||= 左侧有值就用，那就不用执行右边的方法来，左边无值就在取值
    elsif employee_name = cookies.signed[:employee_name]
      employee = Employee.find_by name: employee_name
      return nil unless employee
      if 'kdkdlslgseger24thGEg234rhbN' == cookies.signed[:remember_token]
         sign_in employee
         @current_employee = employee
      end
    end
    @current_employee
  end

  #记住密码
  def remember_me(employee)
    cookies.permanent.signed[:remember_token] = 'kdkdlslgseger24thGEg234rhbN'    #这个地方应该生成一个随机的token,和数据库比较(数据库加字段保存token)
    cookies.permanent.signed[:employee_name] = employee.name
  end

  #忘记密码
  def forget_me(user)   #这是忘记用户名密码
    cookies.delete :remember_token
    cookies.delete :username
  end


  def sign_out   #退出登录
    return unless signed_in?
    session.delete :username
    @current_user = nil
  end


    # 存储原始请求地址
  def store_location   #保存请求地址，应该是为了返回上一个请求，不过只保存get操作
    session[:forwarding_url] = request.original_url if request.get?
  end

  def redirect_back_or(default)   #应用场景应该为做完某些操作后，需要返回上一页。就是用这个方法，然后在删除这个url
    redirect_to ( session[:forwarding_url] || default )
    session.delete :forwarding_url
  end
end
