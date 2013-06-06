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
                           tx.executeSql("REPLACE INTO entries(title,json) VALUES (?,?)", [key, dictObj[key]])

                           // Use shifting operator to increase performance
                           // Estimate size: 2048 * 80 = 163840 (v13.0429 has 162179)
                           if (((++count) & 2047) === 0)
                               WorkerScript.sendMessage({"progress": (count >> 11) / 160 })
                       }
                   })
    dictObj = undefined
    gc()

    var indexObj = JSON.parse(message.index)
    message.index = undefined
    gc()

    db.transaction(function(tx) {
                       var count = 0
                       for (var indexType in indexObj) {
                           var indexDict = indexObj[indexType]
                           for (var key in indexDict) {
                               for (var title in indexDict[key])
                                   tx.executeSql("REPLACE INTO indices(key,title) VALUES (?,?)", [key, title])

                               // Estimate size: 4096 * 67 = 274432 (v13.0429 has 277174)
                               if (((++count) & 4095) === 0)
                                   WorkerScript.sendMessage({"progress": 0.5 + (count >> 12) / 67})
                           }
                       }
                   })

    indexObj = undefined
    gc()

    WorkerScript.sendMessage({"completed": true})
}

WorkerScript.onMessage = loadDict
