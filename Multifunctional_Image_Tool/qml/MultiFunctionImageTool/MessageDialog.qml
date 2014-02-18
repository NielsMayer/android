import QtQuick 2.2;
//import com.nokia.symbian 1.1

Rectangle{
    id: messageRectangle
    anchors.left: parent.left
    anchors.right: parent.right
    y: parent.height / 2 - width/2
    color: "black"
    radius: 10
    visible: false

    height: textRectangle.height + backButton.height + 5

    property alias text: messageLabel.text

    Rectangle {
        id:textRectangle
        height: messageLabel.height
        width: messageLabel.width
        color: "#ff000000"
        anchors.horizontalCenter: parent.horizontalCenter

        Text{
            id: messageLabel
            color: "white"
        }
    }

    ImageButton{
        id: backButton
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: textRectangle.bottom
        anchors.topMargin: 5
        buttonIconImage: "images/back.png"
        onClicked: messageRectangle.visible = false;
    }

    function open(){
        messageRectangle.visible = true;
    }
}

// Implementation For Symbian with QtQuick Symbian components
/*CommonDialog {
    id: dialog
    titleText: "Decoded message"
    titleIcon: "images/QrButton_toolbar.svg"
    buttonTexts: ["OK"]

    property alias text: messageLabel.text

    content: Rectangle {
        height: messageLabel.height
        width: messageLabel.width
        color: "#ff000000"
        anchors.horizontalCenter: parent.horizontalCenter

        Text{
            id: messageLabel
            color: "white"
        }
    }
}*/
