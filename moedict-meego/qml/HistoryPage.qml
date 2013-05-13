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
        delegate: ListDelegate {}
        model: ListModel {
            ListElement { title: "萌";  subtitle: "ㄇㄥˊ" }
            ListElement { title: "論語";  subtitle: "ㄌㄨㄣˊ ㄩˇ" }
            ListElement { title: "明夷待訪錄";  subtitle: "ㄇㄧㄥˊ ㄧˊ ㄉㄞˋ ㄈㄤˇ ㄌㄨˋ" }
            ListElement { title: "辭典";  subtitle: "ㄘˊ ㄉㄧㄢˇ" }
            ListElement { title: "開放資料";  subtitle: "ㄎㄞ ㄈㄤˋ ㄗ ㄌㄧㄠˋ" }
            ListElement { title: "願景";  subtitle: "ㄩㄢˋ ㄐㄧㄥˇ" }
        }
    }

    ScrollDecorator {
        flickableItem: historyList
    }
}
