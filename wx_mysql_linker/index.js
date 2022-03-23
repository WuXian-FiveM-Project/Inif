function parseSQLQuery(query, fields = []) {
    var listPosition = 0;
    for (var j = 0; j < query.length; j++) {
        if (query[j] == '?') {
            if (typeof fields[listPosition] == 'string') {
                fields[listPosition] = fields[listPosition].replace(/'/g, "\"");
                query = query.replace('?', `'${fields[listPosition]}'`);
            } else {
                query = query.replace('?', fields[listPosition]);
            }
            listPosition++;
        }
    }
    return query
}

var mysql = require('mysql');
var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '6u3489m5uc4',
    database: 'wxs'
});


connection.connect();
emit("RegisterModule", "MySql", {
    Sync: {
        Query: async function (query, fields) {
            return new Promise(
                function (resolve, reject) {
                    connection.query(parseSQLQuery(query, fields),
                        function (error, results, fields) {
                            if (error) {
                                reject(error);
                                console.error(parseSQLQuery(query, fields))
                                throw error
                            };
                            resolve(results);
                        }
                    )
                }
            )
        }
    },
    Async: {
        Query: function (query, fields,resolve) {
            connection.query(parseSQLQuery(query, fields),
                function (error, results, fields) {
                    if (error) {
                        console.error(error)
                        throw error
                    };
                    resolve(results);
                }
            )
        }
    }
},true);