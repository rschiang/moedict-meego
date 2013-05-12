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
        placeholderText: "搜尋注音、拼音或國字"
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

            SectionBubble { text: "名" }

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

            SectionBubble { text: "動" }

            Label {
                width: parent.width
                wrapMode: Text.Wrap
                text: "<ol>" +
                    "<li>發芽。<br>如：「萌芽」。<br>楚辭·王逸·九思·傷時：「明風習習兮龢暖，百草萌兮華榮。」</li>" +
                    "<li>發生。<br>如：「故態復萌」。<br>管子·牧民：「惟有道者，能備患於未形也，故禍不萌。」<br>三國演義·第一回：「若萌異心，必獲惡報。」</li>" +
                    "</ol>"
            }
        }
    }

    ScrollDecorator { flickableItem: contentArea }
}
