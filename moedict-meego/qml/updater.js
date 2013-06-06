// updater.js
// This thread parses and loads dictionary JSON into database

function loadDict(message) {
    var dictObj = JSON.parse(message.dict)
    message.dict = undefined
    gc()

    var db = openDatabaseSync("org.moedict", "1", "", 64 * 1024 * 1024)
    db.transaction(function(tx) {
                       var count = 0
                       for (var key in dictObj) {
                           tx.executeSql("REPLACE INTO entries (title,json) VALUES (?,?)", [key, dictObj[key]])

                           // Use shifting operator to increase performance
                           // Estimate size: 2048 * 80 = 163840 (v13.0429 has 162179)
                           // Progress: 0 - 80%
                           if (((++count) & 2047) === 0)
                               WorkerScript.sendMessage({"progress": (count >> 11) / 100 })
                       }
                   })
    dictObj = undefined
    gc()

    var indexObj = JSON.parse(message.index)
    message.index = undefined
    gc()
}

WorkerScript.onMessage = loadDict
