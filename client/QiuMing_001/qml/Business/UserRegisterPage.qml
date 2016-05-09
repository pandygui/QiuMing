import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../Component"

Page {
    id: userRegisterPage
    backNavigationEnabled: false

    signal loginSuccess()

    Column {
        anchors.fill: parent
        anchors.margins: dp(10)
        spacing: dp (10)

        RowLayout {
            width: parent.width
            Image {
                height: userRegisterPage.width * 0.3
                width: userRegisterPage.width * 0.3
                sourceSize: Qt.size(userRegisterPage.width * 0.3, userRegisterPage.width * 0.3)
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
                height: userRegisterPage.width * 0.3
                width: userRegisterPage.width * 0.3
                sourceSize: Qt.size(userRegisterPage.width * 0.3, userRegisterPage.width * 0.3)
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

    AlertDialog {
        id: busyDialog
        mainWindow: app
        positiveActionLabel: "Yes"
        negativeActionLabel: "No"
        onCanceled: close()
        onAccepted: close()
    }

}
