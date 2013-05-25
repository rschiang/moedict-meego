import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: page
    width: parent.itemWidth
    height: parent.itemHeight

    AppViewHeader { id: header; text: "關於萌典" }

    Flickable {
        id: pageArea
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentWidth: width
        contentHeight: contentArea.height + contentArea.anchors.margins * 2
        clip: true

        Column {
            id: contentArea
            spacing: UiConstants.DefaultMargin / 2
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: UiConstants.DefaultMargin
            }

            Image {
                source: "qrc:/app-icon/large"
            }

            Label {
                width: parent.width
                wrapMode: Text.Wrap
                text: "<p>本詞典共收錄十六萬筆中文條目，並支援「自動完成」功能及「%_ *? ^.$」等萬用字元。源碼、其他平台版本、API 及原始資料等，均可在 3du.tw 取得。</p>"+
                      "<p>原始資料來源為教育部「重編國語辭典修訂本」，辭典本文的著作權仍為教育部所有。</p>" +
                      "<p>感謝 #g0v.tw 頻道內所有協助開發的朋友們。</p>"
            }

            SectionHeader { text: "詞彙更新" }

            Updater {
                id: updater
                width: parent.width
            }
        }
    }

    ScrollDecorator {
        flickableItem: pageArea
    }

}
