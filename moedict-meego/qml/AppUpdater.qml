import QtQuick 1.1
import org.moedict 1.1

Item {
    id: root
    property string state: ""
    property real progress: 0.0
    property variant data
    property string recoveryState: ""

    Fetcher {
        id: manifestFetcher
        url: "https://raw.github.com/rschiang/moedict-meego/master/data/manifest.json"
        onProgressChanged: root.progress = progress
        onFinished: {
            var manifest = JSON.parse(content)
            var curVersion = appWindow.settings.get("dict.version")
            if ((curVersion != undefined) && (curVersion >= manifest.version)) {
                root.state = "newest"
            } else {
                root.state = "available"
            }
            root.data = manifest
        }
        onError: {
            root.state = "error"
            root.data = code
            root.recoveryState = "checking"
        }
    }

    function refresh()
    {
        root.state = "checking"
        manifestFetcher.start()
    }

    function install()
    {
        //root.state = "updating"
        // TODO: Update
        root.state = ""
    }

    function cancel()
    {
        if (root.state == "checking") {
            manifestFetcher.cancel()
            root.state = ""
        } else {
            // TODO: Updating
        }
    }

    function retry()
    {
        switch (root.recoveryState) {
        case "checking":
            root.state = "checking"
            manifestFetcher.start()
            break
        // TODO: Updating
        }
    }
}
