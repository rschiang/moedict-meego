import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: page
    width: parent.itemWidth
    height: parent.itemHeight

    AppViewHeader {
        id: header
        text: "關於萌典"

        SheetButton {
            anchors.right: parent.paddingItem.right
            anchors.verticalCenter: parent.paddingItem.verticalCenter
            platformStyle.inverted: true
            visible: !inPortrait
            text: "回報問題"
            onClicked: reportIssue()
        }
    }

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
            spacing: UiConstants.DefaultMargin * (inPortrait ? 1 : 0.5)
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: UiConstants.DefaultMargin
            }

            Item {
                width: parent.width
                height: aboutText.height + (inPortrait ? (appIcon.height + UiConstants.DefaultMargin) : 0)

                Image {
                    id: appIcon
                    source: "qrc:/app-icon/large"

                    MouseArea {
                        anchors.fill: parent
                        onPressAndHold: resetter.reset()
                    }

                    Loader {
                        id: resetter
                        onLoaded: item.queryReset()
                        function reset() {
                            if (source != "")
                                item.queryReset()
                            else
                                source = "AppReset.qml"
                        }
                    }
                }

                Label {
                    id: aboutText
                    anchors {
                        top: (inPortrait) ? appIcon.bottom : parent.top
                        left: (inPortrait) ? parent.left : appIcon.right
                        topMargin: (inPortrait) ? UiConstants.DefaultMargin : 0
                        leftMargin: (inPortrait) ? 0 : UiConstants.DefaultMargin
                        right: parent.right
                    }
                    wrapMode: Text.Wrap
                    text: "<p>本詞典共收錄十六萬筆中文條目。源碼、其他平台版本、API 及原始資料等，均可在 3du.tw 取得。"+
                          "原始資料來源為教育部「重編國語辭典修訂本」，辭典本文的著作權仍為教育部所有。</p>" +
                          "<p>感謝 #g0v.tw 所有協助開發的朋友們。</p>"
                }
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                visible: (inPortrait)
                text: "回報問題"
                onClicked: reportIssue()
            }

            SectionHeader { text: "詞彙更新" }

            UpdaterView {
                id: updater
                width: parent.width
            }
        }
    }

    ScrollDecorator {
        flickableItem: pageArea
    }

    function reportIssue() {
        Qt.openUrlExternally("https://github.com/rschiang/moedict-meego/issues")
    }
}
