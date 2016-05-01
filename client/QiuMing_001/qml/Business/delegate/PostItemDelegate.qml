import QtQuick 2.0

Item {

    property var item: modelData
    property string postTilte: item && item.postTitle
    property string postSummary: item && item.postSummary
    // property string
}

