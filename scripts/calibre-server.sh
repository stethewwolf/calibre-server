#!/bin/sh

CALIBRE_LIBRARY_PATH=${CALIBRE_LIBRARY_PATH:="/srv/calibre/library"}
CALIBRE_PORT=${CALIBRE_PORT:=8080}
CALIBRE_IP=${CALIBRE_IP:="0.0.0.0"}
CALIBRE_URL_PREFIX=${CALIBRE_URL_PREFIX:="/"}
CALIBRE_OPTIONS=${CALIBRE_OPTIONS:=""}
export XDG_RUNTIME_DIR="/srv/calibre/"

if [ ! -d $CALIBRE_LIBRARY_PATH ]; then
    cp -rv /usr/local/share/calibre/library $CALIBRE_LIBRARY_PATH

    echo "created folder $CALIBRE_LIBRARY_PATH"
fi

/usr/bin/calibredb check_library  --library-path $CALIBRE_LIBRARY_PATH

/usr/bin/calibre-server --port $CALIBRE_PORT --listen-on $CALIBRE_IP --log /srv/calibre/logs/server.log --access-log /srv/calibre/logs/access.log --url-prefix $CALIBRE_URL_PREFIX  $CALIBRE_OPTIONS $CALIBRE_LIBRARY_PATH

