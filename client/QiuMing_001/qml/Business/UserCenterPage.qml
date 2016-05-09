import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQml.Models 2.2

import "../Component"
import "./delegate"

Page {
    id: userCenterPage

    property string userId

    title: qsTr("用户中心")
    backNavigationEnabled: true

    rightBarItem: NavigationBarRow {
        //      ActivityIndicatorBarItem {
        //        visible: DataModel.loading
        //      }
        IconButtonBarItem {
            icon: IconType.plus
            title: "发帖"
            // 发帖
            onClicked: mainStack.push(editPostPageCom );
            showItem: showItemAlways
        }
        IconButtonBarItem {
            icon: IconType.tachometer
            title: "设置"
            showItem: showItemAlways
        }
    }

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
        socket.getUserPostList(userCenterPage.userId, 0, 10,function(messageObj){
            if(messageObj["result"] === "SUCCESS") {
                // console.debug(JSON.stringify(messageObj));
                postItem.posts = messageObj["posts"];
            } else {
                console.log(JSON.stringify(messageObj));
            }
        });
    }

    Component {
        id: postViewPageCom
        PostViewPage { }
    }

    Component {
        id: editPostPageCom
        EditPostPage { }
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
                delegate: PostItemDelegate {
                    id: itemDelegate
                    anchors.horizontalCenter: parent.horizontalCenter
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
                        console.log(itemDelegate.time)
                    }
                }  // itemDelegate
                listView.spacing: dp(8)
            }
        }

        NavigationItem {
            title: qsTr("关注")
            icon: IconType.users

            FriendsPage { userId: userCenterPage.userId }
        }
        NavigationItem {
            title: qsTr("收藏")
            icon: IconType.star

            FavoritesPage { userId: userCenterPage.userId }
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

