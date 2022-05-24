#include <QApplication>
#include <QQmlApplicationEngine>

#include <QLocale>
#include <QTranslator>
#include <QQmlContext>

#include <settings.h>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QCoreApplication::setOrganizationName("Cheng Huang");
    QCoreApplication::setOrganizationDomain("cheng.im");
    QCoreApplication::setApplicationName("QNote");

    QTranslator translator;

    Settings settings;

    QString language(settings.language());

    const auto localeName = "QNote_" + language;

    if (translator.load(":/i18n/" + localeName)) {
        app.installTranslator(&translator);
    }

    QQmlApplicationEngine engine;

    engine.addImportPath("qrc:/QNote/imports");
    engine.rootContext()->setContextProperty("settings", &settings);

    const QUrl url(u"qrc:/QNote/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
