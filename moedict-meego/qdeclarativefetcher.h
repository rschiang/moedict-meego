#ifndef QDECLARATIVEFETCHER_H
#define QDECLARATIVEFETCHER_H

#include <QObject>
#include <QUrl>
#include <QtNetwork>

class QDeclarativeFetcher : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl url READ url WRITE setUrl)
    Q_PROPERTY(QString content READ content NOTIFY finished)
    Q_PROPERTY(qreal progress READ progress NOTIFY progressChanged)

public:
    explicit QDeclarativeFetcher(QObject *parent = 0);
    QUrl url() const;
    void setUrl(const QUrl &value);

    QString content() const;
    qreal progress() const;

    Q_INVOKABLE void start();
    Q_INVOKABLE void cancel();

    static void setNetworkAccessManager(QNetworkAccessManager *manager);

private:
    QUrl m_url;
    QString m_content;
    qreal m_progress;
    QNetworkReply *m_reply;

    static QNetworkAccessManager* manager;
    
signals:
    void progressChanged();
    void finished();
    void error(int code);
    
private slots:
    void replyProgress(qint64 bytesReceived, qint64 bytesTotal);
    void replyFinished();
    void replyError(QNetworkReply::NetworkError code);
};

#endif // QDECLARATIVEFETCHER_H
