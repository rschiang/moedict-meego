import QtQuick 1.1

QtObject {
    function getDatabase() {
        return openDatabaseSync("org.moedict", "1", "", 64 * 1024 * 1024)
    }

    function execAction(queries) {
        var db = getDatabase()
        db.transaction(function(tx) {
                            if (Array.isArray(queries))
                                for (var i = 0; i < queries.length; i++)
                                    tx.executeSql(queries[i])
                            else
                                for (var statement in queries)
                                    tx.executeSql(statement, queries[statement])
                       })
    }

    Component.onCompleted: {
        execAction([
                       "CREATE TABLE IF NOT EXISTS entries(title TEXT UNIQUE, json TEXT)",
                       "CREATE TABLE IF NOT EXISTS index(indexer TEXT, title TEXT)"
                   ])
    }
}
