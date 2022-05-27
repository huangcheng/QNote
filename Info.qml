import QtQuick
import QtQuick.Controls

Dialog {
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    property alias text: text.text

    Text {
        id: text

        anchors.fill: parent
    }
}
