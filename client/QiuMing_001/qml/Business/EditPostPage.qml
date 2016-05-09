import VPlayApps 1.0

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

import "../Component"

/*
 * 查看帖子 收藏帖子 点赞帖子 删除帖子 举报帖子 帖子贴标签 赞同帖子的标签
 */

Page {
    id: editPostPage
    backNavigationEnabled: true

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

                        width: editPostPage.width - 2 * dp(16)
                        height: Math.max(textEdit.contentHeight, editPostPage.height * 0.9)
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
                        var __handle = function(messageObj) {
                            if(messageObj["result"] === "SUCCESS") {
                                console.log("发帖成功了");
                                busyDialog.exec("发帖成功了","发帖成功了");

                            } else {
                                console.log("发帖出错了:" + messageObj["message"]);
                                busyDialog.exec("发帖出错了",messageObj["message"]);
                            }
                        }
                        if(textEdit.text != "" ) {
                            if(titleEdit.text != "") {
                                if(textEdit.text.length > 4096) {
                                    busyDialog.exec("发帖失败","文章太长啦");
                                } else {
                                    socket.createPost(titleEdit.text,textEdit.text, __handle);
                                }
                            } else {
                                busyDialog.exec("标题为空","");
                            }
                        } else {
                            console.debug("内容为空");
                            busyDialog.exec("内容为空","");
                        }
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


    Component.onCompleted: {
        textEdit.forceActiveFocus();
    }
}

