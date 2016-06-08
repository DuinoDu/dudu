#ifndef FINGERRECOG_H
#define FINGERRECOG_H

#include <QObject>
#include <QtSerialPort/QSerialPort>

class FingerRecog : public QObject
{
    Q_OBJECT
public:
    explicit FingerRecog(QObject *parent = 0);

    QString createFinger();

    QString recogFinger();

signals:

public slots:

private:
    QSerialPort serial;

    void _genImg();
    void _img2Tz();
    void _match();
    void _regModel();
    void _store();
    void _search();

};

#endif // FINGERRECOG_H
