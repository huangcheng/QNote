QT += \
    core \
    quick \
    widgets \
    network

SOURCES += \
        main.cpp \
        service.cpp \
        settings.cpp

HEADERS += \
        service.h \
        settings.h

resources.files = \
    main.qml \
    Info.qml \
    Settings.qml \
    imports/QNote/qmldir \
    imports/QNote/Constants.qml \
    imports/QNote/Components/qmldir \
    imports/QNote/Components/Button.qml \
    images/icon.png \
    images/setting.png \
    images/more.png

resources.prefix = /$${TARGET}
RESOURCES += resources

TRANSLATIONS += \
    QNote_zh_CN.ts \
    QNote_en_US.ts

CONFIG += \
        lrelease \
        qmltypes

CONFIG += embed_translations

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += $$PWD/imports

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

QML_IMPORT_NAME += service
QML_IMPORT_MAJOR_VERSION = 1

win32 {
    RC_ICONS = icon.ico
}

macx {
    ICON = icon.icns
}

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    Info.qml

