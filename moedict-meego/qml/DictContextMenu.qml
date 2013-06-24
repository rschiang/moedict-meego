import QtQuick 1.1
import com.nokia.meego 1.0

ContextMenu {
    id: menu
    visualParent: appWindow

    MenuLayout {
        MenuItem {
            text: "複製連結"
            onClicked: clipboard.text = "https://www.moedict.tw/#" + __cachedEntry
        }

        MenuItem {
            text: "在瀏覽器開啟條目"
            onClicked: Qt.openUrlExternally("https://www.moedict.tw/#" + __cachedEntry)
        }
    }
}
