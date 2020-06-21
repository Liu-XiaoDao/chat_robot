class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  include LibraryHelper

  before_action :left_data_init, :check_signed_in
  helper_method :sort_params, :sort_column, :sort_direction
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

  #上传sop附件
  def save_sop_attachments
    params[:sop_files].each do |attachment|
      @golden_idea.attachments.create(attachment: attachment, notes: 'sop_file')
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
      :remote_ip => request.remote_ip,
      :employee => Employee.current_employee
    )
    rslt
  end

  # 字段排序
  def sort_params
    return nil unless sort_column
    return nil unless sort_direction

    "#{sort_column} #{sort_direction}"
  end

  def sort_column
    params[:sort]
    # @current_resource.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end
end
