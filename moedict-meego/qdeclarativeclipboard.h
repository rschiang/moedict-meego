#ifndef QDECLARATIVECLIPBOARD_H
#define QDECLARATIVECLIPBOARD_H

#include <QObject>
#include <QClipboard>

class QDeclarativeClipboard : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text WRITE setText)

public:
    explicit QDeclarativeClipboard(QObject *parent = 0);

    QString text() const;
    void setText(const QString &value);

private:
    QClipboard* clipboard;
};

#endif // QDECLARATIVECLIPBOARD_H
