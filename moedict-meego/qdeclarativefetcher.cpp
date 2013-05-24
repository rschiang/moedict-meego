#include "qdeclarativefetcher.h"

QNetworkAccessManager* QDeclarativeFetcher::manager;

void QDeclarativeFetcher::setNetworkAccessManager(QNetworkAccessManager *manager)
{
    QDeclarativeFetcher::manager = manager;
}

QDeclarativeFetcher::QDeclarativeFetcher(QObject *parent) :
    QObject(parent)
{
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

}

void QDeclarativeFetcher::cancel()
{

}
