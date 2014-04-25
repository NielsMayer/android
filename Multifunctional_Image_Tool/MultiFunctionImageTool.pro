HEADERS += \
           imagehandler.h

SOURCES += main.cpp \
           imagehandler.cpp

RESOURCES += MultiFunctionImageTool-default.qrc

QT += widgets quick
unix:target.path = /usr/local/bin

INSTALLS += target

OTHER_FILES += qml/MultiFunctionImageTool/*.qml

linux-g++|linux-g++-64 {
   message("Finalise Makefile for 'linux-g++|linux-g++-64'")
}
tizen {
    message("Finalise Makefile for Tizen Mobile on ARM. Reminder: don't use for x86 emulator!")
    OTHER_FILES += tizen/manifest.xml
    tizen_shared.files = $$_PRO_FILE_PWD_/shared/res
    CONFIG += TIZEN_STANDALONE_PACKAGE
    TIZEN_BUNDLED_QT_LIBS=Qt5Core Qt5DBus Qt5Qml Qt5Quick Qt5Widgets Qt5Gui Qt5Network Qt5Sensors
    load(tizen_app)
}
