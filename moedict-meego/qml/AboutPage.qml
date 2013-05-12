import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: page
    width: parent.itemWidth
    height: parent.itemHeight

    AppViewHeader { id: header; text: "關於萌典" }

    Item {
        anchors {
            top: header.bottom; topMargin: UiConstants.DefaultMargin
            left: parent.left; leftMargin: UiConstants.DefaultMargin
            right: parent.right; rightMargin: UiConstants.DefaultMargin
            bottom: parent.bottom
        }

        Image {
            source: "qrc:/app-icon/large"
        }
    }

    // Data Source: https://github.com/g0v/moedict-data/blob/master/dict-revised.json?raw=true
}
