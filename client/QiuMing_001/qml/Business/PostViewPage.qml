import VPlayApps 1.0

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

import "../Component"

import org.gdpurjyfs.markdown 1.0

/*
 * 查看帖子 收藏帖子 点赞帖子 删除帖子 举报帖子 帖子贴标签 赞同帖子的标签
 * 获取此帖作者
 */

Page {
    id: postViewPage
    backNavigationEnabled: true

    property string     author
    // title
    property string     content
    property string     pariseNumber
    property string     postId
    property string     praiseNumber
    property string     favoriteNumber
    property string     time
    property string     modifyTime
    property int        postState				// 帖子审核状态，0 ： 不通过，1 ： 通过
    property string     roleId                  // 1 帖子 2 发车

    property bool       __pariseThisPost: false       // 使用本应用的用户是否点赞了此篇帖子
    property bool       __favoriteThisPost: false     // 使用本应用的用户是否收藏了此篇帖子

//    Component {
//        id: userCenterPageCom
//        url: "./UserCenterPage.qml"
//    }

    HoedownMarkdownConverter{
        id: converter
    }

    rightBarItem: NavigationBarRow {
        //      ActivityIndicatorBarItem {
        //        visible: DataModel.loading
        //      }
        showMoreButton: true
        IconButtonBarItem {
            icon: IconType.exclamationtriangle
            title: "举报"
            // 发帖
            onClicked: {
                InputDialog
                .inputTextSingleLine(app,
                                     "您的举报理由是？", //message text
                                     "输入举报理由",         //placeholder text
                                     function(ok, text) {
                                         if(ok) {
                                             if(text !== "") {
                                                 __complainPost(text);
                                                 console.debug("您的举报理由是", text);
                                             } else {
                                                 console.debug("举报理由不能为空");
                                                 messageDialog.exec("举报理由不能为空", "举报理由不能为空");
                                             }
                                         }
                                     })
            }
            showItem: showItemNever             // 收到菜单中
        }

        IconButtonBarItem {
            icon: IconType.user
            title: "用户资料"
            showItem: showItemIfRoom
            onClicked: {
                console.debug("打开帖子作者的页面")
                var properties = {
                    "userId": postViewPage.author
                };
                // TODO 因为 UserCenterPage 里包含 PostViewPage
                mainStack.push(Qt.createComponent("./UserCenterPage.qml"), properties)
            }
        }

        IconButtonBarItem {
            icon: IconType.sharealt
            title: "分享"
            showItem: showItemIfRoom
            onClicked: {
                console.debug("分享")
            }
        }
    }

    Component {
        id: modifyPostPageCom
        ModifyPostPage { }
    }

    Item {
        anchors.fill: parent

        ScrollView {
            id: scrollView
            anchors.fill: parent
            anchors.bottomMargin: dp(55)
            horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            // verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff

            flickableItem.interactive: true
            flickableItem.boundsBehavior: Flickable.StopAtBounds
            Rectangle {
                // width: textEdit.height > page.height * 0.9 ? page.width : page.width - dp(16)
                width: scrollView.width
                height: contentView.height
                color: "#434343"
                AppText {
                    id: contentView
                    baseUrl: "."

                    anchors.top: parent.top
                    anchors.topMargin: dp(16)
                    anchors.horizontalCenter: parent.horizontalCenter

                    width: postViewPage.width - 2 * dp(16)
                    height: Math.max(contentView.contentHeight, postViewPage.height * 0.9)
                    wrapMode: TextEdit.WrapAnywhere

                    elide: Text.ElideNone
                    text: converter.markdown2html(postViewPage.content)
                    textFormat: Text.RichText
                    verticalAlignment: TextEdit.AlignTop
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

                layoutDirection: Qt.RightToLeft

                 // 查看评论表
                 IconButton {
                     id: commentButton
                     icon: IconType.commentso
                     selectedIcon: IconType.comments

                     color: Theme.listItem.activeTextColor
                     selectedColor: Theme.listItem.activeTextColor

                     onClicked: {
                         // TODO
                         console.debug("查看评论");
                     }
                 } // commentButton

                 // 修改
                 IconButton {
                     id: editButton
                     icon: IconType.pencilsquareo
                     selectedIcon: IconType.pencilsquare

                     color: Theme.listItem.activeTextColor
                     selectedColor: Theme.listItem.activeTextColor

                     visible: userEntity.userId === author

                     onClicked: {
                         //                        console.log("userEntity uesrId:", userEntity.userId )
                         //                        console.log("author :", author);

                         var properties = {
                             "postId"      :      postId,
                             "postTitle"   :      title,
                             "postContent" :      content,
                         }
                         mainStack.push(modifyPostPageCom, properties);
                     }
                 } // editButton


                Row {
                    IconButton {
                        id: parise
                        anchors.verticalCenter: parent.verticalCenter

                        toggle: true
                        icon: IconType.hearto
                        selectedIcon: IconType.heart

                        color: Theme.listItem.activeTextColor
                        selectedColor: Theme.listItem.activeTextColor

                        onClicked: __toggleParise();
                    }
                    AppText {
                        anchors.verticalCenter: parent.verticalCenter
                        text: pariseNumber
                    }
                }
                // IconType{}
                // 收藏
                IconButton {
                    id: favoriteButton

                    toggle: true
                    icon: IconType.staro
                    selectedIcon: IconType.star

                    color: Theme.listItem.activeTextColor
                    selectedColor: Theme.listItem.activeTextColor

                    onClicked: __toggleStar();
                }
            }
        }
    }

    AlertDialog {
           id: messageDialog
           mainWindow: app
           positiveActionLabel: "好的"
           onAccepted: {
                messageDialog.close();
           }
       }

       function __complainPost(reason) {
           var _handle = function(messageObj) {
               if(messageObj["result"] === "SUCCESS") {
                   console.debug("举报成功")
                   messageDialog.exec("举报成功", "举报成功");
               } else if(messageObj["result"] === "DUPLICATE" ) {
                   console.debug("重复举报")
                   messageDialog.exec("重复举报", "重复举报");
               } else {
                   console.debug("举报失败")
                   messageDialog.exec("举报失败", "举报失败");
               }

           }
           socket.complainPost(postId, reason, _handle);
       }

    function __toggleParise() {
        // 已经点赞过了
        var _pariseHandle = function(messageObj) {
            if(messageObj["result"] === "SUCCESS") {
                pariseNumber = messageObj["pariseNumber"];
                __pariseThisPost = true;
            } else {
                console.debug("pariseHandle 出错");
                console.debug(JSON.stringify(messageObj))
            }
            parise.selected = __pariseThisPost;
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
            parise.selected = __pariseThisPost;
        };

        if(__pariseThisPost) {
            socket.unparisePost(postId, _unpariseHandle);
        } else {
            socket.parisePost(postId, _pariseHandle);
        }
    }

    // 收藏
    // 不过现在先默认收藏到默认收夹
    function __toggleStar() {
        // 已经收藏过了
        var _favoriteHandle = function(messageObj) {
            if(messageObj["result"] === "SUCCESS") {
                __favoriteThisPost = true;
            } else {
                console.debug("_favoriteHandle 出错");
                console.debug(JSON.stringify(messageObj))
            }
            favoriteButton.selected = __favoriteThisPost;
        };

        // 还没有收藏
        var _unfavoriteHandle = function(messageObj) {
            if(messageObj["result"] === "SUCCESS") {
                __favoriteThisPost = false;
            } else {
                console.debug("_unfavoriteHandle 出错");
                console.debug(JSON.stringify(messageObj))
            }
            favoriteButton.selected = __favoriteThisPost;
        };

        if(__favoriteThisPost) {
            socket.unfavoritePost(userEntity.userId, postId, "默认收藏夹", _unfavoriteHandle);
        } else {
            socket.favoritePost(userEntity.userId, postId, "默认收藏夹", _favoriteHandle);
        }
    }

    Component.onCompleted: {
        // 传入的是当前使用应用的用户 id
        // 本页面的 postId

        // 检查用户师是否点赞，并且自动更新 pariseNumber
        var _handle1 = function(messageObj){
            // pariseNumber = messageObj["pariseNumber"];
            if(messageObj["result"] === "SUCCESS") {
                // 已经点赞过
                __pariseThisPost = true;
                pariseNumber = messageObj["pariseNumber"];
                console.log("已经点赞过了", messageObj["pariseNumber"]);

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

            parise.selected = __pariseThisPost;
        };

        var _handle2 = function(messageObj) {
            // console.log("back uuid:", messageObj["uuid"]);
            if(messageObj["result"] === "SUCCESS") {
                // 已经收藏过
                __favoriteThisPost = true;
                console.log("已经收藏过");

            } else if(messageObj["result"] === "NONE") {
                // 还未点赞过
                __favoriteThisPost = false;
                console.log("还未收藏过");
            } else {
                // 服务器出错了。
                console.log("aciton:checkUserFavoritePost", messageObj["message"]);
                __favoriteThisPost = false;
                console.log("服务器出错了。");
            }

            favoriteButton.selected = __favoriteThisPost;
        }

        socket.checkUserParisePost(userEntity.userId, postId, _handle1);
        socket.checkUserFavoritePost(userEntity.userId, postId, "默认收藏夹", _handle2);

    }
}

