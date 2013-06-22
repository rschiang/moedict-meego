// query.js
// This thread performs asynchornous database queries

function execQuery(message) {
    var db = openDatabaseSync("org.moedict", "1", "", 64 * 1024 * 1024)
    var result = []
    db.readTransaction(function(tx) {
                           var rs = tx.executeSql(message.query, message.params)
                           for (var i = 0; i < rs.rows.length; i++)
                               result.push(rs.rows.item(i))
                       })
    WorkerScript.sendMessage({"result": result, "token": message.token})
}

WorkerScript.onMessage = execQuery
