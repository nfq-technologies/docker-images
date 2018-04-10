

## supported env vars

### defaults

This image puts all logs to stdout in case neither NFQ_LOG_TO_FILE 
 nor NFQ_LOG_TO_AGREGATOR is specified.


### NFQ_LOG_TO_FILE (optional)

Use this option to put logs into files by assigning full path with
 file prefix you want your logs stored in.

Empty by default.


### NFQ_LOG_TO_AGREGATOR (optional)

Use this to forward your logs to upstream server by assigning servers
 hostname and optionally port separated by a colon. In case port is
 not specified it defaults to 24224.

Empty by default.

example:
    docker run -it -e NFQ_LOG_TO_AGREGATOR='upstream.fluentd.lan' <this_image>
    docker run -it -e NFQ_LOG_TO_AGREGATOR='upstream.fluentd.lan:24224' <this_image>


## list of available inputs

* http json (port: 9880)
* forwarding (port: 24224)




