import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: root

    QueryDialog {
        id: dialog

        icon: "image://theme/icon-m-settings-reset"
        titleText: "重設辭典？"
        message: "當辭典運作不正常時，可以嘗試清除所有歷史紀錄與離線條目。<br><br>" +
                 "完成後請重新啟動程式。"
        acceptButtonText: "繼續"
        rejectButtonText: "取消"

        onAccepted: {
            appWindow.database.reset()
            Qt.quit()
        }
    }

    function queryReset() {
        dialog.open()
    }
}
