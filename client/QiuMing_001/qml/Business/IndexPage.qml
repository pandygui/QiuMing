import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1

ListPage {
    backNavigationEnabled: true
    emptyText.text: qsTr("首页")

    // 必须是 ListModel

    model: ListModel {
        ListElement {
            text: "Widget test"
            detailText: "Some of the widgets available in V-Play AppSDK"
            image: "../../../assets/user_head.jpg"
        }
        ListElement { text: "Shown are:"
            detailText: "ListPage, NavigationBar with different items, Switch"
            image: "../../../assets/user_head.jpg"
        }
    }

    //    model: [
    //        { text: "Widget test",
    //            detailText: "Some of the widgets available in V-Play AppSDK",
    //            icon: IconType.tablet,
    //            image: "../../../assets/user_head.jpg" },
    //        { text: "Shown are:",
    //            detailText: "ListPage, NavigationBar with different items, Switch",
    //            icon: IconType.question,
    //            image: "../../../assets/user_head.jpg" }
    //    ]


    //        // listItem ThemeSimpleRow
    //        Theme.listItem.textColor = "#ababab";
    //        // Theme.listItem.activeTextColor = "#ababab";
    //        // 详细的文字要白一点
    //        Theme.listItem.detailTextColor = "#b06176";
    //        Theme.listItem.backgroundColor = "#343434";
    //        Theme.listItem.selectedBackgroundColor = "#5c5c5c";
    //        Theme.listItem.dividerColor = "#434343";


    delegate: SimpleRow {
        style: StyleSimpleRow {
            textColor : "#ababab";
            activeTextColor : "#ababab";
            // 详细的文字要白一点
            detailTextColor : "#ababab";
            backgroundColor : "#343434";
            selectedBackgroundColor : "#5c5c5c";
            dividerColor : "#434343";
        }
    }
}

