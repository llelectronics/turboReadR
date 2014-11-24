//db.js
.import QtQuick.LocalStorage 2.0 as LS

// First, let's create a short helper function to get the database connection
function getDatabase() {
    return LS.LocalStorage.openDatabaseSync("turboreader", "1.1", "StorageDatabase", 100000);
}

String.prototype.contains = function(it) { return this.indexOf(it) != -1; };

// At the start of the application, we can initialize the tables we need if they haven't been created yet
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx,er) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS settings(setting TEXT, value TEXT)');
                    tx.executeSql('CREATE UNIQUE INDEX IF NOT EXISTS idx_settings ON settings(setting)');

                });
}

// This function is used to write settings into the database
function addSetting(setting,value) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            //console.log ("Setting written to database");
        } else {
            res = "Error";
            //console.log ("Error writing setting to database");
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

function stringToBoolean(str) {
    switch(str.toLowerCase()){
    case "true": case "yes": case "1": return true;
    case "false": case "no": case "0": case null: return false;
    default: return Boolean(string);
    }
}

// This function is used to retrieve settings from database
function getSettings() {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM settings;');
        for (var i = 0; i < rs.rows.length; i++) {
            if (rs.rows.item(i).setting == "wordsPerMinute") mainWindow.firstpage.words_per_minute = 60000 / parseInt(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "longwordIs") mainWindow.firstpage.long_word_chars = parseInt(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "longWordsPerMinute") mainWindow.firstpage.long_words_timeout = 60000 / parseInt(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "fontSize") mainWindow.firstpage.fontSize = parseInt(rs.rows.item(i).value)
        }
    })
}
