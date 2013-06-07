import QtQuick 1.1

QtObject {
    property bool canGoBack: (__backStack.length > 0)
    property bool canGoForward: (__forwardStack.length > 0)
    property ListModel model: ListModel {}
    property variant __backStack: []
    property variant __forwardStack: []

    function load() {
        var query = appWindow.database.execQuery("SELECT * FROM history ORDER BY date DESC", [])
        for (var i = 0; i < query.length; i++) {
            var entry = query[i]
            var date = new Date(entry.date)
            model.append(__createModel(entry.title, date))
        }
    }

    function back() {
        if (!canGoBack) return
        var bs = __backStack
        var fs = __forwardStack
        var entry = bs.pop()
        fs.push(entry)
        __backStack = bs
        __forwardStack = fs
        appWindow.__showEntry(entry)
    }

    function forward() {
        if (!canGoForward) return
        var bs = __backStack
        var fs = __forwardStack
        var entry = fs.pop()
        bs.push(entry)
        __backStack = bs
        __forwardStack = fs
        appWindow.__showEntry(entry)
    }

    function navigate(title) {
        var bs = __backStack
        bs.push(title)
        __backStack = bs
        __forwardStack = []
        appWindow.database.execAction({"INSERT INTO history (title,date) VALUES (?,?)": [title, Date.parse(new Date())]})
        model.insert(0, __createModel(title, new Date()))
        appWindow.__showEntry(title)
    }

    function get(index) {
        if (model.count >= index) return undefined
        return model.get(index).title
    }

    function clear() {
        appWindow.database.execAction(["DELETE FROM history"])
        __backStack = []
        __forwardStack = []
        model.clear()
    }

    function __createModel(title, date) {
        return { "title": title, "date": date, "day": Qt.formatDate(date) }
    }
}
