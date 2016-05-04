import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1


Page {
    backNavigationEnabled: false

    Column {
        anchors.fill: parent
        anchors.margins: dp(10)
        spacing: dp (10)

        Image {
            source: "../../assets/login-001.png"
        }

        AppTextField {
            id: username
            anchors {
                right: parent.right
                left: parent.left
            }
            showClearButton: true
            text: "qyvlik"
        }

        Rectangle {
            anchors {
                right: parent.right
                left: parent.left
            }
            height: dp(1)
        }

        AppTextField {
            id: password
            anchors {
                right: parent.right
                left: parent.left
            }
            showClearButton: true
            echoMode: TextInput.Password
            text: "1403085871"
        }

        Rectangle {
            anchors {
                right: parent.right
                left: parent.left
            }
            height: dp(1)
        }

        AppButton {
            text: qsTr("登陆")
            anchors {
                right: parent.right
                left: parent.left
            }

            onClicked: {
                var __loginHandle = function (messageObj) {
                    if(messageObj["result"] === "SUCCESS") {
                        console.log("登陆成功");

                        console.log("messageObj: \n"+JSON.stringify(messageObj));

                        busyDialog.close();
                        mainStack.pop();
                        return;
                    } else if(messageObj["result"] === "NONE") {
                        console.log("没有此用户");
                        busyDialog.title = "没有此用户";
                    } else if(messageObj["result"] === "PASSWORD_FAIL") {
                        console.log("密码错误");
                        busyDialog.title = "密码错误";
                    } else {
                        console.log("未知错误");
                        busyDialog.title = "未知错误";
                    }

                    lazyer.lazyDo(500, function(){
                        busyDialog.close();
                    });
                }
                if(username.text == "") {
                    busyDialog.title = "用户名不能为空";
                    return;
                }
                if(password.text == "") {
                    busyDialog.title = "密码不能为空";
                    return;
                }
                busyDialog.open();

                socket.login(username.text,
                             password.text,
                             __loginHandle);
            }
        }
    }

    Dialog {
        id: busyDialog
        mainWindow: app
        title: "Waiting..."
        positiveActionLabel: "Yes"
        negativeActionLabel: "No"
        onCanceled: title = "Think again!"
        onAccepted: close()
    }
}
