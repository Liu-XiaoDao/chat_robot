class HttpService
  require 'net/https'
  require 'uri'

  def initialize
    @config = YAML.load( File.read(Rails.root.to_s + "/config/dingconfig.yml"))
  end

  def get(url,params)
    uri = URI.parse("#{@config['oapi_host']}/#{url}?")
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    if res.code == "200"
      return resbody = JSON.parse(res.body)
    end
    return nil
  end

  def post(url, params, data)
    res = RestClient.post joinParams(url, params), data, :content_type => :json, :accept => :json
  end

  # def execUri(uri,params)
  #   res = Net::HTTP.get_response(uri)
  # end

  def joinParams(path,params)
    url = "#{@config['oapi_host']}#{path}"
    if params.count > 0
      url = url + "?"
      params.each do |key,value|
        url = url + key.to_s + "=" + value.to_s + "&";
      end
      url.last == "&" &&  url.chop!
    end
    return url
  end

end
