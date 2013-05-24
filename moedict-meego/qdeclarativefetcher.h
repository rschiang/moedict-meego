#ifndef QDECLARATIVEFETCHER_H
#define QDECLARATIVEFETCHER_H

#include <QObject>
#include <QUrl>
#include <QtNetwork/QNetworkRequest>

class QDeclarativeFetcher : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl url READ url WRITE setUrl)
    Q_PROPERTY(QString content READ content)

public:
    explicit QDeclarativeFetcher(QObject *parent = 0);
    QUrl url() const;
    void setUrl(const QUrl &value);

    QString content() const;

private:
    QUrl m_url;
    QString m_content;
    
signals:
    
public slots:
    
};

#endif // QDECLARATIVEFETCHER_H
