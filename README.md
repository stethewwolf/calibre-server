# calibre-server

This repo contain the a docker image running calibre server built using debian stable.

# configuration
## environment variables
### `CALIBRE_LIBRARY_PATH` 
*Default value:* `/srv/calibre/library`.
Path to the calibre library path; 

### `CALIBRE_NEW_BOOKS_PATH`
Path to a folder that contains book to be impoted before the server start, this action is performed
only if the folder exists.
*Default value:* **empty**

### `CALIBRE_USERDB_PATH`
Path to a sqlite file containing the user db, it the file is present those options
` --userdb $CALIBRE_USERDB_PATH --enable-auth`
are added to `CALIBRE_OPTIONS` var.

The sqlite file can be generated using the following command
```
calibre-server --userdb /srv/calibre/users.sqlite --manage-users
```

*Default value:* **empty**

### `CALIBRE_PORT`
Calibre server listening port.
*Default value:* `8080`

### `CALIBRE_IP`
Calibre server listening ip address.
*Default value:* `0.0.0.0`

### `CALIBRE_URL_PREFIX`
A  prefix to prepend to all URLs.    Useful if you wish to run this server behind a re‐verse proxy. 
For example use, /calibre as the URL prefix.
*Default value:* `/`

### `CALIBRE_OPTIONS`
*Default value:* **empty**

## server command
The final command will result in:
```
/usr/bin/calibre-server \
    --port $CALIBRE_PORT \
    --listen-on $CALIBRE_IP \
    --log /srv/calibre/logs/server.log \
    --access-log /srv/calibre/log/access.log \
    --url-prefix $CALIBRE_URL_PREFIX  \
    $CALIBRE_OPTIONS $CALIBRE_LIBRARY_PATH
```

## docker-compose example
This is a simple exmaple fot the [docker-compose](docker-compose.yml)
```
version: '3'

services:
  calibre-server:
    build: .
    ports:
      - "8080:8080"
    environment:
      CALIBRE_OPTIONS: "--enable-local-write"
      CALIBRE_NEW_BOOKS_PATH: "/srv/calibre/new"
      CALIBRE_USERDB_PATH: "/srv/calibre/users.sqlite"

    volumes:
      - /etc/localtime:/etc/localtime:ro    # Use host timezone
      - /srv/calibre/new/:/srv/calibre/new/
      - /srv/calibre/users.sqlite:/srv/calibre/users.sqlite
      - /srv/calibre/log:/srv/calibre/log
      - calibre-library:/srv/calibre/library/

volumes:
  calibre-library:

```

## references 
* [calibre home page](https://calibre-ebook.com/)
* [calibre-serve](https://manual.calibre-ebook.com/server.html)

