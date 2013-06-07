import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

Item {
    id: page
    width: parent.itemWidth
    height: parent.itemHeight
    state: (searchField.text.length > 0) ? "search" : ""

    AppViewHeader {
        id: header
        text: "萌典"
        interactive: true
        onClicked: scrollToTop.start()
    }

    Flickable {
        id: pageArea
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        contentWidth: width
        contentHeight: contentArea.height + contentArea.anchors.margins * 2
        clip: true

        Column {
            id: contentArea
            spacing: UiConstants.DefaultMargin
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: UiConstants.DefaultMargin
            }

            SearchField {
                id: searchField
                anchors.left: parent.left
                anchors.right: parent.right
                placeholderText: "搜尋注音、拼音或國字"
                inputMethodHints: Qt.ImhPreferLowercase
                onTextChanged: doSearch()
                Keys.onReturnPressed: {
                    if (searchView.model.length > 0) {
                        showEntry(searchView.model[0].title)
                    } else {
                        closeSoftwareInputPanel()
                        searchField.focus = false
                    }
                }
            }

            Column {
                id: searchResults
                width: parent.width
                visible: (page.state == "search")

                Repeater {
                    id: searchView
                    delegate: Component {
                        ListItem {
                            title: modelData.title
                            subtitle: (modelData.key !== undefined) ? modelData.key : ""
                            onClicked: showEntry(title)
                        }
                    }
                }
            }

            Column {
                id: definitionList
                width: parent.width
                spacing: UiConstants.DefaultMargin / 2
                visible: (page.state == "")
            }
        }
    }

    ScrollDecorator { flickableItem: pageArea }

    NumberAnimation {
        id: scrollToTop
        target: pageArea
        property: "contentY"; to: 0
        duration: 300
        easing.type: Easing.OutCubic
    }

    function doSearch()
    {
        var query = searchField.text
        if (query.length <= 0) return

        // Use first character to determine type
        var chr = query.charCodeAt(0)
        var useindex = (chr <= 0xff) || ((chr >= 0x3100) && (chr <= 0x312f))

        var sql = (useindex) ? "SELECT key, title FROM indices WHERE key LIKE ? LIMIT 10"
                             : "SELECT title FROM entries WHERE title LIKE ? LIMIT 10"
        var result = appWindow.database.execRow(sql, [(query+'%')])
        searchView.model = result
    }

    function showEntry(title)
    {
        searchField.text = ""
        searchField.platformCloseSoftwareInputPanel()
        searchField.focus = false
        console.log(title)
    }
}
