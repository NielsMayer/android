// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.2;

Item{
    id:item
    width: buttonImageElement.width
    height: buttonImageElement.height
    property string buttonImage : "images/button_bg_40x40.png"
    property string buttonImage_Pressed : "images/button_pressed_bg_40x40.png"
    property string buttonIconImage;

    signal clicked();

    Image{
        id: buttonImageElement
        source: mouseArea.pressed ? buttonImage_Pressed : buttonImage
        width: 40
        height: 40
        smooth: true
        Image{
            anchors.centerIn: parent
            source: buttonIconImage
            width: 27
            height: 27
            smooth: true
        }
        MouseArea{
            anchors.fill: parent
            id: mouseArea
            onClicked: item.clicked();
        }
    }
}
