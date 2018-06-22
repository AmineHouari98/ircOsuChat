#include "ircchat.h"

ircChat::ircChat(QObject *parent) : QObject(parent)
{
    socket = new QTcpSocket(this);
    connect(socket,SIGNAL(readyRead()),this,SLOT(onReadyRead()));
}
void ircChat::onReadyRead()
{

    QString buffer = socket->readAll();
    QString line="";
    QStringList bufferList = buffer.split("\n");

    for(int i=0;i<bufferList.length();i++)
    {
        line = bufferList.at(i);
                    qDebug()<<line;


        line.remove(":");
        line.remove("!cho@ppy.sh");

        if(
                line.contains("QUIT",Qt::CaseSensitive)
                ||line.contains("PING",Qt::CaseSensitive)
                ||line.contains("JOIN",Qt::CaseSensitive)
                ||line.contains("PART",Qt::CaseSensitive)
                ||line.isEmpty() || line==" " ||line.contains("cho.ppy.sh")
                ||line.contains("\"\"\"\"\"\"\"\"\"\"\"/")
                )

            continue;
        //condition pour voir qui est connecter

        else if(line.contains("PRIVMSG"))
        {
            QStringList decLine=line.split(" ");

            QString sender=decLine[0];
            QString msg;
            if(decLine.length()>=3)
                for(int i = 3;i<decLine.length();i++)
                    msg+=decLine[i]+" ";

            checkNewUser(sender.toLower());
            emit msgToQml(getCurrentDateTime(),sender.toLower(),msg);


        }
        else if(line.contains(userToCheck))
        {
            qDebug()<<line;
            QStringList decLine=line.split(" ");
            QString sender=decLine[3];
            QString msg;
            if(decLine.length()>=4)
                for(int i = 4;i<decLine.length();i++)
                    msg+=decLine[i]+" ";

            qDebug()<<sender;
            qDebug()<<msg;

            if(msg.contains("No such nick/channel")) emit reply(sender,false);
            else if(msg.contains("https")) emit reply(sender,true);

        }
    }



}
void ircChat::onConnectedClicked(QString username,QString password)
{
    socket->connectToHost("irc.ppy.sh",6667);
    QString pass = "PASS "+password+"\r\n";
    QString user = "NICK "+username+"\r\n";

    socket->write(pass.toLatin1());
    socket->write(user.toLatin1());

}
void ircChat::send(QString username, QString msg)
{
    QString message = "PRIVMSG "+username+" "+msg+"\r\n";
    socket->write(message.toLatin1());


}
void ircChat::checkConnected(QString usr)
{
    userToCheck=usr;
    QString message = "WHOIS "+usr+"\r\n";
    socket->write(message.toLatin1());
}

void ircChat::checkNewUser(QString usr)
{
    QStringList list = getColumnFromTableWithoutDuplicates("messages","Identifier");
    QString buff;
    QStringList buffList;
    for(int i = 0;i<list.length();i++)
    {
        buff = list[i];
        buffList = buff.split("///");
        qDebug()<<buffList[1];
        if(usr== buffList[1]) return;

        emit newUser(buffList[1],false);
    }
}
