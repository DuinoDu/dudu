#ifndef FINGERTHREAD_H
#define FINGERTHREAD_H

#include <QThread>
#include "fingerrecog.h"

class FingerThread : public QThread
{
    Q_OBJECT
public:
    FingerThread(FingerRecog* rec);
    ~FingerThread();

    enum FingerUseType{ CREATE, SEARCH };

    FingerUseType type = SEARCH;

signals:
    void createReady(QString fingerID);
    void searchReady(QString fingerID);

private:
    FingerRecog *rec;
    void run();

};


#endif // FINGERTHREAD_H
