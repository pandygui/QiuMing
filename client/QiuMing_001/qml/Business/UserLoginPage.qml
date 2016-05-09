import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../Component"

Page {
    id: userLoginPage
    backNavigationEnabled: false

    signal loginSuccess()

    Column {
        anchors.fill: parent
        anchors.margins: dp(10)
        spacing: dp (10)

        RowLayout {
            width: parent.width
            Image {
                height: userLoginPage.width * 0.3
                width: userLoginPage.width * 0.3
                sourceSize: Qt.size(userLoginPage.width * 0.3, userLoginPage.width * 0.3)
                Layout.alignment: Qt.AlignLeft
                source: password.activeFocus ? "../../assets/login/left-mask.png" : "../../assets/login/left.png"
                RippleMouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("try to connect");
                        socket.active = false;
                        socket.active = true;
                    }
                }
            }
            Item { Layout.fillWidth: true }
            Image {
                height: userLoginPage.width * 0.3
                width: userLoginPage.width * 0.3
                sourceSize: Qt.size(userLoginPage.width * 0.3, userLoginPage.width * 0.3)
                Layout.alignment: Qt.AlignRight
                source: password.activeFocus ? "../../assets/login/right-mask.png" : "../../assets/login/right.png"
            }
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

        Item {
            width: parent.width
            height: dp(56)
            AppButton {
                text: qsTr("登陆")
                anchors.left: parent.left
                onClicked: {
                    __login();
                }
            }
            AppButton {
                text: qsTr("注册")
                flat: true
                anchors.right: parent.right
                onClicked: {
                    console.debug("注册哦")
                }
            }
        }


    }

    AlertDialog {
        id: busyDialog
        mainWindow: app
        positiveActionLabel: "Yes"
        negativeActionLabel: "No"
        onCanceled: close()
        onAccepted: close()
    }

    function __login() {
        var __loginHandle = function (messageObj) {
            if(messageObj["result"] === "SUCCESS") {
                console.log("登陆成功");
                // console.log("messageObj: \n"+JSON.stringify(messageObj));

                //! 这里返回一些必要的数据
                // 设置用户数据
                userEntity.set(messageObj["user"]);

                busyDialog.close();
                loginSuccess();
                mainStack.pop();

                return;
            } else if(messageObj["result"] === "NONE") {
                console.log("没有此用户");
                busyDialog.exec("没有此用户","没有此用户");
            } else if(messageObj["result"] === "PASSWORD_FAIL") {
                console.log("密码错误");
                busyDialog.exec("密码错误","密码错误");
            } else {
                console.log("未知错误");
                busyDialog.exec("未知错误","未知错误");
            }

            lazyer.lazyDo(500, function(){
                busyDialog.close();
            });
        }

        var __err = function(message) {
            busyDialog.exec("服务器错误",message);
        }

        if(username.text == "") {
            busyDialog.exec("用户名不能为空","用户名不能为空");
            return;
        }
        if(password.text == "") {
            busyDialog.exec("密码不能为空","密码不能为空");
            return;
        }

        socket.login(username.text,
                     password.text,
                     __loginHandle,
                     __err);
    }
}
