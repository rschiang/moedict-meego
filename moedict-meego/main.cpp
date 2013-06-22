#include <QtGui/QApplication>
#include <QtNetwork/QNetworkAccessManager>
#include <qdeclarative.h>
#include <QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "qdeclarativefetcher.h"
#include "qdeclarativeclipboard.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    qmlRegisterType<QDeclarativeFetcher>("org.moedict", 1, 1, "Fetcher");

    QmlApplicationViewer viewer;
    QDeclarativeClipboard appc;
    QNetworkAccessManager* nam = new QNetworkAccessManager(&viewer);
    QDeclarativeFetcher::setNetworkAccessManager(nam);
    viewer.rootContext()->setContextProperty("clipboard", &appc);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setSource(QUrl("qrc:/qml/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
