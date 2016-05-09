import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1

import "./delegate"

ListPage {
    id: favoritesPage

    property string userId

    model: []
    title: qsTr("收藏夹")

    backNavigationEnabled: true
    emptyText.text: qsTr("收藏夹为空")
    delegate: PostItemDelegate {
        id: itemDelegate
        anchors.horizontalCenter: parent.horizontalCenter

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

    listView.headerPositioning: ListView.OverlayHeader
    listView.spacing: dp(8)


    PullToRefreshHandler {
        listView: favoritesPage.listView
        onRefresh:{
            refreshing = true;
            __loadFavoriteList("默认收藏夹", function(){
                refreshing = false;
            });
        }
    }


    function __loadFavoriteList(favoriteName, callable) {
        callable = callable || function(){ };
        var _handle = function(messageObj) {
            if(messageObj["result"] === "SUCCESS") {
                favoritesPage.model = messageObj["favorites"];
            } else {
                console.debug("__loadFavoriteList error:",
                              JSON.stringify(messageObj));
            }
            callable();
        };
        socket.getUserFavoriteList(favoritesPage.userId, favoriteName, _handle);
    }


    Component.onCompleted: {
        __loadFavoriteList("默认收藏夹");
    }
}

