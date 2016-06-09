#ifndef FINGERRECOG_H
#define FINGERRECOG_H

#include <QObject>
#include <QtSerialPort/QSerialPort>

class FingerRecog : public QObject
{
    Q_OBJECT
public:
    FingerRecog();

    QString createFinger();

    QString recogFinger();

signals:

public slots:

private:
    QSerialPort serial;
    QByteArray requestData;

    QString currentPortName = "COM5";
    int waitTimeout = 1000;


    uchar _genImg();
    uchar _img2Tz(uchar bufferID = 0x01);
    uchar _match(int& score);
    uchar _regModel();
    uchar _store(const uchar addressH, const uchar addressL);
    uchar _search(const uchar pageNumberH, const uchar pageNumberL, int& found, int& score);
    uchar _clear();
    uchar _templateNum(int& templateNum);

    void _test();
    QByteArray _readwriteSerial(QByteArray requestData);
    QList<QString> _readConfigFile();
    void _int2uchars(int templateNum, uchar& addressH, uchar& addressL);

};

#endif // FINGERRECOG_H
