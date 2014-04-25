#include <qplatformdefs.h> // defines MEEGO_EDITION_HARMATTAN, QT_VERSION, etc

#if QT_VERSION >= 0x050000
#include <QApplication>
#include <QQuickView>
#include <QQmlEngine>
#include <QQmlContext>
#else
#include <QApplication>
#include "qmlapplicationviewer.h"
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#endif

#include "imagehandler.h"

//#include <QZXing.h>

#ifdef Q_OS_LINUX_TIZEN_MOBILE
extern "C" int OspMain(int argc, char *argv[]);
#endif /* Q_OS_LINUX_TIZEN_MOBILE */

int main(int argc, char* argv[])
{
#ifdef Q_OS_LINUX_TIZEN_MOBILE
    return OspMain(argc,argv);
}

/* NB: Tizen Mobile, but not Desktop (haven't checked emulator) requires
 * this indirection via 'OspMain() otherwise the application will not launch
 * from the desktop icon.
 * (However, it can be launched directly from /opt/apps/.../bin/qt5cinematic.exe as root from shell)
 */
extern "C" int OspMain(int argc, char *argv[])
{
#endif /* Q_OS_LINUX_TIZEN_MOBILE */

#ifdef Q_OS_LINUX_TIZEN_SIMULATOR
    qputenv("QSG_RENDER_LOOP","windows");
#endif /* Q_OS_LINUX_TIZEN_SIMULATOR */
#ifndef Q_OS_ANDROID
    qputenv("QT_QUICK_CONTROLS_STYLE","Tizen");
#endif

    QGuiApplication* app = new QGuiApplication(argc,argv);

//  QZXing::registerQMLTypes();

    // NPM: original static allocation had issue calling superclass destructor on app close
    //  ~ImageHandler() --> ~QQuickImageProvider() -> free ==> crash :
    //    D/Qt      (30180): qrc:///main.qml:25 (): MultiFunctionImageTool application closing ...
    //    D/Qt      (30180): qrc:///main.qml:26 (): MultiFunctionImageTool visible=false
    //    F/libc    (30180): invalid address or address of corrupt block 0x60c15ed0 passed to dlfree
    //    F/libc    (30180): Fatal signal 11 (SIGSEGV) at 0xdeadbaad (code=1), thread 30195 (nctionImageTool)
    // Instead of frobbing the ImageHandler:~ImageHandler() to discern between static and
    // dynamically allocated ImageHandler, seems easier to just dynamically allocate.
    ImageHandler* imageHandler = new ImageHandler("imageRepository");

    // NPM original static allocation had issue calling superclass destructor on app close
    // ~QQuickView() -> ~QQuickWindow() -> segfault
    // so again, use dynamic allocation of QQuickView,
    QQuickView*           viewer = new QQuickView();
    viewer->rootContext()->setContextProperty("imageHandler", imageHandler);
    // NPM -- pass viewer to QML -- viewer.width and viewer.height give display dimensions
    viewer->rootContext()->setContextProperty("viewer", viewer);
    viewer->engine()->addImageProvider(imageHandler->providerName(), imageHandler);
    viewer->setSource(QUrl("qrc:///main.qml"));

#if (defined(Q_OS_ANDROID) || defined(Q_OS_LINUX_TIZEN) || defined(Q_OS_LINUX_TIZEN_MOBILE) || defined(Q_OS_LINUX_TIZEN_SIMULATOR) || defined(Q_OS_LINUX_TIZEN_IVI))
    viewer->showFullScreen();
#else // Desktop, etc.
    viewer->show();
#endif /* Qt5 Q_OS_ANDROID ... */
    return app->exec();
}
