import QtQuick 1.1
import com.nokia.meego 1.0

Image {
    id: viewHeader
    source: "qrc:/theme/app-meegotouch-view-header-fixed"
    anchors.left: parent.left; anchors.top: parent.top
    anchors.right: parent.right;
    height: appWindow.inPortrait ?  UiConstants.HeaderDefaultHeightPortrait : UiConstants.HeaderDefaultHeightLandcape

    // Properties
    property Item paddingItem: __paddingItem
    property alias text: __headerText.text

    Item {
        id: __paddingItem
        anchors.fill: parent
        anchors.leftMargin: 22
        anchors.rightMargin: 22
        anchors.bottomMargin: 2

        Text {
            id: __headerText
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            font: UiConstants.HeaderFont
            color: "white"
            visible: (text != "")
        }
    }
}
