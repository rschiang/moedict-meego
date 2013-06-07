import QtQuick 1.1
import com.nokia.meego 1.0

BaseWindow {
    id: appWindow

    property variant database: DataHolder {}
    property variant settings: AppSettings {}
    property variant updater:  AppUpdater {}
    property bool dictionaryEnabled: true
    property int currentIndex: 0
    property int backStackIndex: 0

    Component.onCompleted: {
        database.load()
        settings.load()
        updater.version = appWindow.settings.getDefault("dict.version", 0)
        if (updater.version <= 0) {
            aboutTab.checked = true
            dictionaryEnabled = false
            historyPage.init()
            historyPage.load()
        } else {
            historyPage.load()
            var last = historyPage.getHistory(0)
            navigate((last != undefined) ? last : "萌")
        }
    }

    function navigate(entry) { dictPage.showEntry(entry) }
    function pushToHistory(entry) {
        historyPage.pushHistory(entry)
        historyPage.saveHistory(entry.title, entry.subtitle)
        currentIndex++
        backStackIndex++
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
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                if (currentIndex >= backStackIndex) {
                    Qt.quit()
                } else {
                    navigate(historyPage.getHistory(++currentIndex))
                }
            }
        }

        ButtonRow {
            TabButton {
                id: dictTab
                iconSource: "image://theme/icon-m-toolbar-list" + (enabled ? "": "-dimmed")
                checked: true
                enabled: dictionaryEnabled
            }
            TabButton {
                id: historyTab
                iconSource: "image://theme/icon-m-toolbar-history" + (enabled ? "": "-dimmed")
                enabled: dictionaryEnabled
            }
            TabButton {
                id: aboutTab
                iconSource: "image://theme/icon-m-toolbar-update"
            }
        }

        ToolIcon {
            platformIconId: "toolbar-next"
            anchors.verticalCenter: parent.verticalCenter
            visible: !inPortrait
            enabled: (currentIndex > 0)
            onClicked: {
                navigate(historyPage.getHistory(--currentIndex))
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
