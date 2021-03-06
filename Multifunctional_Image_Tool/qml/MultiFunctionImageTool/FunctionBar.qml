import QtQuick 2.2;

Item{
    id: item
    signal initiateSaveCroppedImage();
    signal initiateDecodeCroppedImage();

    Column{
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        width: saveButton.width
        spacing: 10
        visible: !inPortrait

        ImageButton{
            id: saveButton
            buttonIconImage: "images/save.svg"
            onClicked: item.initiateSaveCroppedImage();
        }

        ImageButton{
            buttonIconImage: "images/QrButton_toolbar.svg"
            onClicked: item.initiateDecodeCroppedImage();
        }

        ImageButton{
            buttonIconImage: "images/questionMark.svg"
        }
    }

    Row{
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        width: saveButtonRow.width
        spacing: 5
        visible: inPortrait

        ImageButton{
            id: saveButtonRow
            buttonIconImage: "images/save.svg"
            onClicked: item.initiateSaveCroppedImage();
        }

        ImageButton{
            buttonIconImage: "images/QrButton_toolbar.svg"
            onClicked: item.initiateDecodeCroppedImage();
        }

        ImageButton{
            buttonIconImage: "images/questionMark.svg"
        }
    }
}
