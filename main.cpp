#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>

#include "backend.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<Backend>("DD", 1, 0, "Backend");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
