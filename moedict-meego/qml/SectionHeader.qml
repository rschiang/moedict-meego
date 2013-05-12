import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    anchors.left: parent.left
    anchors.right: parent.right
    implicitWidth: parent.width
    implicitHeight: label.implicitHeight
    property alias text: label.text

    Label {
        id: label
        font: UiConstants.GroupHeaderFont
    }

    BorderImage {
        id: seperator
        source: "image://theme/meegotouch-groupheader-background"
        height: 2
        anchors.left: label.right
        anchors.right: parent.right
        anchors.leftMargin: UiConstants.DefaultMargin / 2
        anchors.verticalCenter: label.verticalCenter
    }
}
