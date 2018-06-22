import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import "qrc:///WebAPI.js" as WebAPI


Page {
    id:root

    property string currentUser: ""
    property string  userConnected: dataParser.username
    property string userConnectedId: ""
    readonly property bool inPortrait: window.width < window.height



    Dialog {
        id: dialog
        title: "Title"
        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: console.log("Ok clicked")
        onRejected: console.log("Cancel clicked")

        Label {
            text: "are you sure to delete the conversation with " + currentUser
        }
    }
    ToolBar {
        id: overlayHeader

        z: 1
        width: parent.width
        parent: window.overlay

        Label {
            id: label
            anchors.centerIn: parent
            text:currentUser


        }
    }
    Drawer {
        id: drawer
        y: overlayHeader.height
        width: inPortrait?(window.width / 2):(window.width / 2.5)
        height: window.height - overlayHeader.height
        modal: inPortrait
        interactive: inPortrait
        position: inPortrait ? 0 : 1
        visible: !inPortrait


        ListView {
            id: listView
            anchors.fill: parent
            headerPositioning: ListView.OverlayHeader
            footerPositioning: ListView.OverlayFooter
            header: Pane {
                id: header
                z: 2
                width: parent.width

                contentHeight: logo.height


                Image {
                    id: logo
                    width: parent.width*0.66
                    source: "https://a.ppy.sh/"+userConnectedId
                    fillMode: implicitWidth > width ? Image.PreserveAspectFit : Image.Pad
                    anchors.centerIn: parent
                }

                MenuSeparator {
                    parent: header
                    width: parent.width
                    anchors.verticalCenter: parent.bottom
                    visible: !listView.atYBeginning
                }
            }
            footer: ItemDelegate {
                id: footer
                width: parent.width


                MenuSeparator {
                    parent: footer
                    width: parent.width
                    anchors.verticalCenter: parent.top

                }


                Item{
                    id:xDiD
                    width: parent.width

                    RowLayout {
                        width: parent.width
                        TextArea {
                            id: messageFieldId
                            Layout.fillWidth: true
                            placeholderText: qsTr("add user")
                            wrapMode: TextArea.Wrap
                        }
                        Button {
                            id: sendButtonId
                            text: qsTr("+")
                            enabled: messageFieldId.length > 0
                            onClicked: {
                                usersModel.append({user: messageFieldId.text})
                                dataParser.addToFile(messageFieldId.text,"welcome this message was sent from hOsu!",userConnected)
                                irc.checkConnected(messageFieldId.text)
                                myModel.clear()
                                dataParser.showConvoList(messageFieldId.text)
                                currentUser=messageFieldId.text
                                irc.send(messageFieldId.text,"welcome this message was sent from hOsu!")
                            }
                        }
                    }



                }

            }
            ListModel {
                id: usersModel

            }
            model: usersModel //the string list here
            delegate:ItemDelegate {

                width: parent.width

                Item{
                    width: parent.width

                    RowLayout {
                        width: parent.width

                        //                        Button {
                        //                            id: deleteButtonId
                        //                            text: qsTr("x")
                        //                            height: 50
                        //                            onClicked: {
                        //                                dialog.open()
                        //                            }
                        //                        }

                        Button {
                            id: friendId
                            Layout.fillWidth: true
                            text:user
                            onClicked: {
                                myModel.clear()
                                dataParser.showConvoList(text)
                                currentUser=text
                            }
                        }
                    }



                }

            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }

    }
    Flickable {
        id: flickable
        anchors.fill: parent
        anchors.topMargin: overlayHeader.height
        anchors.leftMargin: !inPortrait ? drawer.width : undefined
        Image{
            anchors.fill: parent
            source:"qrc:/icons/page.png"
        }
        ListModel {
            id: myModel

        }
        ListView {
            id: column
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top:parent.top
            anchors.bottom: pane.top
            footerPositioning: ListView.OverlayFooter
            displayMarginBeginning: 40
            displayMarginEnd: 40
            verticalLayoutDirection: ListView.BottomToTop
            spacing: 6
            model:myModel
            delegate: Row {
                readonly property bool sentByMe: iSent
                anchors.right: sentByMe ? parent.right : undefined
                anchors.left: sentByMe ? undefined : parent.left
                anchors.rightMargin: 5
                anchors.leftMargin:5

                Item{
                    width: rectId.width
                    height: rectId.height

                    Rectangle {
                        id:rectId
                        color: sentByMe ?Material.color(Material.Grey): Material.color(Material.Pink,Material.Shade200)
                        width: Math.min(Math.max(txMsgId.implicitWidth,txDateId.implicitWidth,txUserId.implicitWidth) + 40, column.width - 10)
                        height: txMsgId.height + txUserId.height + txDateId.height +50
                        //border.color: sentByMe ?Material.color(Material.Grey,Material.ShadeA700): Material.color(Material.Pink,Material.ShadeA200)
                        radius:10
                        opacity: 0.8
                        anchors.horizontalCenter: parent.horizontalCenter




                    }
                    Text{
                        id:txUserId
                        text: username
                        font.bold: true
                        font.italic: true
                        anchors.top:rectId.top
                        anchors.left: rectId.left
                        anchors.margins: 8
                        font.pointSize: 10
                        opacity: 1
                        color:"white"



                    }

                    Text{
                        id:txMsgId
                        text:msg
                        font.pointSize: 12
                        verticalAlignment: Text.AlignVCenter
                        anchors.left: rectId.left
                        anchors.verticalCenter: rectId.verticalCenter
                        anchors.margins: 8
                        width: rectId.width
                        wrapMode: Text.Wrap
                        color: "white"





                    }

                    Text{
                        id:txDateId
                        text:date
                        font.pointSize: 8
                        anchors.bottom: rectId.bottom
                        anchors.right: rectId.right
                        anchors.margins: 8
                        color: "white"

                    }

                }


            }
            ScrollIndicator.vertical: ScrollIndicator {}
        }
        Pane {
            id: pane
            Layout.fillWidth: true
            anchors.bottom: parent.bottom
            width:parent.width
            RowLayout {
                width: parent.width
                TextArea {
                    id: messageField
                    Layout.fillWidth: true
                    placeholderText: qsTr("Compose message")
                    wrapMode: TextArea.Wrap
                    Keys.onReturnPressed: {
                        if(messageField.length > 0){
                            irc.send(currentUser,messageField.text)
                            dataParser.addToFile(currentUser,messageField.text,userConnected)
                            console.log("in qml :"+userConnected+"  "+messageField.text)
                            myModel.insert(0,{date: dataParser.getTime(),username:userConnected, msg:messageField.text,iSent:true})
                            messageField.text = "";
                            event.accepted = true;
                        }


                    }


                }
                Button {
                    id: sendButton
                    text: qsTr("Send")
                    enabled: messageField.length > 0
                    onClicked: {//send message
                        irc.send(currentUser,messageField.text)
                        dataParser.addToFile(currentUser,messageField.text,userConnected)
                        console.log("in qml :"+userConnected+"  "+messageField.text)
                        myModel.insert(0,{date: dataParser.getTime(),username:userConnected, msg:messageField.text,iSent:true})
                        messageField.text = "";
                    }
                }
            }
        }

    }
    Audio {
        id: playMusic
        source: "qrc:/sounds/msg.wav"
    }
    Connections{
        target:dataParser
        onMsgToQml:
        {
            myModel.insert(0,{date: datetime,username:user,msg:message,iSent:isMe})
        }
        onNewUser:
        {
            usersModel.append({user:uname})
        }

    }
    Connections{
        target:irc
        onMsgToQml:
        {
            if(user===currentUser)
            {

                myModel.insert(0,{date: datetime,username:user,msg:message,iSent:false})
                dataParser.addToFile(user,message,user)


            }
            else{

                dataParser.addToFile(user,message,user)
                messages.displayMessageColor("New Message From "+user,"darkgreen");

            }
            playMusic.play()


        }
        onNewUser:
        {
            usersModel.append({user:uname})
        }
    }
    InfoBanner{
        id:messages
        width: flickable.width
        anchors.right: flickable.right
    }
    Component.onCompleted: {
        dataParser.show()
        WebAPI.get_Method("https://osu.ppy.sh/api/get_user?u="+dataParser.username+"&k=2211058260cfc8af0fd3eec5734c0721118b5490")

    }


}
