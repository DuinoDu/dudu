#ifndef BACKEND_H
#define BACKEND_H

#include <QQuickItem>
#include <QtSql>
#include <QThread>
#include <QDebug>
#include "fingerrecog.h"


class FingerThread : public QThread
{
    Q_OBJECT
public:
    FingerThread(FingerRecog* rec):rec(rec){}
    ~FingerThread(){}
    int flag = 0;

signals:
    void createReady(QString fingerID);
    void searchReady(QString fingerID);

private:
    FingerRecog *rec;

    void run() Q_DECL_OVERRIDE{
        QString fingerID;
        if(flag == 1){
            fingerID = rec->createFinger();
            emit createReady(fingerID);
        }
        else if(flag == 2){
            fingerID = rec->recogFinger();
            emit searchReady(fingerID);
        }
    }
};


class Backend : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(qreal delta READ delta WRITE setDelta NOTIFY deltaChanged)

public:
    Backend(QQuickItem *parent = 0);

    Q_INVOKABLE int insertNew(QString name, QString phone, QString money, QString password, QString fingerID1, QString fingerID2);

    Q_INVOKABLE QList<QString> select(QString fingerID);

    Q_INVOKABLE QList<QString> searchPhone(QString phone);

    Q_INVOKABLE void updateMoney(QString phone, QString money);

    Q_INVOKABLE void createFinger();

    Q_INVOKABLE void recogFinger(int flag); // 1 is cost, 2 is add

    Q_INVOKABLE void hello();

    qreal delta() const { return m_delta; }
    void setDelta(qreal delta){
        m_delta = delta;
        emit deltaChanged();
    }

signals:
    void deltaChanged();
    void message(int flag, QString msg);
    void createReady(QString fingerID);
    void searchReady(QString fingerID, int searchType);

private slots:
    void _setSearchType(QString fingerID);

private:
    qreal m_delta;

    QSqlDatabase db;
    QSqlQuery *query;

    //FingerRecog rec;
    FingerRecog *rec = NULL;
    FingerThread *fingerTh = NULL;

    int _searchType; // cost or add

    void _initDataBase();


};

#endif // BACKEND_H
