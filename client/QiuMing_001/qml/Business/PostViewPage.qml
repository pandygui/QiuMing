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

    property string author
    // title
    property string content
    property string pariseNumber
    property string postId;
    property string title;
    property string praiseNumber;
    property string favoriteNumber;
    property string time;
    property string modifyTime
    property int postState;				// 帖子审核状态，0 ： 不通过，1 ： 通过
    property string roleId;			// 1 帖子 2 发车

    ScrollView {
        width: parent.width
        height: parent.height
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


}

