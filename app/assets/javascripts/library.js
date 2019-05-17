(function(){
    var OPENAPIHOST = 'http://'+location.host;
    var isDingtalk = /DingTalk/.test(navigator.userAgent);
    var proper = {};
    var _userId = '';
    var _userInfo = {};
    Object.defineProperty(proper,'userId',{
        enumerable: true,
        get: function(){
            return _userId;
        },
        set: function(newValue){
            _userId = newValue;
            getUserInfo(proper.userId);
        }
    });
    Object.defineProperty(proper, 'userInfo',{
        enumerable: true,
        get: function(){
            return _userInfo;
        },
        set: function(newValue){
            _userInfo = newValue;
            updateUI();
        }
    });

    function updateUI(){
        var avatar_url = proper.userInfo.avatar
        $('#nav-avatar').attr('src', avatar_url);
        alert("登录成功");
        // $('#info').html(JSON.stringify(proper.userInfo));
    }

    function getUserId(corpId){
        authCode(corpId).then(function(result){
            var code = result.code;
            var getUserIdRequest = {
                url: OPENAPIHOST + '/apis/getuserid',
                type: 'POST',
                data:{code:code},
                dataType: 'json',
                success: function(response){
                  console.log(response);
                    if (response.errcode === 0){
                        proper.userId = response.userid;
                    } else {
                        alert(JSON.stringify(response) + 'getuserid');
                    }
                },
                error: function(err){
                    alert(JSON.stringify(err));
                }
            }
            $.ajax(getUserIdRequest);
        }).catch(function(error){
            alert(JSON.stringify(error));
        });
    }

    function authCode(corpId){
        return new Promise(function(resolve, reject){
            dd.ready(function(){
                dd.runtime.permission.requestAuthCode({
                    corpId: corpId,
                    onSuccess: function(result) {
                        resolve(result);
                    },
                    onFail : function(err) {
                        reject(err);
                    }
                });
            });
        });
    }

    function getUserInfo(userid){
        var getUserInfoRequest = {
            url: OPENAPIHOST + '/apis/get_userinfo?userid='+userid,
            type: 'POST',
            data:{userid:userid},
            dataType: 'json',
            success: function(response){
                if (response.errcode === 0){
                    proper.userInfo = response;
                } else {
                    alert(JSON.stringify(response) + 'getUserInfo');
                }
            },
            error: function(err){

            }
        };
        $.ajax(getUserInfoRequest);
    }

    $(function(){
        dd.error(function(err){
            alert(JSON.stringify(err));
        });
        var originalUrl = location.href;

        var corpId = "ding4e97ac09cf15a1d2";
        var jsApiList = [];
        var signRequest = {
            url: OPENAPIHOST + '/apis/jsapi_oauth?href='+encodeURIComponent(location.href),
            type: 'GET',
            dataType: 'json',
            success: function(response){
                if (response.errcode === 0){
                    config = {
                        agentId: response.agentId || '',
                        corpId: response.corpId || '',
                        timeStamp: response.timeStamp || '',
                        nonceStr: response.nonceStr || '',
                        signature: response.signature || '',
                        jsApiList: jsApiList || []
                    };
                    dd.config(config);
                    getUserId(corpId);
                } else {
                    alert(JSON.stringify(response) + 'sign');
                }
            },
            error: function(){

            }
        };
        $.ajax(signRequest);
    });
})();
