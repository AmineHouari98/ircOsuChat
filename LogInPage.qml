import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.2



Page {
    id: loginPage

    signal registerClicked()

    property color backGroundColor : "#394454"
    property color mainAppColor: Material.color(Material.Pink,Material.Shade200)
    property color mainTextCOlor: "black"
    property color popupBackGroundColor: "#b44"
    property color popupTextCOlor: "#ffffff"


    Flickable {
        id: flickable
        anchors.fill: parent

        Image {
            anchors.fill: parent
            source: "qrc:/icons/page.png"
        }
        ColumnLayout {
            anchors.fill: parent
            spacing: 15

            Image{

                width:parent.width/2
                height: width

                source:"qrc:/icons/Osu!Logo.png"
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter

            }

            TextField {
                id: loginUsername
                placeholderText: qsTr("Username")
                Layout.preferredWidth: parent.width - 20
                Layout.alignment: Qt.AlignHCenter
                color: mainTextCOlor
                font.pointSize: 14
                font.family: "fontawesome"
                leftPadding: 30
                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 50
                    radius: implicitHeight / 2
                    color: "transparent"

                    Text {
                        text: "\uf007"
                        font.pointSize: 14
                        font.family: "fontawesome"
                        color: mainAppColor
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: 10
                    }

                    Rectangle {
                        width: parent.width - 10
                        height: 1
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        color: mainAppColor
                    }
                }
            }

            TextField {
                id: loginPassword
                placeholderText: qsTr("Password")
                Layout.preferredWidth: parent.width - 20
                Layout.alignment: Qt.AlignHCenter
                color: mainTextCOlor
                font.pointSize: 14
                font.family: "fontawesome"
                leftPadding: 30
                echoMode: TextField.PasswordEchoOnEdit
                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 50
                    radius: implicitHeight / 2
                    color: "transparent"
                    Text {
                        text: "\uf023"
                        font.pointSize: 14
                        font.family: "fontawesome"
                        color: mainAppColor
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: 10
                    }

                    Rectangle {
                        width: parent.width - 10
                        height: 1
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        color: mainAppColor
                    }
                }
            }

            Item {
                height: 20
            }

            CButton{
                height: 50
                Layout.preferredWidth: loginPage.width - 20
                Layout.alignment: Qt.AlignHCenter
                name: "Log In"
                baseColor: mainAppColor
                borderColor: mainAppColor
                myColor: "white"
                onClicked: {

                    if(loginUsername.length>0 && loginPassword.length>0 ){
                        irc.onConnectedClicked(loginUsername.text,loginPassword.text)
                        dataParser.username=loginUsername.text
                        stackView.replace("qrc:/MainPage.qml")

                    }else banner.displayMessageColor("The Username or Password Field Is Empty","darkred")

                }
            }

            CButton{
                height: 50
                Layout.preferredWidth: loginPage.width - 20
                Layout.alignment: Qt.AlignHCenter
                name: "Sign Up"
                baseColor: "transparent"
                borderColor: mainAppColor
                myColor: Material.color(Material.Pink,Material.Shade200)
                onClicked: Qt.openUrlExternally("https://osu.ppy.sh/p/irc") //registerClicked()
            }


        }

    }

    InfoBanner{
        id:banner

    }
}
