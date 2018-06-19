#ifndef DATAPARSER_H
#define DATAPARSER_H

#include <QObject>
#include <QDir>
#include "myparentobject.h"
#include "PropertyHelper.h"
#include "ircchat.h"

class dataParser : public QObject,public myParentObject
{
    Q_OBJECT
public:
    explicit dataParser(QObject *parent = nullptr);





signals:
    void msgToQml(QString datetime,QString user,QString message,bool isMe);
    void newUser(QString uname,bool connected);
    void checkStatus(QString);
public slots:
    void show();
    void showConvoList(QString username);
    void addToFile(QString,QString,QString);
    void onCheckStatusReply(QString,bool);
    QString getTime();


private:
    //ircChat *irc;
    QDir dir;
    QString path;
    QStringList friends_list;
    QStringList convo_list;
    AUTO_PROPERTY(QString,username)

};

#endif // DATAPARSER_H
