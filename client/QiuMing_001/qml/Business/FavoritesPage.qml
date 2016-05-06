import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1

import "./delegate"

ListPage {
    id: page
    model: []
    title: qsTr("收藏夹")

    backNavigationEnabled: true
    emptyText.text: qsTr("收藏夹为空")
    delegate: PostItemDelegate {
        id: itemDelegate

        width: parent.width
        onClicked: {
            // console.log("post id:"+itemDelegate.postId);
            var properties = {
                "author"        : itemDelegate.userId,
                "content"       : itemDelegate.content,
                "pariseNumber"  : itemDelegate.praiseNumber,
                "postId"        : itemDelegate.postId,
                "title"         : itemDelegate.title,
                "favoriteNumber": itemDelegate.favoriteNumber,
                "time"          : itemDelegate.time,
                "modifyTime"    : itemDelegate.modifyTime,
                "postState"     : itemDelegate.postState,
                "roleId"        : itemDelegate.roleId,
            };
            mainStack.push(postViewPageCom, properties );
        }
    }  // itemDelegate

    Component {
        id: postViewPageCom
        PostViewPage { }
    }

    listView.spacing: dp(8)

    listView.footer: VisibilityRefreshHandler {
        onRefresh:{
            defaultAppActivityIndicatorVisible = true;
            __loadFavoriteList("默认收藏夹", function(){
                defaultAppActivityIndicatorVisible = false;
            });
        }
    }

    function __loadFavoriteList(favoriteName, callable) {
        callable = callable || function(){ };
        var _handle = function(messageObj) {
            if(messageObj["result"] === "SUCCESS") {
                page.model = messageObj["favorites"];
            } else {
                console.debug("__loadFavoriteList error:", JSON.stringify(messageObj));
            }
            callable();
        };
        socket.getUserFavoriteList(favoriteName, _handle);
    }


    Component.onCompleted: {
        __loadFavoriteList("默认收藏夹");
    }
}

