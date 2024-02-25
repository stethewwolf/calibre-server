#!/bin/sh

CALIBRE_LIBRARY_PATH=${CALIBRE_LIBRARY_PATH:="/srv/calibre/library"}
CALIBRE_NEW_BOOKS_PATH=${CALIBRE_NEW_BOOKS_PATH:="/srv/calibre/new"}
CALIBRE_USERDB_PATH=${CALIBRE_USERDB_PATH:=""}
CALIBRE_PORT=${CALIBRE_PORT:=8080}
CALIBRE_IP=${CALIBRE_IP:="0.0.0.0"}
CALIBRE_URL_PREFIX=${CALIBRE_URL_PREFIX:="/"}
CALIBRE_OPTIONS=${CALIBRE_OPTIONS:=""}
export XDG_RUNTIME_DIR="/srv/calibre/"


if [ ! -f "$CALIBRE_LIBRARY_PATH/metadata.db" ]; then
    rm -rf $CALIBRE_LIBRARY_PATH/*
    rsync -av /usr/local/share/calibre/library/ $CALIBRE_LIBRARY_PATH/

    echo "populated library in path $CALIBRE_LIBRARY_PATH"
fi

echo "checking library"
/usr/bin/calibredb check_library  --library-path $CALIBRE_LIBRARY_PATH

if [ -d "$CALIBRE_NEW_BOOKS_PATH" ]; then
    echo "importing book on library from $CALIBRE_NEW_BOOKS_PATH"
    find $CALIBRE_NEW_BOOKS_PATH -type f -exec calibredb add {} --with-library $CALIBRE_LIBRARY_PATH \; 
fi

if [ -f "$CALIBRE_USERDB_PATH" ]; then
    echo "enableing user auth with db: $CALIBRE_USERDB_PATH"
    CALIBRE_OPTIONS="$CALIBRE_OPTIONS --userdb $CALIBRE_USERDB_PATH --enable-auth"
fi

echo "starting server with command:"
echo "calibre-server --port $CALIBRE_PORT --listen-on $CALIBRE_IP --log /srv/calibre/logs/server.log --access-log /srv/calibre/logs/access.log --url-prefix $CALIBRE_URL_PREFIX  $CALIBRE_OPTIONS $CALIBRE_LIBRARY_PATH"

/usr/bin/calibre-server --port $CALIBRE_PORT --listen-on $CALIBRE_IP --log /srv/calibre/logs/server.log --access-log /srv/calibre/log/access.log --url-prefix $CALIBRE_URL_PREFIX  $CALIBRE_OPTIONS $CALIBRE_LIBRARY_PATH

