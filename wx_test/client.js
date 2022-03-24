var {exec} = require('child_process');
exec('tasklist', function (error, stdout, stderr) {
    console.log('stdout: ' + stdout);
});