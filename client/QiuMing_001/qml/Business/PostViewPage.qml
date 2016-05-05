import VPlayApps 1.0

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

/*
 * 查看帖子 收藏帖子 点赞帖子 删除帖子 举报帖子 帖子贴标签 赞同帖子的标签
 */

Page {
    id: postViewPage
    backNavigationEnabled: true

    property string     author
    // title
    property string     content
    property string     pariseNumber
    property string     postId
    property string     title
    property string     praiseNumber
    property string     favoriteNumber
    property string     time
    property string     modifyTime
    property int        postState				// 帖子审核状态，0 ： 不通过，1 ： 通过
    property string     roleId                  // 1 帖子 2 发车

    property bool __pariseThisPost: false       // 使用本应用的用户是否点赞了此片帖子

    Item {
        anchors.fill: parent

        ScrollView {
            id: scrollView
            anchors.fill: parent
            anchors.bottomMargin: dp(48)
            horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            // verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff

            flickableItem.interactive: true
            flickableItem.boundsBehavior: Flickable.StopAtBounds
            Item {
                width: parent.width
                height: contentView.contentHeight
                AppText {
                    id: contentView
                    width: parent.width
                    elide: Text.ElideNone
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    text: postViewPage.content
                }
            }
        }

        Rectangle {
            id: bar
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            width: parent.width
            height: dp(56)
            color: "#434343"

            Row {
                anchors.fill: parent
                anchors.rightMargin: dp(16)
                anchors.leftMargin: dp(16)

                Row {
                    IconButton {
                        id: check
                        anchors.verticalCenter: parent.verticalCenter
                        toggle: true
                        icon: IconType.hearto
                        selectedIcon: IconType.heart
                        onToggled: {
                            // 已经点赞过了
                            var _pariseHandle = function(messageObj) {
                                if(messageObj["result"] === "SUCCESS") {
                                    pariseNumber = messageObj["pariseNumber"];
                                    __pariseThisPost = true;

                                } else {
                                    console.debug("pariseHandle 出错");
                                    console.debug(JSON.stringify(messageObj))
                                }
                            };

                            // 还没有点赞过
                            var _unpariseHandle = function(messageObj) {
                                if(messageObj["result"] === "SUCCESS") {
                                    pariseNumber = messageObj["pariseNumber"];
                                    __pariseThisPost = false;
                                } else {
                                    console.debug("unpariseHandle 出错");
                                    console.debug(JSON.stringify(messageObj))
                                }
                            };

                            if(__pariseThisPost) {
                                socket.unparisePost(postId, _unpariseHandle);
                            } else {
                                socket.parisePost(postId, _pariseHandle);
                            }
                        }
                    }
                    AppText {
                        anchors.verticalCenter: parent.verticalCenter
                        text: pariseNumber
                    }
                }
                AppButton {
                    text: "收藏"
                }
            }
        }
    }

    Component.onCompleted: {
        // 传入的是当前使用应用的用户 id
        // 本页面的 postId
        var _handle = function(messageObj){

            if(messageObj["result"] === "SUCCESS") {
                // 已经点赞过
                __pariseThisPost = true;
                console.log("已经点赞过了");
            } else if(messageObj["result"] === "NONE") {
                // 还未点赞过
                __pariseThisPost = false;
                console.log("还未点赞过");
            } else {
                // 服务器出错了。
                console.log("aciton:checkUserParisePost", messageObj["message"]);
                __pariseThisPost = false;
                console.log("服务器出错了。");
            }
        };
        socket.checkUserParisePost(userEntity.userId, postId, _handle);
    }
}

