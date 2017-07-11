

By making connection to sphinxsearch host on tcp port 9313, one could trigger
sphinx index rotate. For example you can put `netcat sphinxsearch 9313` in
your init script to trigger update.

After first indexer run searchd startup must be triggered by making connection
to 2048 port. For example using netcat. After startup this port will be closed
and no further connections will be accepted.

## supported env vars


### NFQ_SPHINX_CONFIG_PATH

Full path to sphinx configuration file. Can be either in project repository
tree or mounted from outside.

You can use `./`, `./data/` and `./log/` directories in your sphinx.conf to
store your index and log data. For logging purpose usage of /proc/self/stdout
is recommended as it will output messages dirrectly to your console instead of
storing them in hard-to-access file.

default value: /full/path/to/your/sphinx.conf

### NFQ_SPHINX_INDEXER_INTERVAL

Interval in seconds to wait between automatic index rotates.

* __0__ - no wait, continously rotate index
* __-1__ - don't rotate at all (manual indexing will be required)

default value: -1



