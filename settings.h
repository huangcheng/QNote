#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>
#include <QString>

class Settings : public QObject
{
    Q_OBJECT
public:
    explicit Settings(QObject *parent = nullptr);
    ~Settings();

public:
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QString language READ language WRITE setLanguage NOTIFY urlChanged)

    QString url() const;
    QString language() const;

public:
    Q_INVOKABLE void setUrl(const QString url);
    Q_INVOKABLE void setLanguage(const QString language);

private:
    QSettings m_settings;

signals:
    void urlChanged(const QString url);
    void languageChanged(const QString language);
};

#endif // SETTINGS_H
