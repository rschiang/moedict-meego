import QtQuick 1.1
import com.nokia.meego 1.0
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
                        appWindow.history.navigate(searchView.model[0].title)
                    } else {
                        platformCloseSoftwareInputPanel()
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
                            subtitle: (modelData.key) ? modelData.key : ""
                            width: searchResults.width
                            onClicked: appWindow.history.navigate(title)
                        }
                    }
                }

                Item {
                    id: loadingIndicator
                    width: parent.width
                    height: UiConstants.ListItemHeightDefault
                    visible: searcher.running

                    BusyIndicator {
                        style: BusyIndicatorStyle { size: "medium" }
                        anchors.centerIn: parent
                        running: parent.visible
                    }
                }
            }

            Column {
                id: definitionList
                width: parent.width
                spacing: UiConstants.DefaultMargin / 2
                visible: (page.state == "")

                function clear() {
                    for (var i = 0; i < children.length; i++)
                        children[i].destroy()
                }
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

    Component {
        id: topicHeaderFactory
        DictTopicHeader {
            MouseArea {
                anchors.fill: parent
                onPressAndHold: entryMenu.open()
            }
        }
    }

    Component {
        id: sectionFactory
        SectionBubble {}
    }

    Component {
        id: labelFactory
        Label {
            width: parent.width
            wrapMode: Text.Wrap
            platformSelectable: true
        }
    }

    ContextMenu {
        id: entryMenu
        MenuLayout {
            MenuItem {
                text: "複製連結"
                onClicked: clipboard.text = "https://www.moedict.tw/#" + appWindow.history.get(0)
            }

            MenuItem {
                text: "在瀏覽器開啟條目"
                onClicked: Qt.openUrlExternally("https://www.moedict.tw/#" + appWindow.history.get(0))
            }
        }
    }

    WorkerScript {
        id: searcher
        source: "query.js"
        property bool running: false
        property int __token: 0 // Use to identify the most recent query

        onMessage: {
            if (messageObject.token === __token) {
                searchView.model = messageObject.result
                running = false
            }
        }

        function start(query, params) {
            running = true
            __token++
            sendMessage({"query": query, "params": params, "token": __token})
        }
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

        searchView.model = undefined
        searcher.start(sql, [(query+'%')])
    }

    function showEntry(title)
    {
        searchField.text = ""
        searchField.platformCloseSoftwareInputPanel()
        searchField.focus = false
        definitionList.clear()

        var entry = appWindow.database.execRow("SELECT json FROM entries WHERE title = ?", [title])
        if (entry === undefined) return

        var data = JSON.parse(entry.json.replace(/'/g, '"'))
        var stroke = (data.c) ? ("+%n=%c".replace("%n", data.n).replace("%c", data.c)) : ""

        if (!data.h) return
        for (var i = 0; i < data.h.length; i++) {
            var item = data.h[i]
            topicHeaderFactory.createObject(definitionList, {
                                                text: data.t,
                                                category: (data.r) ? data.r : "",
                                                strokeText: stroke,
                                                phonetics: [item.b, item.p]
                                            })
            if (!item.d) continue
            var defs = {}
            for (var j = 0; j < item.d.length; j++) {
                var def = item.d[j]
                var t = (def.t) ? def.t : ""
                if (!(t in defs)) defs[t] = ""

                var sentences = [def.f]
                if (def.e) sentences = sentences.concat(def.e)
                if (def.q) sentences = sentences.concat(def.q)
                if (def.l) sentences = sentences.concat(def.l)
                var str = "<li>" + sentences.join("<br>") + "</li>"

                defs[t] += str
            }

            for (var type in defs) {
                if (type) sectionFactory.createObject(definitionList, { text: type })
                labelFactory.createObject(definitionList, { text: "<ol>" + defs[type] + "</ol>" })
            }
        }

        return data.h[0].b
    }
}
