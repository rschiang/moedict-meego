#include "qdeclarativefetcher.h"

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
