import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

Item {
    id: page
    width: parent.itemWidth
    height: parent.itemHeight

    AppViewHeader {
        id: header
        text: "歷程紀錄"

        SheetButton {
            anchors.right: parent.paddingItem.right
            anchors.verticalCenter: parent.paddingItem.verticalCenter
            platformStyle.inverted: true
            text: "清除"
            onClicked: page.clear()
        }
    }

    ListView {
        id: historyList
        anchors {
            top: header.bottom
            left: parent.left; leftMargin: UiConstants.DefaultMargin
            right: parent.right; rightMargin: UiConstants.DefaultMargin
            bottom: parent.bottom
        }

        delegate: Component {
            ListItem {
                title: model.title
                subtitle: model.subtitle
                onClicked: {
                    appWindow.navigate(model.title)
                }
            }
        }

        section.delegate: Component {
            SectionHeader {
                text: section
            }
        }

        section.criteria: ViewSection.FullString
        section.property: "day"
        model: historyModel

        ListModel {
            id: historyModel
        }
    }

    SectionScroller {
        listView: historyList
    }

    function init() {
        var result = appWindow.database.execRow("SELECT COUNT(*) AS count FROM history", [])
        JSON.stringify(result)
        if (result.count <= 0) {
            saveHistory("遠景", "ㄩㄢˇ ㄐㄧㄥˇ", new Date("2013-04-29T00:00:00Z"))
            saveHistory("開放", "ㄎㄞ ㄈㄤˋ", new Date("2013-05-02T00:00:00Z"))
            saveHistory("辭典", "ㄘˊ ㄉㄧㄢˇ", new Date("2013-06-05T00:00:00Z"))
            saveHistory("明夷待訪錄", "ㄇㄧㄥˊ ㄧˊ ㄉㄞˋ ㄈㄤˇ ㄌㄨˋ", new Date("2013-06-06T00:00:00Z"))
            saveHistory("論語", "ㄌㄨㄣˊ ㄩˇ", new Date("2013-06-07T00:00:00Z"))
            saveHistory("萌", "ㄇㄥˊ")
        }
    }

    function load() {
        var result = appWindow.database.execQuery("SELECT * FROM history ORDER BY date ASC", [])
        historyModel.clear()
        for (var i = 0; i < result.length; i++) {
            result[i].day = getDayName(new Date(result[i].date))
            historyModel.append(result[i])
        }
    }

    function view(title, subtitle) {
        var index
        for (var i = 0; i < historyModel.count; i++)
            if (historyModel.get(i).title == title)
                index = i

        var entry = { "title": title, "subtitle": subtitle }
        if (index > appWindow.backStackIndex) { // Count as new
            appWindow.pushToHistory(entry)
            appWindow.currentIndex = 0
        } else {
            appWindow.navigate(entry)
            appWindow.currentIndex = index
        }
    }

    function getHistory(index) {
        if (historyModel.count <= index) return undefined
        return historyModel.get(index).title
    }

    function pushHistory(entry) {
        historyModel.insert(0, entry)
    }

    function saveHistory(title, subtitle, date) {
        if (date == undefined) date = new Date()
        appWindow.database.execAction({"INSERT INTO history (title, subtitle, date) VALUES (?,?,?)":
                                      [title, subtitle, date.toISOString()]})
    }

    function clear() {
        appWindow.database.execAction(["DELETE FROM history"])
        historyModel.clear()
        appWindow.currentIndex = 0
        appWindow.backStackIndex = 0
    }

    function getDayName(date) {
        var cur = new Date()
        var delta = cur.getDate() - date.getDate()
        if (delta <= 0) return "今天"
        if (delta <= 1) return "昨天"
        if (delta <  7) return Qt.formatDate(date, "dddd")
        return Qt.formatDate(date, Qt.DefaultLocaleLongDate)
    }
}
