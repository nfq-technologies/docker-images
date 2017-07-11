
### NFQ_GEARMAND_VERBOSE (optional)

Set verbose level (FATAL, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFO, DEBUG).
default value: WARNING

### NFQ_GEARMAND_CONFIG (optional)

--config-file arg (=/etc/gearmand.conf)

### NFQ_USE_STARTUP_TRIGGER (optional)

Set to __true__ to delay service startup until connection to TCP port 2048 is
received. This is useful if service can be started up only after certain init
tasks have completed. Startup can be triggered with a simple command:
```
    netcat container_hostname 2048
```
If set to false, service will start immediately.

default value: false
