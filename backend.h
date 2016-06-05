#ifndef BACKEND_H
#define BACKEND_H

#include <QQuickItem>
#include <QtSql>

class Backend : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(qreal delta READ delta WRITE setDelta NOTIFY deltaChanged)

    Q_INVOKABLE int insertNew(QString name, QString phone, QString money, QString fingerID1, QString fingerID2, QString password);

    Q_INVOKABLE void select(QString fingerID, QList<QString>& result);

    Q_INVOKABLE void update(QString phone, QString money);

public:
    Backend(QQuickItem *parent = 0);

    qreal delta() const {return m_delta;}
    void setDelta(qreal delta){
        m_delta = delta;
        emit deltaChanged();
    }

signals:
    void deltaChanged();

public slots:

private:
    qreal m_delta;

    QSqlDatabase db;
    QSqlQuery *query;

    void _initDataBase();


};

#endif // BACKEND_H
