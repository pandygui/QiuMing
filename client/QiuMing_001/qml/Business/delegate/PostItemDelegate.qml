import QtQuick 2.0
import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1

Rectangle {
    id: itemDelegate



    color: "transparent"
    border.color: "#ccc"
    border.width: 1

    signal clicked()

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
            color: "white"
            font.bold: true
        }

        AppText {
            width: parent.width
            // 显示前 20 个字符
            text: itemDelegate.content.substring(0, 20)
            elide: Text.ElideRight
        }

        AppText {
            width: parent.width
            // Qt.formatDateTime(d, "hh:mm M月d号")
            text: Qt.formatDateTime(new Date(Number(itemDelegate.time)), "hh:mm M月d号")
            horizontalAlignment: Text.AlignRight
            elide: Text.ElideRight
            font.pixelSize: sp(12)
        }
    }

    RippleMouseArea {
        anchors.fill: parent
        onClicked: {
            itemDelegate.clicked()
            // console.log("post id:"+itemDelegate.postId);
//            var properties = {
//                "author"        : itemDelegate.userId,
//                "content"       : itemDelegate.content,
//                "pariseNumber"  : itemDelegate.praiseNumber,
//                "postId"        : itemDelegate.postId,
//                "title"         : itemDelegate.title,
//                "favoriteNumber": itemDelegate.favoriteNumber,
//                "time"          :itemDelegate.time,
//                "modifyTime"    :itemDelegate.modifyTime,
//                "postState"     :itemDelegate.postState,
//                "roleId"        :itemDelegate.roleId,
//            };
//            mainStack.push(postViewPageCom, properties );
        }
    }
} // itemDelegate

