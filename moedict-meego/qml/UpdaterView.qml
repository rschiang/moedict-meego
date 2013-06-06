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
            visible: root.state != ""
            source: {
                switch (root.state) {
                    case "available":   return "image://theme/icon-m-content-third-party-update"
                    case "updating":    return "image://theme/icon-s-transfer-download"
                    case "error":       return "image://theme/icon-s-transfer-error"
                    case "newest":      return "image://theme/icon-m-common-done"
                    case "checking":    return "image://theme/icon-s-transfer-sync"
                    default:            return ""
                }
            }
        }

        Label {
            id: statusLabel
            anchors.left: indicator.right
            anchors.right: parent.right
            anchors.leftMargin: UiConstants.DefaultMargin / 2
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: {
                switch (root.state) {
                    case "available":   return "有可用的更新（%s）".replace("%s", appWindow.updater.data.version)
                    case "updating":    return "正在更新辭典……"
                    case "error":       return "更新時遇到錯誤（#%s）".replace("%s", appWindow.updater.data)
                    case "newest":      return "MoeDict 已是最新版本（%s）".replace("%s", appWindow.updater.data.version)
                    case "checking":    return "檢查更新……"
                    default:            return "MoeDict 版本 13.0429"
                }
            }
        }
    }

    ProgressBar {
        id: progressBar
        anchors.left: parent.left
        anchors.right: parent.right
        visible: root.state == "checking" || root.state == "updating"
        indeterminate: (value <= 0)
    }

    Button {
        id: actionButton
        anchors.horizontalCenter: parent.horizontalCenter
        visible: root.state != "newest"
        text: {
            switch (root.state) {
                case "":            return "檢查更新"
                case "available":   return "安裝"
                case "error":       return "重試"
                default:            return "取消"
            }
        }
        onClicked: {
            switch (root.state) {
                case "":
                    appWindow.updater.refresh()
                    break
                case "checking":
                case "updating":
                    appWindow.updater.cancel()
                    break
                case "available":
                    appWindow.updater.install()
                    break
                case "error":
                    appWindow.updater.retry()
                    break
            }
        }
    }

    Connections {
        target: appWindow.updater
        onStateChanged: root.state = appWindow.updater.state
        onProgressChanged: progressBar.value = appWindow.updater.progress
        onRecoveryStateChanged: actionButton.enabled = appWindow.updater.recoveryState != "parsing"
    }
}
