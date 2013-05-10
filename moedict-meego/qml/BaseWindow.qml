import QtQuick 1.1
import com.nokia.meego 1.0

Window {
    id: window

    property bool showStatusBar: true
    property bool showToolBar: true
    property Style platformStyle: PageStackWindowStyle{}
    property alias platformToolBarHeight: toolBar.height // read-only
    property alias toolBarTools: toolBar.tools
    property alias contentItem: contentArea.children

    //private api
    property int __statusBarHeight: showStatusBar ? statusBar.height : 0

    objectName: "pageStackWindow"

    StatusBar {
        id: statusBar
        anchors.top: parent.top
        width: parent.width
        showStatusBar: window.showStatusBar
    }

    onOrientationChangeStarted: {
        statusBar.orientation = screen.currentOrientation
    }

    Rectangle {
        id: background
        visible: platformStyle.background == ""
        color: platformStyle.backgroundColor
        anchors { top: statusBar.bottom; left: parent.left; bottom: parent.bottom; right: parent.right; }
    }

    Image {
        id: backgroundImage
        visible: platformStyle.background != ""
        source: window.inPortrait ? platformStyle.portraitBackground : platformStyle.landscapeBackground
        fillMode: platformStyle.backgroundFillMode
        anchors { top: statusBar.bottom; left: parent.left; bottom: parent.bottom; right: parent.right; }
    }

    Item {
        objectName: "appWindowContent"
        width: parent.width
        anchors.top: statusBar.bottom
        anchors.bottom: parent.bottom

        // content area
        Item {
            id: contentArea
            anchors { top: parent.top; left: parent.left; right: parent.right; bottom: parent.bottom; }
            anchors.bottomMargin: toolBar.visible || (toolBar.opacity==1)? toolBar.height : 0
        }

        Item {
            id: roundedCorners
            visible: platformStyle.cornersVisible
            anchors.fill: parent
            z: 10001

            Image {
                anchors.top : parent.top
                anchors.left: parent.left
                source: "image://theme/meegotouch-applicationwindow-corner-top-left"
            }
            Image {
                anchors.top: parent.top
                anchors.right: parent.right
                source: "image://theme/meegotouch-applicationwindow-corner-top-right"
            }
            Image {
                anchors.bottom : parent.bottom
                anchors.left: parent.left
                source: "image://theme/meegotouch-applicationwindow-corner-bottom-left"
            }
            Image {
                anchors.bottom : parent.bottom
                anchors.right: parent.right
                source: "image://theme/meegotouch-applicationwindow-corner-bottom-right"
            }
        }

        ToolBar {
            id: toolBar
            anchors.bottom: parent.bottom
            privateVisibility: (inputContext.softwareInputPanelVisible==true || inputContext.customSoftwareInputPanelVisible == true)
            ? ToolBarVisibility.HiddenImmediately : (window.showToolBar ? ToolBarVisibility.Visible : ToolBarVisibility.Hidden)
        }
    }

    Component.onCompleted: {
    }

}
