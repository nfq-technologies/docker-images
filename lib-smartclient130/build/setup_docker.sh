#!/bin/sh

set -x
set -e

URL="https://www.smartclient.com/builds/SmartClient/13.0d/LGPL"
DATE=$(wget -O - $URL | grep 'LGPL/20..\-..\-.."' | sed 's/^.*href="[^"]*\(20..\-..\-..\)".*$/\1/'| head -n1)
URL="$URL/$DATE/SmartClient_SNAPSHOT_v130d_${DATE}_LGPL.zip"


DDIR=/home/project/lib/smartclient
cd /tmp
wget -O sc.zip $URL
unzip sc.zip
rm -fr sc.zip
mkdir -p $DDIR/smartclientSDK/isomorphic
mv SmartClient_*/smartclientSDK/isomorphic $DDIR/smartclientSDK/
rm -fr /tmp	SmartSlient_*
chmod -R -x+X,o-w $DDIR
chown -R 1000:1000 $DDIR


cp -frv /build/files/* /

#source /usr/local/build_scripts/cleanup_apt.sh

