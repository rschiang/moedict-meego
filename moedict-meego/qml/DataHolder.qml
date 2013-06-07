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

    function execRow(query, params) {
        var db = getDatabase()
        var result = []
        db.readTransaction(function(tx) {
                               var rs = tx.executeSql(query, params)
                               for (var i = 0; i < rs.rows.length; i++)
                                   result.push(rs.rows.item(i))
                           })
        return result
    }

    function load() {
        execAction([
                       "CREATE TABLE IF NOT EXISTS entries(title TEXT UNIQUE, json TEXT)",
                       "CREATE TABLE IF NOT EXISTS indices(key TEXT, title TEXT)",
                       "CREATE TABLE IF NOT EXISTS settings(key TEXT UNIQUE, value TEXT)"
                   ])
    }
}
