import QtQuick 2.0
import Qt.WebSockets 1.0
import "./uuid.js" as UUID
import "./Component"

Item {
    id: socket
    readonly property alias webSocket: webSocket
    property alias active: webSocket.active

    Lazyer { id: interLazyer }

    WebSocket {
        id: webSocket
        url: "ws://localhost:8080/QiuMing002/websocket"

        onStatusChanged: {
            switch(status) {
            case WebSocket.Connecting :
                console.debug("WebSocket status : Connecting");
                break;
            case WebSocket.Open :
                console.debug("WebSocket status : Open");
                break;
            case WebSocket.Closing :
                console.debug("WebSocket status : Closing");
                break;
            case WebSocket.Closed :
                console.debug("WebSocket status : Closed");
//                interLazyer.lazyDo(3*1000, function(){
//                    console.log("timeout and connect")
//                    webSocket.active = false;
//                    webSocket.active = true;
//                })
                break;
            case WebSocket.Error :
                console.debug("WebSocket status : Error");
//                interLazyer.lazyDo(3*1000, function(){
//                    console.log("timeout and connect")
//                    webSocket.active = false;
//                    webSocket.active = true;
//                })
                break;
            }
        }

        //        onTextMessageReceived: {
        //            console.log(message);
        //        }

        onErrorStringChanged: {
            console.log("WebSocket error: "+errorString)
        }

        function sendText(message, err) {
            if(webSocket.status == WebSocket.Open) {
                webSocket.sendTextMessage(message);
                //! Debug
                // console.debug(message);
            } else {
                err(webSocket.errorString);
            }
        }
    }

    // action -> { "action":"login", "username":"qyvlik", "password":"123456" }
    // callable(messageObj)
    // err(messageObj)
    function send(action, callable, err) {
        if(webSocket.active === false) {
            webSocket.active = true;
        }

        action = action || {};
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };

        var uuid = UUID.uuid();
        action.uuid = uuid;
        callable.uuid = uuid;
        err.uuid = uuid;

        webSocket.sendText(JSON.stringify(action), err);
        webSocket.textMessageReceived.connect(function(){
            var messageObj = JSON.parse(arguments[0]);
            if(messageObj["uuid"] === uuid ) {
                callable(messageObj);
                webSocket.textMessageReceived.disconnect(arguments.callee);
            }
        });
    }

    function login(username, password, callable, err) {
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "username": username,
            "password": password,
            "action": "login"
        }
        send(action, callable, err);
    }

    // 用户登出
    function logout(username, callable, err) {
        console.debug("action logout")
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "action": "logout",
            "username": username,
        }
        send(action, callable, err);
    }

    //    function enterUserCenter(userId, callable, err) {
    //        callable = callable || function(messageObj) {
    //            console.log(JSON.stringify(messageObj));
    //        };
    //        err = err || function(message) {
    //            console.log(message)
    //        };

    //        var action = {
    //            "action": "",
    //            "userId": userId
    //        };
    //        send(action, callable, err);
    //    }


    // 由于用户登录了，是在服务端记录登陆状态的，所以在客户端只管发送请求
    function getUserPostList(userId, index, size, callable, err) {
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "action": "getUserPostList",
            "userId": userId,
            "index": index,
            "size": size,
        };
        send(action, callable, err);
    }

    function getPostList(index, size, callable, err) {
        console.debug("action getPostList")
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "action": "getPostList",
            "index": index,
            "size": size,
        };
        send(action, callable, err);
    }

    // 由于用户登录了，是在服务端记录登陆状态的，所以在客户端只管发送请求
    // 点赞
    function parisePost(postId, callable, err) {
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "action": "parisePost",
            "postId": postId,
        };
        send(action, callable, err);
    }

    // 由于用户登录了，是在服务端记录登陆状态的，所以在客户端只管发送请求
    // 取消赞
    function unparisePost(postId, callable, err) {
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "action": "unparisePost",
            "postId": postId,
        };
        send(action, callable, err);
    }

    // 由于用户登录了，是在服务端记录登陆状态的，所以在客户端只管发送请求
    // 创建帖子
    function createPost(title, content, callable, err) {
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "action": "createPost",
            "title": title,
            "content": content,
        };
        send(action, callable, err);
    }

    // 由于用户登录了，是在服务端记录登陆状态的，所以在客户端只管发送请求
    // 修改帖子，还要传入 userId
    function modifyPost(userId, postId , title, content, callable, err) {
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "action": "modifyPost",
            "userId": userId,
            "postId": postId,
            "title": title,
            "content": content,
        };
        send(action, callable, err);
    }

    // 由于用户登录了，是在服务端记录登陆状态的，所以在客户端只管发送请求
    // 检查用户是否点赞了某篇帖子
    function checkUserParisePost(userId, postId, callable, err) {
        console.debug("action : checkUserParisePost")
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "action": "checkUserParisePost",
            "userId": userId,
            "postId": postId,
        };
        send(action, callable, err);
    }
    // 由于用户登录了，是在服务端记录登陆状态的，所以在客户端只管发送请求
    // 用户 userId 收藏 帖子 postId 到 收藏夹 favoriteName
    function favoritePost(userId, postId, favoriteName, callable, err) {
        console.debug("action : favoritePost")
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "action": "favoritePost",
            "userId": userId,
            "postId": postId,
            "favoriteName":favoriteName,
        };
        send(action, callable, err);
    }

    // 由于用户登录了，是在服务端记录登陆状态的，所以在客户端只管发送请求
    // 用户 userId 取消收藏 帖子 postId 到 收藏夹 favoriteName
    function unfavoritePost(userId, postId, favoriteName, callable, err) {
        console.debug("action : unfavoritePost")
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "action": "unfavoritePost",
            "userId": userId,
            "postId": postId,
            "favoriteName":favoriteName,
        };
        send(action, callable, err);
    }

    // 由于用户登录了，是在服务端记录登陆状态的，所以在客户端只管发送请求
    // 检查用户 userId 是否收藏 帖子 postId 到 收藏夹 favoriteName
    function checkUserFavoritePost(userId, postId, favoriteName, callable, err) {
        console.debug("action : checkUserFavoritePost")
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "action": "checkUserFavoritePost",
            "userId": userId,
            "postId": postId,
            "favoriteName":favoriteName,
        };
        send(action, callable, err);
    }

    // 由于用户登录了，是在服务端记录登陆状态的，所以在客户端只管发送请求
    // 获取用户 favoriteName 收藏夹下所有的帖子
    function getUserFavoriteList(userId, favoriteName, callable, err) {
        console.debug("action : getUserFavoriteList userId", userId)
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "action": "getUserFavoriteList",
            "favoriteName":favoriteName,
            "userId":userId,
        };
        send(action, callable, err);
    }

    // 由于用户登录了，是在服务端记录登陆状态的，所以在客户端只管发送请求
    // 一次性获取用户所有关注用户
    function getFriendList(userId, callable, err) {
        console.debug("action : getFriendList userId", userId)
        callable = callable || function(messageObj) {
            console.log(JSON.stringify(messageObj));
        };
        err = err || function(message) {
            console.log(message)
        };
        var action = {
            "action": "getFriendList",
            "userId": userId,
        };
        send(action, callable, err);
    }
}

