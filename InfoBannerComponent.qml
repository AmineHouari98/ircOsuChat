import QtQuick 2.2
import QtQuick.Window 2.3

Item {
    id: banner

    property alias message : messageText.text
    property alias backgroundMain: background.color

    height: 180

    Rectangle {
        id: background

        anchors.fill: banner
        color: "darkblue"
        smooth: true
        opacity: 0.8
    }

    Text {
        font.pointSize: 24
        renderType: Text.QtRendering
//        width: 150
//        height: 40
        id: messageText


        anchors.fill: banner
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap

        color: "white"
    }

    states: State {
        name: "portrait"
        PropertyChanges { target: banner; height: 100 }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            messages.state = ""
        }
    }
}
