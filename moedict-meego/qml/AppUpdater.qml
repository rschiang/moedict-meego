import QtQuick 1.1
import org.moedict 1.1

Item {
    id: root
    property string state: ""
    property real progress: 0.0
    property variant data

    Fetcher {
        id: manifestFetcher
        url: "https://raw.github.com/rschiang/moedict-meego/master/data/manifest.json"
        onProgressChanged: root.progress = progress
        onFinished: {
            var manifest = JSON.parse(content)
            root.state = "available"
            root.data = manifest
            console.log(manifest.version)
        }
        onError: {
            root.state = "error"
            root.data = code
            console.log(code)
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
        // TODO: Cancel current
    }

    function retry()
    {
        root.state = "checking"
        manifestFetcher.start()
    }
}
