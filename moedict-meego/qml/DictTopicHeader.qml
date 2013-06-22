import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: header
    width: parent.width
    height: container.height
    property alias text: topicName.text
    property alias category: topicCategory.text
    property alias strokeText: topicStrokes.text
    property alias phonetics: topicPhoneticList.model

    Column {
        id: container
        width: parent.width

        Item {
            width: parent.width
            height: topicName.height

            Label {
                id: topicName
                anchors.left: parent.left
                font.family: UiConstants.TitleFont.family
                font.bold: Font.Bold
                font.pixelSize: 42
            }

            SectionBubble {
                id: topicCategory
                anchors.verticalCenter: topicStrokes.verticalCenter
                anchors.right: topicStrokes.left
                visible: text != ""
            }

            Label {
                id: topicStrokes
                anchors.right: parent.right
                anchors.baseline: topicName.baseline
                anchors.rightMargin: UiConstants.DefaultMargin
                font.family: UiConstants.SubtitleFont.family
                font.pixelSize: UiConstants.SubtitleFont.pixelSize
                font.weight: Font.Light
                color: "#666"
                visible: text != ""
            }
        }

        Row {
            spacing: UiConstants.SubtitleFont.pixelSize / 2

            Repeater {
                id: topicPhoneticList
                model: header.phonetics
                delegate: Component {
                    Label {
                        font: UiConstants.SubtitleFont
                        color: "#666"
                        text: modelData
                    }
                }
            }
        }
    }
}
