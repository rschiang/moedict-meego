import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

Item {
    id: page
    width: parent.itemWidth
    height: parent.itemHeight
    state: (searchField.text.length > 0) ? "search" : ""

    AppViewHeader {
        id: header
        text: "萌典"
        interactive: true
        onClicked: scrollToTop.start()
    }

    Flickable {
        id: pageArea
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        contentWidth: width
        contentHeight: contentArea.height + contentArea.anchors.margins * 2
        clip: true

        Column {
            id: contentArea
            spacing: UiConstants.DefaultMargin
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: UiConstants.DefaultMargin
            }

            SearchField {
                id: searchField
                anchors.left: parent.left
                anchors.right: parent.right
                placeholderText: "搜尋注音、拼音或國字"
            }

            Column {
                id: searchResults
                width: parent.width
                visible: (page.state == "search")

                ListItem { title: "萌";  subtitle: "ㄇㄥˊ" }
                ListItem { title: "萌芽";  subtitle: "ㄇㄥˊ ㄧㄚˊ" }
                ListItem { title: "萌發";  subtitle: "ㄇㄥˊ ㄈㄚ" }
            }

            Column {
                id: definitionList
                width: parent.width
                spacing: UiConstants.DefaultMargin / 2
                visible: (page.state == "")

                DictTopicHeader {
                    text: "萌"
                    category: "艸"
                    strokeText: "+8=12"
                    phonetics: ["ㄇㄥˊ", "méng"]
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
    }

    ScrollDecorator { flickableItem: pageArea }

    NumberAnimation {
        id: scrollToTop
        target: pageArea
        property: "contentY"; to: 0
        duration: 300
        easing.type: Easing.OutCubic
    }
}
