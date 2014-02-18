import QtQuick 2.2;
 
Item {
    id: mainPage
 
    property alias source: image.source
    property alias offsetX: flick.contentX
    property alias offsetY: flick.contentY
    property alias contentWidth: flick.contentWidth
    property alias contentHeight: flick.contentHeight
    property alias sourceSize: image.sourceSize
    property alias imageElement: originalImage
 
    Flickable {
        id: flick
        anchors.fill: parent
        contentWidth: minimumWidth
        contentHeight: minimumHeight

        flickableDirection: Flickable.HorizontalAndVerticalFlick
 
        property real minimumWidth: inPortrait ? mainPage.height * aspectRatio : mainPage.width
        property real minimumHeight: inPortrait ? mainPage.height : mainPage.width /aspectRatio
 
        property real aspectRatio: (image.sourceSize.width / image.sourceSize.height)
 
        Image {
            id:image
            width: flick.contentWidth
            height: flick.contentHeight
			
			smooth: true
 
            MouseArea {
                anchors.fill: parent
                onDoubleClicked: {
                    flick.contentWidth = flick.minimumWidth
                    flick.contentHeight = flick.minimumHeight
                }
            }
        }
 
        PinchArea {
            id: pinchArea
            width: Math.max(flick.contentWidth, flick.width)
            height: Math.max(flick.contentHeight, flick.height)
 
            function distance(p1, p2) {
                var dx = p2.x-p1.x;
                var dy = p2.y-p1.y;
                return Math.sqrt(dx*dx + dy*dy);
            }
 
            property real initialDistance
            property real initialContentWidth
            property real initialContentHeight
 
            onPinchStarted: {
                initialDistance = distance(pinch.point1, pinch.point2);
                initialContentWidth = flick.contentWidth;
                initialContentHeight = flick.contentHeight;
            }
 
            onPinchUpdated: {
				flick.contentX += pinch.previousCenter.x - pinch.center.x
				flick.contentY += pinch.previousCenter.y - pinch.center.y
			
                var currentDistance = distance(pinch.point1, pinch.point2);
				if(currentDistance < 5)
					return;
                var scale = currentDistance/initialDistance;
 
                var newHeight = initialContentHeight*scale
                var newWidth = initialContentWidth*scale
 
                flick.resizeContent(newWidth, newHeight, pinch.center)
            }
 
            onPinchFinished: {
                var finalWidth = Math.max(flick.contentWidth, flick.minimumWidth)
                var finalHeight = Math.max(flick.contentHeight, flick.minimumHeight)
 
                //Reasure the maximum Scale
                finalWidth = Math.min(finalWidth, image.sourceSize.width)
                finalHeight = Math.min(finalHeight, image.sourceSize.height)
 
                flick.resizeContent(finalWidth, finalHeight, pinch.center)
 
                flick.returnToBounds()
            }
        }
    }
 
    Image {
        id:originalImage
        visible: false
        source: mainPage.source
    }
}
