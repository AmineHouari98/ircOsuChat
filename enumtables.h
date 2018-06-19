#ifndef ENUMTABLES_H
#define ENUMTABLES_H
#include <QString>
#include <QStringList>
#include <QMetaType>

//class EnumTableFriends
//{
//public:
//    QString tableName ;
//    QStringList columnsList;


//    void EnumColumnFriends()
//    {
//        tableName = "friends";
//        columnsList << "id integer primary key autoincrement not null";
//        columnsList << "Date DATETIME";
//        columnsList << "Username  TEXT";
//    }

//    enum ColumnName
//    {
//        _00id,
//        _01Date,
//        _02Username
//    };
//};

class EnumTableMessages
{
public:
    QString tableName ;
    QStringList columnsList;


    void EnumColumnMessages()
    {
        tableName = "messages";
        columnsList << "id integer primary key autoincrement not null";
        columnsList << "Date DATETIME";
        columnsList << "Identifier TEXT";
        columnsList << "Message TEXT";
        columnsList << "Sender TEXT";



    }

    enum ColumnName
    {
        _00id,
        _01Date,
        _02Identifier,
        _03Message,
        _04Sender,


    };
};



// hadi ki tabgi tarsel ahdi class bin deux class over signal as paramter
// emit save(EnumRecord data ) ;


#endif // ENUMTABLES_H
