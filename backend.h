#ifndef BACKEND_H
#define BACKEND_H

#include <QQuickItem>
#include <QtSql>
#include <QDebug>
#include "fingerrecog.h"
#include "fingerthread.h"


class Backend : public QQuickItem
{
    Q_OBJECT

public:
    Backend(QQuickItem *parent = 0);

    Q_INVOKABLE int insertNew(QString name, QString phone, QString money, QString password, QString fingerID1, QString fingerID2);

    Q_INVOKABLE QList<QString> select(QString fingerID);

    Q_INVOKABLE QList<QString> searchPhone(QString phone);

    Q_INVOKABLE void updateMoney(QString phone, QString money);

    Q_INVOKABLE void createFinger();

    Q_INVOKABLE void recogFinger(int flag); // 1 is cost, 2 is add

    Q_INVOKABLE void closePort();

signals:
    void message(int flag, QString msg);
    void createReady(QString fingerID);
    void searchReadyCost(QString fingerID);
    void searchReadyAdd(QString fingerID);

private slots:
    void searchReady(QString fingerID);

private:

    QSqlDatabase db;
    QSqlQuery *query;

    FingerThread *fingerTh = NULL;
    FingerRecog *rec = NULL;

    enum SEARCHTYPE{ COST, ADD };

    SEARCHTYPE _searchType = COST; // cost or add

    void _initDataBase();


};

#endif // BACKEND_H
