#include "backend.h"
#include <QDebug>

Backend::Backend(QQuickItem *parent):QQuickItem(parent)
{
    _initDataBase();
    fingerTh = new FingerThread(rec);
    connect(fingerTh, SIGNAL(createReady(QString)), this, SIGNAL(createReady(QString)));
    connect(fingerTh, SIGNAL(searchReady(QString)), this, SIGNAL(searchReady(QString)));
}


int Backend::insertNew(QString name, QString phone, QString money, QString password, QString fingerID1, QString fingerID2)
{

    qDebug() << name << phone << money << password << fingerID1 << fingerID2;

    query->prepare("insert into customer(name, phone, money, fingerID1, fingerID2, password)VALUES(:name, :phone, :money, :fingerID1, :fingerID2, :password)");
    query->bindValue(":name", name);
    query->bindValue(":phone", phone);
    query->bindValue(":money", money);
    query->bindValue(":fingerID1", fingerID1);
    query->bindValue(":fingerID2", fingerID2);
    query->bindValue(":password", password);


    if (!query->exec()){
        qDebug() << query->lastQuery();

        qDebug() << "Error: Cannot create a new record in customer table.";
        return -1;
    }

    if(!query->exec("select count(*) as currentID from customer")){
        qDebug() << "Error: Cannot get currentID";
        return -1;
    }

    if( query->first()){
        QString currentID = query->value(0).toString();
        //qDebug() << currentID;
        emit message(1, currentID);
    }
    return query->value(0).toInt();

}


QList<QString> Backend::select(QString fingerID)
{
    QList<QString> result;

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
            return result;
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
    if(query->next()){
        result.append(query->value(nameField).toString());
        result.append(query->value(phoneField).toString());
        result.append(query->value(money).toString());
    }

    return result;
}


void Backend::updateMoney(QString phone, QString money)
{
    qDebug() << phone << money;

    query->prepare("update customer set money=?  where phone=? ");
    query->bindValue(0, money);
    query->bindValue(1, phone);

    if(!query->exec()){
        qDebug() << "Error: update failed.";
        return;
    }
    qDebug() << "updata successfully";
}


void Backend::createFinger()
{
    qDebug() << "start multi thead for create finge...";
    fingerTh->flag = 1;
    fingerTh->start();
}


void Backend::recogFinger()
{
    fingerTh->flag = 2;
    fingerTh->start();
}


void Backend::hello(){
    qDebug()<< "Hello, DuDu";
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
