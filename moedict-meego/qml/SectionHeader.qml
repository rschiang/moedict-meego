import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    anchors.left: parent.left
    anchors.right: parent.right
    implicitWidth: parent.width
    implicitHeight: label.implicitHeight + UiConstants.DefaultMargin
    property alias text: label.text

    BorderImage {
        id: seperator
        source: "image://theme/meegotouch-groupheader-background"
        height: 2
        anchors.left: parent.left
        anchors.right: label.left
        anchors.rightMargin: UiConstants.DefaultMargin / 2
        anchors.verticalCenter: parent.verticalCenter
    }

    Label {
        id: label
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        font: UiConstants.GroupHeaderFont
    }
}
