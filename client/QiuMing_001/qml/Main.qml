import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Qt.WebSockets 1.0

import QtQuick.Dialogs 1.2 as ZZZ

import "./Component"
import "./Business"
import "./Entity"

App {
    id: app
    // You get free licenseKeys from http://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from http://v-play.net/licenseKey>"

    // ZZZ.ColorDialog {  visible: true }

    // Theme {}
    onInitTheme: {

//        Theme.platform = "windows";
        console.log(Theme.platform)

        // 设置主字体颜色
        Theme.colors.textColor = "#ababab";
        // 设置应用背景颜色
        Theme.colors.backgroundColor = "#343434";
        // 设置导航条背景色
        Theme.navigationBar.backgroundColor = "#343434";
        // 设置导航条底部线条颜色
        Theme.navigationBar.dividerColor = "#434343";

        Theme.navigationAppDrawer.backgroundColor = "#343434";
        Theme.navigationAppDrawer.itemBackgroundColor = "#343434";
        Theme.navigationAppDrawer.itemSelectedBackgroundColor = "#5c5c5c";
        Theme.navigationAppDrawer.textColor = "#ababab";
        Theme.navigationAppDrawer.activeTextColor = "#b06176"
        Theme.listItem.activeTextColor = "#b06176";
        // Theme.listItem.backgroundColor = "transparent";
        Theme.listItem.backgroundColor = "#343434";
        // activeTextColor

        //        // listItem ThemeSimpleRow
        //        Theme.listItem.textColor = "#ababab";
        //        // Theme.listItem.activeTextColor = "#ababab";
        //        // 详细的文字要白一点
        //        Theme.listItem.detailTextColor = "#b06176";
        //        Theme.listItem.backgroundColor = "#343434";
        //        Theme.listItem.selectedBackgroundColor = "#5c5c5c";
        //        Theme.listItem.dividerColor = "#434343";

        // 输入框
        Theme.colors.inputCursorColor = "#b06176";

        // 选项栏
        Theme.tabBar.titleColor = "#b06176"; //"#ababab";
        Theme.tabBar.backgroundColor = "#343434";
        Theme.tabBar.dividerColor = "#434343";
    }

    property alias mainStack: mainNavigationStack
    property alias mainNavigation: mainPage.mainNavigation
    property alias lazyer: lazyer
    property alias userEntity: userEntity
    property alias socket: socket

    signal loginSuccess()
    signal logoutSuccess()

    UserEntity { id: userEntity }

    Lazyer { id: lazyer }

    Socket { id: socket }

    Component {
        id: userLoginPage
        // socket
        UserLoginPage { onLoginSuccess: app.loginSuccess(); }
    }

    Component.onCompleted: {
        mainNavigationStack.push(userLoginPage);

        lazyer.lazyDo(250, function() {
            socket.active = true;
        });
    }

    NavigationStack {
        id: mainNavigationStack

        splitView: false

        MainPage {
            id: mainPage
        } // mainPage

    } // mainStack

}

