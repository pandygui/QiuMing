import QtQuick 2.0
import Qt.WebSockets 1.0
import "./uuid.js" as UUID

Item {
    id: socket
    readonly property alias webSocket: webSocket
    property alias active: webSocket.active

    WebSocket {
        id: webSocket
        url: "ws://localhost:8080/QiuMing002/websocket"

        onStatusChanged: {
            console.log(status)
            switch(status) {
            case WebSocket.Connecting :
                console.debug("Connecting");
                break;
            case WebSocket.Open :
                console.debug("Open");
                break;
            case WebSocket.Closing :
                console.debug("Closing");
                break;
            case WebSocket.Closed :
                console.debug("Closed");
                break;
            case WebSocket.Error :
                console.debug("Error");
                break;
            }
        }

        //        onTextMessageReceived: {
        //            console.log(message);
        //        }

        onErrorStringChanged: {
            console.log(errorString)
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

}

