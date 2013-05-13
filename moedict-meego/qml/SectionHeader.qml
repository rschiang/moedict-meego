import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    anchors.left: parent.left
    anchors.right: parent.right
    implicitWidth: parent.width
    implicitHeight: label.implicitHeight
    property alias text: label.text

    BorderImage {
        id: seperator
        source: "image://theme/meegotouch-groupheader-background"
        height: 2
        anchors.left: parent.left
        anchors.right: label.left
        anchors.rightMargin: UiConstants.DefaultMargin / 2
        anchors.verticalCenter: label.verticalCenter
    }

    Label {
        id: label
        anchors.right: parent.right
        font: UiConstants.GroupHeaderFont
    }
}
