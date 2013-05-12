import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: page
    width: parent.itemWidth
    height: parent.itemHeight

    AppViewHeader { text: "萌典" }

    ButtonColumn {
        anchors.centerIn: parent

        Button { text: "Lorem Ipsum" }
        Button { text: "Donor Amet" }
        Button { text: "Versi Sali" }
    }
}
