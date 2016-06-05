#include "backend.h"
#include <QDebug>

Backend::Backend(QQuickItem *parent):QQuickItem(parent)
{
    _initDataBase();

}


int Backend::insertNew(QString name, QString phone, QString money, QString fingerID1, QString fingerID2, QString password)
{
    query->prepare("insert into customer(name, phone, money, fingerID1, fingerID2, password)VALUES(:name, :phone, :money, :fingerID, :password)");
    query->bindValue(":name", name);
    query->bindValue(":phone", phone);
    query->bindValue(":money", money);
    query->bindValue(":fingerID1", fingerID1);
    query->bindValue(":fingerID2", fingerID2);
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


void Backend::select(QString fingerID, QList<QString>& result)
{
    QString filter;
    filter.append("fingerID1=");
    filter.append("\"");
    filter.append(fingerID);
    filter.append("\"");

    QString selectQuery;
    selectQuery.append("select * from customer where ");
    selectQuery.append(filter);

    if (!query->exec(selectQuery)){
        filter.clear();
        selectQuery.clear();

        filter.append("fingerID2=");
        filter.append("\"");
        filter.append(fingerID);
        filter.append("\"");
        selectQuery.append("select * from customer where ");
        selectQuery.append(filter);

        if(!query->exec(selectQuery)){
            qDebug() << "select failed.\n";
            return;
        }
        else{
            qDebug() << "select success\n";
        }
    }
    else{
        qDebug() << "select success\n";
    }

    int nameField = query->record().indexOf("name");
    int phoneField = query->record().indexOf("phone");
    int money = query->record().indexOf("money");
    while(query->next()){
        //QList<QString> result;
        result.append(query->value(nameField).toString());
        result.append(query->value(phoneField).toString());
        result.append(query->value(money).toString());
        //emit
    }
}


void Backend::update(QString phone, QString money)
{
    qDebug() << phone << money;
}


void Backend::_initDataBase()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("dudu.db");
    db.open();
    if (!db.isOpen())
    {
        qDebug() << "open database failed ---" << db.lastError().text() << "/n";
        return;
    }

     qDebug() << "init database successful.";

    query = new QSqlQuery(db);
    bool ok = query->exec("CREATE TABLE IF NOT EXISTS  customer (id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "name VARCHAR(20) NOT NULL,"
        "phone VARCHAR(10) NOT NULL,"
        "money VARCHAR(10) NOT NULL,"
        "fingerID1 VARCHAR(10) NOT NULL,"
        "fingerID2 VARCHAR(10) NOT NULL,"
        "password VARCHAR(10) NOT NULL)");
    if (ok)
        qDebug() << "Create table success\n";
    else
        qDebug() << "Create table failed\n";
}
