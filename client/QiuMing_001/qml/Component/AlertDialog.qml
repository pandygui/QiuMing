import QtQuick 2.0
import VPlayApps 1.0

Dialog {
    id: busyDialog
    mainWindow: app
    property alias message: messageContent.text

    positiveActionLabel: "Yes"
    // 不显示取消按钮
    negativeAction: false

    AppText {
        id: messageContent
        anchors.fill: parent
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    }

    function exec(title, message) {
        busyDialog.title = title;
        busyDialog.message = message;
        busyDialog.open();
    }
}

