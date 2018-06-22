#include "dataparser.h"

#include <QDebug>
#include <QThread>

dataParser::dataParser(QObject *parent) : QObject(parent)
{

    initializeTables();
    tModel->setTable("messages");

}
void dataParser::show()
{
    QStringList list = getColumnFromTableWithoutDuplicates("messages","Identifier");
    QString buff;
    QStringList buffList;
    for(int i = 0;i<list.length();i++)
    {
        buff = list[i];
        buffList = buff.split("///");

        emit newUser(buffList[1],false);
        //emit checkStatus(buffList[1]);
    }

}
void dataParser::showConvoList(QString username)
{
    QString identifier = a_username+"///"+username;
    tModel->setFilter("Identifier LIKE '"+identifier+"'ORDER BY Date");
    tModel->select();


    for(int i = 0;i < tModel->rowCount(); i++ )
    {

        bool isMe=false;
        QString date = tModel->index(i,EnumTableMessages::_01Date).data().toString();
        QString msg = tModel->index(i,EnumTableMessages::_03Message).data().toString();
        QString sender = tModel->index(i,EnumTableMessages::_04Sender).data().toString();
        if(sender==a_username)isMe=true;
        emit msgToQml(date,sender,msg,isMe);

    }
}
void dataParser::addToFile(QString user, QString msg, QString ss)
{
    int row = tModel->rowCount();
    tModel->insertRow(row);
    tModel->setData(tModel->index(row,EnumTableMessages::_01Date) ,getCurrentDateTime()) ;
    tModel->setData(tModel->index(row,EnumTableMessages::_02Identifier) ,a_username+"///"+user.toLower()) ;
    tModel->setData(tModel->index(row,EnumTableMessages::_03Message) ,msg) ;
    tModel->setData(tModel->index(row,EnumTableMessages::_04Sender) ,ss.toLower()) ;
    if( !tModel->submitAll() ) msgCritical("insertion error", tModel->lastError().text());

}
void dataParser::onCheckStatusReply(QString usr, bool sts)
{
    emit newUser(usr,sts);
}

QString dataParser::getTime()
{
    return getCurrentDateTime();
}

