#ifndef SERVICE_H
#define SERVICE_H

#include <QObject>
#include <QString>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QUrl>
#include <QJsonObject>
#include <QJsonDocument>
#include <QByteArray>
#include <QtQml/qqmlregistration.h>

class Service : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QString content READ content WRITE setContent NOTIFY contentChanged)
    QML_ELEMENT
public:
    explicit Service(QObject *parent = nullptr);
    ~Service();

public:
    QString url() const;
    QString content() const;

    void setUrl(const QString url);
    void setContent(const QString content);

    Q_INVOKABLE void send();

    enum Status
    {
        Success = 0,
        Error = 1,
    };

    Q_ENUM(Status);

private:
    QNetworkAccessManager *m_manager;
    QNetworkRequest m_request;
    QString m_url;
    QString m_content;

signals:
    void urlChanged(QString url);
    void contentChanged(QString content);
    void sent(Status status);
};

#endif // SERVICE_H
