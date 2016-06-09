#ifndef BACKEND_H
#define BACKEND_H

#include <QQuickItem>
#include <QtSql>
#include <QDebug>
#include "fingerrecog.h"

class Backend : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(qreal delta READ delta WRITE setDelta NOTIFY deltaChanged)

public:
    Backend(QQuickItem *parent = 0);

    Q_INVOKABLE int insertNew(QString name, QString phone, QString money, QString password, QString fingerID1, QString fingerID2);

    Q_INVOKABLE QList<QString> select(QString fingerID);

    Q_INVOKABLE void updateMoney(QString phone, QString money);

    Q_INVOKABLE QString createFinger();

    Q_INVOKABLE QString recogFinger();

    Q_INVOKABLE void hello();

    qreal delta() const { return m_delta; }
    void setDelta(qreal delta){
        m_delta = delta;
        emit deltaChanged();
    }

signals:
    void deltaChanged();
    void message(int flag, QString msg);

public slots:

private:
    qreal m_delta;

    QSqlDatabase db;
    QSqlQuery *query;

    FingerRecog rec;

    void _initDataBase();


};

#endif // BACKEND_H
