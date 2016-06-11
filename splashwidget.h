#ifndef SPLASHWIDGET_H
#define SPLASHWIDGET_H

#include <QMainWindow>
#include <QPainter>
#include <QImage>

#include <QTimer>
#include <QUrl>

#include <QQmlApplicationEngine>
#include <QQuickWindow>


class SplashWidget : public QMainWindow
{
    Q_OBJECT

public:
    SplashWidget(QWidget *parent = 0) : QMainWindow(parent){
        setWindowFlags(Qt::FramelessWindowHint | Qt::WindowSystemMenuHint);
        setAttribute(Qt::WA_TranslucentBackground);

    }

    void start(){
        this->show();
        timer = new QTimer;
        connect(timer, SIGNAL(timeout()), this, SLOT(timeUp()));
        timer->start(delayTimeMs);
    }

    void setSplashImgPath(const QString& path) {
        splashImgPath = path;
        image = QImage(path);
        sizeH = image.height();
        sizeW = image.width();
        this->setFixedSize(sizeW, sizeH);
    }
    void setMainPath(const QString& path){ mainPath = QUrl(path); }
    void setTime(const int& time){ delayTimeMs = time; }

protected:
    virtual void paintEvent( QPaintEvent *){
        QPainter p(this);
        p.save();
        p.drawImage(0, 0, image);
        p.restore();
    }

signals:
    void closeSplashScreen(QUrl);

private slots:
    void timeUp(){
        this->hide();
        timer->stop();
        delete timer;
        emit closeSplashScreen(mainPath);

        engine.load(mainPath);
        QObject* applicationWindow = engine.rootObjects().value(0);
        QQuickWindow* window = qobject_cast<QQuickWindow*>(applicationWindow);
        window->showMaximized();
    }

private:
    QTimer *timer;
    QString splashImgPath;
    QUrl mainPath;
    int delayTimeMs;
    QImage image;
    int sizeH, sizeW;

    QQmlApplicationEngine engine;
};



#endif // SPLASHWIDGET_H
