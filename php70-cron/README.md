
## cron

cron executed user cronjobs placed in NFQ_CRON_D_PATH directory.


### logging 

to log crontjob output to stdout append `2>&1|logger` to every job line

default behavior is to send output via mail


### NFQ_CRON_D_PATH (required)

Startup script will wait for this dir to be present and not empty before
starting cron daemon. This dir must contain at least one file. Multiple cron
jobs can be defined in a single file. Modifications to files in this directory
are detected automatically and crontab gets updated.

default value: none



## php

Inherited features are described in [parent readme](../php70-cli/README.md)


