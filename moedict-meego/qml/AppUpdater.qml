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
            root.recoveryState = ""
        }
        onError: {
            root.state = "error"
            root.data = code
        }
    }

    Fetcher {
        id: dictFetcher
        url: "https://raw.github.com/rschiang/moedict-meego/master/data/index.json"
        onProgressChanged: root.progress = progress * 0.6
        onFinished: {
            root.recoveryState = "updating-2"
            indexFetcher.start()
        }
        onError: {
            root.state = "error"
            root.data = code
        }
    }

    Fetcher {
        id: indexFetcher
        url: "https://raw.github.com/rschiang/moedict-meego/master/data/lookuptable.json"
        onProgressChanged: root.progress = 0.6 + progress * 0.1
        onFinished: {
            root.recoveryState = "parsing"
            parser.start()
        }
        onError: {
            root.state = "error"
            root.data = code
        }
    }

    WorkerScript {
        id: parser
        source: "updater.js"
        onMessage: {
            if (msg.completed) {
                root.state = "newest"
                root.recoveryState = ""
            } else {
                root.progress = 0.7 + msg.progress * 0.3
            }
        }

        function start() {
            sendMessage({"dict": dictFetcher.content, "index": indexFetcher.content })
        }
    }

    function refresh()
    {
        root.state = "checking"
        root.recoveryState = "checking"
        manifestFetcher.start()
    }

    function install()
    {
        root.state = "updating"
        root.recoveryState = "updating-1"
        dictFetcher.start()
    }

    function cancel()
    {
        if (root.state == "checking") {
            manifestFetcher.cancel()
            root.state = ""
        } else {
            switch (root.recoveryState) {
            case "updating-1":
                dictFetcher.cancel()
                break
            case "updating-2":
                indexFetcher.cancel()
                break
            //case "parsing": // Cannot cancel WorkerScript
            //    break
            }
            root.state = "available"
            root.recoveryState = ""
        }
    }

    function retry()
    {
        switch (root.recoveryState) {
        case "checking":
            root.state = "checking"
            manifestFetcher.start()
            break
        case "updating-1":
            root.state = "updating"
            dictFetcher.start()
            break
        case "updating-2":
            root.state = "updating"
            indexFetcher.start()
            break
        case "parsing":
            root.state = "updating"
            parser.start()
            break
        }
    }
}
