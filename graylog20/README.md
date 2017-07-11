

## WARNING

in docker-compose.yml file - __DO NOT__ link elasticsearch to graylog.
leave that job for linker. yes, i know, its a nasty hack.

Long story: graylog has two-way dependency with elasticsearch. as soon as
graylog sees elasticseach it will try to communicate and convince
elasticsearch to connect to hotsname graylog, but at that time elasticseach
can not resolve hostname graylog yet. reverse link is added by linker
container later on. so to stop graylog from comunicating with elasticseach
until linker does its job we need to remove link from graylog to elasticsearch.



## credentials

access to graylog web and api:

    user: project
    password: project



## supported env vars


### NFQ_GRAYLOG_API_HOST

This variable should contain graylog API hostname or ip address.
This host should be accessible from web browser accessing graylog web.

Default value: graylog


### NFQ_GRAYLOG_INPUTS (optional)

Provide space separated lists of graylog inputs in a single quoted string.
Optionally port can be defined after colon.

example:
    docker run -it -e NFQ_GRAYLOG_INPUTS='gelf.udp' <this_image>
    docker run -it -e NFQ_GRAYLOG_INPUTS='gelf.udp syslog.tcp' <this_image>
    docker run -it -e NFQ_GRAYLOG_INPUTS='gelf.udp syslog.tcp:514' <this_image>


### list of available inputs

* gelf.http (port: 12203)
* gelf.tcp (port: 12201)
* gelf.udp (port: 12201)
* raw.tcp (port: 12202)
* raw.udp (port: 12202)
* syslog.tcp (port: 514)
* syslog.udp (port: 514)

`curl --silent -u project:project http://graylog:12900/system/inputs/types | jq '.types' | cut -d\" -f2 | cut -d. -f4,5`



