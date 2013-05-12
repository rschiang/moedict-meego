import QtQuick 1.1
import com.nokia.meego 1.0

BaseWindow {
    id: appWindow

    Component.onCompleted: {
        if (theme.color != undefined) theme.color = "14"
    }

    contentItem: Flickable {
        id: contentArea
        anchors.fill: parent
        contentWidth: width * 3
        contentHeight: height

        Row {
            height: parent.height

            // Common API for Pages
            property alias itemHeight: contentArea.height
            property alias itemWidth: contentArea.width
            function window() {
                return appWindow
            }

            // Page items
            DictPage {}
            HistoryPage {}
            AboutPage {}
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
