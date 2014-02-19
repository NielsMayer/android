HEADERS += \
           imagehandler.h

SOURCES += main.cpp \
           imagehandler.cpp

RESOURCES += MultiFunctionImageTool-default.qrc

QT += widgets quick
unix:target.path = /usr/local/bin

INSTALLS += target

OTHER_FILES += qml/MultiFunctionImageTool/*.qml
