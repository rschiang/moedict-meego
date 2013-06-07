import QtQuick 1.1

import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: listItem

    signal clicked
    property alias pressed: mouseArea.pressed
    property alias title: mainText.text
    property alias subtitle: subText.text

    height: UiConstants.ListItemHeightDefault
    width: parent.width

    BorderImage {
        id: background
        anchors.fill: parent
        // Fill page porders
        anchors.leftMargin: -UiConstants.DefaultMargin
        anchors.rightMargin: -UiConstants.DefaultMargin
        visible: mouseArea.pressed
        source: theme.inverted ? "image://theme/meegotouch-panel-inverted-background-pressed" : "image://theme/meegotouch-panel-background-pressed"
    }

    // Note: this is a lightweight version of ListDelegate
    // which stripped off model and image support
    Column {
        anchors.verticalCenter: parent.verticalCenter

        Label {
            id: mainText
            font: UiConstants.TitleFont
            color: mouseArea.pressed ? "#797979" : (theme.inverted ? "#ffffff" : "#282828")
        }

        Label {
            id: subText
            font: UiConstants.SubtitleFont
            color: mouseArea.pressed ? "#797979" : (theme.inverted ? "#c8c8c8" : "#505050")
            visible: text != ""
        }
    }

    MouseArea {
        id: mouseArea;
        anchors.fill: parent
        onClicked: {
            listItem.clicked();
        }
    }
}
