import VPlayApps 1.0

import QtQuick 2.0
import QtQuick.Layouts 1.1

Page {
    backNavigationEnabled: false

    AppButton {
        anchors.centerIn: parent
        text: "登陆"
        onClicked: {
            busyDialog.open();
            userEntity.isLogin = true;
            lazyer.lazyDo(1000, function(){
                busyDialog.close();
                lazyer.lazyDo(50, function() {
                    if(userEntity.isLogin) {
                        mainStack.pop();
                    }
                });
            });

        }
    }

    Dialog {
        id: busyDialog
        mainWindow: app
        title: "Waiting..."
        positiveActionLabel: "Yes"
        negativeActionLabel: "No"
        onCanceled: title = "Think again!"
        onAccepted: close()
    }
}
