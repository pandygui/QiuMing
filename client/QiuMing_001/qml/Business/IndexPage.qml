import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1

import "./delegate"

ListPage {
    id: page
    backNavigationEnabled: true
    emptyText.text: qsTr("首页")

    property int postIndex: 0
    property int postsSize: 10

    delegate: PostItemDelegate {
        id: itemDelegate

        width: parent.width
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
    }  // itemDelegate

    Component {
        id: postViewPageCom
        PostViewPage { }
    }

    function loadPosts(postIndex, postsSize) {
        var _getPosts = function(messageObj) {
            if(messageObj["result"] === "SUCCESS") {
                page.model = messageObj["posts"];
                console.log("装载成功：length", messageObj["posts"].length, "postIndex:",postIndex, "postsSize:", postsSize)
            } else {
                console.debug("装载失败：", JSON.stringify(messageObj));
            }
        }
        // 在整个帖子表中获取指定 index 和 size
        socket.getPostList(postIndex,
                           postsSize,
                           _getPosts);
    }

}

