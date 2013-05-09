import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow
    Component.onCompleted: pageStack.toolBar.tools = commonTools
    ToolBarLayout {
        id: commonTools

        ToolIcon {
            platformIconId: "toolbar-previous"
        }

        ToolIcon {
            platformIconId: "toolbar-next"
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
