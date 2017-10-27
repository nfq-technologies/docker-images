## Node server 8.x

### Description
A simple docker image containing node and npm, used to run npm targets. Like frontend servers

### Internals
There is a socat proxy added to this image, that tunnel 80 port to 3000. So all aplications runing on this server need to operate on port 3000

### Environment variables
* __NFQ_DOCUMENT_ROOT__:  Used to define starting work dir
* __NFQ_NPM_RUN__: target name from package.json to launch on load
* __NFQ_BACKEND_PORT__: the port node app will listen on so it can be redirected to port 80

