#ifndef FINGERRECOG_H
#define FINGERRECOG_H

#include <QObject>
#include <QtSerialPort/QSerialPort>

class FingerRecog : public QObject
{
    Q_OBJECT
public:
    FingerRecog();

    // this two function should run in second thread

    QString createFinger();

    QString recogFinger();

    bool isOpen = false;

    // a public method for the main thread to exit the second thread

    void closePort(){ isOpen = false; }

signals:

public slots:

private:
    //QSerialPort serial;
    QByteArray requestData;

    QString currentPortName = "COM5";
    int waitTimeout = 1000;


    uchar _genImg(QSerialPort& serial);
    uchar _img2Tz(uchar bufferID, QSerialPort& serial);
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

    //bool _ifClose = true;

};

#endif // FINGERRECOG_H
