#include "settings.h"

Settings::Settings(QObject *parent)
    : QObject{parent}
{

}

Settings::~Settings()
{
    m_settings.sync();
}

QString Settings::url() const
{
    return m_settings.value("url", "").toString();
}

QString Settings::language() const
{
    return m_settings.value("language", "en_US").toString();
}

void Settings::setUrl(const QString url)
{
    m_settings.setValue("url", url);

    emit urlChanged(url);
}

void Settings::setLanguage(const QString language)
{
    m_settings.setValue("language", language);

    emit languageChanged(language);
}


