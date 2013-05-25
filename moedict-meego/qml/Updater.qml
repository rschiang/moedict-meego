import QtQuick 1.1
import com.nokia.meego 1.0
import org.moedict 1.1

Column {
    id: root
    spacing: UiConstants.DefaultMargin

    Item {
        id: statusArea
        anchors.left: parent.left
        anchors.right: parent.right
        height: statusLabel.height

        Image {
            id: indicator
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 32; height: 32; smooth: true
            source: {
                switch (root.state) {
                    case "available":   return "image://theme/icon-m-content-third-party-update"
                    case "updating":    return "image://theme/icon-s-transfer-download"
                    case "error":       return "image://theme/icon-s-transfer-error"
                    case "newest":      return "image://theme/icon-m-common-done"
                    default:            return "image://theme/icon-s-transfer-sync"
                }
            }
        }

        Label {
            id: statusLabel
            anchors.left: indicator.right
            anchors.right: parent.right
            anchors.leftMargin: UiConstants.DefaultMargin / 2
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            property string tag: "13.0429"
            text: {
                switch (root.state) {
                    case "available":   return "有可用的更新（%s）".replace("%s", tag)
                    case "updating":    return "正在更新辭典……"
                    case "error":       return "更新時遇到錯誤（#%s）".replace("%s", tag)
                    case "newest":      return "MoeDict 已是最新版本（%s）".replace("%s", tag)
                    default:            return "檢查更新……"
                }
            }
        }
    }

    ProgressBar {
        id: progressBar
        anchors.left: parent.left
        anchors.right: parent.right
        visible: root.state == "" || root.state == "updating"
        indeterminate: (value <= 0)
    }

    Button {
        id: actionButton
        anchors.horizontalCenter: parent.horizontalCenter
        visible: root.state != "newest"
        text: (root.state == "available" ?  "安裝" :
               root.state == "error" ?      "重試" : "取消")
        onClicked: {
            // TODO: Implement real mechanism
            switch (root.state) {
                case "": root.state = "available"; break
                case "available": root.state = "updating"; break
                case "updating": root.state = "error"; break
                case "error": root.state = "newest"; break
                default: root.state = ""; break
            }
        }
    }

    Fetcher {
        id: manifestFetcher
        url: "https://raw.github.com/rschiang/moedict-meego/master/data/manifest.json"
        onFinished: {
            var manifest = JSON.parse(content)
            root.state = "available"
            statusLabel.tag = manifest.version
        }
        onError: {
            root.state = "error"
            statusLabel.tag = code
        }
    }
}
