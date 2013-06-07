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
                //onClicked:
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
            writeToHistory("遠景", "ㄩㄢˇ ㄐㄧㄥˇ", new Date("2013-04-29T00:00:00Z"))
            writeToHistory("開放", "ㄎㄞ ㄈㄤˋ", new Date("2013-05-02T00:00:00Z"))
            writeToHistory("辭典", "ㄘˊ ㄉㄧㄢˇ", new Date("2013-06-05T00:00:00Z"))
            writeToHistory("明夷待訪錄", "ㄇㄧㄥˊ ㄧˊ ㄉㄞˋ ㄈㄤˇ ㄌㄨˋ", new Date("2013-06-06T00:00:00Z"))
            writeToHistory("論語", "ㄌㄨㄣˊ ㄩˇ", new Date("2013-06-07T00:00:00Z"))
            writeToHistory("萌", "ㄇㄥˊ")
        }
        load()
        appWindow.dictPage.showEntry(result[0].title)
    }

    function load() {
        var result = appWindow.database.execQuery("SELECT * FROM history ORDER BY date DESC", [])
        historyModel.clear()
        for (var i = 0; i < result.length; i++) {
            result[i].day = getDayName(new Date(result[i].date))
            historyModel.append(result[i])
        }
    }

    function writeToHistory(title, subtitle, date) {
        if (date == undefined) date = new Date()
        appWindow.database.execAction({"INSERT INTO history (title, subtitle, date) VALUES (?,?,?)":
                                      [title, subtitle, date.toISOString()]})
    }

    function clear() {
        appWindow.database.execAction(["DELETE FROM history"])
        historyModel.clear()
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
