
## supervisor

This is supervisor installation on top of php image. Via env vars you
can set your config path and enable http interface for child monitoring.

To get most of this image use these settings in your job configs:
* __user=project__ so that files created by this job could be accessed via
  network share and/or your IDE.
* __stdout_logfile=/dev/stdout__ so that all output of child processes could
  be visible in docker terminal.
* __stderr_logfile=/dev/stderr__ see above.
* __stdout_logfile_maxbytes=0__ this is required for logging to console to
  prevent supervisor from doing seek on log files.
* __stderr_logfile_maxbytes=0__ see above


### NFQ_SUPERVISOR_CONF_DIR (optional)

Startup script will wait for this dir to be present before starting
supervisord.

default value: /etc/supervisor/conf.d


### NFQ_SUPERVISOR_ENABLE_HTTP (optional)

If set to __true__, enables http interface for monitoring and managing child
processes.

default value: false


### NFQ_USE_STARTUP_TRIGGER (optional)

Set to __true__ to delay service startup until connection to TCP port 2048 is
received. This is useful if service can be started up only after certain init
tasks have completed. Startup can be triggered with a simple command:
```
    netcat container_hostname 2048
```
If set to false, service will start immediately.

default value: false


## php

Inherited features are described in [parent readme](../php81-cli/README.md)


