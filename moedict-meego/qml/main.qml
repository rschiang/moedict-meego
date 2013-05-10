import QtQuick 1.1
import com.nokia.meego 1.0

BaseWindow {
    id: appWindow

    contentItem: Item {
        id: contentArea
        anchors.fill: parent

        Image {
            id: viewHeader
            source: "image://theme/color14-meegotouch-view-header-fixed"
            anchors.left: parent.left; anchors.top: parent.top
            anchors.right: parent.right;

            Text {
                text: "MoeDict"
                font.pixelSize: 32
                font.weight: Font.Light
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left; anchors.leftMargin: 20
            }
        }
    }

    toolBarTools: ToolBarLayout {

        ToolIcon {
            platformIconId: "toolbar-previous"
            onClicked: {
                Qt.quit() // To-do: Navigate backstack
            }
        }

        ButtonRow {
            TabButton {
                iconSource: "image://theme/icon-m-toolbar-list"
                checked: true
            }
            TabButton {
                iconSource: "image://theme/icon-m-toolbar-history"
            }
            TabButton {
                iconSource: "image://theme/icon-m-toolbar-update"
            }
        }
    }
}
