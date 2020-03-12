class ApisController < ApplicationController

  def initialize
    @auth = AuthService.new
    @user = UserService.new
  end

  def index
    return render palin: 1
  end

  def getuserid
    accessToken = @auth.getAccessToken()
    code = params["code"]
    userInfo = @user.getUserInfo(accessToken, code)
    # Log::i("[USERINFO-getuserid]".json_encode($userInfo))
    if userInfo.present? && userInfo['errcode'] == 0
      sign_in Employee.find_by_userid userInfo['userid']
      # sign_in Employee.find_by_userid '130841175621040386'
    end
    render json: userInfo
  end

  def get_userinfo
    accessToken = @auth.getAccessToken()
    userid = params["userid"]
    userInfo = @user.get(accessToken, userid)
    # Log::i("[get_userinfo]".json_encode($userInfo));
    render json: userInfo
  end

  def get_department
    accessToken = @auth.getAccessToken()
    department = DepartmentService.new.listDept(accessToken)
    department_ids = DepartmentService.new.list_ids(accessToken)
    department_info = DepartmentService.new.department_info(accessToken)
    userlist = @user.list(accessToken, 66950253)
    # Log::i("[get_userinfo]".json_encode($userInfo));
    render json: department
  end

  def jsapi_oauth
    href = params["href"]
    configs = @auth.getConfig(href)
    configs['errcode'] = 0
    render json: configs
  end

  def send_message
    accessToken = @auth.getAccessToken()
    data = {
      "touser":130841175621040386,
      "agentid":180734473,
      "msgtype":"text",
      "text": {
        "content":"哈哈哈，测试消息#{Time.now}"
      }
    }
    msg = MessageService.new.send(accessToken,data)
    render plain: msg
  end

end


# <?php
# require_once(__DIR__ . "/config.php");
# require_once(__DIR__ . "/util/Log.php");
# require_once(__DIR__ . "/util/Cache.php");
# require_once(__DIR__ . "/api/Auth.php");
# require_once(__DIR__ . "/api/User.php");
# require_once(__DIR__ . "/api/Message.php");
#
# $auth = new Auth();
# $user = new User();
# $message = new Message();
#
# $event = $_REQUEST["event"];
# switch($event){
#     case '':
#         echo json_encode(array("error_code"=>"4000"));
#         break;
#     case 'getuserid':
#         $accessToken = $auth->getAccessToken();
#         $code = $_POST["code"];
#         $userInfo = $user->getUserInfo($accessToken, $code);
#         Log::i("[USERINFO-getuserid]".json_encode($userInfo));
#         echo json_encode($userInfo, true);
#         break;
#
#     case 'get_userinfo':
#         $accessToken = $auth->getAccessToken();
#         $userid = $_POST["userid"];
#         $userInfo = $user->get($accessToken, $userid);
#         Log::i("[get_userinfo]".json_encode($userInfo));
#         echo json_encode($userInfo, true);
#         break;
#     case 'jsapi-oauth':
#         $href = $_GET["href"];
#         $configs = $auth->getConfig($href);
#         $configs['errcode'] = 0;
#         echo json_encode($configs, JSON_UNESCAPED_SLASHES);
#         break;
# }
