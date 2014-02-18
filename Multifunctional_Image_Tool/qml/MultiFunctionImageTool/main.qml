import QtQuick 2.2;

Rectangle{
    id:     window
    width:  viewer.width; //NPM -- 'viewer' instance of QQuickView from main.cpp
    height: viewer.height;
	color: "black"

    property bool inPortrait: width <= height

    MainPage{
        anchors.fill: parent
    }

    // NPM: Detect changes in toplevel QQuickView's QWindow superclass
    // https://qt-project.org/doc/qt-5.1/qtquick/qquickview.html
    // --> https://qt-project.org/doc/qt-5.1/qtquick/qquickwindow.html
    // --> https://qt-project.org/doc/qt-5.1/qtgui/qwindow.html
    Connections {
        target:                    viewer; //NPM -- 'viewer' instance of QQuickView from main.cpp
        onWidthChanged:            console.log("MultiFunctionImageTool width="
                                               + viewer.width);
        onHeightChanged:           console.log("MultiFunctionImageTool height="
                                               + viewer.height);
        onClosing:                 console.log("MultiFunctionImageTool application closing ...");
        onVisibleChanged:          console.log("MultiFunctionImageTool visible="
                                               + viewer.visible);
        onWindowStateChanged:      console.log("MultiFunctionImageTool windowState="
                                               + viewer.windowState);
        onStatusChanged:           console.log("MultiFunctionImageTool status="
                                               + viewer.status);
        onModalityChanged:         console.log("MultiFunctionImageTool modality="
                                               + viewer.modality);
        // NPM: documented, but gives "non-existent property" error
        // https://qt-project.org/doc/qt-5.1/qtgui/qwindow.html#contentOrientation-prop
//      contentOrientationChanged: console.log("MultiFunctionImageTool contentOrientation="
//                                             + viewer.contentOrientation);
    }

    // NPM: print status and information of QQuickView's QWindow superclass.
    Component.onCompleted:         console.log("MultiFunctionImageTool"
                                               + " visible="
                                               + viewer.visible
                                               + " status="
                                               + viewer.status
                                               + " modality="
                                               + viewer.modality
                                               + " contentOrientation="
                                               + viewer.contentOrientation
                                               + " windowState="
                                               + viewer.windowState
                                               + " width="
                                               + width
                                               + " height="
                                               + height);
}
