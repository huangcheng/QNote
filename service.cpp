#include "service.h"

Service::Service(QObject *parent) : QObject(parent), m_url(""), m_content("")
{
    m_manager = new QNetworkAccessManager(this);

    m_request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
}

QString Service::url() const
{
    return m_url;
}

QString Service::content() const {
    return m_content;
}

void Service::setUrl(const QString url)
{
    m_url = url;

    emit urlChanged(m_url);
}

void Service::setContent(const QString content)
{
    m_content = content;

    emit contentChanged(m_content);
}

void Service::send()
{
    m_request.setUrl(QUrl(m_url));

    QJsonObject body;
    body["content"] = m_content;

    QJsonDocument doc(body);

    QByteArray data = doc.toJson();

    QNetworkReply *reply = m_manager->post(m_request, data);

    connect(reply, &QNetworkReply::finished, this, [=]()
    {
       if (reply->error() == QNetworkReply::NoError)
       {
           emit sent(Status::Success);
       }
       else
       {
           emit sent(Status::Error);
       }

       reply->deleteLater();
    });
}

Service::~Service()
{
    if (m_manager != nullptr)
    {
        delete m_manager;

        m_manager = nullptr;
    }
}
