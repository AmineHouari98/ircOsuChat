#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "dataparser.h"
#include <QSqlDatabase>
#include <QDebug>
#include <QObject>
#include "myparentobject.h"
#include "enumtables.h"
#include "ircchat.h"




QSqlDatabase bdd ;
bool initDatabase(QString);

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QString databaseName = "bdd.sqlite";
    QString databasePath = QDir::currentPath() ;
    QString databaseLocation = databasePath +"/"+ databaseName ;
    if(!initDatabase(databaseLocation))
        return -1 ;


    dataParser parser;
    ircChat irc;

    QObject::connect(&parser,SIGNAL(checkStatus(QString)),&irc,SLOT(checkConnected(QString)));
    QObject::connect(&irc,SIGNAL(reply(QString,bool)),&parser,SLOT(onCheckStatusReply(QString,bool)));

    engine.rootContext()->setContextProperty("dataParser", &parser);
    engine.rootContext()->setContextProperty("irc", &irc);


    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
bool initDatabase(QString databaseLocation)
{
    bool check = QSqlDatabase::isDriverAvailable("QSQLITE") ;
    if( !check )qDebug()<<"erreur bdd 1";
    bdd = QSqlDatabase::addDatabase("QSQLITE");
    bdd.setDatabaseName(databaseLocation);

    bool ok = bdd.open();
    if ( !ok ) qDebug()<<"erreur bdd";

    return ok ;
}
