function parseSQLQuery(query, fields) {
    var listPosition = 0;
    for (var i = 0; i < query.length; i++) {
        if (query[i] == '?') {
            query = query.replace('?', fields[listPosition]);
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
emit("RegisterModule", "sql", {
    Sync: {
        Query: async function (query, fields) {
            return new Promise(
                function (resolve, reject) {
                    connection.query(parseSQLQuery(query, fields),
                        function (error, results, fields) {
                            if (error) {
                                reject(error);
                                console.error(error)
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
                    };
                    resolve(results);
                }
            )
        }
    }
},true);