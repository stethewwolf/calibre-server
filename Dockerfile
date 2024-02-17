FROM debian:stable-slim

RUN apt-get update && apt-get install -y calibre 

RUN mkdir /srv/calibre

RUN groupadd -r calibre
RUN useradd -g calibre -r calibre

COPY calibre-server.sh /usr/local/bin/calibre-server.sh
RUN chmod a+x /usr/local/bin/calibre-server.sh

USER calibre

# define entrypoint
ENTRYPOINT /usr/local/bin/calibre-server.sh

# run sleep infinity
CMD [ "/usr/bin/sleep", "infinity" ]
