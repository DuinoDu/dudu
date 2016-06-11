#include "fingerthread.h"


FingerThread::FingerThread(FingerRecog* rec)
    :rec(rec){}


FingerThread::~FingerThread(){}


void FingerThread::run()
{
    QString fingerID;

    if(type == CREATE){
        fingerID = rec->createFinger();
        emit createReady(fingerID);
    }
    else if(type == SEARCH){
        fingerID = rec->recogFinger();
        emit searchReady(fingerID);
    }
}
