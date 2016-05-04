import VPlayApps 1.0

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

/*
 * 查看帖子 收藏帖子 点赞帖子 删除帖子 举报帖子 帖子贴标签 赞同帖子的标签
 */

Page {
    id: page
    backNavigationEnabled: true

    Item {
        anchors.fill: parent

        ScrollView {
            id: scrollView
            anchors.fill: parent
            anchors.bottomMargin: dp(48)

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

                    width: page.width - 2 * dp(16)
                    height: Math.max(textEdit.contentHeight, page.height * 0.9)
                    wrapMode: TextEdit.WrapAnywhere

                    selectByMouse: true
                    color: "#ababab"
                    verticalAlignment: TextEdit.AlignTop
                }
            }
        }

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
                spacing: 0
                AppButton {
                    text: "发布"
                    onClicked: {
                        var __handle = function(messageObj) {
                            if(messageObj["result"] === "SUCCESS") {
                                console.log("发帖成功了")
                            } else {
                                console.log("发帖出错了:"+messageObj["message"]);
                            }
                        }

                        // TODO
                        if(textEdit.text != "") {
                            socket.createPost("title",textEdit.text, __handle);
                        } else {
                            console.log("")
                        }
                    }
                }
                AppButton {
                    text: "预览"
                }
            }
        }
    }

    Component.onCompleted: {
        textEdit.forceActiveFocus();
    }
}

