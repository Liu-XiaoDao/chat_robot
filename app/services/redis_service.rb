class RedisService
  # 初始化redis链接
  def initialize

    begin
      @redis = Redis.new(host: "127.0.0.1", port: 6379)
    rescue Redis::CannotConnectError
      puts "链接错误"
    ensure
      @redis = FileCache.new
    end
binding.pry
  end

  def setJsTicket(ticket)
    @redis.set("js_ticket", ticket, ex: 7000); # js ticket有效期为7200秒，这里设置为7000秒
  end

  def getJsTicket()
    return @redis.get("js_ticket")
  end

  def setCorpAccessToken(accessToken)
    @redis.set("corp_access_token", accessToken, ex: 7000) # corp access token有效期为7200秒，这里设置为7000秒
  end

  def getCorpAccessToken
    return @redis.get("corp_access_token")
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


class FileCache

  def set(key,value,options = {})
    ex = options[:ex] ? Time.now.to_i + options[:ex] : 0
    if key && value
      data = get_file(Rails.root.to_s + "/config/filecache.yml")

      item = {}
      item["#{key}"] = value
      item['expire_time'] = ex
      item['create_time'] = Time.now.to_i
      data["#{key}"] = item
      set_file(Rails.root.to_s + "/config/filecache.yml",data.to_json)
    end
  end

  def get(key)
    if key
      data = get_file(Rails.root.to_s + "/config/filecache.yml")
      if data && data.has_key?(key)
          item = data["#{key}"]
          return false  if !item
          if item['expire_time']>0 && item['expire_time'] < Time.now.to_i
              return false;
          end
          return item["#{key}"]
      else
        return false;
      end

    end
  end

  def get_file(filename)
    if !File.exist?(filename)
      file = File.open(filename, "w")
      file.write("")
      file.close
      return
    else
      content = YAML.load(File.read(filename))
    end
    return content
  end

  def set_file(filename, content)
    # File.write(filename)
    file = File.open(filename, "w")
    file.write(content)
    file.close unless file.nil?
  end

end
