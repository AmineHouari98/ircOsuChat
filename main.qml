import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {


    id:window
    visible: true
    width: 640
    height: 600
    title: qsTr("hOsu!")
  // Main stackview
    StackView{
        id: stackView
        focus: true
        anchors.fill: parent
    }

    // After loading show initial Login Page
    Component.onCompleted: {
        stackView.push("qrc:/LogInPage.qml")   //initial page

    }


}



