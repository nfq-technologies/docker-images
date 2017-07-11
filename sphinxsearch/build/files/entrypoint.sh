#!/bin/bash

set -e
source /tools/functions_init.sh

run-parts -v /etc/rc.d


# default features
init_wait_for_a_dir
init_wait_for_a_not_empty_dir
init_wait_for_a_file
init_wait_for_a_not_empty_file



if [ "x${NFQ_SPHINX_CONFIG_PATH}" == "x" ]
then
	echo "-- WARNING: NFQ_SPHINX_CONFIG_PATH is not set! sphinx is useless without project-specific configuration." >&2
	export NFQ_SPHINX_CONFIG_PATH=/root/sphinx/sphinx.conf
	indexer --all -c $NFQ_SPHINX_CONFIG_PATH
fi


init_wait_for_a_not_empty_file ${NFQ_SPHINX_CONFIG_PATH}

# execute everything in correct location directory
cd /root/sphinx

# link project sphinx.conf to default location
rm -f /etc/sphinxsearch/sphinx.conf
ln -s ${NFQ_SPHINX_CONFIG_PATH} /etc/sphinxsearch/sphinx.conf



interval_reindexer() {
	while true
	do
		indexer --all --rotate --quiet 1>/dev/null
		sleep ${NFQ_SPHINX_INDEXER_INTERVAL}
	done
}
# launch reindexer in the background
if [ ${NFQ_SPHINX_INDEXER_INTERVAL} -ge 0 ]
then
	interval_reindexer &
fi



remote_reindexer() {
	while true
	do
		netcat -l -p 9313 -c 'indexer --all --rotate' || true
	done
}
remote_reindexer &



init_use_startup_trigger


exec searchd --nodetach

