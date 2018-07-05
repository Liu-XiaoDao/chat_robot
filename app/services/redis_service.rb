class RedisService
  # 初始化redis链接
  def initialize
    @redis = Redis.new(host: "127.0.0.1", port: 6379)
  end
  # 保存变量
  def set_value(name,value)
    @redis.set(name, value)
  end
  # 使用变量
  def get_value(name)
    @redis.get(name)
  end

end
