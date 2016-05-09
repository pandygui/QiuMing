import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1

import "./delegate"

ListPage {
    id: indexPage
    backNavigationEnabled: true
    emptyText.text: qsTr("首页")

    // listView.backgroundColor: Theme.colors.backgroundColor

    property int postIndex: 0
    property int postsSize: 10

    //    // 添加新的
    //    listView.header: VisibilityRefreshHandler {
    //      onRefresh: {console.debug("添加新的")}
    //    }

    // 继续加载旧的
    listView.footer: VisibilityRefreshHandler {
        // TODO 万一数据库有新的插入，那么这种方式获取到的数据必定会重复的
        // 以后在解决吧
        onRefresh:{

            // 1. 先获取本次页面中的帖子数量
            // 2. 计算得出下一次请求的页面，size
            // 3. 如果获取到的是空，就提示用户，没有更多内容了。
            var pos = indexPage.listView.getScrollPosition() //retrieve scroll position data
            var startIndex = indexPage.model.length;
            postIndex = startIndex;
            console.debug("继续加载旧的");

            defaultAppActivityIndicatorVisible = true;
            var _getPosts = function(messageObj) {
                if(messageObj["result"] === "SUCCESS") {
                    console.log("装载成功：length", messageObj["posts"].length)
                    var newPosts =  messageObj["posts"];
                    if(newPosts.length !== 0) {
                        for(var iter in newPosts) {
                            indexPage.model.push(newPosts[iter]);
                            // 要主动通知视图
                            // 或者自行设计一个 ListModel
                            indexPage.modelChanged();
                            // 然后让 ListView 移动到startIndex
                            indexPage.listView.restoreScrollPosition(pos) //scrolls to the previous position
                        }
                    } else {
                        console.debug("没有更多的帖子了");
                    }
                } else {
                    console.debug("装载失败：", JSON.stringify(messageObj));
                }
                defaultAppActivityIndicatorVisible = false;
            }
            // 在整个帖子表中获取指定 index 和 size
            socket.getPostList(postIndex,
                               postsSize,
                               _getPosts);
            console.debug("加载完毕");
        }
    }

    listView.spacing: dp(8)


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
        }
    }  // itemDelegate

    Component {
        id: postViewPageCom
        PostViewPage { }
    }

    function loadPosts(postIndex, postsSize) {
        var _getPosts = function(messageObj) {
            if(messageObj["result"] === "SUCCESS") {
                indexPage.model = messageObj["posts"];
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

