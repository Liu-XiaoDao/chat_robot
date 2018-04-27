class ChatbotsController < ApplicationController
  def index

  end
  def show

  end

  def get_answer
    # require 'net/http'
    # require 'uri'

    uri = URI.parse("http://aiml.liuxiaodao.top/api.php?requestType=talk&userInput=#{params[:msg]}")
    request = Net::HTTP::Get.new(uri)
    request["Private-Token"] = "z23kiwuVJmQGkgz1ngsy"

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

# JSON.parse response.body
    render json: response.body

  end

end
