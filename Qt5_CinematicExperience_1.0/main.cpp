#include <QGuiApplication>
#include <QQuickView>

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

    //NB: if these are stack allocated, instead of heap allocated, you get a core-dump on exit
    //on some platforms. IMHO this is a new bug introduced after Qt5.1 for QML-based apps.
    QGuiApplication* app  = new QGuiApplication(argc,argv); //NB: never free()'d, exists for lifetime of app
    QQuickView*      view = new QQuickView();               //NB: never free()'d, exists for lifetime of app
    view->setResizeMode(QQuickView::SizeRootObjectToView);

#if QT_VERSION >= 0x050000
    view->setSource(QUrl("qrc:///Qt5_CinematicExperience.qml"));
#else
    view->setSource(QUrl::fromLocalFile(QCoreApplication::applicationDirPath() + QLatin1String("/Qt5_CinematicExperience.qml")));
#endif /* QT_VERSION ... */

    const QString lowerArgument = QString::fromLatin1(argv[1]).toLower();
    if (lowerArgument == QLatin1String("--fullscreen")) {
        view->showFullScreen();
    } else {
        view->show();
    }
    return app->exec();
}
