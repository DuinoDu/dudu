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
    //QSerialPort serial;
    QByteArray requestData;

    QString currentPortName = "COM5";
    int waitTimeout = 1000;


    uchar _genImg(QSerialPort& serial);
    uchar _img2Tz(uchar bufferID = 0x01, QSerialPort& serial = static_cast<QSerialPort>(nullptr));
    uchar _match(int& score, QSerialPort& serial);
    uchar _regModel(QSerialPort& serial);
    uchar _store(const uchar addressH, const uchar addressL, QSerialPort& serial);
    uchar _search(const uchar pageNumberH, const uchar pageNumberL, int& found, int& score, QSerialPort& serial);
    uchar _clear(QSerialPort& serial);
    uchar _templateNum(int& templateNum, QSerialPort& serial);

    void _test(QSerialPort& serial);
    QByteArray _readwriteSerial(QByteArray requestData, QSerialPort& serial);
    QList<QString> _readConfigFile();
    void _int2uchars(int templateNum, uchar& addressH, uchar& addressL);
    void _initSerialPort(QSerialPort& serial);

};

#endif // FINGERRECOG_H
