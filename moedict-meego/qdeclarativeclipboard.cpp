#include "qdeclarativeclipboard.h"
#include <QApplication>

QDeclarativeClipboard::QDeclarativeClipboard(QObject *parent) :
    QObject(parent)
{
    clipboard = QApplication::clipboard();
}

QString QDeclarativeClipboard::text() const {
    return clipboard->text();
}

void QDeclarativeClipboard::setText(const QString &value) {
    clipboard->setText(value);
}
