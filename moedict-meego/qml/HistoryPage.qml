import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

Item {
    id: page
    width: parent.itemWidth
    height: parent.itemHeight

    AppViewHeader {
        id: header
        text: "歷程紀錄"

        SheetButton {
            anchors.right: parent.paddingItem.right
            anchors.verticalCenter: parent.paddingItem.verticalCenter
            platformStyle.inverted: true
            text: "清除"
        }
    }

    Flickable {
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Column {
            id: historyList
            width: page.width
        }
    }
}
