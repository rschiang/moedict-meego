import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: page
    width: parent.itemWidth
    height: parent.itemHeight

    AppViewHeader { id: header; text: "萌典" }

    SearchField {
        id: searchField
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: UiConstants.DefaultMargin
        placeholderText: "搜尋教育部重編國語辭典"
    }

    Flickable {
        id: contentArea
        anchors {
            top: searchField.bottom; topMargin: UiConstants.DefaultMargin
            left: parent.left; leftMargin: UiConstants.DefaultMargin
            right: parent.right; rightMargin: UiConstants.DefaultMargin
            bottom: parent.bottom
        }
        contentWidth: width
        contentHeight: definitionList.height
        clip: true

        Column {
            id: definitionList
            width: parent.width
            spacing: UiConstants.DefaultMargin / 2

            Row {
                spacing: UiConstants.SubtitleFont.pixelSize / 2

                Label {
                    id: topicName
                    font.family: UiConstants.TitleFont.family
                    font.bold: Font.Bold
                    font.pixelSize: 42
                    text: "萌"
                }

                Label {
                    id: topicZhuyin
                    anchors.baseline: topicName.baseline
                    font: UiConstants.SubtitleFont
                    color: "#666"
                    text: "ㄇㄥˊ"
                }

                Label {
                    id: topicPinyin
                    anchors.baseline: topicName.baseline
                    font: UiConstants.SubtitleFont
                    color: "#666"
                    text: "méng"
                }
            }

            BorderImage {
                source: "image://theme/meegotouch-countbubble-background"
                border.left: 10; border.right: 10
                border.top: 10; border.bottom: 10
                width: __defType.width + 10
                height: __defType.height + 6

                Text {
                    id: __defType
                    anchors.centerIn: parent
                    font: UiConstants.SmallTitleFont
                    text: "名"
                }
            }

            Label {
                width: parent.width
                wrapMode: Text.Wrap
                text: "<ol>" +
                    "<li>草木初生的芽。<br>說文解字：「萌，艸芽也。」<br>唐·韓愈、劉師服、侯喜、軒轅彌明·石鼎聯句：「秋瓜未落蒂，凍芋強抽萌。」</li>" +
                    "<li>事物發生的開端或徵兆。<br>韓非子·說林上：「聖人見微以知萌，見端以知末。」<br>漢·蔡邕·對詔問灾異八事：「以杜漸防萌，則其救也。」</li>" +
                    "<li>人民。<br>如：「萌黎」、「萌隸」。<br>通「氓」。</li>" +
                    "<li>姓。如五代時蜀有萌慮。</li>" +
                    "</ol>"
            }
        }
    }

    ScrollDecorator { flickableItem: contentArea }
}
