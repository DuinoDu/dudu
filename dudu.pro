TEMPLATE = app

QT += qml quick widgets sql serialport

CONFIG += c++11

SOURCES += main.cpp \
    backend.cpp \
    fingerrecog.cpp

RESOURCES += \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

HEADERS += \
    backend.h \
    fingerrecog.h \
    splashwidget.h

RC_ICONS = img/icon_48x48.ico
