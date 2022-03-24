var http = require('http');

const PORT=3000;

function handleRequest(request, response){
        response.end('I am alive!');
}

var server = http.createServer(handleRequest);

server.listen(PORT);

