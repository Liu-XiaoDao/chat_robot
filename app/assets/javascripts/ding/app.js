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

    function parseCorpId(url, param) {
        var searchIndex = url.indexOf('?');
        var searchParams = url.slice(searchIndex + 1).split('&');
        for (var i = 0; i < searchParams.length; i++) {
            var items = searchParams[i].split('=');
            if (items[0].trim() == param) {
                return items[1].trim();
            }
        }
    }
    function openLink(url, corpId){
        if(corpId && typeof corpId === 'string'){
            if (url && url.indexOf('$CORPID$') !== -1) {
                url = url.replace(/\$CORPID\$/, corpId);
            }
        }
        if (isDingtalk) {
            dd.biz.util.openLink({
                url: url,
                onSuccess: function(){
                    if(typeof corpId === 'function'){
                        corpId();
                    }
                },
                onFail: function(){
                    if(typeof corpId === 'function'){
                        corpId();
                    }
                }
            });
        } else {
            window.open(url);
        }
    }

    function updateName(){
        var dateTime = new Date().getHours();
        var isAdmin = proper.userInfo.isAdmin;
        var name = proper.userInfo.name;
        var nb = {};
        if(name){
            if (dateTime >= 5 && dateTime <= 12) {
                nb.wh = isAdmin ? '早上好，管理员，' + name : '早上好，' + name;
            } else if (dateTime > 12 && dateTime <= 18) {
                nb.wh = isAdmin ? '下午好，管理员，' + name : '下午好，' + name;
            } else {
                nb.wh = isAdmin ? '晚上好，管理员，' + name : '晚上好，' + name;
            }
        }
        return nb;
    }

    function updateUI(){
        var nb = updateName();
        var html = nb.wh;
        $('.username').html(html);
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

        $('.username').on('click',function(){
          url = 'https://alimarket.m.taobao.com/markets/dingtalk/cydd?lwfrom=20161118115327653';
          openLink(url);
        });
        dd.error(function(err){
            alert(JSON.stringify(err));
        });
        var originalUrl = location.href;
        var corpId = parseCorpId(originalUrl, 'corpId');
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


        var signRequest1 = {
            url: OPENAPIHOST + '/apis/get_department',
            type: 'GET',
            dataType: 'json',
            success: function(response){
              $('.department').html(22222);
                if (response.errcode === 0){
                    alert(response);
                } else {
                    alert(JSON.stringify(response) + 'sign');
                }
            },
            error: function(){

            }
        };
        $.ajax(signRequest1);

    });
})();
