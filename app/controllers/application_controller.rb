class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  before_action :left_data_init
  #侧边数据初始化
  def left_data_init

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
