#include <QtGui/QApplication>
#include <QtNetwork/QNetworkAccessManager>
#include <qdeclarative.h>
#include "qmlapplicationviewer.h"
#include "qdeclarativefetcher.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    qmlRegisterType<QDeclarativeFetcher>("org.moedict", 1, 1, "Fetcher");

    QmlApplicationViewer viewer;
    QNetworkAccessManager* nam = new QNetworkAccessManager(&viewer);
    QDeclarativeFetcher::setNetworkAccessManager(nam);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setSource(QUrl("qrc:/qml/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
