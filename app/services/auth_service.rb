class AuthService

  def initialize
    @http = HttpService.new
    @cache = RedisService.new
    @config = YAML.load( File.read(Rails.root.to_s + "/config/dingconfig.yml"))
  end

  def getAccessToken
     # 缓存accessToken。accessToken有效期为两小时，需要在失效前请求新的accessToken（注意：以下代码没有在失效前刷新缓存的accessToken）。
    @accessToken = @cache.getCorpAccessToken();
    if @accessToken.blank?
      @response = @http.get('/gettoken?', {corpid: @config['corpid'], corpsecret: @config['secret']});
      @accessToken = @response['access_token']
      @cache.setCorpAccessToken(@accessToken);
    end
    return @accessToken;
  end


  def getTicket(accessToken)
    @jsticket = @cache.getJsTicket();
    if @jsticket.blank?
      @response = @http.get('/get_jsapi_ticket?', {type: 'jsapi', access_token: accessToken});
      # @this->check($response);
      @jsticket = @response['ticket'];
      @cache.setJsTicket(@jsticket);
    end
    return @jsticket;
  end

  def getConfig(href)
    corpId = @config['corpid'];
    agentId = @config['agentid'];
    nonceStr = 'abcdefg';
    timeStamp = Time.now.to_i;
    # url = urldecode(href);
    url = href
    corpAccessToken = getAccessToken();
    # if (!@corpAccessToken)
    # {
    #     Log::e("[getConfig] ERR: no corp access token");
    # }
    ticket = getTicket(corpAccessToken);
    signature = sign(ticket, nonceStr, timeStamp, url)

    config = {'url' => url,'nonceStr' => nonceStr,'agentId' => agentId, 'timeStamp' => timeStamp, 'corpId' => corpId, 'signature' => signature}
    return config
  end

  def sign(ticket, nonceStr, timeStamp, url)
    # require 'digest/sha1'
    # sha1 = Digest::SHA1.hexdigest('something secret')
    # plain = 'jsapi_ticket=' + ticket + '&noncestr=' + nonceStr + '&timestamp=' + timeStamp + '&url=' + url
    plain = "jsapi_ticket=#{ticket}&noncestr=#{nonceStr}&timestamp=#{timeStamp}&url=#{url}"
    return Digest::SHA1.hexdigest(plain);
  end

end

# <?php
# require_once(__DIR__ . "/../util/Http.php");
# require_once(__DIR__ . "/../util/Cache.php");
# require_once(__DIR__ . "/../util/Log.php");
# require_once(__DIR__ . "/../config.php");
#
# class Auth
# {
#     private $http;
#     private $cache;
#     public function __construct() {
#         $this->http = new Http();
#         $this->cache = new Cache();
#     }
#
#     public function getAccessToken()
#     {
        # /**
        #  * 缓存accessToken。accessToken有效期为两小时，需要在失效前请求新的accessToken（注意：以下代码没有在失效前刷新缓存的accessToken）。
        #  */
        # $accessToken = $this->cache->getCorpAccessToken('corp_access_token');
        # if (!$accessToken)
        # {
        #     $response = $this->http->get('/gettoken', array('corpid' => CORPID, 'corpsecret' => SECRET));
        #     $this->check($response);
        #     $accessToken = $response->access_token;
        #     $this->cache->setCorpAccessToken($accessToken);
        # }
        # return $accessToken;
#     }
#
#      /**
#       * 缓存jsTicket。jsTicket有效期为两小时，需要在失效前请求新的jsTicket（注意：以下代码没有在失效前刷新缓存的jsTicket）。
#       */
#     public function getTicket($accessToken)
#     {
#         $jsticket = $this->cache->getJsTicket('js_ticket');
#         if (!$jsticket)
#         {
#             $response = $this->http->get('/get_jsapi_ticket', array('type' => 'jsapi', 'access_token' => $accessToken));
#             $this->check($response);
#             $jsticket = $response->ticket;
#             $this->cache->setJsTicket($jsticket);
#         }
#         return $jsticket;
#     }
#
#
#     function curPageURL()
#     {
#         $pageURL = 'http';
#
#         if (array_key_exists('HTTPS',$_SERVER)&&$_SERVER["HTTPS"] == "on")
#         {
#             $pageURL .= "s";
#         }
#         $pageURL .= "://";
#
#         if ($_SERVER["SERVER_PORT"] != "80")
#         {
#             $pageURL .= $_SERVER["SERVER_NAME"] . ":" . $_SERVER["SERVER_PORT"] . $_SERVER["REQUEST_URI"];
#         }
#         else
#         {
#             $pageURL .= $_SERVER["SERVER_NAME"] . $_SERVER["REQUEST_URI"];
#         }
#         return $pageURL;
#     }
#
#     public function getConfig($href)
#     {
#         $corpId = CORPID;
#         $agentId = AGENTID;
#         $nonceStr = 'abcdefg';
#         $timeStamp = time();
#         $url = urldecode($href);
#         $corpAccessToken = $this->getAccessToken();
#         if (!$corpAccessToken)
#         {
#             Log::e("[getConfig] ERR: no corp access token");
#         }
#         $ticket = $this->getTicket($corpAccessToken);
#         $signature = $this->sign($ticket, $nonceStr, $timeStamp, $url);
#
#         $config = array(
#             'url' => $url,
#             'nonceStr' => $nonceStr,
#             'agentId' => $agentId,
#             'timeStamp' => $timeStamp,
#             'corpId' => $corpId,
#             'signature' => $signature);
#         return $config;
#     }
#
#
#     public function sign($ticket, $nonceStr, $timeStamp, $url)
#     {
#         $plain = 'jsapi_ticket=' . $ticket .
#             '&noncestr=' . $nonceStr .
#             '&timestamp=' . $timeStamp .
#             '&url=' . $url;
#         return sha1($plain);
#     }
#
#     function check($res)
#     {
#         if ($res->errcode != 0)
#         {
#             Log::e("FAIL: " . json_encode($res));
#             exit("Failed: " . json_encode($res));
#         }
#     }
# }
