import QtQuick 1.1
import com.nokia.meego 1.0

BorderImage {
    source: "image://theme/meegotouch-countbubble-background"
    border.left: 10; border.right: 10
    border.top: 10; border.bottom: 10
    width: label.width + 10
    height: label.height + 6
    property alias text: label.text

    Text {
        id: label
        anchors.centerIn: parent
        font: UiConstants.GroupHeaderFont
    }
}
