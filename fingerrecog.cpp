#include "fingerrecog.h"
#include <QFile>

#include <QDebug>

FingerRecog::FingerRecog(){}


QString FingerRecog::createFinger()
{

    QSerialPort serial;
    _initSerialPort(serial);

    qDebug() << "start to createFinger...";

    QString fingerID;

    int state = 0;
    bool success = false;

    while( !success ){

        qDebug() << state;

        switch (state) {
        case 0:{
            if( _genImg(serial) == 0) state = 1;
            break;
        }

        case 1:{
            if( _img2Tz(0x01, serial) == 0) state = 2;
            else state = 0;
            break;
        }

        case 2:{
            if( _genImg(serial) == 0) state = 3;
            break;
        }

        case 3:{
            if( _img2Tz(0x02, serial) == 0) state = 4;
            else state = 2;
            break;
        }

        case 4:{
            int score;
            if( _match(score, serial) == 0){
                if(score > 100) state = 5;
                else state = 10; // error
            }
            else
                state = 10;
            break;
        }

        case 5:{
            if( _regModel(serial) ==0) state = 6;
            else state = 10;
            break;
        }

        case 6: {
            int templateNum = 0;
            if( _templateNum(templateNum, serial) != 0)
               state = 10;

            if(templateNum > 1024){
                qDebug() << "too much finger!";
                state  = 10;
                break;
            }

            uchar addressH, addressL;

            _int2uchars(templateNum, addressH, addressL);

            if( _store(addressH, addressL, serial) == 0) {
                success = true;
                fingerID = QString::number(templateNum,10);
            }
            else state = 10;
            break;
        }

        case 10:{
            success = true;
            break;
        }

        default:
            break;
        }
    }

    if(fingerID.length() != 0) qDebug() << "Success, fingerID is" << fingerID;

    return fingerID;
}


QString FingerRecog::recogFinger()
{
    QSerialPort serial;
    _initSerialPort(serial);

    qDebug() << "start to search...";

    QString fingerID;

    int state = 0;
    bool success = false;

    while(!success) {

        qDebug() << state;

        switch (state) {
        case 0:{
            if( _genImg(serial) == 0) state = 1;
            break;
        }

        case 1:{
            if( _img2Tz(0x01, serial) == 0) state = 2;
            else state = 0;
            break;
        }

        case 2:{
            // get amount of all finger template
            int templateNum = 0;
            if( _templateNum(templateNum, serial) != 0)
               state = 10;

            if(templateNum > 1024){
                qDebug() << "too much finger!";
                state  = 10;
                break;
            }
            uchar pageNumberH, pageNumberL;
            _int2uchars(templateNum, pageNumberH, pageNumberL);

            // search
            int foundID, score;

            if( _search(pageNumberH, pageNumberL, foundID, score, serial) == 0) {
                if( score >= 100){
                    fingerID = QString::number(foundID, 10);
                }
                else{
                    qDebug() << "no found finger";
                }
                success = true;
            }
            else
                state = 10;

            break;
        }

        case 10:{
            success = true;
            break;
        }

        default:
            break;
        }
    }

    qDebug() << "fingerID" << fingerID;
    return fingerID;
}


uchar FingerRecog::_genImg(QSerialPort& serial)
{
    requestData.resize(12);

    requestData[7] = 0x00;
    requestData[8] = 0x03; // number of bytes below

    requestData[9] = 0x01; // GenImg

    requestData[10] = 0x00;
    requestData[11] = 0x05;

    QByteArray response = _readwriteSerial(requestData, serial);
    return uchar(response.at(9)); // 00 success; 02 no finger; 03 failed
}


uchar FingerRecog::_img2Tz(uchar bufferID, QSerialPort& serial)
{
    requestData.resize(13);

    requestData[7] = 0x00;
    requestData[8] = 0x04; // number of bytes below

    requestData[9] = 0x02; // Img2Tz
    requestData[10] = bufferID;// BufferID, 01 or 02

    requestData[11] = 0x00;
    requestData[12] = 0x07 + bufferID;

    QByteArray response = _readwriteSerial(requestData, serial);

    qDebug() << uchar(response.at(9));

    return uchar(response.at(9)); // 00 success; 06,07,15 no Tz (image is mess, no enough point, no image)
}


uchar FingerRecog::_match(int& score, QSerialPort& serial)
{
    requestData.resize(12);

    requestData[7] = 0x00;
    requestData[8] = 0x03; // number of bytes below

    requestData[9] = 0x03; // Match

    requestData[10] = 0x00;
    requestData[11] = 0x07;

    QByteArray response = _readwriteSerial(requestData, serial);
    score = uchar(response.at(10)) * 256 + uchar(response.at(11));
    return uchar(response.at(9)); // 00 success; 08 match fail
}


uchar FingerRecog::_regModel(QSerialPort& serial)
{
    requestData.resize(12);

    requestData[7] = 0x00;
    requestData[8] = 0x03; // number of bytes below

    requestData[9] = 0x05; // RegModel

    requestData[10] = 0x00;
    requestData[11] = 0x09;

    QByteArray response = _readwriteSerial(requestData, serial);
    return uchar(response.at(9)); // 00 success; 0a(十进制下的10) fail
}


uchar FingerRecog::_store(const uchar addressH, const uchar addressL, QSerialPort& serial)
{
    requestData.resize(15);

    requestData[7] = 0x00;
    requestData[8] = 0x06;  // number of bytes below

    requestData[9] = 0x06;  // Store
    requestData[10] = 0x01; // BufferID
    requestData[11] = addressH;  //0x00;
    requestData[12] = addressL; //0x00; // PageID

    int sumCheck = 0;
    for(int i = 6; i < 13; i++) sumCheck += requestData[i];
    uchar sumH, sumL;
    _int2uchars(sumCheck, sumH, sumL);

    requestData[13] = sumH;
    requestData[14] = sumL;

    QByteArray response = _readwriteSerial(requestData, serial);
    return uchar(response.at(9)); // 00 success; 0b(十进制下的11) PageID exceed, 0x18(十进制下的24) error writing Flash
}


uchar FingerRecog::_search(const uchar pageNumberH, const uchar pageNumberL, int& found, int& score, QSerialPort& serial)
{
    requestData.resize(17);

    requestData[7] = 0x00;
    requestData[8] = 0x08;  // number of bytes below

    requestData[9] = 0x04;  // Store
    requestData[10] = 0x01; // BufferID
    requestData[11] = 0x00; // StartPage
    requestData[12] = 0x00;
    requestData[13] = pageNumberH; // PageNumber
    requestData[14] = pageNumberL;

    int sumCheck = 0;
    for(int i = 6; i < 15; i++) sumCheck += requestData[i];
    uchar sumH, sumL;
    _int2uchars(sumCheck, sumH, sumL);

    requestData[15] = sumH;
    requestData[16] = sumL;

    QByteArray response = _readwriteSerial(requestData, serial);
    found = uchar(response.at(10)) * 256 + uchar(response.at(11));
    score = uchar(response.at(12)) * 256 + uchar(response.at(13));
    return uchar(response.at(9)); // 00 success; 0b(十进制下的11) PageID exceed, 0x18(十进制下的24) error writing Flash
}


uchar FingerRecog::_templateNum(int& templateNum, QSerialPort& serial)
{
    requestData.resize(12);

    requestData[7] = 0x00;
    requestData[8] = 0x03; // number of bytes below

    requestData[9] = 0x1d; // get template number

    requestData[10] = 0x00;
    requestData[11] = 0x21;

    QByteArray response = _readwriteSerial(requestData, serial);
    templateNum = uchar(response.at(10)) * 256 + uchar(response.at(11));
    return uchar(response.at(9)); // 00 success;
}


uchar FingerRecog::_clear(QSerialPort& serial)
{
    requestData.resize(12);

    requestData[7] = 0x00;
    requestData[8] = 0x03; // number of bytes below

    requestData[9] = 0x0d; // clear

    requestData[10] = 0x00;
    requestData[11] = 0x11;

    QByteArray response = _readwriteSerial(requestData, serial);
    return uchar(response.at(9)); // 00 success; 0x11(17) failed
}


void FingerRecog::_test(QSerialPort& serial)
{
    requestData.resize(16);

    requestData[7] = 0x00;
    requestData[8] = 0x07; // number of bytes below

    requestData[9] = 0x13; // this 5 bytes are the main content
    requestData[10] = 0x00;
    requestData[11] = 0x00;
    requestData[12] = 0x00;
    requestData[13] = 0x00;

    requestData[14] = 0x00;
    requestData[15] = 0x1b; // sum of 01 + 07 + 13 = 1b

    QByteArray responseData = _readwriteSerial(requestData, serial);
    qDebug() << responseData;
}


QByteArray FingerRecog::_readwriteSerial(QByteArray requestData, QSerialPort& serial)
{
    serial.write(requestData);

    QByteArray responseData;
    if(serial.waitForBytesWritten(waitTimeout)){
        if(serial.waitForReadyRead(waitTimeout)){
            responseData = serial.readAll();
            while (serial.waitForReadyRead(10))
                responseData += serial.readAll();
        }
    }

    return responseData;
}

QList<QString> FingerRecog::_readConfigFile()
{
    QFile f("config.ini");
    QList<QString> out;
    if(!f.open(QIODevice::ReadOnly))
    {
        qDebug() << "No config.ini, use default configuration";
        return out;
    }
    QTextStream txtInput(&f);
    while(!txtInput.atEnd())
        out.append(txtInput.readLine());
    f.close();

    qDebug() << "read from file" << out;

    return out;
}

void FingerRecog::_int2uchars(int templateNum, uchar& addressH, uchar& addressL)
{
    addressH = uchar(templateNum / 256);
    addressL = uchar(templateNum % 256);
}



void FingerRecog::_initSerialPort(QSerialPort& serial)
{
    // init serial and open serial
    auto config = _readConfigFile();
    if(config.length() == 0){
        currentPortName = "COM5";
    }
    else{
        currentPortName = config.at(0);
    }

    serial.setPortName(currentPortName);
    serial.setBaudRate(QSerialPort::Baud57600);

    if (!serial.open(QIODevice::ReadWrite)) {
        qDebug() << (tr("Can't open %1, error code %2").arg(currentPortName).arg(serial.error()));
        return;
    }

    // base data for requestData
    requestData.resize(7);
    requestData[0] = 0xef;
    requestData[1] = 0x01;
    requestData[2] = 0xff;
    requestData[3] = 0xff;
    requestData[4] = 0xff;
    requestData[5] = 0xff;
    requestData[6] = 0x01;
}
