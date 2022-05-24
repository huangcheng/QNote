import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Qt.labs.platform
import QNote
import QNote.Components

import service

Window {
    id: window
    width: 320
    height: 282
    visible: false
    flags: Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint
    color: 'transparent'

    readonly property string borderColor: '#a4a4a4'
    readonly property string themeColor: '#FFA500'

    onActiveChanged: {
        if (!active) {
            window.hide()
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height

        anchors.verticalCenter: parent.verticalCenter

        border.color: borderColor
        border.width: 1
        radius: 4
    }

    Rectangle {
        id: titleBar
        height: 30
        width: parent.width -2
        radius: 2
        color: window.themeColor

        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.left: parent.left
        anchors.leftMargin: 1

        MouseArea {
            id: settingIcon
            width: 20
            height: 20

            anchors.right: parent.right
            anchors.rightMargin: 10

            anchors.verticalCenter: parent.verticalCenter

            Image {
                source: "qrc:QNote/images/setting.png"
                anchors.fill: parent
            }

            onClicked: {
                setting.visible = true
            }
        }

        MouseArea {
            id: moreIcon
            width: 20
            height: 20

            anchors.right: settingIcon.left
            anchors.rightMargin: 10

            anchors.verticalCenter: parent.verticalCenter

            Image {
                source: "qrc:QNote/images/more.png"
                anchors.fill: parent
            }

            onClicked: {
                menu.open()
            }

            Menu {
                id: menu
                MenuItem {
                    text: qsTr("About")
                }

                MenuItem {
                    text: qsTr("Quit")
                    onTriggered: Qt.quit()
                }
            }
        }

        Rectangle {
            width: parent.width
            height: 1
            color: window.themeColor
            anchors.left: parent.left
            anchors.bottom: parent.bottom
        }
    }

    Rectangle {
        id: editWrap
        width: parent.width - 2 - 20
        height: parent.height - titleBar.height - footer.height - 2 - 20

        anchors.left: parent.left
        anchors.leftMargin: 11
        anchors.rightMargin: 11
        anchors.topMargin: 11
        anchors.top: titleBar.bottom

        ScrollView {
            anchors.fill: parent

            TextArea {
                id: edit
                width: parent.width
                height: parent.height

                wrapMode: TextEdit.Wrap
                textFormat: TextEdit.PlainText
                selectByMouse: true
            }
        }
    }

    Rectangle {
        id: footer
        width: parent.width - 2
        height: 40
        radius: 2

        anchors.top: editWrap.bottom
        anchors.left: parent.left
        anchors.leftMargin: 1
        anchors.topMargin: 10
        anchors.bottomMargin: 1

        Rectangle {
            width: parent.width
            height: 1

            color: window.borderColor
            anchors.left: parent.left
            anchors.top: parent.top
        }

        Button {
            text: qsTr("Save")
            color: window.themeColor

            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                service.content = edit.text

                service.send()
            }
        }
    }

    Service {
        id: service
        url: settings.url
    }

    SystemTrayIcon {
        id: tray
        visible: true
        icon.source: "qrc:QNote/images/icon.png"

        function getTaskbarPosition(x, y) {
            const center = {
                "x": Screen.width / 2,
                "y": Screen.height / 2
            }

            if (Screen.desktopAvailableHeight !== Screen.height
                    && y < center.y) {
                return Constants.taskbarPositionTop
            } else if (Screen.desktopAvailableHeight !== Screen.height
                       && y > center.y) {
                return Constants.taskbarPositionBottom
            } else if (Screen.desktopAvailableWidth !== Screen.width
                       && x < center.x) {
                return Constants.taskbarPositionLeft
            } else if (Screen.desktopAvailableWidth !== Screen.width
                       && x > center.x) {
                return Constants.taskbarPositionRight
            }

            return Constants.taskbarPositionBottom
        }

        function getTaskbarSize(x, y) {
            const position = getTaskbarPosition(x, y)

            if (position === Constants.taskbarPositionLeft
                    || position === Constants.taskbarPositionRight) {
                return Screen.width - Screen.desktopAvailableWidth
            }

            return Screen.height - Screen.desktopAvailableHeight
        }

        function getWindowPosition(x, y) {
            const position = getTaskbarPosition(x, y)
            const size = getTaskbarSize(x, y)
            const gap = 2

            let pos = {
                x: 0,
                y: 0,
            };

            if (position === Constants.taskbarPositionLeft) {
                pos = {
                    "x": size + gap,
                    "y": y - window.height / 2
                }
            } else if (position === Constants.taskbarPositionRight) {
                pos = {
                    "x": Screen.width - size - window.width - gap,
                    "y": y - window.height / 2
                }
            } else if (position === Constants.taskbarPositionBottom) {
                pos = {
                    "x": x - window.width / 2,
                    "y": Screen.height - size - window.height - gap
                }
            } else if (position === Constants.taskbarPositionTop) {
                pos = {
                    "x": x - window.width / 2,
                    "y": size + gap
                }
            }

            pos.x = pos.x < 0 ? 0 : pos.x;
            pos.y = pos.y < 0 ? 0 : pos.y;

            return pos;
        }

        onActivated: (reason) => {
            if (reason === SystemTrayIcon.Trigger) {
                const position = getWindowPosition(geometry.x, geometry.y)
                window.x = position.x
                window.y = position.y

                window.show()
                window.raise()
                window.requestActivate()
            }
        }
    }

    Settings {
        id: setting
        width: parent.width - 20

        anchors.centerIn: parent
        url: settings.url ?? ''
        language: (settings.language !== undefined && languages.indexOf(settings.language) !== -1) ?  languages.indexOf(settings.language) : 0
        onAccepted: {
            settings.setLanguage(languages[setting.language])
            settings.setUrl(url)
        }
    }
}
