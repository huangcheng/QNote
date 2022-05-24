import QtQuick

Rectangle {
    property string text: ''
    signal clicked()

    height: 24
    width: 72
    radius: 20

    Text {
        text: parent.text
        color: '#FFF'
        font.weight: Font.Medium

        anchors.centerIn: parent
    }

    MouseArea {
        onClicked: parent.clicked()
        anchors.fill: parent
    }
}
