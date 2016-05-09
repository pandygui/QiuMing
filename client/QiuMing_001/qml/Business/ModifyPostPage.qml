import VPlayApps 1.0

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

import "../Component"

Page {
    id: modifyPostPage
    title: qsTr("修改帖子")
    backNavigationEnabled: true

    property string     postId
    property alias      postTitle   :      titleEdit.text
    property alias      postContent :      textEdit.text

    Item {
        anchors.fill: parent

        ColumnLayout {
            //            width: parent.width
            //            height: parent.height

            anchors.fill: parent
            anchors.bottomMargin: dp(48)

            spacing: dp(6)

            AppTextField {
                id: titleEdit
                Layout.fillWidth: true
                Layout.rightMargin: dp(16)
                Layout.leftMargin: dp(16)
                placeholderText: qsTr("请输入标题")
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.rightMargin: dp(16)
                Layout.leftMargin: dp(16)
                height: dp(1)
                color: "#ccc"
            }

            ScrollView {
                id: scrollView
                Layout.fillWidth: true
                Layout.fillHeight: true

                horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
                // verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff

                flickableItem.interactive: true
                flickableItem.boundsBehavior: Flickable.StopAtBounds

                Rectangle {
                    // width: textEdit.height > page.height * 0.9 ? page.width : page.width - dp(16)
                    width: scrollView.width
                    height: textEdit.height
                    color: "#434343"

                    AppTextEdit {
                        id: textEdit
                        focus: true

                        anchors.top: parent.top
                        anchors.topMargin: dp(16)
                        anchors.horizontalCenter: parent.horizontalCenter

                        width: modifyPostPage.width - 2 * dp(16)
                        height: Math.max(textEdit.contentHeight, modifyPostPage.height * 0.9)
                        wrapMode: TextEdit.WrapAnywhere

                        selectByMouse: true
                        color: "#ababab"
                        verticalAlignment: TextEdit.AlignTop
                    }
                }
            }
        } // ColumnLayout

        Rectangle {
            id: editBar
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            width: parent.width
            height: dp(56)
            color: "#434343"

            Row {
                anchors.fill: parent
                anchors.rightMargin: dp(16)
                anchors.leftMargin: dp(16)
                AppButton {
                    text: "发布"
                    onClicked: {
                        __modifyPost();
                    }
                }
                AppButton {
                    text: "预览"
                }
            }
        }
    }

    AlertDialog {
        id: busyDialog
        mainWindow: app
        positiveActionLabel: "我不写了"
        negativeActionLabel: "继续修改"
        onCanceled: {
            busyDialog.close();
        }
        onAccepted: {
            mainStack.pop();
        }
    }


    function __modifyPost() {
        var _handle  = function(messageObj) {
            if(messageObj["result"] === "SUCCESS") {
                busyDialog.exec("修改成功", "修改成功")
                busyDialog.positiveActionLabel = "好的";
                console.debug("修改成功");
            } else if(messageObj["result"] === "NONE") {
                busyDialog.exec("没有这篇文章", "没有这篇文章");
                console.debug("没有这篇文章");
            } else {
                busyDialog.exec("未知错误", "未知错误");
                console.debug("未知错误");
            }
        }
        socket.modifyPost(userEntity.userId, postId, postTitle, postContent, _handle);
    }

    Component.onCompleted: {
        textEdit.forceActiveFocus();
    }
}

