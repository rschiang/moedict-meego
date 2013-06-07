import QtQuick 1.1
import com.nokia.meego 1.0

TextField {
    id: searchField
    platformSipAttributes: sipAttributes

    SipAttributes {
        id: sipAttributes
        actionKeyEnabled: true
        actionKeyHighlighted: true
        actionKeyLabel: "搜尋"
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
