import QtQuick 2.2;

Item {
    property int sizeOfSpacing
    property color dimColor: "#77777777"

    property real aspectRatio: width/height
    property real upDownBarHeight: sizeOfSpacing / aspectRatio
    property real leftRightBarWidth: sizeOfSpacing * aspectRatio

    property variant topLeft: Qt.point(left.width, top.height)
    property variant topRight: Qt.point(parent.width - right.width, top.height)
    property variant bottomLeft: Qt.point(left.width, parent.height - bottom.height)
    property variant bottomRight: Qt.point(parent.width - right.width, parent.height - bottom.height)

    property real cropWidth: topRight.x - topLeft.x
    property real cropHeight: bottomLeft.y - topLeft.y

    Rectangle{
        id:top
        anchors.left: left.right
        anchors.top: parent.top
        anchors.right: right.left
        height: inPortrait ? sizeOfSpacing : upDownBarHeight
        color: dimColor
    }
    Rectangle{
        id: bottom
        anchors.left: left.right
        anchors.bottom: parent.bottom
        anchors.right: right.left
        height: inPortrait ? sizeOfSpacing : upDownBarHeight
        color: dimColor
    }
    Rectangle{
        id:left
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: inPortrait ? leftRightBarWidth : sizeOfSpacing
        color: dimColor
    }
    Rectangle{
        id:right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: inPortrait ? leftRightBarWidth : sizeOfSpacing
        color: dimColor
    }
    BorderImage{
        anchors.left: left.right
        anchors.right: right.left
        anchors.top: top.bottom
        anchors.bottom: bottom.top

        anchors.leftMargin: -2
        anchors.rightMargin: -2
        anchors.topMargin: -2
        anchors.bottomMargin: -2

        source: "images/cropRectangleBorder.PNG"
        border.left: 28; border.top: 29
        border.right: 28; border.bottom: 29
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Repeat
    }
}
