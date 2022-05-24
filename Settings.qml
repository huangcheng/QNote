import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog {
    title: qsTr("Settings")
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    property alias url: url.text
    property alias language: language.currentIndex
    readonly property variant languages: ["en_US", "zh_CN"]
    readonly property variant langs: [qsTr("en_US"), qsTr("zh_CN")]

    ColumnLayout {
        RowLayout {
            Text {
                text: qsTr("Url")
                Layout.minimumWidth: 80
                Layout.maximumWidth: 80
                Layout.preferredWidth: 50
                Layout.preferredHeight: 20
                Layout.minimumHeight: 20
            }

            Rectangle {
                color: '#FFF'
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumWidth: 200
                Layout.preferredWidth: 200
                Layout.preferredHeight: 30
                Layout.minimumHeight: 30

                TextInput {
                    id: url
                    clip: true
                    selectByMouse: true

                    anchors.fill: parent
                    verticalAlignment: TextInput.AlignVCenter
                }
            }
        }

        RowLayout {
            Text {
                text: qsTr("Language")

                Layout.minimumWidth: 80
                Layout.maximumWidth: 80
                Layout.preferredWidth: 50
                Layout.preferredHeight: 20
                Layout.minimumHeight: 20
            }

            ComboBox {
                id: language
                model: langs

                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumWidth: 200
                Layout.preferredWidth: 200
                Layout.preferredHeight: 30
                Layout.minimumHeight: 30
            }
        }
    }
}
