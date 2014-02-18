import QtQuick 2.2;
//import QZXing 1.2

Rectangle {
    anchors.fill: parent
	color: "black"

    InteractionArea{
        id:interactionArea
        anchors.fill: parent
        source: "images/image.jpg"
    }

    BoundingRectangle{
        id:boundingRectangle
        anchors.fill: parent
        sizeOfSpacing:50
    }

    ImageButton{
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        buttonIconImage: "images/back.png"
        onClicked: Qt.quit();
    }

    ActionBar{
        anchors.fill: parent

        onInitiateSaveCroppedImage: saveCroppedImage();
        onInitiateDecodeCroppedImage: decodeCroppedImage();
    }

    MessageDialog{
        id:dialog
    }

//    QZXing{
//        id: decoder
//        onTagFound: {
//            dialog.text = tag
//            dialog.open();
//        }
//    }

    function saveCroppedImage()
    {
        var geometry = extractPortionGeometry();

        imageHandler.save(interactionArea.imageElement, "E:/croppedImage.png",
                          geometry.x, geometry.y, geometry.width, geometry.height)
    }

    function decodeCroppedImage()
    {
//        var geometry = extractPortionGeometry();

//        decoder.decodeSubImageQML(interactionArea.imageElement,
//                                  geometry.x, geometry.y, geometry.width, geometry.height)

    }

    function extractPortionGeometry()
    {
        var geometry = new Object();
        var scaleRatio = 1;

        if(inPortrait)
            scaleRatio = interactionArea.contentHeight / interactionArea.sourceSize.height
        else
            scaleRatio = interactionArea.contentWidth / interactionArea.sourceSize.width

        geometry.x = (interactionArea.offsetX + boundingRectangle.topLeft.x) / scaleRatio
        geometry.y = (interactionArea.offsetY + boundingRectangle.topLeft.y) / scaleRatio

        geometry.width = boundingRectangle.cropWidth / scaleRatio
        geometry.height = boundingRectangle.cropHeight / scaleRatio

        return geometry;
    }
}
