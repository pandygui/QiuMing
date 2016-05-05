import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1


Page {
    id: page
    backNavigationEnabled: false

    signal loginSuccess()

    Column {
        anchors.fill: parent
        anchors.margins: dp(10)
        spacing: dp (10)

        RowLayout {
            width: parent.width
            Image {
                height: page.width * 0.3
                width: page.width * 0.3
                sourceSize: Qt.size(page.width * 0.3, page.width * 0.3)
                Layout.alignment: Qt.AlignLeft
                source: password.activeFocus ? "../../assets/login/left-mask.png" : "../../assets/login/left.png"
            }
            Item { Layout.fillWidth: true }
            Image {
                height: page.width * 0.3
                width: page.width * 0.3
                sourceSize: Qt.size(page.width * 0.3, page.width * 0.3)
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

        Row {
            width: parent.width
            AppButton {
                text: qsTr("登陆")
                Layout.alignment: Qt.AlignLeft
                onClicked: {
                    __login();
                }
            }
            AppButton {
                text: qsTr("注册")
                flat: true
                Layout.alignment: Qt.AlignRight
                onClicked: {
                    console.debug("注册哦")
                }
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

    function __login() {
        var __loginHandle = function (messageObj) {
            if(messageObj["result"] === "SUCCESS") {
                console.log("登陆成功");
                // console.log("messageObj: \n"+JSON.stringify(messageObj));

                //! 这里返回一些必要的数据

                userEntity.set(messageObj["user"]);

                busyDialog.close();
                loginSuccess();
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

        var __err = function(message) {
            busyDialog.title = message;
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
                     __loginHandle,
                     __err);
    }
}
