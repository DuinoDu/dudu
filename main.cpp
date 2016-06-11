#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>

#include "backend.h"
#include "splashwidget.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<Backend>("DD", 1, 0, "Backend");


    SplashWidget screen;
    screen.setTime(1800);
    screen.setSplashImgPath(":/img/splash.png");
    screen.setMainPath("qrc:/qml/main.qml");
    screen.start();

    //QQmlApplicationEngine engine;
    //QObject::connect(&screen, SIGNAL(closeSplashScreen(QUrl)), &engine, SLOT(load(QUrl)));

    return app.exec();
}
