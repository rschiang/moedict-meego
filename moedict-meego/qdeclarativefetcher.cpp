#include "qdeclarativefetcher.h"
#include <QTextStream>

QNetworkAccessManager* QDeclarativeFetcher::manager;

void QDeclarativeFetcher::setNetworkAccessManager(QNetworkAccessManager *manager)
{
    QDeclarativeFetcher::manager = manager;
}

QDeclarativeFetcher::QDeclarativeFetcher(QObject *parent) :
    QObject(parent)
{
    m_reply = 0;
}

QUrl QDeclarativeFetcher::url() const
{
    return m_url;
}

void QDeclarativeFetcher::setUrl(const QUrl &value)
{
    m_url = value;
}

QString QDeclarativeFetcher::content() const
{
    return m_content;
}

qreal QDeclarativeFetcher::progress() const
{
    return m_progress;
}

void QDeclarativeFetcher::start()
{
    QNetworkRequest request(m_url);
    m_reply = manager->get(request);
    connect(m_reply, SIGNAL(downloadProgress(qint64,qint64)), SLOT(replyProgress(qint64,qint64)));
    connect(m_reply, SIGNAL(finished()), SLOT(replyFinished()));
    connect(m_reply, SIGNAL(error(QNetworkReply::NetworkError)), SLOT(replyError(QNetworkReply::NetworkError)));
}

void QDeclarativeFetcher::cancel()
{
    if (m_reply)
        m_reply->abort();
}

void QDeclarativeFetcher::replyProgress(qint64 bytesReceived, qint64 bytesTotal)
{
    m_progress = (qreal)bytesReceived / (qreal)bytesTotal;
    progressChanged();
}

void QDeclarativeFetcher::replyFinished()
{
    m_progress = 1;
    if (!m_reply->error()) {
        QTextStream ts(m_reply);
        ts.setCodec("UTF-8");
        m_content = ts.readAll();
        finished();
    }
    m_reply->deleteLater();
}

void QDeclarativeFetcher::replyError(QNetworkReply::NetworkError code)
{
    error(code);
}
