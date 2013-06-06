import QtQuick 1.1

QtObject {
    property variant __entries

    function load() {
        var db = appWindow.database.getDatabase()
        var result = {}
        db.transaction(function(tx) {
                           var rs = tx.executeSql("SELECT * FROM settings")
                           for (var i = 0; i < rs.rows.length; i++) {
                               var row = rs.rows.item(i)
                               result[row.key] = row.value
                           }
                       })
        __entries = result
    }

    function get(key) {
        return __entries[key]
    }

    function set(key, value) {
        var db = appWindow.database.getDatabase()
        var entries = __entries
        db.transaction(function(tx) {
                           tx.executeSql("REPLACE INTO settings(key, value) VALUES (?,?)", [key, value])
                           entries[key] = value
                       })
        __entries = entries
    }
}
