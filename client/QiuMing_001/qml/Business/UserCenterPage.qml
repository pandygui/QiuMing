import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQml.Models 2.2

import "../Component"

Page {
    id: page

    // socket
    backNavigationEnabled: true

    //    titleItem: Item {
    //        id: header
    //        // 用户中心
    //        width: page.width
    //        height: page.width * 0.6

    //        AppImage {
    //            anchors.fill: parent
    //            defaultSource: "../../assets/vplay-logo.png"
    //            source: "../../assets/drawer-head-background.jpg"
    //        }

    //        ColumnLayout {
    //            anchors.fill: parent
    //            anchors.margins: dp(16)
    //            AnimatedImage {
    //                source: "../../assets/loadTV.gif"
    //            }
    //            AppText {
    //                text: userEntity.username
    //            }
    //        }
    //    } // headerView


    Component.onCompleted: {
        socket.getUserPostList(0, 10,function(messageObj){
            if(messageObj["result"] === "SUCCESS") {
                console.log(JSON.stringify(messageObj));
                postItem.posts = messageObj["posts"];
            } else {
                console.log(JSON.stringify(messageObj));
            }
        });
    }

    // socket
    TabControl {
        // tabPosition: Qt.TopEdge
        NavigationItem {
            id: postItem
            title: qsTr("帖子")
            icon: IconType.file

            property var posts: []

            ListPage {
                model: postItem.posts
                delegate: Rectangle {
                    color: "transparent"
                    border.color: "#ccc"
                    border.width: 1
                    id: itemDelegate

                    property var    item                : modelData
                    property string content             : item && item.content
                    property string favoriteNumber      : item && item.favoriteNumber
                    property string postId              : item && item.id
                    property string praiseNumber        : item && item.praiseNumber
                    property string roleId              : item && item.roleId
                    property string postState           : item && item.state
                    property string time                : item && item.time
                    property string title               : item && item.title
                    property string userId              : item && item.userId
                    property string modifyTime          : item && item.modifyTime           //

                    width: parent.width

                    height: column.childrenRect.height

                    Column {
                        id: column
                        width: parent.width
                        spacing: dp(5)
                        AppText {
                            width: parent.width
                            text: itemDelegate.title
                            elide: Text.ElideRight
                        }

                        AppText {
                            width: parent.width
                            text: itemDelegate.content
                            elide: Text.ElideRight
                        }

                        AppText {
                            width: parent.width
                            text: itemDelegate.time
                            elide: Text.ElideRight
                        }
                    }

                    RippleMouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("post id:"+itemDelegate.postId);
                            var properties = {
                                "author"        : itemDelegate.userId,
                                "content"       : itemDelegate.content,
                                "pariseNumber"  : itemDelegate.praiseNumber,
                                "postId"        : itemDelegate.postId,
                                "title"         : itemDelegate.title,
                                "favoriteNumber": itemDelegate.favoriteNumber,
                                "time"          :itemDelegate.time,
                                "modifyTime"    :itemDelegate.modifyTime,
                                "postState"     :itemDelegate.postState,
                                "roleId"        :itemDelegate.roleId,
                            };
                            mainStack.push(postViewPageCom, properties );
                        }
                    }
                } // itemDelegate

                Component {
                    id: postViewPageCom
                    PostViewPage { }
                }

                Component {
                    id: editPostPageCom
                    EditPostPage { }
                }

                AppButton {
                    text: "发帖"
                    onClicked: {
                        mainStack.push(editPostPageCom );
                    }
                }

            }
        }

        NavigationItem {
            title: qsTr("关注")
            icon: IconType.users

            FocusPage { }
        }
        NavigationItem {
            title: qsTr("收藏")
            icon: IconType.star

            FavoritesPage { }
        }
        NavigationItem {
            title: qsTr("私信")
            icon: IconType.male

            ListPage {
                emptyText.text: qsTr("私信")
                model: 10
            }
        }
    }

}

