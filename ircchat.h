#ifndef IRCCHAT_H
#define IRCCHAT_H

#include <QObject>
#include <QTcpSocket>
#include <QDebug>
#include "PropertyHelper.h"
#include "myparentobject.h"

class ircChat : public QObject,public myParentObject
{
    Q_OBJECT
public:
    explicit ircChat(QObject *parent = nullptr);
    QTcpSocket *socket;

signals:
    void msgToQml(QString datetime,QString user,QString message);
    void reply(QString,bool);

public slots:
    void onConnectedClicked(QString,QString);
    void send(QString,QString);
    void checkConnected(QString);



private slots:
    void onReadyRead();

private:
    QString userToCheck;

    //AUTO_PROPERTY(QString,buffer)




};

#endif // IRCCHAT_H
