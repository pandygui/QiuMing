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
        Theme.listItem.backgroundColor = "transparent";
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
    property alias mainNavigation: mainNavigation
    property alias lazyer: lazyer
    property alias userEntity: userEntity
    property alias socket: socket

    signal loginSuccess()

    UserEntity {
        id: userEntity
        property bool isLogin: false
        property string jsessionid: "xxxx"
        username: "我也是大魔王好不好"
        password: ""
        pickname: ""
        age: 0
        address: ""
    }

    Lazyer { id: lazyer }

    Socket { id: socket }

    Component.onCompleted: {
        mainNavigationStack.push(userLoginPage);

        lazyer.lazyDo(250, function() {
            socket.active = true;
        });
    }

    NavigationStack {
        id: mainNavigationStack

        splitView: false

        Page {
            id: mainPage
            titleItem: Row {
                spacing: dp(6)

                //                Image {
                //                  anchors.verticalCenter: parent.verticalCenter
                //                  height: titleText.height
                //                  fillMode: Image.PreserveAspectFit
                //                  source: "../assets/vplay-logo.png"
                //                }

                AppText {
                    id: titleText
                    anchors.verticalCenter: parent.verticalCenter
                    text:  userEntity.username
                    font.bold: true
                    font.family: Theme.boldFont.name
                    font.pixelSize: dp(Theme.navigationBar.titleTextSize)
                    // color: "orange"
                }
            } // titleItem

            Component {
                id: userLoginPage
                // socket
                UserLoginPage { onLoginSuccess: app.loginSuccess(); }
            }

            Component {
                id: userCenterPage
                UserCenterPage { }
            }

            Navigation {
                id: mainNavigation
                navigationMode: navigationModeDrawer

                // drawer header
                headerView: Item {
                    // 用户中心
                    width: parent.width
                    height: parent.width * 0.8

                    AppImage {
                        anchors.fill: parent
                        defaultSource: "../assets/vplay-logo.png"
                        source: "../assets/drawer-head-background.jpg"
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: dp(16)
                        AnimatedImage {
                            source: "../assets/loadTV.gif"
                        }
                        AppText {
                            text: userEntity.username
                        }
                    }

                    RippleMouseArea {
                        anchors.fill: parent
                        onClicked: {
                            mainNavigationStack.push(userCenterPage);
                        }
                    }
                } // headerView

                footerView: AppButton {
                    text: "logout"
                    onClicked: {
                        mainNavigation.drawer.close();
                        socket.logout(userEntity.username);
                        mainNavigationStack.push(userLoginPage);
                        lazyer.lazyDo(100, function(){
                            socket.active = false;
                            lazyer.lazyDo(100, function(){
                                socket.active = true;
                            });
                        })
                    }
                } // footerView

                NavigationItem {
                    title: qsTr("首页")
                    icon: IconType.home
                    IndexPage {
                        id: indexPage
                        Connections {
                            target: app
                            onLoginSuccess: {
                                indexPage.loadPosts(indexPage.postIndex,
                                                    indexPage.postsSize);
                            }
                        }
                    }
                }

                NavigationItem {
                    title: qsTr("我的收藏")
                    icon: IconType.star
                    FavoritesPage { }
                }

                NavigationItem {
                    title: qsTr("关注的人")
                    icon: IconType.users
                    FocusPage { }
                }

                NavigationItem {
                    title: qsTr("关于")
                    icon: IconType.info
                    AboutPage {  }
                }

                NavigationItem {
                    title: qsTr("设置")
                    icon: IconType.tachometer
                    SettingsPage { }
                }
            } // mainNavigation

        } // mainPage

    } // mainStack

}

