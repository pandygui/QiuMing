import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1

ListPage {
    id: friendsPage

    property string userId

    title: qsTr("关注的人")
    backNavigationEnabled: true
    emptyText.text: qsTr("太宅了以至于没有关注的人")

    //    delegate: Item {
    //        // 展示用户
    //        id: userItemDelegate
    //        property var    item            : modelData
    //        property string userId          : item && item.userId
    //        property string username        : item && item.username
    //        property string pickname        : item && item.pickname
    //        property string email           : item && item.email
    //        property string telephone       : item && item.telephone
    //        property int    age             : item && item.userId
    //        property string address         : item && item.address
    //        property string experience      : item && item.experience
    //        property string sex             : item && item.sex
    //        property int    roleId          : item && item.roleId
    //        property string roleName        : item && item.roleName
    //        property string introduction    : item && item.introduction
    //    }


    // 这里比较特殊
    model: ListModel {
        id: friendsModel
        //        ListElement {
        //            text: "用户名"
        //            image: "../../assets/b012382ac65c10384cbc2176b1119313b17e8902.png"
        //        }
    }

    listView.headerPositioning: ListView.OverlayHeader

    PullToRefreshHandler {
        listView: friendsPage.listView
        // pullToRefreshEnabled: page.listView.contentY < 0
        onRefresh:{
            refreshing = true;
            __loadFriendList(function(){
                refreshing = false;
            });
        }
    }

    // define the SwipeOptionsContainer as delegate
    delegate: SwipeOptionsContainer {
        id: container
        function getModelData(listviewModel) {
            // number
            // list<QtObject>
            // ListModel
            // Array
            try {
                // modelData 适用与 list<QtObject> 类型， js 数组类型，数字等
                // 注意 QtObject* 除 QAbstractItemModel* 外都会转换成 list<QtObject> 这种类型

                // console.debug(typeof modelData)
                return modelData;
            } catch(e) {
                return listviewModel.get(index);
            }
        }
        property var item: getModelData(ListView.view.model)

        // property var    item            : modelData
        //        property string text            : item && item.text
        //        property string detailText      : item && item.detailText
        //        property string icon            : item && item.icon
        //        property url    image           : item && item.image
        //        property bool   active          : item && item.active
        //        property bool   visible         : item && item.visible
        //        property bool   enabled         : item && item.enabled

        SimpleRow {                         //actual content to be displayed in the list rows
            id: row
            item: container.item
            image.radius: dp(20)
            image.img.defaultSource: Qt.resolvedUrl("../../assets/default_user_head_portrait.jpg")
        }

        rightOption: SwipeButton {           // right options, displayed when swiped list row to the right
            text: qsTr("私信")
            icon: IconType.comments
            height: row.height
            onClicked: {
                container.hideOptions()         //hide automatically when button clicked
            }
        }

    } // SwipeOptionsContainer

    function __loadFriendList(callable) {
        callable = callable || function(){};
        var _callable = function(messageObj){
            if(messageObj["result"] === "SUCCESS") {
                friendsModel.clear();
                // friends
                for(var iter in messageObj["friends"]) {
                    var d = {
                        // TODO
                        image: Qt.resolvedUrl("../../../assets/b012382ac65c10384cbc2176b1119313b17e8902.png"),
                        text: messageObj["friends"][iter]["username"]
                    };
                    console.log(JSON.stringify(d));
                    friendsModel.append(d);
                    console.debug("append a friend");
                }
            } else {
                console.debug("获取列表出错", JSON.stringify(messageObj));
            }

            callable();
        };
        socket.getFriendList(friendsPage.userId, _callable);
    }

    Component.onCompleted: {
        __loadFriendList();
    }

}


