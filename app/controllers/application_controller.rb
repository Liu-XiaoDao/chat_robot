class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  include LibraryHelper

  before_action :left_data_init, :check_signed_in
  #侧边数据初始化
  def left_data_init
  end

  #登录
  def check_signed_in
    if signed_in?
      Employee.current_employee = current_employee
    end
  end

  #上传附件
  def save_attachments
    params[:attachment_files].each do |attachment|
      @golden_idea.attachments.create(attachment: attachment)
    end
  end

  def process_action *args
    time = Time.now
    rslt = super
    filtered_params = request.params.reject{|k, v| k.match('file') || v.empty?}
    ur=UserRequest.create(
      :url => request.url,
      :time => (Time.now-time),
      :path => request.path.gsub(/\d+/, ':id'),
      :params => JSON[filtered_params.merge(method: request.method)],
      :remote_ip => request.remote_ip
    )
    rslt
  end

end
