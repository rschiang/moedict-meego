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
        contentWidth: (interactive) ? width * 2 : width * 3
        contentHeight: height
        boundsBehavior: Flickable.StopAtBounds

        Row {
            height: parent.height

            // Common API for Pages
            property alias itemHeight: contentArea.height
            property alias itemWidth: contentArea.width
            function window() {
                return appWindow
            }

            // Page items
            DictPage { id: dictPage }
            HistoryPage { id: historyPage }
            AboutPage { id: aboutPage }
        }

        property int __lastX: 0
        onMovementStarted: {
            __lastX = contentX
        }
        onMovementEnded: {
            var delta = (contentX - __lastX)
            if (delta > 0)
                historyTab.checked = true
            else if (delta < 0)
                dictTab.checked = true
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
                id: dictTab
                iconSource: "image://theme/icon-m-toolbar-list"
                checked: true
            }
            TabButton {
                id: historyTab
                iconSource: "image://theme/icon-m-toolbar-history"
            }
            TabButton {
                id: aboutTab
                iconSource: "image://theme/icon-m-toolbar-update"
            }
        }
    }

    state: "dict"
    states: [
        State {
            name: "dict"
            when: dictTab.checked
            PropertyChanges { target: contentArea; contentX: dictPage.x; interactive: true }
        },
        State {
            name: "history"
            when: historyTab.checked
            PropertyChanges { target: contentArea; contentX: historyPage.x; interactive: true }
        },
        State {
            name: "about"
            when: aboutTab.checked
            PropertyChanges { target: contentArea; contentX: aboutPage.x; interactive: false }
        }
    ]
    transitions: [
        Transition {
            to: "*"
            NumberAnimation {
                target: contentArea; property: "contentX"; duration: 200
                easing.type: Easing.OutCubic
            }
        }
    ]
}
