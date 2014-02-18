HEADERS += \
           imagehandler.h

SOURCES += main.cpp \
           imagehandler.cpp

RESOURCES += MultiFunctionImageTool-default.qrc

QT +=  core gui network widgets qml quick

INSTALLS += target

OTHER_FILES += qml/MultiFunctionImageTool/*.qml
