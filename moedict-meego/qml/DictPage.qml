import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: page
    width: parent.itemWidth
    height: parent.itemHeight

    AppViewHeader { id: header; text: "萌典" }

    TextField {
        id: searchField
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: UiConstants.DefaultMargin
        placeholderText: "搜尋教育部重編國語辭典"
        platformSipAttributes: SipAttributes {
            actionKeyHighlighted: true
            actionKeyIcon: "image://theme/icon-m-toolbar-search"
        }

        Image {
            id: searchIcon
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            source: (searchField.text.length > 0) ? "image://theme/icon-m-input-clear" : "image://theme/icon-m-common-search"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    searchField.text = ""
                }
            }
        }
    }
}
