#include "backend.h"
#include <QDebug>

Backend::Backend(QQuickItem *parent):QQuickItem(parent)
{
    _initDataBase();

}

int Backend::insertNew(QString name, QString phone, QString money, QString fingerID, QString password)
{
    query->prepare("insert into customer(name, phone, money, fingerID, password)VALUES(:name, :phone, :money, :fingerID, :password)");
    query->bindValue(":name", name);
    query->bindValue(":phone", phone);
    query->bindValue(":money", money);
    query->bindValue(":fingerID", fingerID);
    query->bindValue(":password", password);


    if (!query->exec()){
        qDebug() << "Error: Cannot create a new record in ttm table.";
        return -1;
    }

    if(!query->exec("select count(*) as currentID from ttm")){
        qDebug() << "Error: Cannot get currentID";
        return -1;
    }

    if( query->first())
        QString currentID = query->value(0).toString();
    return query->value(0).toInt();

}

void Backend::_initDataBase()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("dudu.db");
    if (!db.isOpen())
    {
        qDebug() << "open database failed ---" << db.lastError().text() << "/n";
        return;
    }

    query = new QSqlQuery(db);
    bool ok = query->exec("CREATE TABLE IF NOT EXISTS  customer (id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "name VARCHAR(20) NOT NULL,"
        "phone VARCHAR(10) NOT NULL,"
        "money VARCHAR(10) NOT NULL,"
        "fingerID VARCHAR(10) NOT NULL,"
        "password VARCHAR(10) NOT NULL");
    if (ok)
        qDebug() << "Create table success\n";
    else
        qDebug() << "Create table failed\n";
}
