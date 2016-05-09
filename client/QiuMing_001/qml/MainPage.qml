import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Qt.WebSockets 1.0

import QtQuick.Dialogs 1.2 as ZZZ

import "./Component"
import "./Business"
import "./Entity"

Page {
    id: mainPage

    property alias mainNavigation: mainNavigation

    titleItem: Row {
        spacing: dp(6)
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
        id: userCenterPage
        UserCenterPage { userId: userEntity.userId }
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
                app.logoutSuccess();
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
                    onLogoutSuccess: {
                        indexPage.postIndex = 0;
                        indexPage.postsSize = 10;
                        // TODO 确保 model 使用给数组！
                        indexPage.model = [];
                        // 清空用户数据
                        userEntity.clear();
                    }
                }
                
            }
        }
        
        NavigationItem {
            title: qsTr("我的收藏")
            icon: IconType.star
            FavoritesPage { userId: userEntity.userId }
        }
        
        NavigationItem {
            title: qsTr("关注的人")
            icon: IconType.users
            FriendsPage { userId: userEntity.userId }
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
    
}
